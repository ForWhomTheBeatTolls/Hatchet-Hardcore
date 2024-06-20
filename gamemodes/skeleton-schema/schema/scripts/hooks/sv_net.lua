util.AddNetworkString("impulseHL2RPTerminalLeave")
util.AddNetworkString("impulseHL2RPRankUse")
util.AddNetworkString("impulseHL2RPRankBecome")
util.AddNetworkString("impulseHL2RPTerminalCharge")
util.AddNetworkString("impulseHL2RPOpenLocker")
util.AddNetworkString("impulseHL2RPUseLocker")
util.AddNetworkString("impulseHL2RPCombineOverlayBoot")
util.AddNetworkString("impulseHL2RPChargesRequest")
util.AddNetworkString("impulseHL2RPChargesGet")
util.AddNetworkString("impulseHL2RPChargesEdit")
util.AddNetworkString("impulseHL2RPDemoteCP")
util.AddNetworkString("impulseHL2RPTearGasFX")
util.AddNetworkString("impulseHL2RPInspectBody")
util.AddNetworkString("impulseHL2RPInspectBodyComplete")
util.AddNetworkString("impulseHL2RPVortessenceStart")
util.AddNetworkString("impulseHL2RPTheatreControls")
util.AddNetworkString("impulseHL2RPTheatreAction")
util.AddNetworkString("impulseHL2RPRadioInDb")
util.AddNetworkString("impulseHL2RPWorkforceRankUse")
util.AddNetworkString("HatchetVendingMachineFillStart")
util.AddNetworkString("HatchetVendingMachineFillEnd")
util.AddNetworkString("HatchetBecomeCivilWorker")

net.Receive("HatchetBecomeCivilWorker", function()
	local ply = net.ReadPlayer()
	ply:SetTeam(TEAM_WORKFORCE)
end)

net.Receive("HatchetVendingMachineFillEnd", function()
	local ply = net.ReadPlayer()
	local tr = util.TraceLine( {
	start = ply:EyePos(),
	endpos = ply:EyePos() + ply:GetAimVector() * 100,
	filter = function(ent) return ( ent:GetClass() == "m_vendingmachine" ) end
} )
	local ent = tr.Entity
	local success = net.ReadBool()
	if success == true and ent:GetClass() == "m_vendingmachine" then
		ent:Refill()
		ply:Notify("good for you")
		ply:TakeInventoryItemClass("work_canbox", 1, 1)
		ply.PendingReward = ply.PendingReward + 20
	else
		ply:Notify("bad for you")
	end
end)

net.Receive("impulseHL2RPTerminalLeave", function(len, ply)
	if IsValid(ply) and ply:IsCP() then
		local terminal = ply.Terminal

		if terminal and IsValid(terminal) then
			terminal:RemoveUser(ply)
		end
	end
end)

net.Receive("impulseHL2RPRankBecome", function(len, ply) -- needs more validation checks
	if (ply.nextRankTry or 0) < CurTime() then
		ply.nextRankTry = CurTime() + 2
		local div = net.ReadUInt(8)
		local rank = net.ReadUInt(8)

		if ply.nextRankBecome and ply.nextRankBecome > CurTime() then
			ply:Notify("Please wait "..string.NiceTime(ply.nextRankBecome - CurTime()).." before attempting to change your rank/division again.")
			return
		end

		if not IsValid(ply) then
			return
		end

		if ( ply:IsCP() ) then

			local classData = impulse.Teams.Data[ply:Team()].classes
			local rankData = impulse.Teams.Data[ply:Team()].ranks

			if not div or not rank or not isnumber(div) or not isnumber(rank) or not classData or not rankData or not classData[div] or not rankData[rank] then
				return
			end

			local ent = ply.currentNPC

			if not ent or not IsValid(ent) or ent:GetPos():DistToSqr(ply:GetPos()) > 380 ^ 2 then
				return
			end

			local set = false

			if ply:Team() == TEAM_CP and rank == RANK_CMD and div != CLASS_UNION and div != CLASS_STORM then
				return ply:Notify("To become CmD please select UNION as your division.")
			end

			if ply:Team() == TEAM_OTA and div == CLASS_SENTINEL and rank >= RANK_OVC then
				return ply:Notify("NOMAD units can not be rank leaders.")
			end

			if ply:Team() == TEAM_OTA and rank == RANK_OWC and div != CLASS_ECHO then
				return ply:Notify("To become OWC please select ECHO as your division.")
			end



			ply:SetSkin(0)
			ply:SetBodyGroups("00000000000000000")

			if ply:GetTeamClass() == div and ply:GetTeamRank() != rank and ply:CanBecomeTeamRank(rank, true) then
				ply:SetTeamRank(rank)
				set = true

			elseif ply:CanBecomeTeamClass(div, true) and ply:CanBecomeTeamRank(rank, true) then
				ply:SetTeamClass(div, true) -- the second argument skips the loadout, as rank will set it up. it can be kinda stressful on the server if you remove this
				ply:SetTeamRank(rank)
				set = true
			end

			--ply:SetSubMaterial(2, impulse.SubmatsConfig[ply:Team()][div][rank])

			if set then
				local nameIsPassed = false 
				while not nameIsPassed do
					local isGood = true
					local testing = tostring(math.random(10, 99))

					-- check if anyone has the same last 2 digits of their name
					for v,k in ipairs(team.GetPlayers(ply:Team())) do
						local digits = string.match(string.sub(k:Name(), -2), "%d+", 0)
						if not digits then
							continue -- they dont gotta rank 
						end

						if digits == testing then
							isGood = false
							nameIsPassed = false
							break
						end
					end

					if isGood then
						nameIsPassed = true
					end
				end
				local taglines = {
        "UNION",
        "TAP",
        "XRAY",
        "HELIX",
        "VICE",
        "KING",
        "ROLLER"
    }
				local generatedName = "C17:"..table.Random(taglines).."-"..math.random(0, 99)

				if ply:Team() == TEAM_CP then
				
					ply:SetRPName(generatedName)
				else
					local generatedName = "C17:"..table.Random(taglines).."-"..math.random(0, 99)
					ply:SetRPName(generatedName)
				end

				ply:Notify("You have set your division and rank to "..classData[div].name.."-"..rankData[rank].name..".")

				hook.Run("PlayerSetCombineRank", ply, rankData[rank], classData[div])

				local isPreview = GetConVar("impulse_ispreview"):GetBool()

				if not (ply:IsSuperAdmin() or isPreview) then
					ply.nextRankBecome = CurTime() + 120
				end

				net.Start("impulseHL2RPCombineOverlayBoot")
				net.Send(ply)
			end
		elseif (ply:Team() == TEAM_WORKFORCE) then
			local classData = impulse.Teams.Data[ply:Team()].classes
			local rankData = impulse.Teams.Data[ply:Team()].ranks

			if ply:GetTeamClass() == div and ply:GetTeamRank() != rank and ply:CanBecomeTeamRank(rank, true) then
				ply:SetTeamRank(rank)
				set = true
				ply:Notify("You started the job as a "..rankData[rank].name.."! Go to the locker room to grab your outfit.")
			elseif ply:CanBecomeTeamClass(div, true) and ply:CanBecomeTeamRank(rank, true) then
				ply:SetTeamClass(div, true) -- the second argument skips the loadout, as rank will set it up. it can be kinda stressful on the server if you remove this
				ply:SetTeamRank(rank)
				set = true
				ply:Notify("You started the job as a "..rankData[rank].name.."! Go to the locker room to grab your outfit.")
			end

		end
	end
end)

net.Receive("impulseHL2RPTerminalCharge", function(len, ply)
	if ply:Team() != TEAM_CP then
		return
	end

	local count = net.ReadUInt(4)

	if not isnumber(count) or count > impulse.Config.MaxArrestCharges then
		return
	end

	local target = ply.ArrestedDragging
	if not target or not IsValid(target) or not ply:CanArrest(target) or target.InJail or target.BeingArrested then -- see if target is real and can be arrested
		return
	end

	target = Entity(ply.ArrestedDragging:EntIndex()) -- fix for an issue?

	if target:GetSyncVar(SYNC_ARRESTED, false) == false then -- see if target is arrested
		return
	end
	
	local charges = {}
	local sounds = {"npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav"}
	local chargeNames = ""
	local time = 0

	for i=1,count do
		local charge = net.ReadUInt(8)
		local chargeData = impulse.Config.ArrestCharges[charge]

		if chargeData then
			time = time + (chargeData.severity * 60)

			table.insert(charges, charge)
			table.insert(sounds, chargeData.sound)

			if i == count then
				chargeNames = chargeNames..chargeData.name
			else
				chargeNames = chargeNames..chargeData.name.." "
			end
		end
	end

	chargeNames = chargeNames.."."

	table.insert(sounds, "npc/overwatch/radiovoice/youarejudgedguilty.wav")

	local maxTime = impulse.Config.MaxJailTimeGrunt

	if ply:IsCPCommand() then
		maxTime = impulse.Config.MaxJailTime
	end

	time = math.Clamp(time, impulse.Config.MinJailTime, maxTime)

	target.BeingJailed = time
	local delay = ply:EmitQueuedSounds(sounds, 1)

	for v,k in pairs(player.GetAll()) do
		if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then 
			k:SendChatClassMessage(52, chargeNames, ply)
		end
	end

	timer.Simple(delay, function()
		if IsValid(target) and target:IsPlayer() then
			target:Jail(time, charges)
			target.BeingJailed = nil

			hook.Run("PlayerJailed", target, ply, time, charges)
		end
	end)
end)

net.Receive("impulseHL2RPUseLocker", function(lem, ply)
	if (ply.nextLocker or 0) > CurTime() then return end
	ply.nextLocker = CurTime() + 1

	if not ply:Team() == TEAM_CITIZEN then return end
	if not IsValid(ply.currentLocker) then return end
	if (ply:GetPos() - ply.currentLocker:GetPos()):LengthSqr() > (120 ^ 2) then return end

	if ply:GetBodygroup(impulse.Bodygroups["Shirt"]) == 8 or ply:GetBodygroup(impulse.Bodygroups["Shirt"]) == 9 then
		ply:SetBodygroup(impulse.Bodygroups["Shirt"], ply.lastTorsoBodygroup)

		hook.Run("HL2RPRebelState", ply, true)
	else
		ply.lastTorsoBodygroup = ply:GetBodygroup(impulse.Bodygroups["Shirt"])
		local normal = net.ReadBool()
		if normal then
			ply:SetBodygroup(impulse.Bodygroups["Shirt"], 8)
		else
			ply:SetBodygroup(impulse.Bodygroups["Shirt"], 9)
		end

		hook.Run("HL2RPRebelState", ply, false)
	end
end)

net.Receive("impulseHL2RPChargesRequest", function(len, ply)
	if (ply.nextChargesRequest or 0) > CurTime() then return end
	ply.nextChargesRequest = CurTime() + 2

	if not IsValid(ply.Terminal) then
		return
	end

	if not ply.Terminal:GetConvictIndex() then
		return
	end

	if not ply:CanUseTerminalConvicts() then
		return
	end

	local id = net.ReadUInt(8)
	local targ = Entity(id)
	
	if IsValid(targ) and targ:IsPlayer() and targ.InJail then
		local jailInfo = impulse.Arrest.Prison[targ.InJail][id]

		if jailInfo then
			local charges = jailInfo.jailData

			if charges then
				net.Start("impulseHL2RPChargesGet")
				net.WriteTable(charges)
				net.Send(ply)
			else
				ply:Notify("No charges data for "..targ:Nick()..".")
			end
		end
	end
end)

net.Receive("impulseHL2RPChargesEdit", function(len, ply)
	if (ply.nextChargesEdit or 0) > CurTime() then return end
	ply.nextChargesEdit = CurTime() + 2

	if not IsValid(ply.Terminal) then
		return
	end

	if not ply.Terminal:GetConvictIndex() then
		return
	end

	if not ply:CanUseTerminalConvicts() then
		return
	end

	local cycles = net.ReadUInt(8)
	local id = net.ReadUInt(8)
	local target = Entity(id)

	cycles = math.Clamp(cycles, 1, (impulse.Config.MaxJailTime / 60))

	if target and IsValid(target) and target:IsPlayer() and target.InJail then
		local jailInfo = impulse.Arrest.Prison[target.InJail][target:EntIndex()]

		if jailInfo then
			local start = jailInfo.start
			local oldDur = jailInfo.duration
			local newDur = cycles * 60
			local delta = (newDur + start) - CurTime()
			delta = math.Clamp(delta, 0, impulse.Config.MaxJailTime)

			timer.Adjust(target:UserID().."impulsePrison", delta, function()
				if IsValid(target) and target.InJail then
					target:UnJail()
				end
			end)

			impulse.Arrest.Prison[target.InJail][target:EntIndex()].duration = newDur
			target:SendJailInfo(delta)

			target:Notify("Your sentence has been changed to "..cycles.." cycles by a Civil Protection officer.")
			ply:Notify(target:Nick().."'s sentence has been changed to "..cycles.." cycles.")

			hook.Run("PlayerJailSentenceEdit", ply, target, oldDur, newDur)
		end
	end
end)

net.Receive("impulseHL2RPDemoteCP", function(len, ply)
	if (ply.nextDemoteCP or 0) > CurTime() then return end
	ply.nextDemoteCP = CurTime() + 2

	if not IsValid(ply.Terminal) then
		return
	end

	if ply:Team() != TEAM_CP or not ply:GetTeamRank() or ply:GetTeamRank() < RANK_DVL then
		return
	end

	local targ = net.ReadEntity()

	if not targ or not IsValid(targ) or not targ:IsPlayer() or targ:Team() != TEAM_CP then
		return
	end

	if targ:GetTeamRank() and targ:GetTeamRank() >= RANK_DVL or targ:IsAdmin() then
		return
	end

	if ply:GetTeamRank() == RANK_DVL and (ply.totalCPDemotes or 0) > 3 then
		return ply:Notify("You've demoted too many units.")
	end

	if targ.impulseData.CombineBan then
		return ply:Notify("Target already has an active combine ban.")
	end

	local cTime = os.time()
	local length = 30 -- 30 min

	if ply:GetTeamRank() == RANK_CMD then
		length = 2880 -- 2 days
	end

	length = length * 60

	local eTime = cTime + length

	targ.impulseData.CombineBan = eTime
	targ:SaveData()

	targ:SetTeam(impulse.Config.DefaultTeam)

	local howLong = string.NiceTime(length)

	targ:Notify("You have been demoted from CP by "..ply:Nick().." you will be unable to access combine teams for "..howLong..".")
	ply:Notify("You have demoted "..targ:Nick()..". They will be unable to access combine teams for "..howLong..".")
	ply.totalCPDemotes = (ply.totalCPDemotes or 0) + 1

	hook.Run("OnCPDemoted", ply, targ)
end)

net.Receive("impulseHL2RPInspectBody", function(len, ply)
	if (ply.nextBodyCheck or 0) > CurTime() then return end
	ply.nextBodyCheck = CurTime() + 2

	if ply:Team() != TEAM_CP or ply:GetTeamClass() != CLASS_JURY then
		return
	end

	local body = net.ReadEntity()

	if not IsValid(body) or body:GetClass() != "prop_ragdoll" then
		return
	end

	if body:GetPos():DistToSqr(ply:GetPos()) > (400 ^ 2) then
		return
	end

	if not body.Killer or not body.DmgInfo then
		return
	end

	local isCp = false

	if impulse.Anim.GetModelClass(body:GetModel()) == "metrocop" then
		isCp = true
	end

	local wep = body.DmgWep or "unknown"
	local killer

	if isCp and math.random(1, 1) == 1 and IsValid(body.Killer) and body.Killer:IsPlayer() and not body.Killer:IsCP() and not body.Inspected then
		killer = body.Killer:Nick()
	end
	local cantBOL = false
	if (body.Killer.lastDeath or 0) > (body.creationTime or 0) then
		cantBOL = true
	end

	if (not body.NoBodycamID and killer and not body.Killer:IsDispatchBOL()) and (not cantBOL) then
		body.Killer:AddDispatchBOL(10, 1200) -- assault on pt and 20 mins
		ply:Notify(killer.." has been automatically added to the BOL index.")
	end

	net.Start("impulseHL2RPInspectBodyComplete")
	net.WriteBool(body.FallDeath or false)
	net.WriteString(wep)
	net.WriteString(killer or "")
	net.WriteBool(cantBOL)
	net.Send(ply)

	body.Inspected = true
end)

-- for v,k in pairs(impulse.Config.TheatreMusic) do
	-- sound.Add({name = "impulseHL2RPTheatreMusic."..v, channel = CHAN_AUTO, volume = 1, level = 72, sound = k})
-- end

-- net.Receive("impulseHL2RPTheatreAction", function(len, ply)
	-- if (ply.nextTheatreAction or 0) > CurTime() then return end
	-- ply.nextTheatreAction = CurTime() + 1

	-- if not IsValid(ply.TheatreConsole) or ply.TheatreConsole:GetPos():DistToSqr(ply:GetPos()) > (400 ^ 2) or not ply:Alive() then
		-- return
	-- end

	-- local actionId = net.ReadUInt(8)
	-- local song = net.ReadString()
	-- local console = ply.TheatreConsole

	-- if actionId == 1 then
		-- console.ECurtain:Fire("toggle")
		-- ply:Notify("Toggled curtain.")
	-- elseif actionId == 2 then
		-- for v,k in pairs(console.ELights) do
			-- k:Fire("turnon")
		-- end

		-- for v,k in pairs(console.ELightProps) do
			-- k:SetSkin(0)
		-- end

		-- for v,k in pairs(console.ELightSpots) do
			-- k:Fire("lighton")
		-- end

		-- ply:Notify("Turned stage lights on.")
	-- elseif actionId == 3 then
		-- for v,k in pairs(console.ELights) do
			-- k:Fire("turnoff")
		-- end

		-- for v,k in pairs(console.ELightProps) do
			-- k:SetSkin(1)
		-- end

		-- for v,k in pairs(console.ELightSpots) do
			-- k:Fire("lightoff")
		-- end

		-- ply:Notify("Turned stage lights off.")
	-- elseif actionId == 4 then
		-- console.ESpeaker1:StopSound(console.ESpeaker1.soundscript or "")
		-- console.ESpeaker2:StopSound(console.ESpeaker2.soundscript or "")

		-- if impulse.Config.TheatreMusic[song] then
			-- local sscript = "impulseHL2RPTheatreMusic."..song
			-- console.ESpeaker1:EmitSound(sscript)
			-- console.ESpeaker1.soundscript = sscript
			-- console.ESpeaker2:EmitSound(sscript)
			-- console.ESpeaker2.soundscript = sscript
		-- end

		-- ply:Notify("Started playing "..song..".")
	-- elseif actionId == 5 then
		-- console.ESpeaker1:StopSound(console.ESpeaker1.soundscript or "")
		-- console.ESpeaker2:StopSound(console.ESpeaker2.soundscript or "")

		-- ply:Notify("Stopped music.")
	-- end
-- end)

net.Receive("impulseHL2RPRadioInDb", function(len, ply)
	if (ply.nextRadioIn or 0) > CurTime() then return end
	ply.nextRadioIn = CurTime() + 1

	if ply:Team() != TEAM_CP then
		return
	end

	local bd = net.ReadEntity()

	if not IsValid(bd) or bd:GetClass() != "prop_ragdoll" then
		return
	end

	if bd:GetPos():DistToSqr(ply:GetPos()) > (400 ^ 2) then
		return
	end

	if not bd.Killer or not bd.DmgInfo then
		return
	end

	if not (bd:GetSyncVar(SYNC_BODY_STATE, 0) == 1) then
		return
	end

	bd:SetSyncVar(SYNC_BODY_STATE, 2, true)
	ply:Notify("You have radioed in the body.")
	ply:Say("/rt got a db here 11-44")
end)

util.AddNetworkString("impulseRepresentativeOpenMenu")
util.AddNetworkString("impulseRepresentativeSelect")

net.Receive("impulseRepresentativeSelect", function(len, ply)
    local teamID = net.ReadUInt(8)

    if not ( IsValid(ply) and ply:Alive() and ply:Team() == teamID ) then
        return
    end

    local teamData = impulse.Teams.Data[teamID]
    if not ( teamData ) then
        return
    end

    local classID = net.ReadUInt(8)
    local classData = teamData.classes
    if not ( classID != 0 ) then
        ply:Notify("Select a class first!")
        return
    end

    if ( table.IsEmpty(classData) ) then
        error(teamData.name.." has no classes!")
    end

    if not ( classData[classID] ) then
        error("undefined class "..classID)
    end

    local rankID = net.ReadUInt(8)
    local rankData = teamData.ranks
    if ( teamData.rankRequired ) then
        if not ( rankID != 0 ) then
            ply:Notify("Select a rank first!")
            return
        end
    end

    local canBecomeClass, canBecomeClassMessage = impulse.Combine.CanBecomeTeamClass(ply, classID)
    if ( teamData.rankRequired ) then
        local canBecomeRank, canBecomeRankMessage = impulse.Combine.CanBecomeTeamRank(ply, rankID)
        if not ( canBecomeRank ) then
            if ( canBecomeRankMessage != nil or canBecomeRankMessage != "" ) then
                ply:Notify(tostring(canBecomeRankMessage))
            end

            return false
        end
    end

    if ( canBecomeClass ) then
        ply:ResetSubMaterials()
        ply:SetTeamClass(classID)
    else
        if ( canBecomeClassMessage != nil or canBecomeClassMessage != "" ) then
            ply:Notify(tostring(canBecomeClassMessage))
        end

        return false
    end

    if ( rankData and rankData[rankID] ) then
        ply:SetTeamRank(rankID)
    end

    if ( teamData.nameFormat and teamData.taglines ) then
        local randomTagline = teamData.taglines[math.random(1, #teamData.taglines)]
        local randomNumbers = math.random(1, 9999)
        local rpName = string.format(teamData.nameFormat, randomTagline, randomNumbers)
        ply:SetRPName(rpName)
    end

    ply:ScreenFade(SCREENFADE.IN, color_black, 10, 0)
    ply:EmitSound("items/ammo_pickup.wav")
    ply:EmitSound("items/nvg_on.wav")
end)

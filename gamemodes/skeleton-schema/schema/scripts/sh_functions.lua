local entityMeta = FindMetaTable("Entity")

function meta:IsRebel() -- if u want a smarter is rebel then make it SEPERATE to this func, this function should just be based off team,class and bodygroups/skins/models.
	if not self:Team() == TEAM_CITIZEN or TEAM_RESISTANCE then
		return false
	end

	if self:Team() == TEAM_CITIZEN then
		if (self:GetBodygroup(1) == 6) or (self:GetBodygroup(1) == 5) then -- if torso is rebel
			return true
		end
	end
	
	if self:Team() == TEAM_RESISTANCE then
		return true
	end

	if self:GetModel() == "models/vortigaunt.mdl" then
		return true
	end

	return false
end

CRIME_ANTCIITIZEN = 1
CRIME_VORT = 2
CRIME_WEAPON = 3
CRIME_CONTRABAND = 4
CRIME_EVASION = 5
CRIME_CURFEW = 6
CRIME_BOL = 7

CRIME_NICENAMES = {
	[CRIME_ANTCIITIZEN] = "Anti-Citizen",
	[CRIME_VORT] = "Unregistered Biotic",
	[CRIME_WEAPON] = "95, illegal carrying",
	[CRIME_EVASION] = "Surveillance Evasion",
	[CRIME_CURFEW] = "Escapade",
	[CRIME_BOL] = "BOL Target"
}

local unallowedWeps = {
	["m_smg"] = true,
	["m_usp"] = true,
	["m_rev"] = true,
	["m_ar2"] = true,
	["m_shotgun"] = true,
	["m_annabelle"] = true,
	["m_ak47"] = true,
	["ls_axe"] = true,
	["ls_crowbar"] = true,
	["ls_pipe"] = true,
	["ls_shovel"] = true
	
}

local strsub = string.sub
function meta:IsRebelSmart()
	local isCriminal = false
	local idKnown = true
	local firstCrime
	local crimes = {}

	if self.IsCP(self) then
		return false, false, {}
	end

	-- if self.HasFaceCover then -- has facewrap on
		-- isCriminal = true
		-- idKnown = false
		-- firstCrime = firstCrime or CRIME_EVASION
		-- crimes[CRIME_EVASION] = true
	-- end

	--if impulse.Dispatch.GetCityCode() >= CODE_JW and  then this would be too annoying imo
	--	isCriminal = true
	--end

	if idKnown and self:IsDispatchBOL() then
		isCriminal = true
		firstCrime = firstCrime or CRIME_BOL
		crimes[CRIME_BOL] = true
	end

	local wep = self.GetActiveWeapon(self)

	if IsValid(wep) then
		local wepclass = wep.GetClass(wep)

		if  unallowedWeps[wepclass] then
			isCriminal = true
			firstCrime = firstCrime or CRIME_WEAPON
			crimes[CRIME_WEAPON] = true
	
		end
	end
		local ZoneName = self:GetZoneName(self)
		if ZoneName == "404 Zone" then
		isCriminal = true
		firstCrime = firstCrime or CRIME_CURFEW
		crimes[CRIME_CURFEW] = true
		end

	local t = self.Team(self)

	if t == TEAM_CITIZEN and (self.GetBodygroup(self, 1) == 6 or self.GetBodygroup(self, 1) == 5) then -- rebel suit
		isCriminal = true
		firstCrime = firstCrime or CRIME_ANTCIITIZEN
		crimes[CRIME_ANTCIITIZEN] = true
	-- elseif t == TEAM_VORT and self.GetModel(self) != "models/vortigaunt_slave.mdl" then -- unshackled vort
		-- isCriminal = true
		-- firstCrime = firstCrime or CRIME_VORT
		-- crimes[CRIME_VORT] = true
	end

	-- if self.GasSafe or self.HasHelmet or self.HasOTAVest then
		-- isCriminal = true
		-- firstCrime = firstCrime or CRIME_ANTCIITIZEN
		-- crimes[CRIME_ANTCIITIZEN] = true
	-- end

	return isCriminal, idKnown, crimes, firstCrime
end

function meta:GetDigits()
	if not self:IsCP() then return end

	local digits = string.Right(self:Name(), 4)
	digits = tonumber(digits)

	if digits and isnumber(digits) then
		return digits
	end
end

-- function meta:IsCPCommand()
	-- local rank = self:GetTeamRank()
	-- if not rank then return false end

	-- if self:Team() == TEAM_CP then
		-- if rank >= RANK_OFC then
			-- return true
		-- end
	-- elseif self:Team() == TEAM_OTA then
		-- if rank >= RANK_LDR then
			-- return true
		-- end
	-- end

	-- return false
-- end

function meta:CanUseTerminalConvicts()
	if not self:Team() == TEAM_CP then
		return false
	end

	if self:IsCPCommand() then
		return true
	end

	local class = self:GetTeamClass()

	if class and class == CLASS_JURY then
		return true
	end
	
	return false
end

-- function impulse.CanNexusRaid()
	-- local cps = #team.GetPlayers(TEAM_CP)
	-- local otas = #team.GetPlayers(TEAM_OTA)
	-- local players = player.GetCount()
	-- local baddies = cps + otas
	-- local modCount = 0

	-- for k, ply in ipairs(player.GetHumans()) do
		-- if ply:IsAdmin() then
			-- modCount = modCount + 1
		-- end
	-- end

	-- if modCount == 0 then
		-- print("no mods?")
		-- return false
	-- end

	-- if (impulse.BoxRaidBypass or false) then
		-- return true
	-- end

	-- if baddies < 12 then
		-- return false
	-- end

	-- if otas < 3 then
		-- return false
	-- end

	-- if players < 40 then
		-- return false
	-- end

	-- return true
-- end

-- local gasMaskTeams = {
	-- --[TEAM_OTA] = true,
	-- [TEAM_CP] = true
-- }

-- function meta:HasGasMask()
	-- if gasMaskTeams[self.Team(self)] then
		-- return true
	-- end

	-- if self.GasSafe then
		-- return true
	-- end

	-- if self.GetMoveType(self) == MOVETYPE_NOCLIP then
		-- return true
	-- end

	-- return false
-- end

if SERVER then
	function entityMeta:EmitChargedSounds(charges)
		local queueTime = 0
		local duration = 0
		local speechBreak = 0.5

		table.insert(charges, 1, {sound = "npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav"})
		table.insert(charges, {sound = "npc/overwatch/radiovoice/youarejudgedguilty.wav"})

		for v,k in pairs(charges) do
			duration = SoundDuration(k.sound)
			
			timer.Simple(queueTime, function()
				if not IsValid(self) then return end

				self:EmitSound(k.sound)
			end)

			queueTime = queueTime + duration + speechBreak
		end

		return queueTime
	end

	function meta:AddRewardRation(amount)
		if not self.RewardRation then
			self:Notify("Your reward ration is now ready to be collected at the ration distribution center.")
			self:SurfacePlaySound("buttons/blip1.wav")
		end

		self.RewardRation = (self.RewardRation or 0) + amount
	end
end

function impulse.PlayGesture(ply, gesture, slot)

    if not ( ply ) then

        ply = LocalPlayer()

    end



    if not ( slot ) then

        slot = GESTURE_SLOT_CUSTOM

    end



    ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, ply:LookupSequence(gesture), 0, 1)
end

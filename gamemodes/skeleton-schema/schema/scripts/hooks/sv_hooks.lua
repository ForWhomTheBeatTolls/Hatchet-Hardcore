	--reloadmarker, make changes here then save to lua refr

	function SCHEMA:PlayerSpawn(ply)
		ply.NextHurtSound = CurTime()
		ply.TimesDamagedCool = CurTime()
		ply.TimesStunnedCool = CurTime()
		ply:SetNWInt("CombatCool", CurTime())
		ply:SetNWInt("ApplyWearTime", CurTime() + 120)
		ply.IsInASequence = false
		ply:SetNWBool("IsInCombat", false)
		ply:SetNWBool("Applied", true)
		ply.CanCrouch = true
		ply.CanJump = true
		ply.Stunned = false
		ply.TimesDamaged = 0
		ply.CombatCool = 0
		ply.TimesStunned = 0
		ply:SetNWInt("CarryWeight", 25)
		ply.FoodPoisoning = false
		ply.PendingReward = ply.PendingReward or 0
		ply.HealOverTime = false
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
		ply:RemoveAllDecals()
	end

	hook.Add("PostEntityTakeDamage","hatchetdamagefunctions",function(ent, dmg, took)
		if ent:IsPlayer() and took and ent.NextHurtSound < CurTime() then

			if dmg:IsDamageType(DMG_NERVEGAS) then
				ent:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav", 50)
			else

				if ( ent:Team() == TEAM_CP ) and (ent:Health() > 1) then
					ent:EmitSound("npc/metropolice/pain"..math.random(1,4)..".wav", 80)
				elseif ( ent:Team() == TEAM_OTA ) and (ent:Health() > 1) then
					ent:EmitSound("npc/combine_soldier/pain"..math.random(1,3)..".wav", 80)
				elseif ( ent:Team() == TEAM_CITIZEN or TEAM_RESISTANCE ) and (ent:Health() > 1) then
					ent:EmitSound("npc_citizen.pain0"..math.random(1,7).."", 80)
				end
				
				ent.NextHurtSound = CurTime() + 0.4
			end
			
			ent.IsInCombat = true
			ent.CombatCool = CurTime() + 30
			ent.TimesDamaged = ent.TimesDamaged + 1
			if ent.TimesDamagedCool < CurTime() then 
				ent.TimesDamagedCool = CurTime() + 0.5
			else 
				ent.TimesDamagedCool = ent.TimesDamagedCool + 0.7
			end
			
		end
		
		if IsValid(dmg:GetAttacker()) then
			dmg:GetAttacker():SetNWBool("IsInCombat", true)
			dmg:GetAttacker():SetNWInt("CombatCool", CurTime() + 30)
		end
		
	end)

	hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
			if ply:Team() == TEAM_CP then
				if !ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 30)
				elseif ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 70)
				end
			end
			
			if ply:Team() == TEAM_OTA  then
				if !ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 55)
				elseif ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 75)
				end
			end
			
			if ply.HasVest then
				if !ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/footsteps/hardboot_generic"..math.random(1,6)..".wav", 30)
				elseif ply:KeyDown(IN_SPEED) then
					ply:EmitSound("npc/footsteps/hardboot_generic"..math.random(1,6)..".wav", 70)
				end
			end
			
			if ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_WORKFORCE and not ply.HasVest then
				return false
			end
			
		return true
			
	end)

	local deathsounds = {
		"npc_citizen.die",
		"npc_citizen.startle01",
		"npc_citizen.startle02",
		"ep1_citizen.cit_pain04",
		"ep1_citizen.cit_pain06",
		"ep1_citizen.cit_pain07",
		"ep1_citizen.cit_shock02",
		"ep1_citizen.cit_shock08",
		"ep1_citizen.cit_shock11"
	}

	hook.Add( "PlayerDeathSound", "CustomPlayerDeath", function( ply )
		if (ply:Team() == TEAM_CP) then
		ply:EmitSound("npc/metropolice/die"..math.random(1,4)..".wav", 70)
		end
		if (ply:Team() == TEAM_OTA) then
		ply:EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 70)
		end
		if (ply:Team() == TEAM_CITIZEN) then
		ply:EmitSound(table.Random(deathsounds), 100)
		end
		if (ply:Team() == TEAM_RESISTANCE) then
		ply:EmitSound(table.Random(deathsounds), 100)
		end
		return true
	end )

	function SCHEMA:ChatClassMessageSend(classID, message, sender)
		if not impulse.Voice.ChatTypes[classID] then
			return
		end
		
		for _, definition in ipairs(impulse.Voice.GetClass(sender)) do
			local sounds, message = impulse.Voice.GetVoiceList(definition.class, message)

			if (sounds) then
				local volume = 70

				if classID == 7 then -- whisper
					volume = 30 
				elseif classID == 6 then -- yell
					volume = 100
				end
				
				if (definition.onModify) then
					if (definition.onModify(sender, sounds, classID, message) == false) then
						continue
					end
				end

				if (definition.isGlobal) then
					netstream.Start(nil, "voicePlay", sounds, volume)
				else
					netstream.Start(nil, "voicePlay", sounds, volume, sender:EntIndex())

					if classID == 8 then -- radio
						for v,k in pairs(player.GetAll()) do
							if k:IsCP() and k != client then
								netstream.Start(k, "voicePlay", sounds, volume * 0.5)
							end
						end
					end
				end

				return message
			end
		end
	end

	function SCHEMA:PlayerChangedTeam(ply, oldTeam, newTeam)

		if newTeam == TEAM_CITIZEN then
			ply:SetRPName(ply:GetSavedRPName())
			ply:SetNWInt("CarryWeight", 25)
		end
		
		if newTeam == TEAM_OTA then
			ply:SetNWInt("CarryWeight", 125)
		end

		if newTeam == TEAM_CP then
			ply:SetNWInt("CarryWeight", 25)
		end
		
		if ply:GetSyncVar(SYNC_RANKPOINTS, 0) == nil then
			ply:SetSyncVar(SYNC_RANKPOINTS, 0)
		end

		if oldTeam == TEAM_OTA then
			ply:SetNWInt("CarryWeight", 25)
		
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
	 end

	function SCHEMA:PlayerShouldGetHungry(ply)
		return ply:Team() != TEAM_OTA
	end

	function SCHEMA:DoInventorySearch(searcher, searchee)
		if searcher:Team() == TEAM_CP then
			searcher:ForceSequence("spreadwall")
		end
	end

	function SCHEMA:ChatStateChanged(ply, oldState, newState)
			ply.CPBeepCooldown = 0
		if (ply.CPBeepCooldown or 0) > CurTime() then
			return
		end

		if ply:GetNoDraw() or not ply:Alive() then
			return
		end

		if ply:Team() == TEAM_CP and ply.CPBeepCooldown < CurTime() then
			if newState then
				ply:EmitSound("NPC_MetroPolice.Radio.On", nil, nil, 1, CHAN_AUTO, SND_NOFLAGS, 1 )
			else
				ply:EmitSound("npc/metropolice/vo/off"..math.random(1, 4)..".wav", nil, nil, 1, CHAN_AUTO, SND_NOFLAGS, 1 )
			end

			ply.CPBeepCooldown = CurTime() + 2
		elseif ply:Team() == TEAM_OTA then
			if newState then
				ply:EmitSound("npc/combine_soldier/vo/on"..math.random(1, 2)..".wav", nil, nil, 1, CHAN_AUTO, SND_NOFLAGS, 1 )
			else
				ply:EmitSound("npc/combine_soldier/vo/off"..math.random(1, 3)..".wav", nil, nil, 1, CHAN_AUTO, SND_NOFLAGS, 1 )
			end
		end
	end

	function SCHEMA:PlayerDeath(ply, attacker)

		ply.lastDeath = CurTime()
		ply.IsInASequence = false
		
		if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
			impulse.Inventory.SpawnItem("item_kevlar", ply:GetPos())
		end
		
		if ply:GetSyncVar(SYNC_DISPATCH_BOL, nil) then
			ply:RemoveDispatchBOL()
		end
		
		if IsValid(attacker) and attacker:IsPlayer() then
			if attacker:GetSyncVar(SYNC_KILLS) == nil or not attacker:GetSyncVar(SYNC_KILLS)  then
			attacker:SetSyncVar(SYNC_KILLS, 1, true)
			else
			attacker:SetSyncVar(SYNC_KILLS, attacker:GetSyncVar(SYNC_KILLS) + 1, true)
			local query = mysql:Update("impulse_players")
			query:Update("kills", attacker:GetSyncVar(SYNC_KILLS))
			query:Where("steamid", attacker:SteamID())
			query:Execute()
			end
			attacker:PrintMessage( HUD_PRINTCONSOLE, "Kills: "..attacker:GetSyncVar(SYNC_KILLS) )
		end
		
		if ply:Team() == TEAM_CITIZEN then rpgainamount = 50
		elseif ply:Team() == TEAM_RESISTANCE then rpgainamount = 100
		elseif ply:Team() == TEAM_OTA then rpgainamount = -200
		elseif ply:Team() == TEAM_CP then rpgainamount = -100
		end
		
		
		if IsValid(attacker) and attacker:IsPlayer() then
			if IsValid(ply) and attacker != ply then
				if (attacker:Team() == TEAM_CP or attacker:Team() == TEAM_OTA) then
					if attacker:GetSyncVar(SYNC_RANKPOINTS) == nil or not attacker:GetSyncVar(SYNC_RANKPOINTS) then
						attacker:SetSyncVar(SYNC_RANKPOINTS, rpgainamount, true)
						local query = mysql:Update("impulse_players")
						query:Update("rankpoints", attacker:GetSyncVar(SYNC_RANKPOINTS))
						query:Where("steamid", attacker:SteamID())
						query:Execute()
					else
						attacker:SetSyncVar(SYNC_RANKPOINTS, attacker:GetSyncVar(SYNC_RANKPOINTS) + rpgainamount, true)
						local query = mysql:Update("impulse_players")
						query:Update("rankpoints", attacker:GetSyncVar(SYNC_RANKPOINTS))
						query:Where("steamid", attacker:SteamID())
						query:Execute()
					end
				end
			end
		elseif (ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA) then
			ply:SetSyncVar(SYNC_RANKPOINTS, ply:GetSyncVar(SYNC_RANKPOINTS) - 80)
		end
	end

	function SCHEMA:PlayerUnRestrain(ply)
	
		if ply:Team() == (TEAM_CP or TEAM_OTA) then
			ply:GiveInventoryItem("util_ziptie", 1, true)
		else
			ply:GiveInventoryItem("util_ziptie", 1, false)
		end
		
	end

	function SCHEMA:InitPostEntity()
	
		timer.Simple(15, function()
	
			for k, v in pairs( ents.FindByClass("impulse_item") ) do
				v:Initialize()
			end
			
			for k, v in pairs(	ents.FindByClass("npc_combine_camera") ) do
        		v:RepairCombineCamera()
				v:SetHealth(60)
				v:SetColor(Color(255,255,255,255))
			end
			
		end)
		
		RunConsoleCommand("mp_show_voice_icons", "0")
		
	print[[#    _    _           _                                                  _   _          __          __                                             ]]
	print[[#   | |  | |         | |                                                | | ( )         \ \        / /                                             ]]
	print[[#   | |  | |  _   _  | |__     __ _   _ __ ___    _ __ ___     ___    __| | |/   ___     \ \  /\  / /    ___    __ _   _ __     ___    _ __    ___ ]]
	print[[#   | |\/| | | | | | |  _ \   / _  | |  _   _ \  |  _   _ \   / _ \  / _  |     / __|     \ \/  \/ /    / _ \  / _  | |  _ \   / _ \  |  _ \  / __|]]
	print[[#   | |  | | | |_| | | | | | | (_| | | | | | | | | | | | | | |  __/ | (_| |     \__ \      \  /\  /    |  __/ | (_| | | |_) | | (_) | | | | | \__ \]]
	print[[#   |_|  |_|  \__,_| |_| |_|  \__,_| |_| |_| |_| |_| |_| |_|  \___|  \__,_|     |___/       \/  \/      \___|  \__,_| | .__/   \___/  |_| |_| |___/]]
	print[[#                                                                                                                     | |                          ]]

	end

	function SCHEMA:OnReloaded()
	
		timer.Simple(1, function()
	
			for k, v in pairs( ents.FindByClass("impulse_item") ) do
				v:Initialize()
			end
			
			for k, v in pairs(	ents.FindByClass("npc_combine_camera") ) do
        		v:RepairCombineCamera()
				v:SetHealth(60)
				v:SetColor(Color(255,255,255,255))
			end
			
		end)
		
	end


	function SCHEMA:Think()
	
		for k, v in pairs( ents.FindByClass("impulse_item") ) do
			v:SetPersistent(true)
		end
		
	end

	gameevent.Listen( "player_connect" )
	hook.Add("player_connect", "HatchetJANITORConnectNotif", function( data )
		for i, ply in pairs( player.GetAll() ) do
			ply:SendChatClassMessage(17, data.name.." Has connected to the server. SteamID: "..data.networkid, ply)
		end
	end)

	gameevent.Listen( "player_disconnect" )
	hook.Add( "player_disconnect", "HatchetJANITORDisconnectNotif", function( data )
		for i, ply in pairs( player.GetAll() ) do
			ply:SendChatClassMessage(18, data.name.." Has disconnected from the server. SteamID: "..data.networkid, ply)
		end
	end )

	function DeployOS()
		local posselector = math.random(1,3)
		for k,v in ipairs(player.GetAll()) do
			if ( v:Team() == TEAM_OTA ) and (v:GetTeamClass() == 1 or v:GetTeamClass() == 2 or v:GetTeamClass() == 3) and v:Alive() and v:IsValid() then
				for i=1,2 do
					local pos = Vector(-10059.227539, -5831.410645, 0.031250)
					local pos2 = Vector(-6860.460938, -7233.070312, 64.031250)
					local pos3 = Vector(-1853.559692, -735.352173, 92.386597)
					local trace = { start = v:GetPos(), endpos = v:GetPos(), filter = v }
					local tr = util.TraceEntity( trace, v )
					if posselector == 1 then
						v:SetPos(pos)
					elseif posselector == 2 then
						v:SetPos(pos2)
					elseif posselector == 3 then
						v:SetPos(pos3)
					end
					if ( tr.Hit ) then
						v:SetPos(impulse.FindEmptyPos(v:GetPos(), {v}, 600, 30, Vector(16, 16, 64)))
					end
				end
			end
		end
	end
	
	hook.Add( "PhysgunPickup", "AllowPickupPersistentEnts", function( ply, ent )
		if ply:IsAdmin() and ent:GetPersistent() then
			return true
		end
	end)
end

local function callhookremoval()
	hook.Add("CreateEntityRagdoll", "ZomficiationRadgollRemoval", function(owner, rdg)
		rdg:Remove()
	end)
end

hook.Add("PlayerDeath", "ZombificationTransformer", function(victim, inflictor, attacker)
	if attacker:GetClass() == "npc_headcrab" then
		local headcrab = ents.Create("npc_zombie")
		headcrab:SetPos(victim:GetPos())
		headcrab:Spawn()

		callhookremoval()

		victim:EmitSound( "npc/zombie/zombie_voice_idle6.wav", 75, 100, 1, CHAN_AUTO )
		victim:EmitSound( "npc/headcrab/headbite.wav", 75, 100, 1, CHAN_AUTO )

		attacker:Remove()
	end

	if attacker:GetClass() == "npc_headcrab_fast" then
		local headcrab = ents.Create("npc_fastzombie")
		headcrab:SetPos(victim:GetPos())
		headcrab:Spawn()

		callhookremoval()

		victim:EmitSound( "npc/fast_zombie/fz_alert_far1.wav", 75, 100, 1, CHAN_AUTO )
		victim:EmitSound( "npc/headcrab/headbite.wav", 75, 100, 1, CHAN_AUTO )

		attacker:Remove()
	end

	timer.Simple(1, function() hook.Remove("CreateEntityRagdoll", "ZomficiationRadgollRemoval") end)

end)

--reloadmarker, make changes here then save to lua refre

function SCHEMA:PlayerSpawn(ply)
	ply.IsInASequence = false
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
end

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

function SCHEMA:OnPlayerChangedTeam(ply)

	if ply:Team() != TEAM_CP or TEAM_OTA then
		ply:SetRPName(ply:GetSavedRPName())
	end
	
	if ply:GetSyncVar(SYNC_RANKPOINTS, 0) == nil then
		ply:SetSyncVar(SYNC_RANKPOINTS, 0)
	end
	
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
 end

function SCHEMA:PlayerShouldGetHungry(ply)
    -- cops will not get hungry
    return ply:Team() != TEAM_OTA
end

function SCHEMA:ScalePlayerDamage(ply, hitgroup, dmginfo)
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
	--ply:DoCustomAnimEvent(PLAYERANIMEVENT_FLINCH_CHEST, 1)
	
	if dmginfo:GetAmmoType() == game.GetAmmoID("Snark") then
		if hitgroup == HITGROUP_HEAD then
			dmginfo:ScaleDamage(0.7)
		end
	end
	 
	if ply:Team(ply) == TEAM_CP then
		dmginfo:ScaleDamage(0.7)
		end
	if ply:Team(ply) == TEAM_CP and (dmginfo:GetDamageType() == DMG_CLUB)  then
		dmginfo:ScaleDamage(1.5)
		end
	if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound"))  then
		dmginfo:ScaleDamage(1.2)
		end
	if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("357"))  then
		dmginfo:ScaleDamage(1.55)
		end
	if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2"))  then
		dmginfo:ScaleDamage(1.55)
		end
	if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot"))  then
		dmginfo:ScaleDamage(1.55)
		end
	if (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_LEFTARM) then
	dmginfo:ScaleDamage(2.8)
	end
	if ply:Team(ply) == TEAM_OTA then
		dmginfo:ScaleDamage(0.25)
	end
	if ply:Team(ply) == TEAM_OTA and ply:GetTeamClass() == 3 then
		dmginfo:ScaleDamage(0.8)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) then
		dmginfo:ScaleDamage(2.5)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) then
		dmginfo:ScaleDamage(2.4)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2")) then
		dmginfo:ScaleDamage(2.6)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) then
		dmginfo:ScaleDamage(1)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) and (hitgroup == HITGROUP_HEAD) then
		dmginfo:ScaleDamage(2.5)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) and (hitgroup == HITGROUP_HEAD) then
		dmginfo:ScaleDamage(3)
	end
	if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) and (hitgroup == HITGROUP_HEAD) then
		dmginfo:ScaleDamage(2.4)
	end
	if ply:Team(ply) == TEAM_CP and (hitgroup == HITGROUP_HEAD) then
	dmginfo:ScaleDamage(1.1)
	end
	if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) then
	dmginfo:ScaleDamage(0.7)
	end
	if (ply.WeldingMask == true) and (hitgroup == HITGROUP_HEAD) then
	dmginfo:ScaleDamage(0.55)
	end
	
end
	
	
hook.Add( "PlayerHurt", "HurtEffect", function(ply)
	ply:ScreenFade( SCREENFADE.IN, Color( 215, 0, 0, 128 ), 0.3, 0 )
end)
		

-- -- hook.Add( "PlayerShouldTakeDamage", "OSAcidImmunity", function( ply, attacker )
	-- -- if ply:Team() == TEAM_OTA and attacker:GetName() == "worldspawn" then
		-- -- return false -- that will block damage if attacker and ply is on the same team.
	-- -- end
-- -- end )
-- -- function SCHEMA:OnPlayerChangedTeam(ply, newTeam)
	-- -- local teamData = impulse.Teams.Data[newTeam]
	
	-- -- if newTeam = TEAM_OTA then
	-- -- ply.InventoryWeight = impulse.Config.OSInventoryMaxWeight
	-- -- end
	-- -- if ply:teamData = TEAM_CITIZEN then
	-- -- ply.InventoryWeight = impulse.Config.InventoryMaxWeight
	-- -- end
-- -- end

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
	ply:GiveInventoryItem("util_ziptie")
end

function SCHEMA:Initialize()

	for k, v in pairs( ents.FindByClass("impulse_item") ) do
		--v:SetPersistent(true)
		v:Initialize()
		
	end
	
	for k, v in pairs(	ents.FindByClass("npc_combine_camera") ) do
		v:Fire("sethealth", -100)
		--b:Activate()
	end
	
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
print[[#    _    _           _                                                  _   _          __          __                                             ]]
print[[#   | |  | |         | |                                                | | ( )         \ \        / /                                             ]]
print[[#   | |  | |  _   _  | |__     __ _   _ __ ___    _ __ ___     ___    __| | |/   ___     \ \  /\  / /    ___    __ _   _ __     ___    _ __    ___ ]]
print[[#   | |\/| | | | | | |  _ \   / _  | |  _   _ \  |  _   _ \   / _ \  / _  |     / __|     \ \/  \/ /    / _ \  / _  | |  _ \   / _ \  |  _ \  / __|]]
print[[#   | |  | | | |_| | | | | | | (_| | | | | | | | | | | | | | |  __/ | (_| |     \__ \      \  /\  /     |  _/  |(_| | | |_) | | (_) | | | | | \__ \]]
print[[#   |_|  |_|  \__,_| |_| |_|  \__,_| |_| |_| |_| |_| |_| |_|  \___|  \__,_|     |___/       \/  \/      \___|  \__,_| | .__/   \___/  |_| |_| |___/]]
print[[#                                                                                                                     | |                          ]]
		for k, v in pairs( ents.FindByClass("impulse_item") ) do
		--v:SetPersistent(true)
		v:Initialize()
		end
		
		for k, v in pairs(	ents.FindByClass("npc_combine_camera") ) do
			v:Fire("sethealth", -100)

			--b:Activate()
		end
end

-- local blacklist = {
-- "

function SCHEMA:Think()
	for k, v in pairs( ents.FindByClass("impulse_item") ) do
	v:SetPersistent(true)
	--timer.Simple(15, function() v:Initialize() end )
	
	end
	
	-- for _, ply in pairs(ply.GetAll()) do
		-- if table.HasValue(blacklist, ply:SteamID()) then
		-- ply:Kick()
		-- end
	-- end

end

hook.Add("OnNPCKilled", "NPCDropsHatchet", function(npc, attacker, inflictor)

	local duration = nil  //How much time do the drops exist for until they dissapear (nil makes them not dissapear at all)

	if npc:GetClass() == "npc_headcrab" or npc:GetClass() == "npc_headcrab_black" or npc:GetClass() == "npc_headcrab_fast" then
		impulse.Inventory.SpawnItem("item_bucket", npc:GetPos() + Vector(0, 0, 40), nil, duration)
	elseif npc:GetClass() == "npc_metropolice" then
		if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
			impulse.Inventory.SpawnItem("wep_smg", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_pistol" then
			impulse.Inventory.SpawnItem("wep_pistol", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_stunstick" then
			impulse.Inventory.SpawnItem("wep_stunstick", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		end
	elseif npc:GetClass() == "npc_combine_s" or npc:GetClass() == "CombinePrison" or npc:GetClass() == "PrisonShotgunner" or npc:GetClass() == "ShotgunSoldier" or npc:GetClass() == "CombineElite" then
		if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
			impulse.Inventory.SpawnItem("wep_smg", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_shotgun" then
			impulse.Inventory.SpawnItem("wep_shotgun", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_ar2" then
			impulse.Inventory.SpawnItem("wep_ar2", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		end
	elseif npc:GetClass() == "npc_rollermine" or npc:GetClass() == "npc_combine_camera" or npc:GetClass() == "npc_manhack" or npc:GetClass() == "npc_turret_ceiling" or npc:GetClass() == "npc_clawscanner" or npc:GetClass() == "npc_cscanner" then
		impulse.Inventory.SpawnItem("util_scrapmetal", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		impulse.Inventory.SpawnItem("util_scrapmetal", npc:GetPos() + Vector(0, 0, 30), nil, duration)
		impulse.Inventory.SpawnItem("util_refmetal", npc:GetPos() + Vector(0, 0, 20), nil, duration)
	elseif npc:GetClass() == "npc_crow" or npc:GetClass() == "npc_pigeon" or npc:GetClass() == "npc_seagull" then
		impulse.Inventory.SpawnItem("food_fish", npc:GetPos() + Vector(0, 0, 0), nil, duration)
	end
	
	//print(npc:GetClass().." Died while having a "..npc:GetActiveWeapon():GetClass())
end)

gameevent.Listen( "player_connect" )
hook.Add("player_connect", "AnnounceConnection", function( data )
	for i, ply in pairs( player.GetAll() ) do
		ply:SendChatClassMessage(17, data.name.." Has connected to the server.", ply)
	end
end)

gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "player_disconnect_example", function( data )
	for i, ply in pairs( player.GetAll() ) do
		ply:SendChatClassMessage(18, data.name.." Has disconnected from the server.", ply)
	end
end )

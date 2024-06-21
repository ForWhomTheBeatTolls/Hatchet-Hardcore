hook.Add("OnNPCKilled", "NPCDropsHatchet", function(npc, attacker, inflictor)

	local duration = nil  //How much time do the drops exist for until they dissapear (nil makes them not dissapear at all)
	local handbonenum = npc:LookupBone("ValveBiped.Bip01_R_Hand")
	local handpos
	if handbonenum then
		handpos = npc:GetBonePosition(npc:LookupBone("ValveBiped.Bip01_R_Hand"))
	else
		handpos = npc:GetPos()
	end

	if npc:GetClass() == "npc_headcrab" or npc:GetClass() == "npc_headcrab_black" or npc:GetClass() == "npc_headcrab_fast" then
		impulse.Inventory.SpawnItem("item_bucket", npc:GetPos() + Vector(0, 0, 20), nil, duration)
	elseif npc:GetClass() == "npc_metropolice" then
		if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
			impulse.Inventory.SpawnItem("wep_smg", handpos, nil, duration)
			impulse.Inventory.SpawnItem("ammo_smg", npc:GetPos() + Vector(0, 0, 20), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_pistol" then
			impulse.Inventory.SpawnItem("wep_pistol", handpos, nil, duration)
			impulse.Inventory.SpawnItem("ammo_pistol", npc:GetPos() + Vector(0, 0, 20), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_stunstick" then
			impulse.Inventory.SpawnItem("wep_stunstick", handpos, nil, duration)
		end
	elseif npc:GetClass() == "npc_combine_s" or npc:GetClass() == "CombinePrison" or npc:GetClass() == "PrisonShotgunner" or npc:GetClass() == "ShotgunSoldier" or npc:GetClass() == "CombineElite" then
		if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
			impulse.Inventory.SpawnItem("wep_smg", handpos, nil, duration)
			impulse.Inventory.SpawnItem("ammo_smg", npc:GetPos() + Vector(0, 0, 20), nil, duration)
			impulse.Inventory.SpawnItem("ammo_smg", npc:GetPos() + Vector(0, 0, 10), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_shotgun" then
			impulse.Inventory.SpawnItem("wep_shotgun", handpos, nil, duration)
			impulse.Inventory.SpawnItem("ammo_shotgun", npc:GetPos() + Vector(0, 0, 15), nil, duration)
			impulse.Inventory.SpawnItem("ammo_shotgun", npc:GetPos() + Vector(0, 0, 10), nil, duration)
		elseif npc:GetActiveWeapon():GetClass() == "weapon_ar2" then
			impulse.Inventory.SpawnItem("wep_ar2", handpos, nil, duration)
			impulse.Inventory.SpawnItem("ammo_ar2", npc:GetPos() + Vector(0, 0, 15), nil, duration)
			impulse.Inventory.SpawnItem("ammo_ar2", npc:GetPos() + Vector(0, 0, 10), nil, duration)
		end
	elseif npc:GetClass() == "npc_rollermine" or npc:GetClass() == "npc_combine_camera" or npc:GetClass() == "npc_manhack" or npc:GetClass() == "npc_turret_ceiling" or npc:GetClass() == "npc_clawscanner" or npc:GetClass() == "npc_cscanner" then
		impulse.Inventory.SpawnItem("util_scrapmetal", npc:GetPos() + Vector(0, 0, 40), nil, duration)
		impulse.Inventory.SpawnItem("util_scrapmetal", npc:GetPos() + Vector(0, 0, 30), nil, duration)
		impulse.Inventory.SpawnItem("util_refmetal", npc:GetPos() + Vector(0, 0, 20), nil, duration)
	elseif npc:GetClass() == "npc_crow" or npc:GetClass() == "npc_pigeon" or npc:GetClass() == "npc_seagull" then
		impulse.Inventory.SpawnItem("food_crow", npc:GetPos() + Vector(0, 0, 25), nil, duration)
	end
	
	for k,v in pairs(ents.FindByClass("impulse_item")) do
		if v:GetPos():DistToSqr(npc:GetPos()) < 600 then
		v:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		v:SetVelocity(Vector(0,0,0))
		end
	end
	
	//print(npc:GetClass().." Died while having a "..npc:GetActiveWeapon():GetClass())
end)

hook.Add( "CreateEntityRagdoll", "NPCDropsRagdollsHatchet", function(owner, ragdoll)
	if owner:GetClass() == "npc_crow" or owner:GetClass() == "npc_pigeon" or owner:GetClass() == "npc_seagull" then
		ragdoll:Remove()
	end
end)

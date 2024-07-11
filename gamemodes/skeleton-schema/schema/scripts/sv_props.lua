hook.Add("PlayerSpawnProp", "HatchetBuildReq", function(ply, model)
		if ( !ply:HasInventoryItem("tool_buildkit") and !ply:IsSuperAdmin() ) then
			ply:Notify("You need a building kit to spawn props.")
			return false
		end
		if ( ply:IsSuperAdmin() ) then	
			return true
		end
	return true
end)

hook.Add("PlayerSpawnedProp", "HatchetBuildFunc", function(ply, model, ent)

	if ply:HasInventoryItem("tool_buildkit") then
		ent.IsBKitProp = true
	elseif ply:IsAdmin() and !ply:HasInventoryItem("tool_buildkit") then
		ent.IsAdminProp = true
	else
		ent.IsUnknownProp = true
	end
	
	if IsValid(ent:GetPhysicsObject()) then
		local phys = ent:GetPhysicsObject()
		ent:SetHealth(phys:GetMass() * 1.35)
	end
	
end)

hook.Add("CanProperty", "HatchetPropertyFixer", function( ply, property, ent )
        
    if (ply:IsSuperAdmin()) then
		
			return true
			
	end
	
	if IsValid(ent:CPPIGetOwner()) then
	
		if (ent:CPPIGetOwner() == ply) then
		
			if property == "skin" then return true
			elseif property == "bodygroups" then return true
			elseif property == "remove" then return true
            end             
		
		elseif (ply:IsAdmin() or ply:IsSuperAdmin()) then
		
			return true
			
		end
	
    end
	
	return false
	
end)

--- PROP DAMAGE ---

local metal = {
"physics/metal/metal_box_break1.wav",
"physics/metal/metal_box_break2.wav"
}

local paintcan = {
"physics/metal/paintcan_impact_hard1.wav",
"physics/metal/paintcan_impact_hard2.wav",
"physics/metal/paintcan_impact_hard3.wav"
}

local plastic = {
"physics/plastic/plastic_barrel_break1.wav",
"physics/plastic/plastic_barrel_break2.wav"
}

local wood = {
"physics/wood/wood_box_break1.wav",
"physics/wood/wood_box_break2.wav",
"physics/wood/wood_crate_break1.wav",
"physics/wood/wood_crate_break2.wav",
"physics/wood/wood_crate_break3.wav",
"physics/wood/wood_crate_break4.wav"
}

local porce = {
"physics/glass/glass_pottery_break1.wav",
"physics/glass/glass_pottery_break2.wav",
"physics/glass/glass_pottery_break3.wav",
"physics/glass/glass_pottery_break4.wav"
}

local chain = {
"physics/metal/metal_chainlink_impact_hard1.wav",
"physics/metal/metal_chainlink_impact_hard2.wav",
"physics/metal/metal_chainlink_impact_hard3.wav"
}

local concrete = {
"physics/concrete/concrete_break2.wav",
"physics/concrete/concrete_break3.wav"
}

local glass = {
"physics/glass/glass_largesheet_break1.wav",
"physics/glass/glass_largesheet_break2.wav",
"physics/glass/glass_largesheet_break3.wav"
}

hook.Add("EntityTakeDamage", "HatchetPropDamage", function(target, dmginfo)
	if IsValid(target:GetPhysicsObject()) and IsValid(target:CPPIGetOwner()) and (target:GetClass() == "prop_physics") then
		target:SetHealth(target:Health() - dmginfo:GetDamage())
		local surf = target:GetBoneSurfaceProp(0)
		--print(surf)
		--print(target:Health())
		if target:Health() <= 0 then
			if (surf == "metal" or surf == "metal_barrel") then
				target:EmitSound(table.Random(metal), 120)
			elseif surf == "popcan" then
				target:EmitSound(table.Random(paintcan), 90)
			elseif (surf == "plastic_barrel" or surf == "plastic")then
				target:EmitSound(table.Random(plastic), 100)
			elseif (surf == "wood" or surf == "wood_crate") then
				target:EmitSound(table.Random(wood), 70)
			elseif surf == "porcelain" then
				target:EmitSound(table.Random(porce), 90)
			elseif surf == "chainlink" then
				target:EmitSound(table.Random(chain), 90)
			elseif surf == "concrete" then
				target:EmitSound(table.Random(concrete), 90)
			elseif surf == "combine_glass" then
				target:EmitSound(table.Random(glass), 90)
			end
			target:Remove()
		end
	end
end)

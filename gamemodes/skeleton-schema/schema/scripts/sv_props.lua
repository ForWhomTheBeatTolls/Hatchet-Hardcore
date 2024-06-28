hook.Add("PlayerSpawnProp", "HatchetBuildReq", function(ply, model)
	if ( !ply:HasInventoryItem("tool_buildkit") ) then
		ply:Notify("You require a building kit to spawn props.")
		return false
	end
end

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
		ent:SetHealth(phys:GetMass() * 1.15)
	end
	
end)

hook.Add("CanProperty", "HatchetPropertyFixer", function( ply, property, ent )
	
	if IsValid(ent:CPPIGetOwner()) then
	
		if (ent:CPPIGetOwner() == ply) && (!ply:IsAdmin or !ply:IsSuperAdmin()) then
		
			if property == "skin" then return true end
			if property == "bodygroups" then return true end
			if property == "remove" then return true end
			
			return false
		
		elseif (ply:IsAdmin() or ply:IsSuperAdmin()) then
		
			return true
			
		end
		
	end
	
	return false
	
end)

--- PROP DAMAGE ---

hook.Add("EntityTakeDamage", "HatchetPropDamage", function(target, dmginfo)
	if target:IsProp() and IsValid(ent:CPPIGetOwner()) then
		if target:Health() <= 0 then
			target:PrecacheGibs()
			target:GibBreakClient(target:GetVelocity())
		end
	end
end)

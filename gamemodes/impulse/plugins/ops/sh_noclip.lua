hook.Add("PlayerNoClip", "opsNoclip", function(ply, state)
	if ply:IsAdmin() then
		if SERVER then
			if state then
				impulse.Ops.Cloak(ply)
				ply:GodEnable()
				ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				ply:SetNoTarget(true)

				if ply:FlashlightIsOn() then
					ply:Flashlight(false)
				end

				ply:AllowFlashlight(false)
			else
				impulse.Ops.Uncloak(ply)
				ply:GodDisable()
				ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				ply:AllowFlashlight(true)
				ply:SetNoTarget(false)
			end
		end

		return true
	end

	return false
end)
hook.Add("PlayerEnteredVehicle", "opsVehicleDamageFix", function(ply, veh, role)
	ply:GodDisable()
	ply:SetNoTarget(false)
	ply:AllowFlashlight(true)
	impulse.Ops.Uncloak(ply)
	ply.InSeat = true
end)

local CMoveData = FindMetaTable("CMoveData")

function CMoveData:RemoveKeys(keys)
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end

hook.Add("SetupMove", "HatchetMovementRestrictFunctions", function(ply, mvd, cmd)
	if mvd:KeyDown(IN_JUMP) then
		if not ply.CanJump then
			mvd:RemoveKeys(IN_JUMP)
		end
		if ply:Team() == TEAM_DISPATCH then
			mvd:RemoveKeys(IN_JUMP)
		end
	end
	
	if mvd:KeyDown(IN_DUCK) then
		if not ply.CanCrouch then
			mvd:RemoveKeys(IN_DUCK)
		end
		if ply:Team() == TEAM_DISPATCH then
			mvd:RemoveKeys(IN_DUCK)
		end
	end

	if mvd:KeyDown(IN_FORWARD) then
		if ply:Team() == TEAM_DISPATCH then
			mvd:SetForwardSpeed( 0 )
		end
	end

	if mvd:KeyDown(IN_MOVELEFT) then
		if ply:Team() == TEAM_DISPATCH then
			mvd:SetSideSpeed( 0 )
		end
	end

	if mvd:KeyDown(IN_SPEED) then
		if ply:GetActiveWeapon():GetClass() == "ls_suitcase" or ply:GetActiveWeapon():GetClass() == "ls_femalesuitcase" then
			if ply:IsWalking() then
				mvd:SetForwardSpeed( impulse.Config.WalkSpeed )
			else
				mvd:SetForwardSpeed( 0 )
			end
		end
	end



	if mvd:KeyDown(IN_MOVERIGHT) then
		if ply:Team() == TEAM_DISPATCH then
			mvd:SetSideSpeed( 0 )
		end
	end

	if mvd:KeyDown(IN_BACK) then
		if ply:Team() == TEAM_DISPATCH then
			mvd:SetForwardSpeed( 0 )
		end
	end
	
end)

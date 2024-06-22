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
	end
	
	if mvd:KeyDown(IN_DUCK) then
		if not ply.CanCrouch then
			mvd:RemoveKeys(IN_DUCK)
		end
	end
	
end)

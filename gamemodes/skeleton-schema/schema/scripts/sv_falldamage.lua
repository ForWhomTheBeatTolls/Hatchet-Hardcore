hook.Add( "OnPlayerHitGround", "HatchetCalculateFallDamage", function(ply, inWater, onFloater, speed)
local fallconditions = (speed > 450 and not inWater)
	if fallconditions and not ply:Crouching() then
		falldamage = speed / 7
	elseif fallconditions and ply:Crouching() then
		falldamage = speed / 12
	elseif not fallconditions then
		falldamage = 0
	end
	
	if fallconditions then
	local fall = DamageInfo()
	fall:SetDamage(falldamage)
	fall:SetAttacker(Entity(0))
	fall:SetInflictor(Entity(0))
	fall:SetDamageType(DMG_FALL)
	ply:TakeDamageInfo(fall)
	ply:EmitSound("player/pl_fallpain3.wav", 75, 100, 1, CHAN_BODY)
		if falldamage > 55 then
			ply:BreakLegs()
		end
	end
	
end)

hook.Add( "GetFallDamage", "HatchetFallDamage", function( ply, speed )
    return ( 0 )
end )

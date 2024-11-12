hook.Add( "OnPlayerHitGround", "HatchetCalculateFallDamage", function(ply, inWater, onFloater, speed)
local maxspeed

	if ply:Crouching() then
		maxspeed = 530
	else
		maxspeed = 410
	end

local fallconditions = (speed >  maxspeed and not inWater)
	if fallconditions and not ply:Crouching() then
		falldamage = speed / 7
	elseif fallconditions and ply:Crouching() then
		falldamage = speed / 12
	elseif not fallconditions then
		falldamage = 0
	end
	
	if fallconditions then
	local fall = DamageInfo()
	local leg = {"RLeg", "LLeg"}
	fall:SetDamage(falldamage)
	fall:SetAttacker(Entity(0))
	fall:SetInflictor(Entity(0))
	fall:SetDamageType(DMG_FALL)
	
	ply:TakeDamageLimb(table.Random(leg), falldamage * 2.4)
	-- if ply:GetNWBool("LLegCrippled") == true then
		-- ply:Notify("Your Left Leg feels numb!")
	-- end
	-- if ply:GetNWBool("RLegCrippled") == true then
		-- ply:Notify("Your Right Leg feels numb!")
	-- end
	
	ply:TakeDamageInfo(fall)
	ply:EmitSound("player/pl_fallpain3.wav", 75, 100, 1, CHAN_BODY)
		-- if falldamage > 55 then
			-- ply:BreakLegs()
		-- end
	end
	
end)

hook.Add( "GetFallDamage", "HatchetFallDamage", function( ply, speed )
    return ( 0 )
end )

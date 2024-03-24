-- put clientside hooks here, format the same as sv_hooks.lua
-- function SCHEMA:PlayerFootstep(ply, pos, foot, soundName, vol)
	-- if ply:KeyDown(IN_SPEED) then
		-- if ply:Team() == TEAM_CP then
			-- if ply == LocalPlayer() then
				-- EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, 65 / 100)
			-- else
				-- ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 90)
			-- end

			-- return true
		-- elseif ply:Team() == TEAM_OTA then
			-- if ply == LocalPlayer() then
				-- EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, 65 / 100)
			-- else
				-- ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 100)
			-- end
			-- end
			-- end
			-- end
			
			--local TADieSounds = {
			--"npc/combine_soldier/die1.wav",
			--"npc/combine_soldier/die2.wav",
			--"npc/combine_soldier/die3.wav"
			--}
-- hook.Add( "PlayerDeathSound", "CustomPlayerDeath", function( ply )
		-- if ply:Team() == TEAM_OTA then
			-- ply:EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 90) //// BROKEN AND DOES JACK.
	-- return true -- we don't want the default sound!
	-- end
-- end )

-- hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
		-- if ply:KeyDown(IN_SPEED) then
		-- if ply:Team() == TEAM_CP then
			-- if ply == LocalPlayer() then
				-- EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, 65 / 100)
			-- else
				-- ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 90)
			-- end

			-- return true
		-- elseif ply:Team() == TEAM_OTA then
			-- --if ply == LocalPlayer() then
				-- EmitSound("NPC_CombineS.FootstepLeft", ply:GetPos(), 100, 100)
			-- --else
				-- --ply:EmitSound("NPC_CombineS.FootstepLeft",100)
			-- end
			-- end--Play the footsteps 
	-- return true -- Don't allow default footsteps, or other addon footsteps
-- end)

hook.Add("PlayerHurt","dmgsounds",function(victim)
    if ( victim:Team() == TEAM_CP ) then
        victim:EmitSound("npc/metropolice/pain"..math.random(1,4)..".wav", 90)
	elseif ( victim:Team() == TEAM_OTA ) then
		victim:EmitSound("npc/combine_soldier/pain"..math.random(1,3)..".wav", 90)
    end
end)
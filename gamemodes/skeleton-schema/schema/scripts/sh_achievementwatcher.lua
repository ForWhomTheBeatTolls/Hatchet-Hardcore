if SERVER then
	
hook.Add("PlayerDeath", "impulseAchDeath", function(ply, inflictor, attacker)
		if attacker:IsPlayer() then
			if not attacker:AchievementHas("ach_akill") == true then
				attacker:AchievementGive("ach_akill")
			end
		end
		if ply:Team() == TEAM_OTA and (attacker:IsPlayer()) and (attacker != ply) then
			if not attacker:AchievementHas("ach_acombine2") == true then
				attacker:AchievementGive("ach_combine2")
			end
		end
		if ply:Team() == TEAM_CP and (attacker:IsPlayer()) and (attacker != ply) then
			if not attacker:AchievementHas("ach_acombine1") == true then
				attacker:AchievementGive("ach_combine1")
			end
		end
		
		ply:AchievementGive("ach_adie")
end)
	hook.Add("PlayerSay", "impulseChatAchWatch", function(ply, text)
			if
		text == "I keep falling, but never falling six feet deep." or
		text == "I keep falling, but never falling six feet deep" or
		text == "i keep falling, but never falling six feet deep." or
		text == "i keep falling, but never falling six feet deep" then
				if not ply:AchievementHas("ach_a6feet") then
					ply:AchievementGive("ach_6feet")
				end
			end
		end)
		
end

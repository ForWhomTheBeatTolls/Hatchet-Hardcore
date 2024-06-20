if SERVER then
	hook.Add("PlayerDeath", "impulseAchDeath", function(ply, inflictor, attacker)
	if SERVER then
		if not attacker:IsPlayer() then return end
		if not ply:Alive() then
			ply:AchievementGive("ach_adie")
		end
		if attacker:IsPlayer() and attacker:Alive() then
			attacker:AchievementGive("ach_akill")
		end
		if ply:Team() == TEAM_OTA and (attacker:IsPlayer()) and (attacker != ply) then
			attacker:AchievementGive("ach_combine2")
		end
		if ply:Team() == TEAM_CP and (attacker:IsPlayer()) and (attacker != ply) then
			attacker:AchievementGive("ach_combine1")
		end
	end
end)
	hook.Add("PlayerSay", "impulseChatAchWatch", function(ply, text)
			if
		text == "I keep falling, but never falling six feet deep." or
		text == "I keep falling, but never falling six feet deep" or
		text == "i keep falling, but never falling six feet deep." or
		text == "i keep falling, but never falling six feet deep" then
		ply:AchievementGive("ach_6feet")
			end
		end)
    end

function VitalSystem()
	for k,v in pairs(player.GetAll()) do
		if v:Team() != TEAM_OTA and v:GetModel() != ("models/player.mdl") then
			v:SetRunSpeed(impulse.Config.JogSpeed + (v:GetSkillXP("vital") / 204.545) )
		elseif v:Team() == TEAM_OTA and v:GetModel() != ("models/player.mdl") then
			v:SetRunSpeed(184.40)
		end
	end
end

local delay = CurTime()
hook.Add( "Think", "vitdelay1", function()
	if (CurTime() > delay) then
		VitalSystem()
		delay = CurTime() + 2
	end
end)

local delay2 = CurTime()
hook.Add( "Think", "vitdelay2", function()
	if (CurTime() > delay2) then 
		for k, v in pairs(player.GetAll()) do
			v:AddSkillXP("vital", -1)
		end
	delay2 = CurTime() + 240 -- Makes every 4 secs run the code
	end
end)

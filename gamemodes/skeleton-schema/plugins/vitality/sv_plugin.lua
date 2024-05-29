
function VitalSystem()
		for k,v in pairs(player.GetAll()) do
		if v:Team() != TEAM_OTA and v:GetModel() != ("models/player.mdl") then
			v:SetRunSpeed(impulse.Config.JogSpeed + (v:GetSkillXP("vital") / 204.545) )
			-- if v:GetSkillXP("vital") <= 299 then
				-- --v:Say("Under 300")
				-- v:SetRunSpeed(impulse.Config.JogSpeed)
			-- elseif v:GetSkillXP("vital") <= 300 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed  * 1.02)
				-- --v:Say("300")
			-- elseif v:GetSkillXP("vital") <= 600 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.04)
				-- --v:Say("600")
			-- elseif v:GetSkillXP("vital") <= 1499 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.04)
				-- --v:Say("600")
			-- elseif v:GetSkillXP("vital") <= 1500 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.05)
				-- --v:Say("1500")
			-- elseif v:GetSkillXP("vital") <= 2799 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.05)
				-- --v:Say("1500")
			-- elseif v:GetSkillXP("vital") <= 2800 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
				-- --v:Say("2800")
			-- elseif v:GetSkillXP("vital") <= 4499 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
				-- --v:Say("2800")
			-- elseif v:GetSkillXP("vital") <= 4500 then
				-- v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
				-- --v:Say("4500")
			-- end
		elseif v:Team() == TEAM_OTA and v:GetModel() != ("models/player.mdl") then
			v:SetRunSpeed(184.40)
		end
		end
end

delay = CurTime()
hook.Add( "Think", "vitdelay1", function()
	if CurTime() < delay then return end	
    VitalSystem()
	delay = CurTime() + 0.4 -- Makes every 4 secs run the code
    --print(Entity(1):GetSkillXP("vital"))
end)

delay2 = CurTime()
hook.Add( "Think", "vitdelay2", function()
	if CurTime() < delay2 then return end	
    for k, v in pairs(player.GetAll()) do
        v:AddSkillXP("vital", -1)
    end
	delay2 = CurTime() + 240 -- Makes every 4 secs run the code
    --print(Entity(1):GetSkillXP("vital"))
end)

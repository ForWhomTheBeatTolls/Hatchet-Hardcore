delay2 = CurTime()
hook.Add( "Think", "shootskilldelay2", function()
	if CurTime() < delay2 then return end	
    for k, v in pairs(player.GetAll()) do
        v:AddSkillXP("shooting", math.random(-4, -1))
    end
	delay2 = CurTime() + 240 -- Makes every 4 secs run the code
    --print(Entity(1):GetSkillXP("vital"))
end)

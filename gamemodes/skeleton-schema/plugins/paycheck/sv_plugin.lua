local paycheckdelay = CurTime() + 600

function PLUGIN:Think()
	if CurTime() > paycheckdelay then
		for k,v in pairs(player.GetAll()) do
			if v:Team() == TEAM_CITIZEN then
				v:GiveBankMoney(5)
			elseif v:Team() == TEAM_CP then
				v:GiveBankMoney(15)
			elseif v:Team() == TEAM_WORKFORCE then
				v:GiveBankMoney(10)
			elseif v:Team() == TEAM_RESISTANCE then
				v:GiveBankMoney(1)
			end
		end
	paycheckdelay = CurTime() + 600
	end
end

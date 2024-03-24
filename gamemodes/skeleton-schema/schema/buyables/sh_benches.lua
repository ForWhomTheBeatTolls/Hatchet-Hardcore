impulse.Business.Define("General Workbench", {
	bench = "general",
	model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl",
    refund = false,
	price = 50,
    removeOnTeamSwitch = false,
    customCheck = function(ply)
        -- you can write any code here to check if they should be allowed to spawn it, return false for no, true for yes

    	return true
    end
})
impulse.Business.Define("Microwave", {
	bench = "microwave",
	model = "models/props/CS_militia/stove01.mdl",
    refund = false,
	price = 10,
    removeOnTeamSwitch = false,
    customCheck = function(ply)
        -- you can write any code here to check if they should be allowed to spawn it, return false for no, true for yes

    	return true
    end
})

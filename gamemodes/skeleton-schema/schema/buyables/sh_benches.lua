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
impulse.Business.Define("Barrel", {
    entity = "m_barrel",
    model = "models/props_c17/oildrum001.mdl", -- old: models/props_junk/wood_crate002a.mdl
    description = "Can store fuel.",
    price = 150,
    refund = true,
	teams = {TEAM_RESISTANCE},
    postSpawn = function(ent, ply)
        ent:SetOwner(ply)
    end
})

--impulse.Config.MapWorkshopID = "99999999" commented out cause gm_construct has no workshop file, if your map does, put it here and all clients will download it!

impulse.Config.MenuCamPos = Vector(-3531.849365, -2581.553955, 117.032791)
impulse.Config.MenuCamAng = Angle(-21.510452, 131.078705, 0.000000)

impulse.Config.SpawnPos1 = Vector(-6970.562012, -1981.045776, 65.752151)
impulse.Config.SpawnPos2 = Vector(-6803.397461, -2117.691406, 67.050522)
impulse.Config.SpawnPos3 = Vector(-6317.864258, -1975.392334, 66.888390)
impulse.Config.SpawnPos4 = Vector(-6342.052246, -2101.275391, 66.742241)
impulse.Config.SpawnPos5 = Vector(-6063.499512, -2099.411133, 66.672424)
impulse.Config.SpawnPos6 = Vector(-6020.071777, -1989.494995, 66.784615)

impulse.Config.BlacklistEnts = {
	["game_text"] = true,
	["item_healthcharger"] = true,
	["item_suitcharger"] = true,
	["npc_template_maker"] = true
}

impulse.Config.Zones = {
	{name = "Spawn", pos1 = Vector(-7273.3833007813, -2595.669921875, -43.829444885254), pos2 = Vector(-5036.5541992188, -1508.5622558594, 560.92633056641)},
	{name = "Precinct 9", pos1 = Vector(-3050.6494140625, -798.19805908203, -25.602670669556), pos2 = Vector(-1267.1274414063, -2943.8610839844, 892.61614990234)},
	{name = "Residential Alley", pos1 = Vector(-3010.1164550781, -4409.4243164063, -23.718994140625), pos2 = Vector(-3776.1584472656, -5183.5546875, 292.00234985352)},
	{name = "Park", pos1 = Vector(-5547.5732421875, -4159.322265625, -21.217350006104), pos2 = Vector(-4426.6928710938, -3329.6650390625, 539.16619873047)},
	{name = "Trainstation ", pos1 = Vector(-6044.3056640625, -3123.2836914063, -19.604333877563), pos2 = Vector(-3563.6606445313, -2624.2075195313, 270.56390380859)},
	{name = "Residential Area", pos1 = Vector(-3586.0170898438, -4405.5083007813, -20.305110931396), pos2 = Vector(-4424.2431640625, -3330.3833007813, 246.23028564453)},
	{name = "Apartments", pos1 = Vector(-5549.1806640625, -4166.3344726563, 15.955545425415), pos2 = Vector(-3821.6979980469, -5055.060546875, 535.77081298828)},
	{name = "404 Zone", pos1 = Vector(-9168.6923828125, -8200.7099609375, 24.492225646973), pos2 = Vector(-9522.1220703125, -6776.748046875, 455.9382019043)},
	{name = "Precinct 15", pos1 = Vector(-2385.45703125, -5196.92578125, -16.187959671021), pos2 = Vector(-8981.90625, -7336.0034179688, 1450.7478027344)},
	{name = "Transitional Checkpoint", pos1 = Vector(-2638.9782714844, -4907.0439453125, -5.0257325172424), pos2 = Vector(-1833.0207519531, -5630.2075195313, 470.625)},
	{name = "CP Checkpoint", pos1 = Vector(-6762.4379882813, -1410.2888183594, -50.84561920166), pos2 = Vector(-5245.5297851563, -410.13027954102, 364.70056152344)},
	{name = "CP Armory", pos1 = Vector(-5220.5493164063, -549.63690185547, -21.520723342896), pos2 = Vector(-4421.8564453125, 199.36500549316, 343.41882324219)},
	{name = "Amputation Zone", pos1 = Vector(-4163.4790039063, 315.99261474609, 225.85522460938), pos2 = Vector(-4405.9306640625, -117.49286651611, -38.137237548828)},
	{name = "CP Checkpoint Exit", pos1 = Vector(-5211.1000976563, -626.81628417969, 5.9551320075989), pos2 = Vector(-3523.3562011719, -1291.7479248047, 414.27679443359)},
	{name = "RDC", pos1 = Vector(-4236.0737304688, -1316.9565429688, 358.45593261719), pos2 = Vector(-3220.5107421875, -2613.8129882813, 70.307144165039)},
	{name = "Train Tunnel Forcefield", pos1 = Vector(-11720.064453125, -14062.470703125, -561.18389892578), pos2 = Vector(-11962.61328125, -5678.8837890625, -331.61761474609)},
	{name = "Train Tunnel", pos1 = Vector(-2499.9575195313, -6925.2236328125, -10485.876953125), pos2 = Vector(-1076.8270263672, 9111.19921875, -10329.44140625)},
	{name = "Rebel Base", pos1 = Vector(-10373.883789063, 10385.451171875, -11947.885742188), pos2 = Vector(-14112.681640625, 14215.196289063, -10121.352539063)},
	{name = "The Desert", pos1 = Vector(-5144.1870117188, 15350.11328125, -1.0038161277771), pos2 = Vector(-6175.1591796875, 14278.474609375, 948.18249511719)},
	{name = "The Grasslands", pos1 = Vector(-5108.611328125, -14822.91796875, -4596.6352539063), pos2 = Vector(-4122.09765625, -13855.080078125, -3310.1484375)},
	{name = "Acid Pit", pos1 = Vector(-2511.0070800781, -6942.2001953125, -10462.853515625), pos2 = Vector(1531.0626220703, -10577.471679688, -8871.341796875)},
	{name = "The Canals", pos1 = Vector(13276.663085938, 5117.9780273438, -5871.5610351563), pos2 = Vector(3476.8325195313, -10213.125, -4446.2368164063)},
	{name = "Service Tunnels", pos1 = Vector(9404.2841796875, -11164.02734375, -5621.2758789063), pos2 = Vector(11130.134765625, -10503.5546875, -5435.025390625)}
}

impulse.Config.Buttons = {}

local ran = math.random(1,10)
impulse.Config.LoadScript = function()
	for k,v in pairs(ents.FindByClass("npc_combine_camera")) do
		v;SetHealth(-100)
	end
	
	for k,v in pairs(ents.FindByClass("prop_physics")) do
		if ran > 7 then
			v:Remove()
		end
	end
end

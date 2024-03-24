--impulse.Config.MapWorkshopID = "99999999" commented out cause gm_construct has no workshop file, if your map does, put it here and all clients will download it!

impulse.Config.MenuCamPos = Vector(-202.16909790039, 968.25067138672, 165.60955810547)
impulse.Config.MenuCamAng = Angle(4.2976760864258, -46.718040466309, 0)

impulse.Config.SpawnPos1 = Vector(518.02081298828, 1069.4327392578, 373.51406860352)
impulse.Config.SpawnPos2 = Vector(2293.4453125, -996.84686279297, -445.95684814453)

impulse.Config.BlacklistEnts = {
	["game_text"] = true,
	["item_healthcharger"] = true,
	["item_suitcharger"] = true
}
impulse.Config.Zones = {
	{name = "Trainstation", pos1 = Vector(-3008.0051269531, -1327.96875, 48.03125), pos2 = Vector(-5569.751953125, 2140.416015625, 546.46252441406)},
	{name = "CP Armory", pos1 = Vector(-2922.3190917969, 1248.03125, 48.03125), pos2 = Vector(-2421.0727539063, 1981.1003417969, 356.28332519531)},
	{name = "Trainstation Corridor", pos1 = Vector(-2987.3813476563, 1232.3839111328, 40.146167755127), pos2 = Vector(-1510.1000976563, 852.31475830078, 388.95065307617)},
	{name = "Ration Distribution Center", pos1 = Vector(-1196.4249267578, 820.42395019531, 86.464141845703), pos2 = Vector(-2388.1628417969, -1398.5646972656, 341.15362548828)},
	{name = "Trainstation Storage Area", pos1 = Vector(-2927.3159179688, -847.48712158203, 10.167888641357), pos2 = Vector(-2507.4912109375, -1331.6685791016, 368.15707397461)},
	{name = "Precinct 9", pos1 = Vector(946.494140625, -1738.4907226563, 1652.9587402344), pos2 = Vector(-1064.7583007813, 1018.2401123047, 58.52836227417)},
	{name = "Citadel Courtyard", pos1 = Vector(962.56018066406, 383.96875, 80.03125), pos2 = Vector(1964.3031005859, -310.86727905273, 1320.4591064453)},
	{name = "Citadel Airlock", pos1 = Vector(2013.8140869141, 84.937561035156, 59.050853729248), pos2 = Vector(2406.0322265625, -244.6912689209, 244.39140319824)},
	{name = "Citadel", pos1 = Vector(2416.4890136719, 353.79141235352, 552.84228515625), pos2 = Vector(5986.916015625, -2191.3532714844, -167.43453979492)},
	{name = "Precinct 9 Transitionary Area", pos1 = Vector(-1050.5823974609, -1750.4240722656, 53.842254638672), pos2 = Vector(49.132865905762, -3398.9404296875, 892.23486328125)},
	{name = "Precinct 15", pos1 = Vector(-4441.2626953125, -3463.5378417969, 54.738452911377), pos2 = Vector(282.71618652344, -4585.4565429688, 797.681640625)},
	{name = "CP Hardpoint", pos1 = Vector(320.06729125977, -3286.8576660156, 154.07572937012), pos2 = Vector(962.44226074219, -4591.21875, 317.4309387207)},
	{name = "Industrial Zone Entrance", pos1 = Vector(246.67720031738, -2706.7021484375, 42.752296447754), pos2 = Vector(840.11822509766, -3272.1943359375, 575.66320800781)},
	{name = "Industrial Zone", pos1 = Vector(900.81018066406, -2151.0688476563, 498.01770019531), pos2 = Vector(3187.4826660156, -5931.3735351563, 37.823154449463)},
	{name = "Precinct 6 Transitionary Area", pos1 = Vector(-60.543884277344, 1036.4270019531, 80.03125), pos2 = Vector(336.12057495117, 1373.3642578125, 404.44052124023)},
	{name = "Precinct 6", pos1 = Vector(2452.2761230469, 1432.7655029297, -26.447143554688), pos2 = Vector(-2608.140625, 6713.2065429688, 1923.9366455078)},
	{name = "Residential Block 15", pos1 = Vector(-1067.0941162109, -3408.0246582031, 1189.8862304688), pos2 = Vector(-4442.8359375, -1615.8853759766, -12.909516334534)}
	
}

impulse.Config.Buttons = {}

impulse.Config.LoadScript = function()
	-- code here is ran on load
end
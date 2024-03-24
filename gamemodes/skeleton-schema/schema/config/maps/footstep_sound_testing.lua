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
	{name = "Spawn area", pos1 = Vector(399.33520507813, 1344.9311523438, 1067.6563720703), pos2 = Vector(2317.3337402344, -1515.2611083984, -391.20645141602)},
	{name = "Lake", pos1 = Vector(-3334.7414550781, 1563.5078125, -660.46258544922), pos2 = Vector(1117.4166259766, 6829.3505859375, 1549.6022949219)},
	{name = "Weird room", pos1 = Vector(-971.84545898438, -993.80676269531, 353.15579223633), pos2 = Vector(-3066.0302734375, -2074.6345214844, -116.8119354248)},
	{name = "The MaTRiXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", pos1 = Vector(-750.43322753906, -2586.3601074219, 136.55348205566), pos2 = Vector(-3371.5285644531, -4646.4916992188, -296.34191894531)}
}

impulse.Config.Buttons = {}

impulse.Config.LoadScript = function()
	-- code here is ran on load
end
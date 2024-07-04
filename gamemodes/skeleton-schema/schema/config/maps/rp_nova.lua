--impulse.Config.MapWorkshopID = "99999999" commented out cause gm_construct has no workshop file, if your map does, put it here and all clients will download it!

impulse.Config.MenuCamPos = Vector(-922.43560791016, 5738.2016601563, -1677.9348144531)
impulse.Config.MenuCamAng = Angle(-37.008354187012, 34.520606994629, 0)

impulse.Config.BlacklistEnts = {
	["game_text"] = true,
	["item_healthcharger"] = true,
	["item_suitcharger"] = true
}

impulse.Config.Zones = {
	{name = "Spawn", pos1 = Vector(11680.615234375, 7280.5751953125, 329.57876586914), pos2 = Vector(12155.422851563, 7987.6953125, 666.93951416016)},
	{name = "Rebel Camp", pos1 = Vector(9422.8427734375, -14529.109375, -2051.2114257813), pos2 = Vector(7872.7890625, -15981.0859375, -1430.5877685547)},
	{name = "Depot", pos1 = Vector(-11699.130859375, 8641.8671875, 1073.4554443359), pos2 = Vector(-12369.370117188, 9899.9375, 1478.8193359375)},
}

impulse.Config.Buttons = {}

impulse.Config.LoadScript = function()
	-- code here is ran on load
end
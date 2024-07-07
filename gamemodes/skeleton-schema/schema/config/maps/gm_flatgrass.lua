--impulse.Config.MapWorkshopID = "99999999" commented out cause gm_construct has no workshop file, if your map does, put it here and all clients will download it!

impulse.Config.MenuCamPos = Vector(-673.63421630859, -2355.59375, -12175.616210938)
impulse.Config.MenuCamAng = Angle(-0.68970000743866, 72.610305786133, 0)

impulse.Config.BlacklistEnts = {
	["game_text"] = true,
	["item_healthcharger"] = true,
	["item_suitcharger"] = true
}

impulse.Config.Zones = {
	{name = "Spawn", pos1 = Vector(872.41137695313, 870.73455810547, -12287.96875), pos2 = Vector(-883.67535400391, -840.39233398438, -10556.60546875)},
	{name = "Underground", pos1 = Vector(367.96875, -1035.4849853516, -12799.96875), pos2 = Vector(-409.73181152344, 1022.2111816406, -12434.486328125)},
	{name = "Secret Room", pos1 = Vector(-432.03125, 431.96875, -12767.96875), pos2 = Vector(-989.58172607422, -449.44360351563, -12564.79296875)},
}

impulse.Config.Buttons = {}

impulse.Config.LoadScript = function()
	-- code here is ran on load
end
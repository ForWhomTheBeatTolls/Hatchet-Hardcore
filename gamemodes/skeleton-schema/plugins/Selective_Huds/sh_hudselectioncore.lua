AddCSLuaFile("cl_huds.lua")

if CLIENT then

impulse.DefineSetting("crosshair_radius", {name="Crosshair Radius", category="HUD", type="slider", default=8, minValue=1, maxValue=40})
impulse.DefineSetting("hud_selection", {name="HUD Design", category="HUD", type="dropdown", default="Hatchet", options={"Hatchet", "Hatchet Legacy"}})
impulse.DefineSetting("crosshair_selection", {name="Crosshair Design", category="HUD", type="dropdown", default="Default", options={"Default", "Hatchet Legacy", "Half-Life 2"}})

end

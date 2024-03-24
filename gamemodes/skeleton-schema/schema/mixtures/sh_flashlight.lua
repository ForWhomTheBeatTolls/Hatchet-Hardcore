local MIX = {}

MIX.Class = "flashlight"

MIX.Level = 2
MIX.Bench = "general"
--MIX.XPMultiplier = 0.5 this will half the XP for crafting it, used to nerf the XP from simple items to stop them being spammed

MIX.Output = "tool_flashlight"
MIX.Input = {
	["util_refmetal"] = {take = 1},
	["util_battery"] = {take = 1},
	["util_electronics"] = { take = 1}
}

impulse.RegisterMixture(MIX)
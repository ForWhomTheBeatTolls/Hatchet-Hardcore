local MIX = {}

MIX.Class = "lockshocker"

MIX.Level = 1
MIX.Bench = "general"
--MIX.XPMultiplier = 0.5 this will half the XP for crafting it, used to nerf the XP from simple items to stop them being spammed

MIX.Output = "util_lockshocker"
MIX.Input = {
	["util_refmetal"] = {take = 1},
	["util_electronics"] = {take = 1}
}

impulse.RegisterMixture(MIX)
local MIX = {}

MIX.Class = "beartrap"

MIX.Level = 4
MIX.Bench = "general"
--MIX.XPMultiplier = 0.5 this will half the XP for crafting it, used to nerf the XP from simple items to stop them being spammed

MIX.Output = "trap_bear"
MIX.Input = {
	["util_refmetal"] = {take = 3},
	["util_recmetal"] = {take = 1}
}

impulse.RegisterMixture(MIX)

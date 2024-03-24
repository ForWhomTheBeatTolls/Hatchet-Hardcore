local MIX = {}

MIX.Class = "greenrebeltop"

MIX.Level = 4
MIX.Bench = "general"
--MIX.XPMultiplier = 0.5 this will half the XP for crafting it, used to nerf the XP from simple items to stop them being spammed

MIX.Output = "clothing_greenrebeltop"
MIX.Input = {
	["util_refmetal"] = {take = 3},
	["item_kevlar"] = {take = 1},
	["clothing_greenshirt"] = {take = 1}
}

impulse.RegisterMixture(MIX)
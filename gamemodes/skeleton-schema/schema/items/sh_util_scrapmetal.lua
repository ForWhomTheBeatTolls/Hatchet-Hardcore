local ITEM = {}

ITEM.UniqueID = "util_scrapmetal"
ITEM.Name = "Scrap Metal"
ITEM.Desc = "A piece of bent, unusable metal."
ITEM.Model = Model("models/gibs/metal_gib1.mdl")
ITEM.FOV = 43
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)

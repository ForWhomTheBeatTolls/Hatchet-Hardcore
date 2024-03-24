local ITEM = {}

ITEM.UniqueID = "util_recmetal"
ITEM.Name = "Reclaimed Metal"
ITEM.Desc = "A piece of straightened metal."
ITEM.Model = Model("models/gibs/metal_gib2.mdl")
ITEM.FOV = 43
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)

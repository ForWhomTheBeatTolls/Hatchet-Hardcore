local ITEM = {}

ITEM.UniqueID = "util_refmetal"
ITEM.Name = "Refined Metal"
ITEM.Desc = "A chunk of refined, smoothened metal.."
ITEM.Model = Model("models/props_wasteland/tram_leverbase01.mdl")
ITEM.FOV = 43
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
local ITEM = {}

ITEM.UniqueID = "tool_knife"
ITEM.Name = "Kitchen Knife"
ITEM.Desc = "A generic kitchen knife."
ITEM.Model = Model("models/weapons/w_knife_ct.mdl")
ITEM.FOV = 4
ITEM.CamPos = Vector(-160, 125.70928955078, 5.1509056091309)
ITEM.NoCenter = true
ITEM.Illegal = true
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
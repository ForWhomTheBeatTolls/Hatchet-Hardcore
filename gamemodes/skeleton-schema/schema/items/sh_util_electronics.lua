local ITEM = {}

ITEM.UniqueID = "util_electronics"
ITEM.Name = "Functional Electronics"
ITEM.Desc = "Despite being old, this bit of human engineering seems to actually work."
ITEM.Model = Model("models/props/cs_office/projector_p6.mdl")
ITEM.FOV = 6.4971346704871
ITEM.CamPos = Vector(81.948425292969, 100, 60.744987487793)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "electronics"
ITEM.CraftTime = 3.5

impulse.RegisterItem(ITEM)
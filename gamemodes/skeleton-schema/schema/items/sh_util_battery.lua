local ITEM = {}

ITEM.UniqueID = "util_battery"
ITEM.Name = "Battery"
ITEM.Desc = "A regular battery."
ITEM.Model = Model("models/props_citizen_tech/transponder.mdls")
ITEM.FOV = 6.4971346704871
ITEM.CamPos = Vector(81.948425292969, 100, 60.744987487793)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "electronics"
ITEM.CraftTime = 3.5

impulse.RegisterItem(ITEM)
local ITEM = {}

ITEM.UniqueID = "wep_grenade"
ITEM.Name = "Grenade"
ITEM.Desc = "A modified grenade, labeled 'Mk3A2-C'. This variant has been equipped with a flare-type tracking system and a fuse-dependent pitch-shifting beep noise. Very expensive to manufacture."
ITEM.Model = Model("models/Items/grenadeAmmo.mdl")
ITEM.FOV = 6.4971346704871
ITEM.CamPos = Vector(81.948425292969, 100, 60.744987487793)
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "electronics"
ITEM.CraftTime = 3.5

impulse.RegisterItem(ITEM)
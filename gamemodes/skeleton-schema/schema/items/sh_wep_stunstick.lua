local ITEM = {}

ITEM.UniqueID = "wep_stunstick"
ITEM.Name = "Stunstick"
ITEM.Desc =  "A civil protection stun-baton."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_stunbaton.mdl")
ITEM.FOV = 24.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_stunstick"

impulse.RegisterItem(ITEM)

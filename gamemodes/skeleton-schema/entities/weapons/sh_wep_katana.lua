local ITEM = {}

ITEM.UniqueID = "wep_katana"
ITEM.Name = "Katana"
ITEM.Desc =  "A katana made in Japan before the invasion, with some left over dried blood on it, Not sure who used it..?"
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_katana.mdl")
ITEM.FOV = 24.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 4.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_katana"

impulse.RegisterItem(ITEM)

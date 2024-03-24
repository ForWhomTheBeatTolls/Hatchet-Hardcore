local ITEM = {}

ITEM.UniqueID = "wep_ar2"
ITEM.Name = "Pulse Rifle"
ITEM.Desc =  "A combine Pulse Rifle, it uses pulse-energy magazines."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_irifle.mdl")
ITEM.FOV = 15.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 10

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "m_ar2"

impulse.RegisterItem(ITEM)

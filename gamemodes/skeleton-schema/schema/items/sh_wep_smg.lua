local ITEM = {}

ITEM.UniqueID = "wep_smg"
ITEM.Name = "Submachine Gun"
ITEM.Desc =  "A submachine gun that fires 4.6x30mm rounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_smg1.mdl")
ITEM.FOV = 24.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "m_smg"

impulse.RegisterItem(ITEM)

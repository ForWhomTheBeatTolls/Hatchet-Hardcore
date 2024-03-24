local ITEM = {}

ITEM.UniqueID = "wep_revolver"
ITEM.Name = "Magnum Revolver"
ITEM.Desc =  "An .357 Magnum revolver. It has an engraving saying ''P.L.U.T.O.N.''"
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_357.mdl")
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
ITEM.EquipGroup = "secondary"
ITEM.CanStack = false

ITEM.WeaponClass = "m_rev"

impulse.RegisterItem(ITEM)

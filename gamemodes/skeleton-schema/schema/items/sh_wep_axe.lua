local ITEM = {}

ITEM.UniqueID = "wep_axe"
ITEM.Name = "Axe"
ITEM.Desc =  "A hefty woodcutting axe. The blade has been dulled over years of wear."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/props/CS_militia/axe.mdl")
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

ITEM.WeaponClass = "ls_axe"

impulse.RegisterItem(ITEM)

local ITEM = {}

ITEM.UniqueID = "util_suitcase"
ITEM.Name = "Suitcase"
ITEM.Desc =  "A suitcase used to transfer stuff."
ITEM.Model = Model("models/props_c17/SuitCase001a.mdl")
ITEM.FOV = 24.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 2

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_suitcase"

impulse.RegisterItem(ITEM)

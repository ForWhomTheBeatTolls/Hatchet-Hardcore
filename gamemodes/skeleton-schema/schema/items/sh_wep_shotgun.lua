local ITEM = {}

ITEM.UniqueID = "wep_shotgun"
ITEM.Name = "SPAS-12"
ITEM.Desc =  "A pump-action combat shotgun firing 12Gamma rounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_shotgun.mdl")
ITEM.FOV = 11.233509941575
ITEM.CamPos = Vector(153.45793151855, -66.938781738281, 58.213577270508)
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

ITEM.WeaponClass = "m_shotgun"

impulse.RegisterItem(ITEM)

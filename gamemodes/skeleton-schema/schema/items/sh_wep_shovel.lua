local ITEM = {}

ITEM.UniqueID = "wep_shovel"
ITEM.Name = "Shovel"
ITEM.Desc =  "A shovel, used for burying stuff in soil."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/props_junk/Shovel01a.mdl")
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false


ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_shovel"

impulse.RegisterItem(ITEM)

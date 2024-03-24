local ITEM = {}

ITEM.UniqueID = "wep_pipe"
ITEM.Name = "Pipe"
ITEM.Desc =  "A pipe."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/props_canal/mattpipe.mdl")
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

ITEM.WeaponClass = "ls_pipe"

impulse.RegisterItem(ITEM)

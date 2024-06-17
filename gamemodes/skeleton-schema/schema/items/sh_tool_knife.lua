local ITEM = {}

ITEM.UniqueID = "tool_knife"
ITEM.Name = "Kitchen Knife"
ITEM.Desc = "A generic kitchen knife."
ITEM.Model = Model("models/weapons/w_knife_ct.mdl")
ITEM.FOV = 4
ITEM.CamPos = Vector(-160, 125.70928955078, 5.1509056091309)
ITEM.NoCenter = true
ITEM.Illegal = true
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

ITEM.WeaponClass = "ls_cleaver"

impulse.RegisterItem(ITEM)

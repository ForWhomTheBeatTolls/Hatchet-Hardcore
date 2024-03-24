local ITEM = {}

ITEM.UniqueID = "wep_annabelle"
ITEM.Name = "Winchester Model 1886"
ITEM.Desc =  "An old & rusty lever-action repeater rifle. This one has been retrofitted to use Magnum ammunition."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_annabelle.mdl")
ITEM.Weight = 7.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false


ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "m_annabelle"

impulse.RegisterItem(ITEM)

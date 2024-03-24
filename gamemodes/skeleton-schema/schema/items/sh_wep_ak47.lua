local ITEM = {}

ITEM.UniqueID = "wep_ak47"
ITEM.Name = "AK-47"
ITEM.Desc =  "A cold-war era assault rifle manufactured by the Soviet Union for it's low cost and easy maintenance."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_rif_ak47.mdl")
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

ITEM.WeaponClass = "m_ak47"

impulse.RegisterItem(ITEM)

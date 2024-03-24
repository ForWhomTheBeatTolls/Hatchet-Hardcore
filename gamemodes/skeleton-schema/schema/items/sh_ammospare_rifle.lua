local ITEM = {}

ITEM.UniqueID = "ammo_sparerifle"
ITEM.Name = "7.62 Cartridge"
ITEM.Desc =  " "
ITEM.Category = "Ammo"
ITEM.Model = Model("models/ammo/762.mdl")
ITEM.DropModel = Model("models/ammo/5mm.mdl")
ITEM.Mass = 20
ITEM.Damping = 0, 20
ITEM.FOV = 2.3868194842407
ITEM.CamPos = Vector(-10, 24.756446838379, 9)
ITEM.Weight = 0.1

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Discard"

function ITEM:OnUse(ply)
    ply:TakeInventoryItemClass("ammo_sparerifle", 1, 900)
    return true
end

impulse.RegisterItem(ITEM)
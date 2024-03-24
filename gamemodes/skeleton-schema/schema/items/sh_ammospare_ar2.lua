local ITEM = {}

ITEM.UniqueID = "ammo_sparear2"
ITEM.Name = "AR2 Cartridge"
ITEM.Desc =  " "
ITEM.Category = "Ammo"
ITEM.Model = Model("models/weapons/w_bullet.mdl")
ITEM.FOV = 11.687679083095
ITEM.CamPos = Vector(-10, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Discard"

function ITEM:OnUse(ply)
    ply:TakeInventoryItemClass("ammo_sparear2", 1, 100)
    return true
end


impulse.RegisterItem(ITEM)
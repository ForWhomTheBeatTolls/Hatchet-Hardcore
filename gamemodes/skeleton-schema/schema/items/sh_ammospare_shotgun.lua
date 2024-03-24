local ITEM = {}

ITEM.UniqueID = "ammo_spareshotgun"
ITEM.Name = "Buckshot Shell"
ITEM.Desc =  " "
ITEM.Category = "Ammo"
ITEM.Model = Model("models/ammo/shotgunshell.mdl")
ITEM.FOV = 19.550143266476
ITEM.CamPos = Vector(-10, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Discard"

function ITEM:OnUse(ply)
    ply:TakeInventoryItemClass("ammo_spareshotgun", 1, 900)
    return true
end

impulse.RegisterItem(ITEM)
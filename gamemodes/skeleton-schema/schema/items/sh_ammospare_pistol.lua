local ITEM = {}

ITEM.UniqueID = "ammo_sparepistol"
ITEM.Name = "9mm Round"
ITEM.Desc =  " "
ITEM.Category = "Ammo"
ITEM.Model = Model("models/ammo/10mm.mdl")
ITEM.FOV = 4.3868194842407
ITEM.CamPos = Vector(-10, 24.756446838379, 9)
ITEM.Weight = 0.1

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Discard"

function ITEM:OnUse(ply)
    ply:TakeInventoryItemClass("ammo_sparepistol", 1, 900)
    return true
end

impulse.RegisterItem(ITEM)
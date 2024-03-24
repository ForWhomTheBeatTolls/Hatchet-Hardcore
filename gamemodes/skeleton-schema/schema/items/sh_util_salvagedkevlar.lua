local ITEM = {}

ITEM.UniqueID = "item_kevlar"
ITEM.Name = "Damaged Kevlar"
ITEM.Desc =  "A damaged piece of kevlar. When repaired, it is a strong, pressure-resistant fabric."
ITEM.Model = Model("models/weapons/w_defuser.mdl")
ITEM.FOV = 38.644699140401
ITEM.CamPos = Vector(0, 25, 18.91117477417)
ITEM.NoCenter = true
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

-- ITEM.UseName = "Stare"
-- ITEM.UseWorkBarTime = 2
-- ITEM.UseWorkBarName = "Staring..."

-- function ITEM:OnUse(ply)
    -- ply:Notify("You stared into the bucket...")
    -- return false
-- end

impulse.RegisterItem(ITEM)
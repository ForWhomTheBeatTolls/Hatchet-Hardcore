local ITEM = {}

ITEM.UniqueID = "item_cpcitration"
ITEM.Name = "Civil Protection Ration"
ITEM.Desc = "A special ration for Civil Protection Officers, containing food & water."
ITEM.Model = Model("models/weapons/w_packatm.mdl")
ITEM.FOV = 6.4971346704871
ITEM.CamPos = Vector(81.948425292969, 100, 60.744987487793)
ITEM.NoCenter = true
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.UseName = "Open"
ITEM.UseWorkBarName = "Opening..."
ITEM.UseWorkBarTime = 1
-- ITEM.CraftSound = "electronics"
-- ITEM.CraftTime = 3.5

function ITEM:OnUse(ply)
	ply:GiveInventoryItem("food_burger")
	ply:GiveInventoryItem("food_watercan")
	ply:GiveMoney("100")
	ply:Say("/me opens a " ..self.Name.. ".", false)

	return true
end

impulse.RegisterItem(ITEM)
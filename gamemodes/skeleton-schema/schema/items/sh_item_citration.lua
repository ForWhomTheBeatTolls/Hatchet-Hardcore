local ITEM = {}

ITEM.UniqueID = "item_citration"
ITEM.Name = "Citizen Ration"
ITEM.Desc = "A regular citizen ration containing food & water."
ITEM.Model = Model("models/weapons/w_packate.mdl")
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
	ply:GiveInventoryItem("food_bread")
	ply:GiveInventoryItem("food_watercan")
	ply:GiveMoney(impulse.Config.CitizenWage)
	if ply.PendingReward > 0 then
		ply:GiveMoney(ply.PendingReward)
		ply:Notify("Due to your work, you have earned an extra "..ply.PendingReward.." tokens.")
		ply.PendingReward = 0
	end
	ply:Say("/me opens a " ..self.Name.. ".", false)

	return true
end

impulse.RegisterItem(ITEM)

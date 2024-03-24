local ITEM = {}	

ITEM.UniqueID = "ammo_smg"
ITEM.Name = "4.6x30mm Ammunition"
ITEM.Desc =  "A box full of small rounds that can be used in light automatic weapons."
ITEM.Model = Model("models/Items/BoxMRounds.mdl")
ITEM.FOV = 42.575931232092
ITEM.CamPos = Vector(10, 33.9255027771, 15.128939628601)
ITEM.Category = "Ammo"
ITEM.NoCenter = true
ITEM.Weight = 4

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

-- ITEM.UseName = "Load"

-- function ITEM:OnUse(ply)
	-- ply:GiveAmmo(45, "SMG1")
-- --	if (not self.restricted) then
-- --		ply:GiveInventoryItem("ammobox_smg")
-- --	end
	-- return true
-- end

impulse.RegisterItem(ITEM)
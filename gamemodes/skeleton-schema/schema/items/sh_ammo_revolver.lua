local ITEM = {}	

ITEM.UniqueID = "ammo_revolver"
ITEM.Name = ".357 Ammunition"
ITEM.Desc =  "A box full of .357 Revolver rounds."
ITEM.Model = Model("models/Items/357ammobox.mdl")
ITEM.FOV = 42.575931232092
ITEM.CamPos = Vector(10, 33.9255027771, 15.128939628601)
ITEM.Category = "Ammo"
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

--ITEM.UseName = "Load"

-- function ITEM:OnUse(ply)
	-- ply:GiveAmmo(6, "357")
-- --	if (not self.restricted) then
-- --		ply:GiveInventoryItem("ammobox_smg")
-- --	end
	-- return true
-- end

impulse.RegisterItem(ITEM)
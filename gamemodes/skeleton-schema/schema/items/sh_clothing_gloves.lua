local ITEM = {}

ITEM.UniqueID = "clothing_gloves"
ITEM.Name = "Gloves"
ITEM.Desc =  "A pair of gloves."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 12.213467048711
ITEM.CamPos = Vector(46.418338775635, 20.630373001099, 32.091690063477)
ITEM.NoCenter = true
ITEM.Weight = 0

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.Equipable = false
ITEM.EquipGroup = "hands"
ITEM.CanStack = false

ITEM.UseName = "Wear"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Wearing..."
ITEM.UseWorkBarSound = "physics/body/body_medium_scrape_rough_loop1.wav"

function ITEM:CanEquip(ply)
    return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	--impulse.MakeWorkbar(time, text, onDone, popup)
    ply:SetBodygroup(3,2)
	ply:Say("/me puts on a pair of " ..ITEM.Name.. ".")
	--ply:StopSound(self.UseWorkBarSound)
	--ply:SetInventoryItemEquipped(impulse.Inventory.ClassToNetID(self.UniqueID), true)
	
	--else 
	--ply:SetBodygroup(3, 0)
	--ply:SetInventoryItemEquipped(impulse.Inventory.ClassToNetID(self.UniqueID), false)
	
	--ply:StopSound(self.UseWorkBarSound)

	--ply.Vest = true
end

function ITEM:UnEquip(ply)
    ply:SetBodygroup(3,0)
	ply:Say("/me takes off a pair of " ..ITEM.Name.. ".")
 --ply.Vest = false
end

impulse.RegisterItem(ITEM)
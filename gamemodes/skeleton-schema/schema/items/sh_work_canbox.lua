local ITEM = {}

ITEM.UniqueID = "work_canbox"
ITEM.Name = "Box of Water Cans"
ITEM.Desc = "A box filled with water. Quite heavy."
ITEM.Weight = 20
ITEM.Model = Model("models/props_junk/cardboard_box003a.mdl")
ITEM.FOV = 16.568767908309
ITEM.CamPos = Vector(-17.191976547241, 16.618911743164, 100)

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = false

function ITEM:OnUse(ply, door)

	if door:GetClass() == "m_vendingmachine" and door:GetStock() == false then
	net.Start("HatchetVendingMachineFillStart")
	net.Send(ply)
	end
	
	return false
	
end

function ITEM:ShouldTraceUse(ply, ent)
    if ent:GetClass() == "m_vendingmachine" and ent:GetStock() == false then
		return true
	end
end

impulse.RegisterItem(ITEM)

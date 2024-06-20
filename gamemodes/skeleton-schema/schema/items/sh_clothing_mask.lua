local ITEM = {}

ITEM.UniqueID = "clothing_mask"
ITEM.Name = "Mask"
ITEM.Desc =  "A Mask of cloth used to hide your identity."
ITEM.Model = Model("models/sal/halloween/ninja.mdl")
ITEM.Category = "Clothing"
ITEM.FOV = 17.644699140401
ITEM.CamPos = Vector(0, 18, 18.91117477417)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.EquipName = "Equip"

ITEM.CosmeticData = {

	model = Model("models/sal/halloween/ninja.mdl"),
	pos = Vector(0, 1, -.01),
	ang = Angle(0, -90, 270),
	scale = 1.2,
	femalePos = Vector(0.5, 0.8, -0.2),
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse

impulse.Cosmetics[6] = ITEM.CosmeticData

function ITEM:CanEquip(ply)

	return not ply:IsCP()

end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 6, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
end

impulse.RegisterItem(ITEM)

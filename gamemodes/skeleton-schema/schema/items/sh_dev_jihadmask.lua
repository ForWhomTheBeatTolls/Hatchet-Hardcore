local ITEM = {}

ITEM.UniqueID = "devitem_jihadmask"
ITEM.Name = "Jihadist Mask"
ITEM.Desc =  "Lalalalala!"
ITEM.Model = Model("models/sal/halloween/ninja.mdl")
ITEM.Category = "devitem"
//ITEM.Material = "gold_tool/australium"
ITEM.FOV = 17.644699140401
ITEM.CamPos = Vector(0, 18, 18.91117477417)
ITEM.NoCenter = true
ITEM.Weight = 1
ITEM.Colour = Color(17,83,0)

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.EquipName = "Equip"

ITEM.CosmeticData = {

	model = Model("models/sal/halloween/ninja.mdl"),
	pos = Vector(0, 1, -.01),
	ang = Angle(0, -90, 270),
	scale = 1,
	femalePos = Vector(0.5, 0.8, -0.2),
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse

impulse.Cosmetics[5] = ITEM.CosmeticData

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 5, true)
	ply:SetBodygroup(1,11)
	ply:SetBodygroup(2,2)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
	ply:SetBodygroup(1,0)
	ply:SetBodygroup(2,0)
end

impulse.RegisterItem(ITEM)

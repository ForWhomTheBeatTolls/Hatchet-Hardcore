local ITEM = {}

ITEM.UniqueID = "item_masterglasses"
ITEM.Name = "Willmaster's Precious Melon"
ITEM.Desc =  "Very precious..."
ITEM.Model = Model("models/foodnhouseholditems/watermelon_unbreakable.mdl")
ITEM.Category = "Accesories"
//ITEM.Material = "gold_tool/australium"
ITEM.FOV = 17.644699140401
ITEM.CamPos = Vector(0, 18, 18.91117477417)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.EquipName = "Equipp"

ITEM.CosmeticData = {

	model = Model("models/foodnhouseholditems/watermelon_unbreakable.mdl"),
	pos = Vector(3, 2.3, 0.1),
	ang = Angle(0, -90, 270),
	scale = 1,
	femalePos = Vector(0.5, 0.8, -0.2),

	onEntLoad = function(ply, ent)

		//ent:SetMaterial("phoenix_storms/metalset_1-2")
		ent:SetColor(Color(255, 0, 0))

	end
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse

impulse.Cosmetics[4] = ITEM.CosmeticData

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 4, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
end

impulse.RegisterItem(ITEM)
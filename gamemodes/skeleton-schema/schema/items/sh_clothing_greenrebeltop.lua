local ITEM = {}

ITEM.UniqueID = "clothing_greenrebeltop"
ITEM.Name = "Green Rebel Armor"
ITEM.Desc =  "Green rebel armor."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 12.213467048711
ITEM.CamPos = Vector(46.418338775635, 20.630373001099, 32.091690063477)
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "torso"
ITEM.CanStack = false

ITEM.UseName = "Equip"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Wearing..."
ITEM.UseWorkBarSound = "physics/body/body_medium_scrape_rough_loop1.wav"
ITEM.UseWorkBarFreeze = true

function ITEM:CanEquip(ply)
    return not ply:IsCP()
end

function ITEM:OnEquip(ply)
    ply:SetBodygroup(1,6)
    ply.HasVest = true
	print("ply.Vest = true")
end

function ITEM:UnEquip(ply)
    ply:SetBodygroup(1,0)
    ply.HasVest = false
	print("ply.Vest = false")
end

impulse.RegisterItem(ITEM)
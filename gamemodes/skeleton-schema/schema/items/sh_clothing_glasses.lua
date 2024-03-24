local ITEM = {}

ITEM.UniqueID = "clothing_glasses"
ITEM.Name = "Glasses"
ITEM.Desc =  "A pair of reading glasses. A shame it doesn't have the lenses."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 12.213467048711
ITEM.CamPos = Vector(46.418338775635, 20.630373001099, 32.091690063477)
ITEM.NoCenter = true
ITEM.Weight = 0

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "eyes"
ITEM.CanStack = false

ITEM.UseName = "Wear"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Wearing..."
ITEM.UseWorkBarSound = "physics/body/body_medium_scrape_rough_loop1.wav"

function ITEM:CanEquip(ply)
    return not ply:IsCP()
end

function ITEM:OnEquip(ply)
    ply:SetBodygroup(5,1)
  --ply.Vest = true
end

function ITEM:UnEquip(ply)
    ply:SetBodygroup(5,0)
 --ply.Vest = false
end

impulse.RegisterItem(ITEM)
local ITEM = {}

ITEM.UniqueID = "item_cigarette"
ITEM.Name = "Cigarette"
ITEM.Desc =  "Tobacco wrapped in rolling paper. Bare minimum cigarette."
ITEM.Category = "Tools"
ITEM.Model = Model("models/phycinnew.mdl")
ITEM.Weight = 0.1
ITEM.FOV = 2.9828080229226
ITEM.CamPos = Vector(-47.679084777832, -41.260746002197, 68.080230712891)
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Smoke"
ITEM.UseWorkBarTime = 0.5
ITEM.UseWorkBarName = "Lighting..."

function ITEM:OnUse(ply)

    ply:Say("/me lights a cigarette.")
    ply:EmitSound("ambient/fire/mtov_flame2.wav", 50, 110, 0.08)
    ply:EmitSound("buttons/lever7.wav", 50, 250, 0.08)

    GiveCig(ply)

    return true
end

impulse.RegisterItem(ITEM)
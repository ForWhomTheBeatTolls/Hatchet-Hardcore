local ITEM = {}

ITEM.UniqueID = "food_noodles"
ITEM.Name = "Noodles"
ITEM.Desc =  "A cold, bland carton of noodles."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.FOV = 16
ITEM.Weight = 1
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Drinking.."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 50

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a carton of " ..self.Name.. ".", false)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 35
	trace.filter = ply
    
    local tr = util.TraceLine(trace)
    
    local rubbish = ents.Create("prop_physics")
    rubbish:SetModel(self.Model)
    rubbish:SetPos(tr.HitPos)
    rubbish:SetAngles(ply:GetAngles())
    rubbish:Spawn()
    rubbish:Fire( "kill", "nil", 300 )
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
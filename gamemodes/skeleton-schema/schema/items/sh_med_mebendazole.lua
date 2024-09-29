local ITEM = {}

ITEM.UniqueID = "item_mebendazole"
ITEM.Name = "Mebendazole Pills"
ITEM.Desc =  "A pill bottle labeled 'Mebendazole'."
ITEM.Category = "Medical"
ITEM.Model = Model("models/warz/consumables/painkillers.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(100, 100, 0)
ITEM.NoCenter = true
ITEM.Weight = 0.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.UseName = "Take"
ITEM.UseWorkBarTime = 1.5
ITEM.UseWorkBarName = "Taking..."
ITEM.UseWorkBarFreeze = false
ITEM.UseWorkBarSound = "physics/cardboard/cardboard_cup_impact_hard1.wav"

function ITEM:MakeRubbish(ply)
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
end

local increment = 1
function ITEM:OnUse(ply, target)

	if ply:GetNWInt("FoodPoisoning") == true then
	
		ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
		ply:SetNWInt("FoodPoisoning", false)
		ply:SetNWInt("FoodPoisoningDel", 0)
		ply:SetNWInt("FoodPoisoningTime", 0)
		ply:Say("/me takes some pills.")
		ply:Notify("Your nausea subsides.")
		
		self:MakeRubbish(ply)
		return true
		
	else
	
	ply:Notify("''I don't feel nauseous. It's best if I don't use this.''")

	end
	
end

impulse.RegisterItem(ITEM)

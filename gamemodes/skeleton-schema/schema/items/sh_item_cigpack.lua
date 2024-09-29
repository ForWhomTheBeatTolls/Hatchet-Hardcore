local ITEM = {}

ITEM.UniqueID = "item_cigpack"
ITEM.Name = "Pack of Cigarettes"
ITEM.Desc =  "A pack of un-identified cigarettes."
ITEM.Model = Model("models/closedboxshin.mdl")
ITEM.Weight = 1
ITEM.FOV = 5
ITEM.CamPos = Vector(-20, 40, 12)
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.UseName = "Open"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Opening..."

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

function ITEM:OnUse(ply)
    ply:Say("/me opens a pack of cigarettes.")
	

    for i = 1,10 do
		ply:GiveInventoryItem("item_cigarette")
	end
	
	self:MakeRubbish(ply)
    
    return true
end

impulse.RegisterItem(ITEM)
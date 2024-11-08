local ITEM = {}

ITEM.UniqueID = "trap_bear"
ITEM.Name = "Bear Trap"
ITEM.Desc =  "A bear trap."
ITEM.Category = "Traps"
ITEM.Model = Model("models/trap/trap_close.mdl")
ITEM.FOV = 10.308022922636
ITEM.CamPos = Vector(-0.57306587696075, -91.117477416992, 98.567337036133)
ITEM.NoCenter = true
ITEM.Weight = 12

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.UseName = "Place"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Placing..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "weapons/c4/c4_plant.wav"

function ITEM:OnUse(ply, door)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	local trap = ents.Create("m_beartrap")
	trap:SetPos(tr.HitPos)
	trap:SetAngles(ply:GetAngles())

	local phys = trap:GetPhysicsObject()

	if phys and IsValid(phys) then
		phys:SetMass(20)	
	end

	function trap:Use(ply)
		if trap:GetCollisionGroup() == "COLLISION_GROUP_NONE" then
			ply:GiveInventoryItem("trap_bear")
			ply:Notify("You have picked up the bear trap.")

			self:Remove()
		end
	end

	trap:Spawn()

	return true
end

impulse.RegisterItem(ITEM)

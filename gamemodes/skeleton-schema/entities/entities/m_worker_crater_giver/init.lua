AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props/CS_militia/boxes_frontroom.mdl" )
    self:SetColor(Color(177, 212, 100))

    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    self.OpeningTime = 10
    self.IsBeingRetrieved = false
    self.Retriever = ""
end

function ENT:Use(actv)
    if (self.IsBeingRetrieved) then return end
    self.Retriever = actv
    self.IsBeingRetrieved = true
    net.Start("impulse_CreateWorkBar")
    net.WriteString(tostring(self.OpeningTime))
    net.WriteString("Retrieving a clothing box..")
    net.WriteBool(false)
    net.Send(actv)

    --for some reason it wouldnt let me freeze the player using the freeze from ForceSequence.. 
    --so im using normal freeze

    actv:Freeze(true)
    actv:ForceSequence("pullrope1idle", function() actv:Freeze(false) end, self.OpeningTime + .4)

    timer.Simple(self.OpeningTime, function()

        local ent = ents.Create("m_worker_clothing_crate")
        ent:SetPos(self.Retriever:GetPos() + self.Retriever:GetForward() * 30 + Vector(0, 0, 20))
        ent:Spawn()


        self.IsBeingRetrieved = false
        self.Retriever = ""
    end)
end
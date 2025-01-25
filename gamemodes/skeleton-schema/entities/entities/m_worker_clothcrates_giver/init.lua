AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props_vehicles/truck001a.mdl" )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    local ct = ents.Create("prop_dynamic")
    ct:SetPos(self:GetPos() + self:GetForward() * 18 + Vector(1, 0, 0))
    ct:SetAngles(Angle(self:GetAngles().x, self:GetAngles().y, 0))
    ct:SetModel("models/props_junk/wood_crate002a.mdl")
    ct:SetParent(self)
    ct:Spawn()

    local ct2 = ents.Create("prop_dynamic")
    ct2:SetPos(self:GetPos() + self:GetForward() * -24 + Vector(1, 0, 0))
    ct2:SetAngles(Angle(self:GetAngles().x, self:GetAngles().y, 0))
    ct2:SetModel("models/props_junk/wood_crate002a.mdl")
    ct2:SetParent(self)
    ct2:Spawn()

    local ct4 = ents.Create("prop_dynamic")
    ct4:SetPos(self:GetPos() + self:GetForward() * -24 + Vector(1, 0, 38))
    ct4:SetAngles(Angle(self:GetAngles().x, self:GetAngles().y - 50, 0))
    ct4:SetModel("models/props_junk/wood_crate002a.mdl")
    ct4:SetParent(self)
    ct4:Spawn()

    local ct3 = ents.Create("prop_dynamic")
    ct3:SetPos(self:GetPos() + self:GetForward() * -66 + Vector(1, 0, 0))
    ct3:SetAngles(Angle(self:GetAngles().x, self:GetAngles().y, 0))
    ct3:SetModel("models/props_junk/wood_crate002a.mdl")
    ct3:SetParent(self)
    ct3:Spawn()

    self:DeleteOnRemove(ct2)
    self:DeleteOnRemove(ct3)
    self:DeleteOnRemove(ct4)
    self:DeleteOnRemove(ct)

    local mins, maxs = self:GetModelBounds()

    local x0 = mins.x -- Define the min corner of the box
    local y0 = mins.y
    local z0 = mins.z

    local x1 = maxs.x-- Define the max corner of the box
    local y1 = maxs.y
    local z1 = maxs.z
    self:PhysicsInitConvex( {
        Vector( x0, y0, z0 ),
        Vector( x0, y0, z1 ),
        Vector( x0, y1, z0 ),
        Vector( x0, y1, z1 ),
        Vector( x1, y0, z0 ),
        Vector( x1, y0, z1 ),
        Vector( x1, y1, z0 ),
        Vector( x1, y1, z1 )
    } )

    self:EnableCustomCollisions( true )

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
    net.WriteString("Retrieving a box..")
    net.WriteBool(false)
    net.Send(actv)

    --for some reason it wouldnt let me freeze the player using the freeze from ForceSequence.. 
    --so im using normal freeze

    actv:Freeze(true)
    actv:ForceSequence("pullrope1idle", function() actv:Freeze(false) end, self.OpeningTime + .4)

    timer.Simple(self.OpeningTime, function()

        local ent = ents.Create("m_worker_dirtycloths_crate")
        ent:SetPos(self:GetPos() - self:GetForward() * 130)
        ent:Spawn()


        self.IsBeingRetrieved = false
        self.Retriever = ""
    end)
end
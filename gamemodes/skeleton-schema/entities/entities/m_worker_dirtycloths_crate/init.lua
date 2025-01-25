AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props_junk/cardboard_box003b.mdl" )
    self:SetColor(Color(194, 157, 79))
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    self.OpeningTime = 5 --default is 5
    self.IsBeingOpened = false
    self.Opener = ""
end


function ENT:Use(actv)
    if (self.IsBeingOpened) then return end
    self.Opener = actv
    self.IsBeingOpened = true
    net.Start("impulse_CreateWorkBar")
    net.WriteString(tostring(self.OpeningTime))
    net.WriteString("Opening..")
    net.WriteBool(false)
    net.Send(actv)

    actv:Freeze(true)
    actv:ForceSequence("takepackage", function() actv:Freeze(false) end, self.OpeningTime + .4)

    timer.Simple(self.OpeningTime, function()


        self:OpenCrate(math.random(2, 4))

        self.IsBeingOpened = false
        self.Opener = ""
    end)
end
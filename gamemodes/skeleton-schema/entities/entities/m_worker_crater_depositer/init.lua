AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    // todo: glue this prop also in here to make it look good: models/props/de_nuke/truck_nuke_glass.mdl
	self:SetModel( "models/props/de_nuke/truck_nuke.mdl" )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    local ct = ents.Create("prop_dynamic")
    ct:SetPos(self:GetPos())
    ct:SetAngles(Angle(self:GetAngles().x, self:GetAngles().y, 0))
    ct:SetModel("models/props/de_nuke/truck_nuke_glass.mdl")
    ct:SetParent(self)
    ct:Spawn()

    self:DeleteOnRemove(ct)
end
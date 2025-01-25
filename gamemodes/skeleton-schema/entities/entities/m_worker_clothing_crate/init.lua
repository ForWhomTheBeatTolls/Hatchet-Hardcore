AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Use(actv)
    if (self:GetAmount() != 5) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 24)) do
            if (not IsValid(v)) or (v:GetName() != "m_DriedCloth") then continue end
            if self:GetPos():DistToSqr(v:GetPos()) < (400 ^ 2) then
                if (self:GetAmount() == 5) then 
                    continue 
                else
                    self:SetAmount(self:GetAmount() + 1)
                    actv:Notify("You inserted a cloth to the box, The box space is now " .. self:GetAmount() .. "/5.")
                    v:Remove()
                end
            end
        end
    else
        actv:Notify("This box is full. (5/5)")
    end
end

function ENT:Initialize()
    self:SetModel( "models/props_junk/cardboard_box001a.mdl" )
    self:SetColor(Color(177, 212, 100))
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
    local phys = self:GetPhysicsObject()
    if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    self:SetAmount(0)
end
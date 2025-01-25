AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props_wasteland/laundry_washer003.mdl" )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end

    self.Busy = false
end

function ENT:Work()
    self.Busy = true
    self:EmitSound("plats/elevator_large_start1.wav")
    self:EmitSound("plats/tram_motor.wav")

    timer.Simple(8, function()
        self:EmitSound("plats/elevator_large_stop1.wav")
        self:StopSound("plats/tram_motor.wav")
        self.Busy = false

        local collist = {
            Color(228, 228, 228),
            Color(74, 153, 255),
            Color(76, 224, 243),
        }
        local posoffset = 12
        local cloth = ents.Create("prop_physics")
        cloth:SetName("m_DriedCloth")
        cloth:SetModel("models/props_junk/garbage_bag001a.mdl")
        cloth:SetMaterial("models/props_c17/FurnitureFabric003a")
        cloth:SetColor(table.Random(collist))
        local f,r,u = self:GetForward(), self:GetRight(), self:GetUp()
        cloth:SetPos(self:GetPos() - r * 20)
        posoffset = posoffset + 12
        cloth:Spawn()
    end)
end

function ENT:Think()
    if (!self.Busy) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 24)) do
            if (not IsValid(v)) or (v:GetName() != "m_WashedCloth") then continue end
            if self:GetPos():DistToSqr(v:GetPos()) < (400 ^ 2) then
                v:Remove()
                self:Work()
            end
        end
    end
    self:NextThink(CurTime() + .6)

    return true
end
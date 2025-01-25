AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props_wasteland/laundry_dryer001.mdl" )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
    self.Amount = 0
    self.Busy = false
end

function ENT:Work()
    self.Amount = 0
    self.Busy = true
    self:EmitSound("plats/elevator_large_start1.wav")
    self:EmitSound("plats/tram_motor.wav")

    timer.Simple(24, function()
        self:EmitSound("plats/elevator_large_stop1.wav")
        self:StopSound("plats/tram_motor.wav")
        self.Busy = false

        local collist = {
            Color(117, 117, 117),
            Color(59, 83, 114),
            Color(39, 75, 80),
        }
        local posoffset = 12
        for i = 1, 5 do
            local cloth = ents.Create("prop_physics")
            cloth:SetName("m_WashedCloth")
            cloth:SetModel("models/props_junk/garbage_bag001a.mdl")
            cloth:SetMaterial("models/props_c17/FurnitureFabric003a")
            cloth:SetColor(table.Random(collist))
            cloth:SetPos(self:GetPos() + Vector(0, 0, posoffset) + self:GetForward() * 50)
            posoffset = posoffset + 12
            cloth:Spawn()
        end
    end)
end

function ENT:Think()
    if (!self.Busy) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 40)) do
            if (not IsValid(v)) or (v:GetName() != "m_DirtyCloth") then continue end
            if self:GetPos():DistToSqr(v:GetPos()) < (400 ^ 2) then
                v:Remove()
                self.Amount = self.Amount + 1
                if (self.Amount == 5) then
                    self:Work()
                end
            end
        end
    end
    self:NextThink(CurTime() + .6)

    return true
end
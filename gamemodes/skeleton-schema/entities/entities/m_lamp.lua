AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

// made by willmaster n steveb

ENT.PrintName = "Lamp"
ENT.Category = "Hatchet"
ENT.Spawnable = true

ENT.State = true

ENT.HUDName = ""
ENT.HUDDesc = ""

function ENT:Initialize()
	self:SetModel( "models/props_interiors/Furniture_Lamp01a.mdl" )
	self:SetColor( Color( 255, 255, 255 ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNW2Bool("HATCHET_Lamp_Activated", false)
	self:SetHealth(10)
	
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
			phys:Wake()
	end
	
	self.Enabled = true
end


function ENT:Use()
	self:SetHealth(10)
	if self:GetNW2Bool("HATCHET_Lamp_Activated") == true then
		self:SetNW2Bool("HATCHET_Lamp_Activated", false)
		self:DrawShadow(true)
	else
		self:SetNW2Bool("HATCHET_Lamp_Activated", true)
		self:DrawShadow(false)
	end
end

if CLIENT then
function ENT:Think()
	
	local position = self:GetPos()
	local angles = self:GetAngles()
	local position = self:GetPos()
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

	if LocalPlayer():GetPos():Distance(self:GetPos()) > 2048 and not LocalPlayer():IsLineOfSightClear(self) then return end
	if self:GetNW2Bool("HATCHET_Lamp_Activated") == true then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
		dlight.pos = position + u*47.4
		dlight.r = 255
		dlight.g = 191
		dlight.b = 72
		dlight.brightness = 4
		dlight.Decay = 1000
		dlight.Size = 300
		dlight.DieTime = CurTime() + 1
		end
	end
end
end

function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() < 0 then
		self:SetNW2Bool("HATCHET_Lamp_Activated", false)
	end
end

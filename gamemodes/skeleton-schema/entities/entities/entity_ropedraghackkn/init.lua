AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
function ENT:Initialize()
	self.Entity:SetModel("models/Gibs/HGIBS_rib.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
end

function ENT:Think( entity )
	if !constraint.FindConstraint(self,"Rope") or !constraint.FindConstraint(self,"Weld") then
	self:Remove()
	end
end
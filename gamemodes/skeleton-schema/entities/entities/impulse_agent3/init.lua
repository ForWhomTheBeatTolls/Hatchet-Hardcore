AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)  
		self:SetMoveType(SOLID_VPHYSICS)  
		self:SetSolid(SOLID_VPHYSICS)   
		self:SetUseType(SIMPLE_USE)
		self:SetModel("models/props_junk/cardboard_box001a.mdl")


    	local physObj = self:GetPhysicsObject()
    	self.nodupe = true

    	if IsValid(physObj) then
			physObj:Wake()
		end
	end

	function ENT:Use(activator, caller)
	if caller:CanHoldItem("ammo_pistol") then
	caller:GiveInventoryItem("ammo_pistol", 1, true)
	end
end
end
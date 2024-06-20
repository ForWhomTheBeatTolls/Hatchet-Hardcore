AddCSLuaFile( "shared.lua" ) 
include('shared.lua')
if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_combine/breenconsole.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)  
		self:SetMoveType(SOLID_VPHYSICS)  
		self:SetSolid(SOLID_VPHYSICS)   
		self:SetUseType(SIMPLE_USE)


    	local physObj = self:GetPhysicsObject()
    	self.nodupe = true

    	if IsValid(physObj) then
			physObj:Wake()
		end
	end
	
	
end

    local teamChangeTime = impulse.Config.TeamChangeTime
	function ENT:Use(activator, caller)
	if caller:Team() == TEAM_CITIZEN then
		if CLIENT then
			vgui.Create("hatchetCivilWorkerSignup")
		end
		self:EmitSound("ambient/machines/keyboard_slow_1second.wav", 60, 100, 1, CHAN_AUTO)
	elseif caller:Team() == TEAM_WORKFORCE then
		caller:Notify("You have turned in your Workforce ID and received your deposit of 25 tokens.")
	else
		caller:Notify("You can't use this.")
	end
end

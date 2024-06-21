AddCSLuaFile() 

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Author = "SteveB"
ENT.PrintName = "CIVIL WORKER JOB SELECT TERMINAL"
ENT.Category = "Hatchet"
ENT.Spawnable = true

ENT.HUDName = "CIVIL WORKER JOB SELECT TERMINAL"
ENT.HUDDesc = ""

if SERVER then

	function ENT:Initialize()
		self:SetModel("models/props_combine/breenconsole.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)  
		self:SetMoveType(SOLID_VPHYSICS)  
		self:SetSolid(SOLID_VPHYSICS)   
		self:SetUseType(SIMPLE_USE)
		self.NextUse = CurTime()

    	local physObj = self:GetPhysicsObject()
    	self.nodupe = true

    	if IsValid(physObj) then
			physObj:Wake()
		end
	end
	
	
end

    local teamChangeTime = impulse.Config.TeamChangeTime
	function ENT:Use(activator, caller)
	
	if self.NextUse < CurTime() then
	
		if caller:Team() == TEAM_WORKFORCE then
	
			net.Start("HatchetSelectWorkerJobStart")
			net.WritePlayer(caller)
			net.Send(caller)
			self:EmitSound("ambient/machines/keyboard_slow_1second.wav", 60, 100, 1, CHAN_AUTO)
		
		else
		
			caller:Notify("You can't use this.")
			
		end
		
		self.NextUse = CurTime() + 1.5
	end
	
end

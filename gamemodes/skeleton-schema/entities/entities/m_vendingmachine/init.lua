AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:DrawShadow(false)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
	
	self.Stock = 20
	self:SetStock(true)
    self:Refill()
    self.nextDispenseTime = 1
	self.NextUse = CurTime()
end

function ENT:Refill()
    self.Stock = 20
	self:SetStock(true)
    self:EmitSound("ambient/machines/combine_terminal_idle1.wav")
end

function ENT:Use(ply)
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
	if self.NextUse < CurTime() then

		if self.Stock > 0 then
            
			if ply:GetSyncVar(SYNC_MONEY, 0) >= 5 then
				ply:TakeMoney(5)
				self:EmitSound("buttons/button1.wav", 70, 100, 0.7, CHAN_AUTO)
				self.NextUse = CurTime() + 2
				self.Stock = self.Stock - 1
				timer.Simple(0.6, function() if IsValid(self) then
				if self.Stock == 0 then
					self:SetStock(false)
				else
					self:SetStock(true)
				end
				impulse.Inventory.SpawnItem("food_watercan", self:GetPos() + f*15 + r*3 + u*-18)
				end end)
			else
				ply:Notify("You require 5 credits to use this machine.")
				self.NextUse = CurTime() + 2
			end
	
		else
			ply:Notify("This machine is out of stock.")
			self:SetStock(false)
			self:EmitSound("buttons/button2.wav", 60, 90, 0.6, CHAN_AUTO)
			self.NextUse = CurTime() + 2
		end
	end
end

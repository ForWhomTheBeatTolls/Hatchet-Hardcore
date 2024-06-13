AddCSLuaFile()
include("shared.lua")
include("cl_init.lua")

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" )

	-- Sets what color to use
	self:SetColor( Color( 255, 255, 255 ) )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	-- Make prop to fall on spawn
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
	
	self.stock = 5
	self:SetStock(true)
    self:Refill()
    self.nextDispenseTime = 1
end

function ENT:Refill()
    self.stock = 5
    self:EmitSound("ambient/machines/combine_terminal_idle1.wav")
end

local nextuse = CurTime()
function ENT:Use(ply)
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
	if nextuse < CurTime() then

		if self.stock > 0 then
            
			if ply:GetSyncVar(SYNC_MONEY, 0) >= 5 then
				ply:TakeMoney(5)
				self:EmitSound("buttons/button1.wav", 70, 100, 0.7, CHAN_AUTO)
				nextuse = CurTime() + 2
				self.stock = self.stock - 1
				timer.Simple(0.6, function() if IsValid(self) then
				if self.stock == 0 then
					self:SetStock(false)
				else
					self:SetStock(true)
				end
				impulse.Inventory.SpawnItem("food_watercan", self:GetPos() + f*15 + r*3 + u*-18)
				end end)
			else
				ply:Notify("You require 5 credits to use this machine.")
				nextuse = CurTime() + 2
			end
	
		else
			ply:Notify("This machine is out of stock.")
			self:SetStock(false)
			self:EmitSound("buttons/button2.wav", 60, 90, 0.6, CHAN_AUTO)
		end
	end
end

function ENT:NeedsRefill()
    if self:GetStock() == false then
        return true
    else
        return false
    end
end
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Fire: The Sequel"
ENT.Category = "Hatchet-unobt"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Author = "Muhammed"

function ENT:Initialize()

if SERVER then

self:SetModel("models/hunter/plates/plate.mdl")
self:SetColor( Color( 255, 255, 255, 0 ) )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
self.nextfiresound = CurTime()
self.nextfiretick = CurTime() + 1
self.cooksoundplayed = false

local fire = ents.Create("env_fire")

fire:SetPos(self:GetPos())

fire:SetKeyValue("health","nil")
fire:SetKeyValue("firesize","12")
fire:SetKeyValue("fireattack","1")
fire:SetKeyValue("damagescale","2")
fire:SetKeyValue("spawnflags","128")

fire:Spawn()
fire:Activate()
fire:Fire("StartFire","",0)
fire:SetParent(self, -1)

self:CallOnRemove( "RemoveFireOnDelete", function( self ) if IsValid(fire) then fire:Remove() end end )


end

end

function ENT:Think()

	if SERVER then
	
	if self.nextfiresound < CurTime() then
		self:StopSound("ambient/fire/fire_small1.wav")
		self:EmitSound("ambient/fire/fire_small1.wav", 60)
		self.nextfiresound = CurTime() + 5
	end
	
	for k,v in pairs(self:GetChildren()) do
		v:SetPos(self:GetPos())
	end
	
	--if nextfiretick < CurTime() then
		for k,v in pairs(ents.FindInCone(self:GetPos() + Vector(0,0,8), Vector(0,0,90), 25, 0)) do
		local firerange = 1050
		local DistToFire = v:GetPos():DistToSqr(self:GetPos())
			if DistToFire < firerange then
				if v:GetClass() == "impulse_item" then
					local itemid = v:GetItemID()
					local item = impulse.Inventory.Items[itemid]
					local vpos = v:GetPos()
					local f,r,u = v:GetForward(), v:GetRight(), v:GetUp()
					if item.Name == "Can of Water" then
						timer.Simple(5, function() if IsValid(v) and DistToFire < firerange then local fishpos = v:GetPos() v:Remove() impulse.Inventory.SpawnItem("util_scrapmetal", fishpos) end end)
					elseif item.Name == "Raw Fish" then
						timer.Simple(5, function() if IsValid(v) and DistToFire < firerange then local fishpos = (v:GetPos() + Vector(0,0,15)) v:Remove() impulse.Inventory.SpawnItem("food_cookedfish", fishpos) end end)
					elseif item.Name == "Dead Crow" then
						timer.Simple(5, function() if IsValid(v) and DistToFire < firerange then local fishpos = (v:GetPos() + Vector(0,0,15)) v:Remove() impulse.Inventory.SpawnItem("food_cookedcrow", fishpos) end end)
					else
						if self.nextfiretick < CurTime() then
							v:TakeDamage(1, self, nil)
							self:EmitSound("ambient/fire/gascan_ignite1.wav", 40)
						end
						self.nextfiretick = CurTime() + 1
					end
				elseif v:IsPlayer() then
					if self.nextfiretick < CurTime() then
						if math.random(1, 100) >= 60 then
							v:Ignite(10, 20)
						end
						v:TakeDamage(1, self, nil)
						v:EmitSound("ambient/fire/gascan_ignite1.wav", 40)
						v:EmitSound("player/pl_burnpain1.wav", 70)
						self.nextfiretick = CurTime() + 1
					end
				else
					if self.nextfiretick < CurTime() then
						if math.random(1, 100) >= 60 then
							v:Ignite(10, 20)
						end
						v:TakeDamage(1, self, nil)
						v:EmitSound("ambient/fire/gascan_ignite1.wav", 40)
						self.nextfiretick = CurTime() + 1
					end
				end
			end	
		end
	end
end

function ENT:OnRemove()
	self:StopSound("ambient/fire/fire_small1.wav")
end

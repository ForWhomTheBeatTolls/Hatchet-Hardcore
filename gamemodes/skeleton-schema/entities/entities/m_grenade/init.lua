include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/grenadeAmmo.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetHealth(40)
	self.TickCount = 0
	self.Increment = 1.5
	self.NextTick = CurTime() + (self.Increment - 0.4)
	local phys = self:GetPhysicsObject()
		
	if phys:IsValid() then
		phys:Wake()
	end
		
	util.SpriteTrail(self, 0, Color( 255, 0, 0 ), false, 8, 0, 1, 1 / ( 15 + 1 ) * 0.5, "trails/plasma" )
		
end

function ENT:Think()
	if self.NextTick < CurTime() then
		self.TickCount = self.TickCount + 1
		self.Increment = self.Increment - 0.3
		self:EmitSound("weapons/grenade/tick1.wav", 90, 100 + (self.TickCount * 15) )
		self.NextTick = CurTime() + self.Increment
	end
	if self.Increment <= 0 then
		self:Boom()
	end
	if (self:Health() <= 0) then
		self:Boom()
	end
end

function ENT:OnTakeDamage( dmginfo )
	local damage = dmginfo:GetDamage()
		self:SetHealth(self:Health() - damage)
end

function ENT:Boom()
	local push_force = 2500
	local explode = ents.Create("env_explosion")
	explode:SetPos(self:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "0")
	explode:SetKeyValue("DamageForce", "380")
	explode:Fire( "Explode", 0, 0 )
	for k,v in pairs(ents.FindInSphere(explode:GetPos(), 404)) do
		
		local center = self:GetPos()
		local r = 404 ^ 2
		local d = 0.0
		local diff = nil 
		local dmg = 0
		
		if v:IsPlayer() and v:IsLineOfSightClear(self) then
			
			diff = center - v:GetPos()
			d = diff:Dot(diff)
			
			d = math.max(0 , math.sqrt(d) - 190)
			dmg = -0.01 * (d^2) + 125
			
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(dmg)
			dmginfo:SetDamageType(DMG_BLAST)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamagePosition(self:GetPos())
			
			v:TakeDamageInfo(dmginfo)
			
			v:ViewPunch(Angle(math.random(-50, 50),  math.random(-50, 50),  math.random(-50, 50)))
		
		end
		
		if v:IsLineOfSightClear(self) and v:GetClass() == "impulse_item" then
			
			diff = center - v:GetPos()
			d = diff:Dot(diff)
			
			d = math.max(0 , math.sqrt(d) - 190)
			dmg = -0.01 * (d^2) + 125
			
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(dmg)
			dmginfo:SetDamageType(DMG_BLAST)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamagePosition(self:GetPos())
			
			v:TakeDamageInfo(dmginfo)
			
		
		end
		
		if v:GetPhysicsObject():IsValid() and v:IsLineOfSightClear(self) then
			
			local vpos = v:LocalToWorld(v:OBBCenter())
			local spos = self:GetPos()
			local dir = (vpos - spos):GetNormal()
			local phys = v:GetPhysicsObject()
			
			dir.z = math.abs(dir.z) + (1 * (phys:GetMass() / 25))
			
			diff = center - v:GetPos()
			d = diff:Dot(diff)
			
			d = math.max(0 , math.sqrt(d) - 190)
			dmg = -0.01 * (d^2) + 125
			
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(dmg)
			dmginfo:SetDamageType(DMG_BLAST)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamagePosition(self:GetPos())
			
			v:TakeDamageInfo(dmginfo)
			
			
			phys:ApplyForceCenter(dir * 1 * push_force)
			
		end
		
		
		
	end
	self:Remove()
end

function ENT:Use(activator)
	if activator:IsPlayer() then
		activator:PickupObject(self)
	end
end

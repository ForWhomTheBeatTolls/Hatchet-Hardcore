AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Stun Baton"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")
SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.ViewModelFOV = 52

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
SWEP.Primary.ImpactSound = Sound("weapons/stunstick/stunstick_impact2.wav")
SWEP.Primary.ImpactEffect = "StunstickImpact"
SWEP.Primary.FlashTime = 1
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 12 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7
SWEP.Primary.HullSize = 12
SWEP.Primary.Range = 75

sound.Add({
	name = "lsStunstickBuzz",
	channel = CHAN_AUTO,
	volume = 0.34,
	level = 45,
	sound = "ambient/machines/combine_shield_touch_loop1.wav"
})

function SWEP:ExtraDataTables()
	self:NetworkVar("Int", 5, "Mode")
end

function SWEP:ExtraHolster()
	self.Owner:StopSound("lsStunstickBuzz")

	self:SetMode(1)
end

function SWEP:OnRemove()
	if IsValid(self.Owner) then
		self.Owner:StopSound("lsStunstickBuzz")
	end
end

function SWEP:OnLowered()
	self:SetMode(1)


	self.Owner:StopSound("lsStunstickBuzz")
end

function SWEP:PrePrimaryAttack()
	local mode = self:GetMode()

	if mode == 1 then
		self.Primary.Damage = 3
		self.Primary.ImpactEffect = nil
		self.Primary.FlashTime = 0.2
		self.Primary.Sound = Sound("WeaponFrag.Roll")
		self.Primary.ImpactSound = Sound("physics/plastic/plastic_barrel_impact_bullet1.wav")
	else
		if mode == 2 then
			self.Primary.Damage = 6
			self.Primary.DoStun = true
			self.Primary.FlashTime = 0.8
		else
			self.Primary.Damage = 10
			self.Primary.DoStun = true
			self.Primary.FlashTime = 1.1
		end

		self.Primary.ImpactEffect = "StunstickImpact"
		self.Primary.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
		self.Primary.ImpactSound = Sound("weapons/stunstick/stunstick_impact2.wav")
	end
end

function SWEP:PrimaryAttack()
	local boxSize = self.Primary.HullSize
	if self.PrePrimaryAttack then
		self.PrePrimaryAttack(self)
	end

	if self.Primary.HitDelay then
		timer.Simple(self.Primary.HitDelay, function()
			if IsValid(self) and IsValid(self.Owner) then
				if SERVER then
				local bullet = {}
				bullet.Num    = 1
				bullet.AmmoType = "Snark"
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 0
				bullet.Hullsize = self.Primary.HullSize
				bullet.Distance = self.Primary.Range + (self.Owner:GetVelocity():LengthSqr() / 950)
				bullet.Damage = self.Primary.Damage
				bullet.Callback = function(attacker, tr, dmginfo)
					if tr.Hit then
					
					--debugoverlay.Cross(tr.HitPos, 2, 3, Color(255, 0, 0), true)
					--debugoverlay.Cross(tr.Entity:GetBonePosition(6), 2, 3, Color(0, 255, 0), true)
					--debugoverlay.Cross(tr.Entity:GetBonePosition(6) - Vector(math.random(-17, 17),math.random(-17, 17),math.random(0, 60)), 2, 3, Color(0, 0, 255), true)
					
			if self.Primary.ImpactSound then
				self.Owner:EmitSound(self.Primary.ImpactSound)
			end

		-- if self.Primary.ImpactEffect then
			-- local effect = EffectData()
			-- effect:SetStart(tr.HitPos)
			-- effect:SetNormal(tr.HitNormal)
			-- effect:SetOrigin(tr.HitPos)

			-- util.Effect(self.Primary.ImpactEffect, effect, true, true)
		-- end

		local ent = tr.Entity

			if ent:IsPlayer() then
				util.Decal("Blood", ent:GetBonePosition(6), ent:GetBonePosition(6) -Vector(math.random(-10, 10),math.random(-10, 10),math.random(0, 60)))
				if self.Primary.FlashTime then
					ent:ScreenFade(SCREENFADE.IN, self.Primary.FlashColour or color_white, self.Primary.FlashTime, 0)
					ent.StunTime = CurTime() + self.Primary.FlashTime
					ent.StunStartTime = CurTime()
				elseif self.Primary.StunTime then
					ent.StunTime = CurTime() + self.Primary.StunTime
					ent.StunStartTime = CurTime()
				end
			end

			if tr.MatType == MAT_FLESH then
				ent:EmitSound("Flesh.ImpactHard")

			elseif tr.MatType == MAT_WOOD then
				ent:EmitSound("Wood.ImpactHard")
			elseif tr.MatType == MAT_CONCRETE then
				ent:EmitSound("Concrete.ImpactHard")
			end
		end
			end
		self.Owner:FireBullets(bullet)
	--self:ClubAttack()
	self:ViewPunch()
		end
	end
end)
		
	else
		if SERVER then
		local bullet = {}
		bullet.Num    = 1
		bullet.AmmoType = "Snark"
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 0
		bullet.Hullsize = self.Primary.HullSize
		bullet.Distance = self.Primary.Range + (self.Owner:GetVelocity():LengthSqr() / 950)
		bullet.Damage = self.Primary.Damage
		bullet.Callback = function(attacker, tr, dmginfo)
					if tr.Hit then
					
			if self.Primary.ImpactSound then
				self.Owner:EmitSound(self.Primary.ImpactSound)
			end

		if self.Primary.ImpactEffect then
			local effect = EffectData()
			effect:SetStart(tr.HitPos)
			effect:SetNormal(tr.HitNormal)
			effect:SetOrigin(tr.HitPos)

			util.Effect(self.Primary.ImpactEffect, effect, true, true)
		end

		local ent = tr.Entity

			if ent:IsPlayer() then
				util.Decal("Blood", ent:GetBonePosition(6), ent:GetBonePosition(6) -Vector(math.random(-10, 10),math.random(-10, 10),math.random(0, 60)))
				if self.Primary.FlashTime then
					ent:ScreenFade(SCREENFADE.IN, self.Primary.FlashColour or color_white, self.Primary.FlashTime, 0)
					ent.StunTime = CurTime() + self.Primary.FlashTime
					ent.StunStartTime = CurTime()
				elseif self.Primary.StunTime then
					ent.StunTime = CurTime() + self.Primary.StunTime
					ent.StunStartTime = CurTime()
				end
			end

			if tr.MatType == MAT_FLESH then
				ent:EmitSound("Flesh.ImpactHard")
			elseif tr.MatType == MAT_WOOD then
				ent:EmitSound("Wood.ImpactHard")
			elseif tr.MatType == MAT_CONCRETE then
				ent:EmitSound("Concrete.ImpactHard")
			end
		end
			end	
		self.Owner:FireBullets(bullet)
			if self.Primary.DoStun then
				self:StunAttack()
			end

			
		--self:ClubAttack()
		self:ViewPunch()
	end
	end

	self:EmitSound(self.Primary.Sound)

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if self.DoFireAnim then
		self:PlayAnim(ACT_VM_PRIMARYATTACK)
	else
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_WALK) then
		local oldMode = self:GetMode()
		local newMode = oldMode + 1

		if newMode > 3 then
			newMode = 1
			self.Owner:StopSound("lsStunstickBuzz")
		end

		if SERVER then
			self:SetMode(newMode)

			local seq = "deactivatebaton"

			if newMode > 1 then
				self.Owner:EmitSound("weapons/stunstick/spark3.wav", 100, math.random(90, 110))
				seq = "activatebaton"
			else
				self.Owner:EmitSound("weapons/stunstick/spark"..math.random(1, 2)..".wav", 100, math.random(90, 110))
			end

			if newMode == 3 then
				self.Owner:EmitSound("lsStunstickBuzz")
			end

			if self.Owner:Team() == TEAM_CP then
				self.Owner:ForceSequence(seq, nil, nil, true)
			end
		end

		return self:SetNextSecondaryFire(CurTime() + 1)
	end

	self.Owner:LagCompensation(true)

	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 72
	trace.filter = self.Owner
	trace.mins = Vector(-7, -7, -30)
	trace.maxs = Vector(8, 8, 10)

	local tr = util.TraceHull(trace)
	local ent = tr.Entity
	self.Owner:LagCompensation(false)

	if SERVER and ent and IsValid(ent) then
		if ent:IsPlayer() then
			self.Owner:EmitSound("weapons/crossbow/hitbod"..math.random(1, 2)..".wav")
			local direction = self.Owner:GetAimVector() * 330
			direction.z = 0

			ent:SetVelocity(direction)
			ent.TimesDamaged = ent.TimesDamaged + 1

			if self.Owner:Team() == TEAM_CP then
				self.Owner:ForceSequence("pushplayer")
			end

			self:SetNextSecondaryFire(CurTime() + 2)
		end
	end
end

-- based on NS sunstick effects:

local STUNSTICK_GLOW_MATERIAL = Material("effects/stunstick")
local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

local color_glow = Color(128, 128, 128)

function SWEP:ExtraDrawWorldModel()
	self:DrawModel()
	local mode = self:GetMode()

	if not mode or mode < 2 then
		return
	end

	local size

	if mode == 2 then
		size = math.Rand(4.0, 6.0)
	else
		size = math.Rand(6.5, 7.5)
	end

	local glow = math.Rand(0.6, 0.8) * 255
	local color = Color(glow, glow, glow)
	local attachment = self:GetAttachment(1)

	if (attachment) then
		local position = attachment.Pos

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL2)
		render.DrawSprite(position, size * 2, size * 2, color)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL)
		render.DrawSprite(position, size, size + 3, color_glow)
	end
end

local NUM_BEAM_ATTACHEMENTS = 9
local BEAM_ATTACH_CORE_NAME	= "sparkrear"

function SWEP:PostDrawViewModel()
	local mode = self:GetMode()

	if not mode or mode < 2 then
		return
	end

	local vm = LocalPlayer():GetViewModel()

	if not IsValid(vm) then
		return
	end

	cam.Start3D(EyePos(), EyeAngles())
		local size

		if mode == 2 then
			size = math.Rand(3.0, 4.0)
		else
			size = math.Rand(5.5, 6.5)
		end

		local color = Color(255, 255, 255, 50 + math.sin(RealTime() * 2)*20)

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

		local attachment = vm:GetAttachment(vm:LookupAttachment(BEAM_ATTACH_CORE_NAME))

		if (attachment) then
			render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
		end

		for i = 1, NUM_BEAM_ATTACHEMENTS do
			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."a"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end

			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."b"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end
		end
	cam.End3D()
end

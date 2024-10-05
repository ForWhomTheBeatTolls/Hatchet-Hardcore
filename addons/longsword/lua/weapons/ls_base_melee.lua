AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.Bleeder = false


function SWEP:CanPrimaryAttack()
	if self.Owner.Stunned then
		return false
	end
	
	return true
end

function SWEP:PrimaryAttack()

	if (!self:CanPrimaryAttack()) then return end
	
	local boxSize = self.Primary.HullSize
	if self.PrePrimaryAttack then
		self.PrePrimaryAttack(self)
	end
	
	local ammotype
	
	if self.Primary.Bleeder == true then
		ammotype = "Snark"
	else
		ammotype = "Hornet"
	end
	
	if self.Primary.HitDelay then
		timer.Simple(self.Primary.HitDelay, function()
			if IsValid(self) and IsValid(self.Owner) then
				if SERVER then
				local bullet = {}
				bullet.Num    = 1
				bullet.AmmoType = ammotype
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
		bullet.AmmoType = ammotype
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

function SWEP:Think()
	self:IdleThink()
end

function SWEP:Reload()
	return
end

function SWEP:StunAttack()
	
	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * (self.Primary.Range + (self.Owner:GetVelocity():LengthSqr() / 950) - 7)
	trace.filter = self.Owner
	trace.mask = MASK_SHOT_HULL

	local boxSize = self.Primary.HullSize or 6
	trace.mins = Vector(-boxSize, -boxSize, -boxSize)
	trace.maxs = Vector(boxSize, boxSize, boxSize)

	self.Owner:LagCompensation(true)

	local tr = util.TraceHull(trace)

	self.Owner:LagCompensation(false)

	if SERVER and tr.Hit then
		if tr.Entity:IsPlayer() then
			tr.Entity.TimesStunned = tr.Entity.TimesStunned + 1
			tr.Entity.TimesStunnedCool = CurTime() + 1.5
		end
	end
end

function SWEP:ClubAttack()
	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * (self.Primary.Range - 7)
	trace.filter = self.Owner
	trace.mask = MASK_SHOT_HULL

	local boxSize = self.Primary.HullSize or 6
	trace.mins = Vector(-boxSize, -boxSize, -boxSize)
	trace.maxs = Vector(boxSize, boxSize, boxSize)

	self.Owner:LagCompensation(true)

	local tr = util.TraceHull(trace)

	self.Owner:LagCompensation(false)

	if CLIENT then
		debugoverlay.BoxAngles(tr.HitPos, trace.mins, trace.maxs, self.Owner:EyeAngles(), 5, Color(200, 0, 0, 100))
	end

	if SERVER and tr.Hit then
		--hook.Run("LongswordMeleeHit", self.Owner)
		
		--if tr.Entity:GetClass() != "player" then
			if self.Primary.ImpactSound then
				self.Owner:EmitSound(self.Primary.ImpactSound)
			end
		--end

		if self.Primary.ImpactEffect then
			local effect = EffectData()
			effect:SetStart(tr.HitPos)
			effect:SetNormal(tr.HitNormal)
			effect:SetOrigin(tr.HitPos)

			util.Effect(self.Primary.ImpactEffect, effect, true, true)
		end

		local ent = tr.Entity

			--if ent:GetClass() != "prop_ragdoll" then
				--dmg:SetDamageForce(self.Owner:GetAimVector() * 10000)
			--end

			--ent:DispatchTraceAttack(dmg, trace.start, trace.endpos)

			if SERVER and ent:IsPlayer() then
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

				-- local effect = EffectData()
				-- effect:SetStart(tr.HitPos)
				-- effect:SetNormal(tr.HitNormal)
				-- effect:SetOrigin(tr.HitPos)

				-- util.Effect("BloodImpact", effect, true, true)
			elseif tr.MatType == MAT_WOOD then
				ent:EmitSound("Wood.ImpactHard")
			elseif tr.MatType == MAT_CONCRETE then
				ent:EmitSound("Concrete.ImpactHard")
			end
		end
	end

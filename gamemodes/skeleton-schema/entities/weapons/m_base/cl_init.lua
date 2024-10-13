function SWEP:DrawWorldModel( flags )
	self:DrawModel( flags )
	--if self:GetOwner():IsWeaponRaised() == true then
	
	end

function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )  -- View model animation
	self:GetOwner():MuzzleFlash() -- Crappy muzzle light
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation

end

function SWEP:ViewPunch()
	local punch = Angle()
	local mul = 1
	local cmod = 0.7
	
	if self.Owner:Crouching() then
		cmod = 0.4
	else
		cmod = 0.7
	end
	
	punch.p = util.SharedRandom( "ViewPunch", -0.5, 0.5 ) * self.Primary.Recoil * mul
	punch.y = util.SharedRandom( "ViewPunch", -0.5, 0.5 ) * self.Primary.Recoil * mul
	punch.r = 0

	self.Owner:ViewPunch( punch )

	if IsFirstTimePredicted() and ( CLIENT or game.SinglePlayer() ) then
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() -
			Angle( self.Primary.Recoil * cmod, 0, 0 ) )
	end
end

function SWEP:OnReloaded()
	timer.Simple(0, function()
		self:SetHoldType(self.HoldType)
	end)
end

function SWEP:QueueIdle()
	if self.Owner:IsNPC() then return end
	self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.1 )
end

function SWEP:PlayAnim(act)

	if self.Owner:IsNPC() then

		return

	end

--	if self.CustomEvents[act] then
--		act = self.CustomEvents[act]
--	end

	local vmodel = self.Owner:GetViewModel()
	local seq = vmodel:SelectWeightedSequence(act)

	vmodel:SendViewModelMatchingSequence(seq)
end

function SWEP:PlayAnimWorld(act)
	local wmodel = self
	local seq = wmodel:SelectWeightedSequence(act)

	self:ResetSequence(seq)
end

function SWEP:IdleThink()
	if self:GetNextIdle() == 0 then return end

	if CurTime() > self:GetNextIdle() then
		self:SetNextIdle( 0 )
		self:SendWeaponAnim( self:Clip1() > 0 and ACT_VM_IDLE or ACT_VM_IDLE_EMPTY )
	end
end

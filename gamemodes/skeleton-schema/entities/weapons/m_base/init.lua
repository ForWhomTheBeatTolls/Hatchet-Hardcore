function SWEP:Ammo1()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
end

function SWEP:Ammo2()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
end

function SWEP:TakePrimaryAmmo( num )
	
	-- Doesn't use clips
	if ( self.Weapon:Clip1() <= 0 ) then 
	
		if ( self:Ammo1() <= 0 ) then return end
		
		self:GetOwner():RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip1( self.Weapon:Clip1() - num )	
	
end

function SWEP:TakeSecondaryAmmo( num )
	
	-- Doesn't use clips
	if ( self.Weapon:Clip2() <= 0 ) then 
	
		if ( self:Ammo2() <= 0 ) then return end
		
		self:GetOwner():RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )	
	
end

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() <= 0 ) then
	
		self:EmitSound( self.Primary.EmptySound )
		self:SetNextPrimaryFire( CurTime() + 0.5 )
	--	self.GetOwner():PlayAnimWorld(ACT_VM_PRIMARYATTACK)
	--	self.Owner:SetAnimation(PLAYER_ATTACK1)
		--self:Reload()
		return false
		
	end
	
	if self:GetOwner().Stunned then
		return false
	end

	return true

end

function SWEP:PrimaryAttack()

--if self.Owner:GetSkillXP() 
 
if ( !self:CanPrimaryAttack() ) then return end
local dmginfo = DamageInfo()
dmginfo:SetAmmoType(game.GetAmmoID( self.Primary.Ammo ) )
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector()

--local skillaccuracy = self.Owner:GetSkillXP("shooting") / 80000 SWEP.Primary.Spread
if self.Owner:GetSkillXP("shooting") <= 20 then
	skillaccuracyunr = 0
	else
	skillaccuracyunr = self.Primary.Spread * (self.Owner:GetSkillXP("shooting") / 20000)
end
if self.Owner:Team() == TEAM_RESISTANCE or self.Owner:Team() == TEAM_CP then
	skillaccuracy = skillaccuracyunr
	else
	skillaccuracy = skillaccuracyunr / 2
end

--print(skillaccuracy)
 
if self.Owner:Crouching() then
bullet.Spread = Vector( self.Primary.Spread * (0.06 - skillaccuracy)  , self.Primary.Spread * (0.06 - skillaccuracy), 0)
else
bullet.Spread = Vector( self.Primary.Spread * ( 0.1 - skillaccuracy )  , self.Primary.Spread * ( 0.1 - skillaccuracy ), 0)
--print(bullet.Spread)
end

bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -.018
local rndb = self.Primary.Recoil * math.random(-.018, .018) 

local rnda2 = self.Primary.Recoil * -.01
local rndb2 = self.Primary.Recoil * math.random(-.01, .01) 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:EmitSound(self.Primary.Sound)
if self.Owner:Crouching() then
self.Owner:ViewPunch( Angle( rnda2,rndb2,rnda2 ) ) 
else
self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
end
self:ViewPunch()
self:TakePrimaryAmmo(self.Primary.TakeAmmo)
if SERVER then
self.Owner:AddSkillXP("shooting", math.random(1,3))
end
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
end 

function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:SecondaryAttack()
	--print("gaah")
end

function SWEP:CanReloadPrimaryAlternate()
	if (self.Weapon:Clip1() <  1) && (self:Ammo1() > 0) or self.Owner:HasInventoryItem(self.RelAmmo) then
	return true
	end
	end

function SWEP:CanReloadPrimary()
	if (self.Weapon:Clip1() <  self.Primary.ClipSize) && (self:Ammo1() > 0) or self.Owner:HasInventoryItem(self.RelAmmo) then
	return true
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

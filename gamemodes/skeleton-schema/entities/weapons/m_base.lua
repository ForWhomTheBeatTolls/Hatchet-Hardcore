SWEP.PrintName = "Muhammed's Base" -- The name of the weapon
    
SWEP.Author = "Muhammed Bin Willard"
SWEP.Contact = "xdwazzup@gmail.com"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

--local FireSound = Sound("weapons/pistol/pistol_fire3.wav")
--local EmptySound = Sound("weapons/pistol/pistol_empty.wav")
--local ReloadSound = Sound("weapons/pistol/pistol_reload1.wav")
SWEP.Primary.EmptySound = Sound("weapons/pistol/pistol_empty.wav")
SWEP.Primary.ReloadSound = Sound("weapons/smg1/smg1_reload.wav")
SWEP.Primary.Sound = Sound("weapons/pistol/pistol_fire3.wav")
SWEP.Primary.Damage = 5 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 45  -- How much bullets are in the mag
SWEP.Primary.Ammo = "pistol" --The ammo type will it use
SWEP.Primary.DefaultClip = 45 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.1 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = .2 -- The amount of recoil
SWEP.Primary.Delay = 0.1 -- Delay before the next shot
SWEP.Primary.RelDelay = 0 -- Delay before shooting after a reload
SWEP.Primary.Force = 100
SWEP.RelAmmo = "ammo_pistol"
SWEP.RelAmmo2 = "ammo_sparepistol"
SWEP.RelAmmount = 20


SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "pistol" 

SWEP.FiresUnderwater = false

SWEP.ReloadSound = "sound/epicreload.wav"

SWEP.CSMuzzleFlashes = true

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 1, "Reloading")
	self:NetworkVar("Float", 3, "ReloadTime")

	if self.ExtraDataTables then
		self.ExtraDataTables(self)
	end
end

function SWEP:Initialize()

	self:SetHoldType("smg")
	
	end

function SWEP:Ammo1()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
end

function SWEP:Ammo2()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
end

function SWEP:DrawWorldModel( flags )
	self:DrawModel( flags )
	--if self:GetOwner():IsWeaponRaised() == true then
	
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

function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )  -- View model animation
	self:GetOwner():MuzzleFlash() -- Crappy muzzle light
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation

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

	return true

end

function SWEP:PrimaryAttack()
 
if ( !self:CanPrimaryAttack() ) then return end
local dmginfo = DamageInfo()
dmginfo:SetAmmoType(game.GetAmmoID( self.Primary.Ammo ) )
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
if self.Owner:Crouching() then
bullet.Spread = Vector( self.Primary.Spread * 0.06 , self.Primary.Spread * 0.06, 0)
else
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
end
bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -.5
local rndb = self.Primary.Recoil * math.random(-.5, .5) 

local rndc = self.Primary.Spread * -.5
local rndd = self.Primary.Spread * math.random(-.5, .5)

local rnda2 = self.Primary.Recoil * -.2
local rndb2 = self.Primary.Recoil * math.random(-.2, .2) 

local rndc2 = self.Primary.Spread * -.5
local rndd2 = self.Primary.Spread * math.random(-.5, .5)
 
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
 
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
end 

function SWEP:ViewPunch()
	local punch = Angle()

	local mul = 1
	punch.p = util.SharedRandom( "ViewPunch", -0.5, 0.5 ) * self.Primary.Recoil * mul
	punch.y = util.SharedRandom( "ViewPunch", -0.5, 0.5 ) * self.Primary.Recoil * mul
	punch.r = 0

	self.Owner:ViewPunch( punch )

	if IsFirstTimePredicted() and ( CLIENT or game.SinglePlayer() ) then
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() -
			Angle( self.Primary.Recoil * .7, 0, 0 ) )
	end
end

function SWEP:SecondaryAttack()

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
	
-- function SWEP:Reload()
		-- --if self:CanReloadPrimary() then
		-- --self:EmitSound(self.Primary.ReloadSound) 
        -- --self.PlayAnim( ACT_VM_RELOAD )
		-- if (self:Ammo1() > 0) and (self.Weapon:Clip1() <  self.Primary.ClipSize) then
		-- --self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- --self.Owner:GiveAmmo(20, self.Primary.Ammo, true)
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- self:SetNextPrimaryFire(self.Primary.RelDelay)
		-- self:EmitSound(self.Primary.ReloadSound)
		-- elseif (self.Owner:HasInventoryItem(self.RelAmmo) and self.Weapon:Clip1() < self.Primary.ClipSize) or (self.Weapon:Clip1() == 0 and self.Owner:HasInventoryItem(self.RelAmmo))  then
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		-- --self.Weapon:DefaultReload( ACT_VM_RELOAD )
		
		-- end
-- end
--SNIPPET ABOVE IS OLD CODE. REVERT IF NEEDED.

function SWEP:Reload()
		local ply = self.Owner
		local has, amount = ply:HasInventoryItem(self.RelAmmo)
		local hasSpare, amountSpare = ply:HasInventoryItem(self.RelAmmo2)
		--if self:CanReloadPrimary() then
		--self:EmitSound(self.Primary.ReloadSound) 
        --self.PlayAnim( ACT_VM_RELOAD )
		
    if self.Owner:KeyDown( IN_ATTACK ) then
		return
	end

	if(self:Clip1() >= self:GetMaxClip1()) then
		return
	end

		if(SERVER) then
		if(!has and !hasSpare) then
			ply:SetAmmo( 0, self.Primary.Ammo)
			return
		elseif(!has and hasSpare ) then
			ply:SetAmmo(amountSpare, self.Primary.Ammo)
			for i = 1, amountSpare do
				ply:TakeInventoryItemClass(self.RelAmmo2)
				amountSpare = amountSpare - 1
			end
		elseif(has) then
			ply:SetAmmo(self.Primary.ClipSize, self.Primary.Ammo)
			ply:TakeInventoryItemClass(self.RelAmmo)
		end
	end
	if(SERVER and self:Clip1() + self:Ammo1() > self.Primary.ClipSize) then
		for i = 1, (self:Clip1() + self:Ammo1())-self.Primary.ClipSize do
			if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
				ply:GiveInventoryItem(self.RelAmmo2, 1, true)
			else
				ply:GiveInventoryItem(self.RelAmmo2)
			end
			if(amountSpare == nil) then amountSpare = 1 else amountSpare = amountSpare + 1 end
		end
		if(hasSpare and amountSpare >= self.Primary.ClipSize) then
			for i = 1, self.Primary.ClipSize do
				ply:TakeInventoryItemClass(self.RelAmmo2)
				amountSpare = amountSpare - 1
			end
			if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
				ply:GiveInventoryItem(self.RelAmmo, 1, true)
			else
				ply:GiveInventoryItem(self.RelAmmo)
			end
		end	
	end
		if(self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0) then
			self:SetHoldType( self.HoldType )
			self.Weapon:DefaultReload(ACT_VM_RELOAD);
			ply:EmitSound(self.Primary.ReloadSound, 80, 100, 0.5)
			ply:DoCustomAnimEvent(PLAYERANIMEVENT_RELOAD, 1)
		else
			self:SetHoldType( self.HoldType )
		end
end

-- Code is unfortunately stolen. IDK where from, but it's stolen. I'm sorry, to whoever is reading.


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


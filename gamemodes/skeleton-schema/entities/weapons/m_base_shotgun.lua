SWEP.PrintName = "weapon name" -- The name of the weapon
    
SWEP.Author = "your name"
SWEP.Contact = "your email adress"--Optional
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
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "shotgun" 

SWEP.FiresUnderwater = false

SWEP.ReloadSound = "sound/epicreload.wav"

SWEP.CSMuzzleFlashes = true

function SWEP:Reload()
	if not self:CanReloadPrimary() then return end

	self:PlayAnim( ACT_SHOTGUN_RELOAD_START )
	self.Owner:DoReloadEvent()
	self:QueueIdle()

	self:SetReloading( true )
	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:InsertShell()
	
	if self.ReloadSound then
		self:EmitSound(self.ReloadSound)
	end
end

function SWEP:InsertShell()
	self:SetClip1( self:Clip1() + 1 )
	self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )

	self:PlayAnim( ACT_VM_RELOAD )
	self:QueueIdle()

	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

	if self.ReloadShellSound then
		self:EmitSound(self.ReloadShellSound)
	end
end

function SWEP:ReloadThink()
	if self:GetReloadTime() > CurTime() then return end

	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0
		and not self.Owner:KeyDown( IN_ATTACK ) then
		self:InsertShell()
	else
		self:FinishReload()
	end
end

function SWEP:FinishReload()
	self:SetReloading( false )

	self:PlayAnim( ACT_SHOTGUN_RELOAD_FINISH )
	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:QueueIdle()

	if self.PumpSound then self:EmitSound( self.PumpSound ) end
end

SWEP.PrintName = "AK47" -- The name of the weapon
SWEP.Author = "your name"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

SWEP.Primary.Sound = Sound("Weapon_iAK47.Single")
SWEP.Primary.EmptySound = Sound("weapons/clipempty_rifle.wav")
SWEP.Primary.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Damage = 20 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 30  -- How much bullets are in the mag
SWEP.Primary.Ammo = "12mmRound" --The ammo type will it use
SWEP.Primary.DefaultClip = 0 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.3 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Recoil = 2 -- it no go BOOM
SWEP.Primary.Delay = 0.15 -- Delay before the next shot
SWEP.Primary.Force = 1
SWEP.RelAmmo = "ammo_rifle"
SWEP.RelAmmo2 = "ammo_sparerifle"
SWEP.RelAmmount = 30

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "smg" 

SWEP.FiresUnderwater = false

SWEP.CSMuzzleFlashes = true

-- function SWEP:PrimaryAttack()
 
-- if ( !self:CanPrimaryAttack() ) then return end
 
-- local bullet = {} 
-- bullet.Num = self.Primary.NumberofShots 
-- bullet.Src = self.Owner:GetShootPos() 
-- bullet.Dir = self.Owner:GetAimVector() 
-- bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
-- bullet.Tracer = 1
-- bullet.Force = self.Primary.Force 
-- bullet.Damage = self.Primary.Damage 
-- bullet.AmmoType = self.Primary.Ammo 
 
-- local rnda = self.Primary.Recoil * -.5
-- local rndb = self.Primary.Recoil * math.random(-.5, .5) 

-- local rndc = self.Primary.Spread * -.5
-- local rndd = self.Primary.Spread * math.random(-.5, .5)
 
-- self:ShootEffects()
 
-- self.Owner:FireBullets( bullet ) 
-- self:EmitSound(self.Primary.Sound, 100, 88)
-- self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
-- self:ViewPunch()
-- self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
-- self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
-- end 

sound.Add({
	name = "Weapon_iAK47.Single",
	sound = "weapons/cw_ak74/fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_150dB,
	pitch = {90, 105}
})

-- function SWEP:Reload()
		-- if self:CanReloadPrimary() then
		-- self:EmitSound(self.Primary.ReloadSound) 
        -- --self.PlayAnim( ACT_VM_RELOAD )
		-- if (self:Ammo1() > 0) then
		-- --self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- --self.Owner:GiveAmmo(20, self.Primary.Ammo, true)
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- elseif self.Owner:HasInventoryItem(self.RelAmmo) and self.Weapon:Clip1() < self.Primary.ClipSize  then
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		-- --self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- end
-- end
-- end

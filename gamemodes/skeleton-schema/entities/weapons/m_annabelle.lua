SWEP.PrintName = "Winchester Model 1886" -- The name of the weapon
    
SWEP.Author = "your name"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_fire6.wav")
SWEP.Primary.EmptySound = Sound("weapons/clipempty_rifle.wav")
SWEP.Primary.ReloadSound = Sound("weapons/shotgun/shotgun_reload1.wav")
SWEP.Primary.Damage = 75 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 2  -- How much bullets are in the mag
SWEP.Primary.ShitClipSize = 1
SWEP.Primary.Ammo = "357" --The ammo type will it use
SWEP.Primary.DefaultClip = 0 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.03 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = 12 -- it go BOOM
SWEP.Primary.Delay = 1.6 -- Delay before the next shot
SWEP.Primary.Force = 1
SWEP.RelAmmo = "ammo_revolver"
SWEP.RelAmmo2 = "ammo_sparerevolver"
SWEP.RelAmmount = 6

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
SWEP.ViewModel			= "models/weapons/v_annabelle.mdl"
SWEP.WorldModel			= "models/weapons/w_annabelle.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "ar2" 

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

function SWEP:Reload()
		if self:CanReloadPrimary() then
		--self:EmitSound(self.Primary.ReloadSound) 
        --self.PlayAnim( ACT_VM_RELOAD )
		if (self:Ammo1() > 0) then
		--self.Owner:TakeInventoryItemClass(self.RelAmmo)
		--self.Owner:GiveAmmo(20, self.Primary.Ammo, true)
		if self:Clip1() == 1 then
		--timer.Create("annabellereload"..self.Owner:UniqueID(), .8, 1, function()
		self:EmitSound(self.Primary.ReloadSound)
		elseif self:Clip1() == 0 then
		timer.Create("annabellereload"..self.Owner:UniqueID(), .8, 2, function()
		self:EmitSound(self.Primary.ReloadSound) end)
		end
		self.Weapon:DefaultReload( ACT_VM_RELOAD )
		 if !timer.Exists("annabellereload"..self.Owner:UniqueID()) then
		 self:SetNextPrimaryFire(CurTime() + 2.5)
		 elseif timer.Exists("annabellereload"..self.Owner:UniqueID()) then
		 self:SetNextPrimaryFire(CurTime() + 2.9)
		 end
		-- elseif self.Owner:HasInventoryItem(self.RelAmmo) and self.Weapon:Clip1() < self.Primary.ClipSize  then
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		--self.Weapon:DefaultReload( ACT_VM_RELOAD )
		end
end
end
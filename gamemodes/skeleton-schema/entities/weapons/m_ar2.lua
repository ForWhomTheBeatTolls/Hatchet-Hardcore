SWEP.PrintName = "AR-2" -- The name of the weapon
    
SWEP.Author = "your name"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

--local FireSound = Sound("weapons/smg1/smg1_fire1.wav")
--local EmptySound = Sound("weapons/pistol/pistol_empty.wav")
--local ReloadSound = Sound("weapons/smg1/smg1_reload.wav")
SWEP.Primary.EmptySound = Sound("weapons/ar2/ar2_empty.wav")
SWEP.Primary.ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.Primary.Sound = Sound("weapons/ar2/fire1.wav")
SWEP.Primary.Damage = 20 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 30  -- How much bullets are in the mag
SWEP.Primary.Ammo = "ar2" --The ammo type will it use
SWEP.Primary.DefaultClip = 0 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = .12 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Delay = 0.16 -- Delay before the next shot
SWEP.Primary.RelDelay = 2.7 -- Delay before allowing you to shoot after reloading
SWEP.Primary.Recoil = 1.6 -- The amount of recoil
SWEP.Primary.Force = .5
SWEP.RelAmmo = "ammo_ar2"
SWEP.RelAmmo2 = "ammo_sparear2"
SWEP.RelAmmount = 30

SWEP.Secondary.FireSound = Sound("weapons/grenade_launcher1.wav")
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "ar2altfire"

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/c_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "ar2" 

SWEP.FiresUnderwater = false

SWEP.CSMuzzleFlashes = true

-- function SWEP:Reload()
		-- if self:CanReloadPrimary() then
		-- self:EmitSound(self.Primary.ReloadSound) 
        -- --self.PlayAnim( ACT_VM_RELOAD )
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- self:SetNextPrimaryFire(CurTime() + 1.95 )
		-- end
-- end

function SWEP:TakeSecondaryAmmo( num )
	
	-- Doesn't use clips
	if ( self.Weapon:Clip2() <= 0 ) then 
	
		if ( self:Ammo2() <= 0 ) then return end
		
		self:GetOwner():RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip2( self.Weapon:Clip2() - 1 )	
	
end

function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )  -- View model animation
	self:GetOwner():MuzzleFlash() -- Crappy muzzle light
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation

end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end
	
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( "AR2Impact", effectdata )

end

-- function SWEP:FireAnimationEvent( pos, ang, event, options )
	
	-- -- Disables animation based muzzle event
	-- --if ( event == 21 ) then return true end	

	-- -- Disable thirdperson muzzle flash
	-- if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 ) then return true end

-- end

-- function SWEP:PrimaryAttack()
 
-- if ( !self:CanPrimaryAttack() ) then return end
-- local dmginfo = DamageInfo()
-- dmginfo:SetAmmoType(game.GetAmmoID( self.Primary.Ammo ) )
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
-- self:EmitSound(self.Primary.Sound)
-- self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
-- self:ViewPunch()
-- self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
-- self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
-- end 

-- function SWEP:SecondaryAttack()
	-- local ply = self:GetOwner()
	
	-- if ply:Team() == TEAM_OTA and nadetimer < CurTime() then
		-- if SERVER then
		-- local nadetimer = CurTime()
		-- local ent = ents.Create("npc_grenade_frag")

		-- local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
		-- local dir = self.Owner:EyeAngles()

		-- ent:SetPos(ply:GetShootPos())
		-- ent:SetAngles(ang)

		-- ent:SetOwner(ply)

		-- --ent:SetVelocity(dir * 100)

		-- ent:Spawn()
		-- ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		-- ent:Activate()
		-- ent:Fire("settimer", 2)
		-- local phys = ent:GetPhysicsObject()

		-- phys:SetVelocity( self.Owner:GetAimVector() * 3000 )
		-- nadetimer = CurTime() + 5
	-- end
	-- end
-- end
-- function SWEP:SecondaryAttack()
	-- local ply = self:GetOwner()
	-- local secondary = self.Secondary.Ammo

	-- self:TakeSecondaryAmmo(1)

	-- self:EmitSound(self.Secondary.FireSound)

	-- --self:SendTranslatedWeaponAnim(ACT_VM_SECONDARYATTACK)
	
	-- self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	-- ply:SetAnimation(PLAYER_ATTACK1)

	-- if SERVER then
		-- local ent = ents.Create("simple_ent_hl2_40mm")

		-- local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
		-- local dir = ang:Forward()

		-- ent:SetPos(ply:GetShootPos())
		-- ent:SetAngles(ang)

		-- ent:SetOwner(ply)

		-- ent:SetVelocity(dir * 1000)

		-- ent:Spawn()
		-- ent:Activate()
	-- end

	-- --self:ApplyRecoil()

	-- self.Primary.Automatic = true

	-- --self:SetNextIdle(CurTime() + self:SequenceDuration())
	-- --self:SetNextFire(CurTime() + 0.5)
	-- --self:SetNextAltFire(CurTime() + 1)
-- end

-- function SWEP:Reload()
		-- --if self:CanReloadPrimary() then
		-- --self:EmitSound(self.Primary.ReloadSound) 
        -- --self.PlayAnim( ACT_VM_RELOAD )
		-- if (self:Ammo1() > 0) and (self.Weapon:Clip1() <  self.Primary.ClipSize) then
		-- --self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- --self.Owner:GiveAmmo(20, self.Primary.Ammo, true)
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- self:SetNextPrimaryFire(CurTime() + self.Primary.RelDelay)
		-- self:EmitSound(self.Primary.ReloadSound)
		-- elseif (self.Owner:HasInventoryItem(self.RelAmmo) and self.Weapon:Clip1() < self.Primary.ClipSize) or (self.Weapon:Clip1() == 0 and self.Owner:HasInventoryItem(self.RelAmmo))  then
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		-- self.Owner:Notify("No reserve ammo left. Loading from inventory...")
		-- self:SetNextPrimaryFire(self.Primary.RelDelay)
		-- --self.Weapon:DefaultReload( ACT_VM_RELOAD )
		
		-- end
-- end

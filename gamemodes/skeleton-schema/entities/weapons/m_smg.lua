SWEP.PrintName = "SMG" -- The name of the weapon
    
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
SWEP.Primary.EmptySound = Sound("weapons/pistol/pistol_empty.wav")
SWEP.Primary.ReloadSound = Sound("weapons/smg1/smg1_reload.wav")
SWEP.Primary.Sound = Sound("weapons/smg1/smg1_fire1.wav")
SWEP.Primary.Damage = 16 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 45  -- How much bullets are in the mag
SWEP.Primary.Ammo = "smg1" --The ammo type will it use
SWEP.Primary.DefaultClip = 0 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = .4 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Delay = 0.10 -- Delay before the next shot
SWEP.Primary.RelDelay = 1.97
SWEP.Primary.Recoil = 2 -- The amount of recoil
SWEP.Primary.Force = .5
SWEP.RelAmmo = "ammo_smg"
SWEP.RelAmmo2 = "ammo_sparesmg"
SWEP.RelAmmount = 45

SWEP.Secondary.FireSound = Sound("weapons/grenade_launcher1.wav")
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "SMG1_Grenade"

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/c_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "smg" 

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

function SWEP:Reload()
	local ply = self.Owner
	local has, amount = ply:HasInventoryItem("ammo_smg")
	local hasSpare, amountSpare = ply:HasInventoryItem("ammo_sparesmg")
	self:SetHoldType("smg")
    
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
				ply:TakeInventoryItemClass("ammo_sparesmg")
				amountSpare = amountSpare - 1
			end
		elseif(has) then
			ply:SetAmmo(self.Primary.ClipSize, self.Primary.Ammo)
			ply:TakeInventoryItemClass("ammo_smg")
		end
	end
	if(SERVER and self:Clip1() + self:Ammo1() > self.Primary.ClipSize) then
		for i = 1, (self:Clip1() + self:Ammo1())-self.Primary.ClipSize do
			if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
				ply:GiveInventoryItem("ammo_sparesmg", 1, true)
			else
				ply:GiveInventoryItem("ammo_sparesmg")
			end
			if(amountSpare == nil) then amountSpare = 1 else amountSpare = amountSpare + 1 end
		end
		if(hasSpare and amountSpare >= self.Primary.ClipSize) then
			for i = 1, self.Primary.ClipSize do
				ply:TakeInventoryItemClass("ammo_sparesmg")
				amountSpare = amountSpare - 1
			end
			if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
				ply:GiveInventoryItem("ammo_smg", 1, true)
			else
				ply:GiveInventoryItem("ammo_smg")
			end
		end	
	end
	if(self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0) then
		self.Weapon:DefaultReload(ACT_VM_RELOAD);
		ply:EmitSound("weapons/smg1/smg1_reload.wav", 80, 100, 0.5)
		ply:DoCustomAnimEvent(PLAYERANIMEVENT_RELOAD, 1)
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
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self:SetNextPrimaryFire(CurTime() + self.Primary.RelDelay)
		-- elseif (self.Owner:HasInventoryItem(self.RelAmmo) and self.Weapon:Clip1() < self.Primary.ClipSize) or (self.Weapon:Clip1() == 0 and self.Owner:HasInventoryItem(self.RelAmmo))  then
		-- self:EmitSound(self.Primary.ReloadSound)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		-- self.Owner:Notify("No reserve ammo left. Loading from inventory...")
		-- --self.Weapon:DefaultReload( ACT_VM_RELOAD )
		
		-- end
-- end

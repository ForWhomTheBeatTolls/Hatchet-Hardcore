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
			ply:DoReloadEvent()
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
		--ply:DoReloadEvent()
			for i = 1, self.Primary.ClipSize do
				ply:TakeInventoryItemClass(self.RelAmmo2)
				amountSpare = amountSpare - 1
			end
			if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
				ply:GiveInventoryItem(self.RelAmmo, 1, true)
				--ply:DoReloadEvent()
			else
				ply:GiveInventoryItem(self.RelAmmo)
				--ply:DoReloadEvent()
			end
		end	
	end
		if(self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0) then
			self:SetHoldType( self.HoldType )
			self.Weapon:DefaultReload(ACT_VM_RELOAD);
			ply:EmitSound(self.Primary.ReloadSound, 80, 100, 0.5)
			--ply:DoReloadEvent()
			ply:DoCustomAnimEvent( PLAYERANIMEVENT_RELOAD )
		else
			self:SetHoldType( self.HoldType )
		end
end

function SWEP:Initialize()

	self:SetHoldType("smg")
	
	end

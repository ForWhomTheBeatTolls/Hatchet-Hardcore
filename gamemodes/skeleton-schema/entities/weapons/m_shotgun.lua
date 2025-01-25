SWEP.PrintName = "Shotgun" -- The name of the weapon

SWEP.Author = "your name"
SWEP.Contact = "your email adress"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.EmptySound = Sound("weapons/clipempty_rifle.wav")
SWEP.Primary.ReloadSound = Sound("Weapon_Shotgun.Reload")
SWEP.Primary.Damage = 19 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 6  -- How much bullets are in the mag\
SWEP.Primary.ShitClipSize = 5
SWEP.Primary.Ammo = "buckshot" --The ammo type will it use
SWEP.Primary.DefaultClip = 0 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 1 -- The spread when shot
SWEP.Primary.NumberofShots = 10 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = 4 -- it no go BOOM
SWEP.Primary.Delay = 1 -- Delay before the next shot
SWEP.Primary.Force = 3
SWEP.RelAmmo = "ammo_shotgun"
SWEP.RelAmmo2 = "ammo_spareshotgun"
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
SWEP.ViewModel			= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "shotgun" 

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
-- timer.Simple(.5, function() self:EmitSound("Weapon_Shotgun.Special1") end)
-- self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
-- self:ViewPunch()
-- self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
-- self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
-- end 


-- function SWEP:Reload()
		-- if self:CanReloadPrimary() then
		-- --self:EmitSound(self.Primary.ReloadSound) 
        -- --self.PlayAnim( ACT_VM_RELOAD )
		-- if (self:Ammo1() > 0) and (self.Weapon:Clip1() < 6) then
		-- --self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- --self.Owner:GiveAmmo(20, self.Primary.Ammo, true)
		-- timer.Create("shottyreload"..self.Owner:UniqueID(), .5, (self:GetMaxClip1()) - (self:Clip1()), function() if not IsValid(self) then return end
		-- self:EmitSound(self.Primary.ReloadSound) end)
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- if timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 1 then
		-- self:SetNextPrimaryFire(CurTime() + 2.5)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 2 then
		-- self:SetNextPrimaryFire(CurTime() + 2.7)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 3 then
		-- self:SetNextPrimaryFire(CurTime() + 3.1)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 4 then
		-- self:SetNextPrimaryFire(CurTime() + 3.4)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 5 then
		-- self:SetNextPrimaryFire(CurTime() + 3.9)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 6 then
		-- self:SetNextPrimaryFire(CurTime() + 4.4)
		-- elseif !timer.Exists("shottyreload"..self.Owner:UniqueID()) then return
		-- end
		-- elseif self.Owner:HasInventoryItem(self.RelAmmo) and (self.Weapon:Clip1() < 6)  then
		-- -- timer.Create("shottyreload"..self.Owner:UniqueID(), .5, (self:GetMaxClip1()) - (self:Clip1()), function()
		-- -- self:EmitSound(self.Primary.ReloadSound) end)
		-- -- self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- if timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 1 then
		-- self:SetNextPrimaryFire(CurTime() + 2.5)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 2 then
		-- self:SetNextPrimaryFire(CurTime() + 2.7)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 3 then
		-- self:SetNextPrimaryFire(CurTime() + 3.1)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 4 then
		-- self:SetNextPrimaryFire(CurTime() + 3.4)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 5 then
		-- self:SetNextPrimaryFire(CurTime() + 3.9)
		-- elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 6 then
		-- self:SetNextPrimaryFire(CurTime() + 4.4)
		-- -- elseif !timer.Exists("shottyreload"..self.Owner:UniqueID()) then return
		-- end
		-- self.Weapon:DefaultReload( ACT_VM_RELOAD)
		-- --self:SetNextPrimaryFire(timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) + 2)
		-- self.Owner:TakeInventoryItemClass(self.RelAmmo)
		-- self.Owner:GiveAmmo(self.RelAmmount, self.Primary.Ammo, true)
		-- --self.Weapon:DefaultReload( ACT_VM_RELOAD )
		-- end
-- end
-- end

function SWEP:PrimaryAttack()

--if self.Owner:GetSkillXP() 
 
if ( !self:CanPrimaryAttack() ) then return end
local dmginfo = DamageInfo()
dmginfo:SetAmmoType(game.GetAmmoID( self.Primary.Ammo ) )
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector()
bullet.Spread = Vector( self.Primary.Spread * ( 0.1 - 0 )  , self.Primary.Spread * ( 0.1 - 0 ), 0)
--print(bullet.Spread)

bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -.025
local rndb = self.Primary.Recoil * math.random(-.025, .025) 

local rndc = self.Primary.Spread * -.025
local rndd = self.Primary.Spread * math.random(-.025, .025)

local rnda2 = self.Primary.Recoil * -.01
local rndb2 = self.Primary.Recoil * math.random(-.01, .01) 

local rndc2 = self.Primary.Spread * -.025
local rndd2 = self.Primary.Spread * math.random(-.025, .025)
 
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

function SWEP:Reload()
	local ply = self.Owner
	local has, amount = ply:HasInventoryItem("ammo_shotgun")
	local hasSpare, amountSpare = ply:HasInventoryItem("ammo_spareshotgun")
	self:SetHoldType("shotgun")

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
				ply:TakeInventoryItemClass("ammo_spareshotgun")
				amountSpare = amountSpare - 1
			end
		elseif(has) then
			ply:SetAmmo(self.Primary.ClipSize, self.Primary.Ammo)
			ply:TakeInventoryItemClass("ammo_shotgun")
		end
	end
	if(SERVER and self:Clip1() + self:Ammo1() > self.Primary.ClipSize) then
		for i = 1, (self:Clip1() + self:Ammo1())-self.Primary.ClipSize do
			if ply:Team() == TEAM_CPF or ply:Team() == TEAM_TA then
				ply:GiveInventoryItem("ammo_spareshotgun", 1, true)
			else
				ply:GiveInventoryItem("ammo_spareshotgun")
			end
			if(amountSpare == nil) then amountSpare = 1 else amountSpare = amountSpare + 1 end
		end
		if(hasSpare and amountSpare >= self.Primary.ClipSize) then
			for i = 1, self.Primary.ClipSize do
				ply:TakeInventoryItemClass("ammo_spareshotgun")
				amountSpare = amountSpare - 1
			end
			if ply:Team() == TEAM_CPF or ply:Team() == TEAM_TA then
				ply:GiveInventoryItem("ammo_shotgun", 1, true)
			else
				ply:GiveInventoryItem("ammo_shotgun")
			end
		end	
	end
		if(self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0) then
			self:SetHoldType("shotgun")
			--self:SetNextPrimaryFire(self.Primary.ClipSize - self:Clip1() + 3)
			self.Weapon:DefaultReload(ACT_VM_RELOAD);
			--ply:EmitSound("weapons/shotgun/shotgun_reload2.wav", 80, 100, 0.5)
			timer.Create("shottyreload"..self.Owner:UniqueID(), .5, (self:GetMaxClip1()) - (self:Clip1()), function() if not IsValid(self) then return end
		self:EmitSound(self.Primary.ReloadSound) end)
		self.Weapon:DefaultReload( ACT_VM_RELOAD )
		if timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 1 then
		self:SetNextPrimaryFire(CurTime() + 2.5)
		elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 2 then
		self:SetNextPrimaryFire(CurTime() + 2.7)
		elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 3 then
		self:SetNextPrimaryFire(CurTime() + 3.1)
		elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 4 then
		self:SetNextPrimaryFire(CurTime() + 3.4)
		elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 5 then
		self:SetNextPrimaryFire(CurTime() + 3.9)
		elseif timer.RepsLeft("shottyreload"..self.Owner:UniqueID()) == 6 then
		self:SetNextPrimaryFire(CurTime() + 4.4)
		elseif !timer.Exists("shottyreload"..self.Owner:UniqueID()) then return
		end
		end
end

function SWEP:StartReload()
	local reload = self.Primary.Reload

	self:GetOwner():SetAnimation(PLAYER_RELOAD)

	--if reload.Shotgun then
		self:SendTranslatedWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self:SetFirstReload(true)

	local duration = self:GetReloadTime()

	self:SetFinishReload(CurTime() + duration)
	self:SetNextIdle(CurTime() + duration)
end

function SWEP:TranslateWeaponAnim(act)
	return act
end

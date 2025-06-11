SWEP.PrintName = "Muhammed's Base" -- The name of the weapon
    
SWEP.Author = "Muhammed Bin Willard"
SWEP.Contact = "xdwazzup@gmail.com"--Optional
SWEP.Purpose = "add your purpose here"
SWEP.Instructions = "add instructions here."
SWEP.Category = "Hatchet" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

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
SWEP.ViewModel			= nil
SWEP.WorldModel			= SWEP.WorldModel or "models/weapons/w_pistol.mdl"
SWEP.UseHands           = true

SWEP.HoldType = SWEP.HoldType or "pistol"
SWEP.Active = SWEP.Active or nil

SWEP.FiresUnderwater = false

SWEP.ReloadSound = "sound/epicreload.wav"

SWEP.CSMuzzleFlashes = true

local barrelAngles = {
    _default = {Vector(10,.65,3.5),Angle(-2,5,0)},
   	["m_rev"] = {Vector(-9,-0.9,2.8),Angle(-5,-1,0)},
    ["m_usp"] = {Vector(-5,0.3,4.3),Angle(-5,1.6,0)},
    ["m_ar2"] = {Vector(25,-0.8,10),Angle(-10.2,0,0)},
    ["m_smg"] = {Vector(5,-0.15,6.5),Angle(-10,0.25,0)},
	["m_ak47"] = {Vector(11,-1,5.25),Angle(-9,0,0)},
	["m_shotgun"] = {Vector(5,-.85,4.65),Angle(-5.4,-0.9,0)}
}


function SWEP:Think()
	
--	debugoverlay.Cross(self:GetNWVector('AT_PosSV'), 3, 3, Color(255, 0, 255), true)
	
--	if SERVER then
--	else
--	end
		
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
	
	if self:GetOwner().Stunned then
		return false
	end

	return true

end

function SWEP:DrawHUD()
	local ply = self:GetOwner()
	local pos, dir = self:GetShootPos()
	
	local tr = util.TraceLine( {
	start = pos,
	endpos = pos + (dir * 100000),
	filter = function(ent)
        return ent != ply and ent:GetRenderMode() ~= RENDERMODE_TRANSALPHA
    end
	} )
	local pivotpoint = tr.HitPos:ToScreen()
	
	local tobedrawn = impulse.GetSetting("crosshair_selection")
	local tbdcol = impulse.GetSetting("crosshair_color")
	
	-- local colorcor = {
	-- [Purple] = Color(162, 0, 255),
	-- [Blue] = Color(65, 125, 255),
	-- [Orange] = Color(255, 145, 0),
	-- [Red] = Color(255, 0, 0),
	-- [Yellow] = Color(255, 238, 0),
	-- [Green] = Color(0, 255, 0),
	-- [White] = Color(255, 255, 255)
	-- }
	
	--print(pivotpoint)
	
	--if tobedrawn == "Hatchet Legacy" then
		surface.SetDrawColor(255, 0, 0)
		--if LocalPlayer():IsValid() and LocalPlayer():Alive() then
			-- local x, y = 0, 0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawCircle(pivotpoint.x, pivotpoint.y, radius, 255, 0, 0, 255)
			
hook.Add( "PostDrawTranslucentRenderables", "MySuper3DRenderingHook", function()
			render.DrawLine( pos, tr.HitPos, Color(255,0,0))
end)
			
		--end
	--end
	return true
end




function SWEP:GetShootPos()
    local ply = self:GetOwner()
    local lookAtt = ply:LookupAttachment('anim_attachment_rh')
    if lookAtt and ply:GetMoveType() != MOVETYPE_NOCLIP then
        local att = ply:GetAttachment(lookAtt)
        local mPos, mAng = self.MuzzlePos, self.MuzzleAng
        if not mPos then
            if barrelAngles[self:GetClass()] then
                mPos, mAng = unpack(barrelAngles[self:GetClass()])
            else
                mPos, mAng = unpack(barrelAngles._default)
            end
        end
        local pos, dir = LocalToWorld(mPos, mAng, att.Pos, att.Ang)
        return pos, dir:Forward()
    else
        return ply:GetShootPos(), (ply.viewAngs or ply:EyeAngles()):Forward()
    end
end


function SWEP:PrimaryAttack()
 
if ( !self:CanPrimaryAttack() ) then return end

local dmginfo = DamageInfo()
dmginfo:SetAmmoType(game.GetAmmoID( self.Primary.Ammo ) )

local pos, dir = self:GetShootPos()

local bullet = {} 
bullet.Num = self.Primary.NumberofShots
bullet.Src = pos
bullet.Dir = dir



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
 
	if self.Owner:Crouching() then
		bullet.Spread = Vector( self.Primary.Spread * (0.06 - skillaccuracy)  , self.Primary.Spread * (0.06 - skillaccuracy), 0)
	else
		bullet.Spread = Vector( self.Primary.Spread * ( 0.1 - skillaccuracy )  , self.Primary.Spread * ( 0.1 - skillaccuracy ), 0)
	end

bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
self:GetOwner():FireBullets( bullet ) 

if SERVER then
	self.Owner:AddSkillXP("shooting", math.random(1,3))
end

self:EmitSound(self.Primary.Sound) 

local rnda = self.Primary.Recoil * -.018
local rndb = self.Primary.Recoil * math.random(-.018, .018) 

local rnda2 = self.Primary.Recoil * -.01
local rndb2 = self.Primary.Recoil * math.random(-.01, .01) 
 
self:ShootEffects()

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
			ply:DoReloadEvent()
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
		self:SetNextIdle( 1 )
		self:SendWeaponAnim( self:Clip1() > 0 and ACT_VM_IDLE or ACT_VM_IDLE_EMPTY )
	end
	
end

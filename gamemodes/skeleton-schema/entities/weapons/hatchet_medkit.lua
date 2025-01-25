SWEP.PrintName = "Medkit" -- The name of the weapon
SWEP.Author = "WillMaster"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "hatchet_medicalbase"

SWEP.hidehud = true
SWEP.OffsetVector = Vector(6, -0.5, -2.4)
SWEP.OffsetAngle = Angle(180, 90, -90)
SWEP.WorldModelOfHand   = "models/warz/items/medkit.mdl"
SWEP.AmountOfHealth = 15
SWEP.HealSound = "items/smallmedkit1.wav"
SWEP.HealDelay = .5
SWEP.HealDelayOnSecondaryAttack = 2
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 15 -- How much bullets are in the mag
SWEP.Primary.Ammo = "medkit_hatchet_ammo" --The ammo type will it use
SWEP.NextFire = CurTime()
SWEP.RDel = CurTime()

-- SWEP.Primary.Sound = Sound("")
-- SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
-- SWEP.Primary.ClipSize = 1  -- How much bullets are in the mag
-- SWEP.Primary.Ammo = "medkit" --The ammo type will it use

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 0 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/v_bugbait.mdl"
SWEP.WorldModel			= ""
SWEP.UseHands           = true
SWEP.IsAlwaysRaised = true

SWEP.HoldType = "normal"

SWEP.FiresUnderwater = false

SWEP.CSMuzzleFlashes = true

local rdel = CurTime()

function SWEP:PrimaryAttack()

	if SERVER then

	local trace = util.TraceLine({

		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 150,
		filter = self:GetOwner()
	})
	
	local ent = trace.Entity
	
	--print(trace.Entity:Nick())
	
	if not IsValid(ent) then return end

	if ent and ent:GetClass() != "player" then
		return
	end
	
	if ent:Health() == ent:GetMaxHealth() then
			self:GetOwner():Notify("This person isn't hurt.")
		return
	end

	self:TakePrimaryAmmo(1)
	self:EmitSound(self.HealSound)
	ent:SetHealth(math.Clamp( ent:Health() + self.AmountOfHealth, 0, ent:GetMaxHealth() ))
	ent:ScreenFade(1, Color(201, 217, 242, 180), 1, 0)

	self.NextFire = CurTime() + self.HealDelay
	self:SetNextPrimaryFire(CurTime() + self.HealDelay)

	if SERVER then
		if self:GetOwner():GetActiveWeapon():Clip1() <= 0 then
			local curwep = self
			-- print(curwep)
			self:GetOwner():Notify("You're out!")
			self:GetOwner():SelectWeapon("impulse_hands")
			self:GetOwner():StripWeapon(curwep)
		end
	end
	
	end

end

function SWEP:SecondaryAttack()
	-- print("t")
	if SERVER then
	if self.NextFire < CurTime() then
		-- print("t2")
		if self:GetOwner():Health() == self:GetOwner():GetMaxHealth() then
			self:GetOwner():Notify("You're fully healed.")
			return
		end

		self:TakePrimaryAmmo(1)

		self:EmitSound(self.HealSound)
		self:GetOwner():SetHealth(math.Clamp( self:GetOwner():Health() + self.AmountOfHealth, 0, self:GetOwner():GetMaxHealth() ))
		self:SetNextPrimaryFire(CurTime() + self.HealDelayOnSecondaryAttack)
		self:GetOwner():ScreenFade(1, Color(201, 217, 242, 180), 1, 0)
		if self:GetOwner():GetActiveWeapon():Clip1() <= 0 then
			local curwep = self:GetOwner():GetActiveWeapon():GetClass()
			-- print(curwep)
			self:GetOwner():Notify("You're out!")

			self:GetOwner():SelectWeapon("impulse_hands")
			self:GetOwner():StripWeapon(curwep)
		end
		Delay = CurTime() + self.HealDelayOnSecondaryAttack
	end
	end
end

function SWEP:Reload()
	if SERVER then
		if rdel > CurTime() then return end
		rdel = CurTime() + 2
		net.Start("HatchetOpenLimbsMenu")
		net.Send(self:GetOwner())
		self:GetOwner().currentMedkit = self
	end
end

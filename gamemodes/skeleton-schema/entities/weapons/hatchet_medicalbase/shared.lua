SWEP.PrintName = "HEALINGBASE" -- The name of the weapon
SWEP.Author = "WillMaster"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

SWEP.hidehud = true
SWEP.OffsetVector = Vector(6, -0.5, -2.4)
SWEP.OffsetAngle = Angle(180, 90, -90)
SWEP.WorldModelOfHand   = "models/warz/items/medkit.mdl"

SWEP.AmountOfHealth = 15
SWEP.HealSound = "items/smallmedkit1.wav"
SWEP.HealDelay = 2
SWEP.HealDelayOnSecondaryAttack = 2
-- SWEP.AmountOfUses = 5 // Ignore this, we arent using it anymore
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 15 -- How much bullets are in the mag
SWEP.Primary.Ammo = "medkit_base" --The ammo type will it use

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

local Delay = CurTime()

-- function SWEP:Think()
-- 	print(self:GetOwner():GetActiveWeapon():Clip1())
-- end

function SWEP:PrimaryAttack()

	local trace = util.TraceLine({

		start = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 25,
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500,
		filter = ply
	})

	local ent = trace.Entity
	if !ent:IsPlayer() then
		return
	end

	self:TakePrimaryAmmo(1)
	self:EmitSound(self.HealSound)
	ent:SetHealth(math.Clamp( ent:Health() + self.AmountOfHealth, 0, ent:GetMaxHealth() ))
	ent:ScreenFade(1, Color(201, 217, 242, 180), 1, 0)

	Delay = CurTime() + self.HealDelay
	self:SetNextPrimaryFire(CurTime() + self.HealDelay)

	if SERVER then
		if self:GetOwner():GetActiveWeapon():Clip1() <= 0 then
			local curwep = self:GetOwner():GetActiveWeapon():GetClass()
			-- print(curwep)
			self:GetOwner():Notify("You're out!")
			self:GetOwner():SelectWeapon("impulse_hands")
			self:GetOwner():StripWeapon(curwep)
		end
	end

end

function SWEP:SecondaryAttack()
	-- print("t")
	if Delay < CurTime() then
		-- print("t2")

		self:TakePrimaryAmmo(1)

		self:EmitSound(self.HealSound)
		self:GetOwner():SetHealth(math.Clamp( self:GetOwner():Health() + self.AmountOfHealth, 0, self:GetOwner():GetMaxHealth() ))
		self:SetNextPrimaryFire(CurTime() + self.HealDelayOnSecondaryAttack)
		self:GetOwner():ScreenFade(1, Color(201, 217, 242, 180), 1, 0)

		if SERVER then
			if self:GetOwner():GetActiveWeapon():Clip1() <= 0 then
				local curwep = self:GetOwner():GetActiveWeapon():GetClass()
				-- print(curwep)
				self:GetOwner():Notify("You're out!")
	
				self:GetOwner():SelectWeapon("impulse_hands")
				self:GetOwner():StripWeapon(curwep)
			end
		end
		Delay = CurTime() + self.HealDelayOnSecondaryAttack
	end
end

if SERVER then

	local broom = ents.Create("prop_dynamic")

	function SWEP:Deploy()

		-- print(self:GetOwner().curwepmodel)
		if IsValid(self:GetOwner().curwepmodel) then
			self:GetOwner().curwepmodel:Remove()
			self:GetOwner().curwepmodel = nil
		end
		timer.Simple(0, function()
			if not IsValid(broom) then
				broom = ents.Create("prop_dynamic")
			end
			broom:SetModel(self.WorldModelOfHand)
			broom:DrawShadow(true)
			broom:SetMoveType(MOVETYPE_NONE)
			broom:SetParent(self:GetOwner())
			broom:SetSolid(SOLID_NONE)
			broom:Spawn()
			broom:SetName(self:GetOwner():SteamID64() .. "_Broom")
			broom:Fire("setparentattachment", "anim_attachment_RH", 0.01)
			timer.Simple(0.016, function()
	
				local boneid = self:GetOwner():LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
				if !boneid then return end
	
				local matrix = self:GetOwner():GetBoneMatrix(boneid)
				if !matrix then return end
	
				local newPos, newAng = LocalToWorld(self.OffsetVector, self.OffsetAngle, matrix:GetTranslation(), matrix:GetAngles())
		
				if IsValid(broom) then
					broom:SetPos(newPos)
					broom:SetAngles(newAng)
				end
			end)

			self:GetOwner().curwepmodel = broom

		end)

	end

	function SWEP:Holster()
		-- print("Broom: " .. broom:GetName())
		if IsValid(broom) and broom:GetName() == self:GetOwner():SteamID64() .. "_Broom" then
			broom:Remove()
			return true
		end

		if IsValid(self:GetOwner().curwepmodel) then
			-- print("side 2")
			self:GetOwner().curwepmodel:Remove()
			self:GetOwner().curwepmodel = nil
			return true
		end
	end

end

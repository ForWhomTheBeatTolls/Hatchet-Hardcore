AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Broom"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("models/weapons/v_crowbar.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.IsAlwaysRaised = true

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")

SWEP.Primary.ImpactSound = Sound("physics/body/body_medium_impact_hard" .. math.random(1, 6) .. ".wav")


SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 5 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.HullSize = 4
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 50
SWEP.Primary.StunTime = 0.1
SWEP.Primary.Automatic = true

SWEP.BlockDelay = CurTime()

function SWEP:PrimaryAttack()
	if not self:GetOwner():Team() == TEAM_VORT then
		return true
	end

	if not self:GetOwner():OnGround() then
		return
	end

	if SERVER then
		self:GetOwner():ForceSequence("sweep")
		self:GetOwner():EmitSound("impulse/broom.wav")

		self:GetOwner():Freeze(true)
	end

	timer.Simple(3, function() self:GetOwner():Freeze(false) end)
	self:SetNextPrimaryFire(CurTime() + 3)
end

if SERVER then

	local broom = ents.Create("prop_dynamic")

	function SWEP:Deploy()
		if IsValid(self:GetOwner().curwepmodel) then
			self:GetOwner().curwepmodel:Remove()
			self:GetOwner().curwepmodel = nil
		end
		if not IsValid(broom) then
			broom = ents.Create("prop_dynamic")
		end
		broom:SetModel("models/props_c17/pushbroom.mdl")
		broom:DrawShadow(true)
		broom:SetMoveType(MOVETYPE_NONE)
		broom:SetParent(self:GetOwner())
		broom:SetSolid(SOLID_NONE)
		broom:Spawn()
		broom:SetName(self:GetOwner():SteamID64() .. "_Broom")
		broom:Fire("setparentattachment", "cleaver_attachment", 0.01)

		self:GetOwner().curwepmodel = broom
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

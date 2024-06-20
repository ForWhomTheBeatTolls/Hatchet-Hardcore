AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Katana"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/w_katana.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_axe.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("physics/metal/metal_solid_impact_bullet2.wav")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 43 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.HullSize = 3
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 80
SWEP.Primary.StunTime = 0.3

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

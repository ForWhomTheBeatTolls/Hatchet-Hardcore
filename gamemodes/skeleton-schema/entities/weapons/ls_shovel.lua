AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Shovel"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/hl2meleepack/w_shovel.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_shovel.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 1.4 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 30 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.Delay = 1.2
SWEP.Primary.Range = 90
SWEP.Primary.StunTime = 0.4
SWEP.Primary.Automatic = true

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

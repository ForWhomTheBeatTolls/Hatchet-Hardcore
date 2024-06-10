AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Pipe"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/props_canal/mattpipe.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_pipe.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 1.4 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 25 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.HullSize = 12
SWEP.Primary.Delay = 1
SWEP.Primary.Range = 80
SWEP.Primary.StunTime = 0.3
SWEP.Primary.Automatic = true

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

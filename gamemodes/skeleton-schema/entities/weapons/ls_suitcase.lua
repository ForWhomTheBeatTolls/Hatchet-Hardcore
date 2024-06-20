AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Suitcase"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "suitcase"

SWEP.WorldModel = Model("models/weapons/w_hatchetsuitcase.mdl")
SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.IsAlwaysRaised = true

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
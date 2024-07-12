AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "KM"
SWEP.Category = "Hatchet-unobt"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.IsAlwaysRaised = true

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
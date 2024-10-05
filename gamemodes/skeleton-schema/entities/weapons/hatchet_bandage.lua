SWEP.PrintName = "Bandage" -- The name of the weapon
SWEP.Author = "WillMaster"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "hatchet_medicalbase"
SWEP.hidehud = true

SWEP.hidehud = true
SWEP.OffsetVector = Vector(6, -0.5, -2.4)
SWEP.OffsetAngle = Angle(180, 90, -90)
SWEP.WorldModelOfHand   = "models/warz/items/bandage.mdl"


SWEP.AmountOfHealth = 10
SWEP.HealSound = "items/smallmedkit1.wav"
SWEP.AmountOfUses = 1

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
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Submachine Gun"
SWEP.Category = "Plutonic: Half-Life 2"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.IconOverride = "materials/entities/weapon_pistol.png"

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/w_smg1.mdl")
SWEP.ViewModel = Model("models/weapons/c_smg1.mdl")
SWEP.ViewModelFOV = 55
SWEP.ViewModelOffset = Vector(0, 0, 0)

SWEP.Primary.Shell = "ShellEject"
SWEP.Primary.ShellScale = 1
SWEP.Primary.ShellAttachment = 2

SWEP.BarrelLength = 6
SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("weapons/smg1/smg1_reload.wav")
SWEP.EmptySound = Sound("weapons/pistol/pistol_empty.wav")

SWEP.Primary.Sound = Sound("weapons/smg1/smg1_fire1.wav")

SWEP.Primary.Recoil = .9
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = Plutonic.FireRate.RPM(710)

SWEP.Primary.RecoilUp = 1
SWEP.Primary.RecoilDown = 1
SWEP.Primary.RecoilSide = 1.2

SWEP.Primary.StartFalloff = 1200
SWEP.Primary.FallOff = 1800

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 300

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.002
SWEP.Spread.Max = 0.015
SWEP.Spread.IronsightsMod = 0.7
SWEP.Spread.CrouchMod = 1
SWEP.Spread.AirMod = 1.2
SWEP.Spread.RecoilMod = 0.03
SWEP.Spread.VelocityMod = 0.2

SWEP.Sway = 0.2
SWEP.SwayFactor = 4
SWEP.SwayScale = 0.1
SWEP.BobScale = 0

SWEP.IronsightsPos = Vector(-6.69, 2, 1.15)
SWEP.IronsightsAng = Angle(0.2, -1, 1.2)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.45
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

SWEP.BlowbackPos = Vector(0, -4, -0.1)
SWEP.BlowbackAngle = Angle(0, 0, 0)

SWEP.CenteredPos = Vector(-4.5, 4, -.65)
SWEP.CenteredAng = Angle(0.472, 0.017, 0)

SWEP.LoweredPos = Vector(2, -5, -10)
SWEP.LoweredAng = Angle(-5, 40, -35)

hook.Add("LongswordWeaponCanReload", "Weapon.MP7.CanReload", function(ply, weapon, time)
    return ply:IsOnGround() // for the animations
end)

// add support for other frameworks
--local function getModelClass(model)
    --if ( ix ) then
    --    return ix.anim.GetModelClass(model)
    --elseif ( nut ) then
    --    return nut.anim.getModelClass(model)
  --  elseif ( impulse ) then
--        return impulse.GetModelClass(model)
--    elseif ( Clockwork ) then
--        return Clockwork.animation:GetModelClass(model)
--    end
--
--    return "citizen_male"
--end

-- if table, arg#1 is standing anim, arg#2 is crouching anim
--local animationTranslator = {
--    ["overwatch"] = {"reload", "reload_low"},
--    ["metrocop"] = "reload_smg1",
--    ["citizen_female"] = "reload_smg1",
--    ["citizen_male"] = "reload_smg1",
--}
-- hook.Add("LongswordWeaponReload", "Weaon.MP7.Reload", function(ply, weapon, time)
 --   if ( SERVER and ply:IsOnGround() and weapon:GetClass() == "plutonic_mp7" ) then
 --       ply:SetLocalVelocity(Vector(0, 0, 0))
--
 --       local data = animationTranslator[getModelClass(ply:GetModel())]
 --       if ( data ) then
 --           local animation = istable(data) and ( ply:Crouching() and data[2] or data[1] ) or data
 --           if ( ply.ForceSequence ) then // helix, impulse
 --               ply:ForceSequence(animation, nil, time)
--            elseif ( ply.forceSequence ) then // nutscript
 --               ply:forceSequence(animation, nil, time)
 --           elseif ( ply.SetForcedAnimation ) then // clockwork
--                ply:SetForcedAnimation(animation, time) // not sure if thats how it works for clockwork
--            end
--        end
--    end
--end)

// disables the Player:DoReloadEvent() function to hide the gesture of reloading
SWEP.NoReloadEvent = false
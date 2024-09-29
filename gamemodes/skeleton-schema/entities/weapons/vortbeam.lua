SWEP.PrintName = "Vort Beam" -- The name of the weapon
SWEP.Author = "WillMaster"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "m_base"

SWEP.Primary.Sound = Sound("npc/vort/attack_shoot.wav")
SWEP.Primary.EmptySound = Sound("")
SWEP.Primary.ReloadSound = Sound("")
SWEP.Primary.Damage = 55 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 0 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 1  -- How much bullets are in the mag
SWEP.Primary.Ammo = "" --The ammo type will it use
SWEP.Primary.DefaultClip = 100 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.2 -- The spread when shot
SWEP.Primary.NumberofShots = 5 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Recoil = 8 -- it no go BOOM
SWEP.Primary.Delay = 2 -- Delay before the next shot
SWEP.Primary.Force = 1
SWEP.Primary.Cone = 0.03
SWEP.DamageForce = 2
-- SWEP.RelAmmo = "ammo_rifle"
-- SWEP.RelAmmo2 = "ammo_sparerifle"
-- SWEP.RelAmmount = 30

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spread = {}
SWEP.Spread.RecoilMod = 0.025
SWEP.Spread.VelocityMod = 0.5

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 0 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= ""
SWEP.UseHands           = true
SWEP.IsAlwaysRaised = true

SWEP.HoldType = "shotgun"

SWEP.FiresUnderwater = false

SWEP.CSMuzzleFlashes = true

SWEP.Beaming = false
SWEP.Healing = false

local dly = CurTime()
local dly2 = CurTime()
local dly3 = CurTime()

function SWEP:SecondaryAttack()

    if self.Beaming == true then
        return 
    end

    if dly2 < CurTime() then
        dly2 = CurTime() + 5
        self.Healing = true

        if CLIENT then
            local part = CreateParticleSystem( self:GetOwner(), "vortigaunt_charge_token_c", PATTACH_POINT_FOLLOW, 6 )
            local part2 = CreateParticleSystem( self:GetOwner(), "vortigaunt_charge_token_c", PATTACH_POINT_FOLLOW, 7 )
    
            timer.Simple(3.8, function()
                self:GetOwner():DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE, self:GetOwner():LookupSequence("g_zapattack1"))
            end)
    
            timer.Simple(4, function()
                part:StopEmission( false, true, false )
                part2:StopEmission( false, true, false )
            end)
        end
        self:GetOwner():EmitSound("npc/vort/health_charge.wav")

        timer.Simple(4, function()
            local trace = util.TraceLine({

                start = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 25,
                endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500,
                filter = ply
            })
    
            local ent = trace.Entity
            if !ent:IsPlayer() then
                self.Healing = false
                return
            end
            ent:SetHealth(math.Clamp( ent:Health() + 50, 0, 100 ))
            ent:EmitSound("items/suitchargeok1.wav")
            ent:EmitSound("beams/beamstart5.wav")
            self.Healing = false
            dly2 = CurTime() + 35
        end)
    else
        if dly3 < CurTime() then
            dly3 = CurTime() + 2
            self:GetOwner():Notify("You have to wait " .. tostring(math.ceil(dly2 - CurTime())) .. " before healing again.")
        end
    end
end

function SWEP:PrimaryAttack()

    if self.Healing == true then return end

    if dly < CurTime() then
        dly = CurTime() + 4
        self.Beaming = true

        if CLIENT then
        local part = CreateParticleSystem( self:GetOwner(), "vortigaunt_charge_token_c", PATTACH_POINT_FOLLOW, 6 )
        local part2 = CreateParticleSystem( self:GetOwner(), "vortigaunt_charge_token_c", PATTACH_POINT_FOLLOW, 7 )

        timer.Simple(1.7, function()
            self:GetOwner():DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE, self:GetOwner():LookupSequence("g_zapattack1"))
        end)

        timer.Simple(2, function()
            part:StopEmission( false, true, false )
            part2:StopEmission( false, true, false )
        end)
        end
        -- ParticleEffect( "vortigaunt_charge_token_c", hand1, Angle( 0, 0, 0 ) )

        self:GetOwner():EmitSound("npc/vort/attack_charge.wav", 42)
            timer.Simple(2, function()

                self:GetOwner():StopSound("npc/vort/attack_charge.wav")

                        	-- Make sure we can shoot first
                -- Play shoot sound
                self.Weapon:EmitSound(self.Primary.Sound )

                local trace = util.TraceLine({

                    start = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 25,
                    endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500,
                    filter = ply
                })

                local victim = trace.Entity

                if CLIENT then

                    local id = 4
                    local mdl = self:GetOwner()
                    local blastPos = mdl:GetShootPos() + mdl:GetAimVector() * 500
                    local d = CreateParticleSystem(mdl,"vortigaunt_beam", PATTACH_POINT_FOLLOW,id,Vector(0,0,0))
                        d:AddControlPoint(1, Entity(0), 0, 0, blastPos)

                end

                -- local effectdata = EffectData()
                -- effectdata:SetOrigin( self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500 )
                -- util.Effect( "VortDispel", effectdata )

                if SERVER then
                    if IsValid(victim) then
                        local DMG = DamageInfo()
                        DMG:SetDamageType(DMG_SHOCK)
                        DMG:SetDamage(self.Primary.Damage)
                        DMG:SetAttacker(self:GetOwner())
                        DMG:SetInflictor(self:GetOwner():GetActiveWeapon())
                        DMG:SetDamagePosition(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 500)
                        DMG:SetDamageForce(self:GetOwner():GetAimVector() * self.DamageForce)
                        victim:TakeDamageInfo( DMG )
                    end
                end

                self:GetOwner():ViewPunch( Angle( 0 - self.Primary.Recoil, 0, 0 ) )
                self.Beaming = false
            end)
    end

end
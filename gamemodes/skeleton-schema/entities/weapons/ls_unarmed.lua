AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Unarmed"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("")
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
SWEP.Primary.Delay = 1.4
SWEP.Primary.Range = 50
SWEP.Primary.StunTime = 0.1
SWEP.Primary.Automatic = true

function SWEP:PrimaryAttack()
	if self.PrePrimaryAttack then
		self.PrePrimaryAttack(self)
	end

    if self.Owner:KeyDown(IN_ATTACK2) == true then
        return
    end

	if self.Primary.HitDelay then
		timer.Simple(self.Primary.HitDelay, function()
			if IsValid(self) and IsValid(self.Owner) then
				self:ClubAttack()
				self:ViewPunch()
			end
		end)
	else
		self:ClubAttack()
		self:ViewPunch()
	end

    local sounds = {
        "vo/npc/male01/hacks01.wav",
        "vo/npc/male01/headsup01.wav",
        "vo/npc/male01/headsup02.wav",
        "vo/npc/male01/gordead_ques17.wav",
        "vo/npc/male01/likethat.wav",
        "vo/npc/male01/gethellout.wav",
		"vo/npc/male01/getdown02.wav",
		"vo/npc/male01/overhere01.wav",
		"vo/npc/male01/oneforme.wav",
		"vo/npc/male01/upthere02.wav",
		"vo/npc/male01/thehacks01.wav"
    }

    self:EmitSound( sounds[math.random(1, #sounds)] )
	self:EmitSound(self.Primary.Sound)

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if self.DoFireAnim then
		self:PlayAnim(ACT_VM_PRIMARYATTACK)
	else
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_ATTACK2) then
		if SERVER then
			self.Owner:Say("/me Blocks their arms!")
		end
		self:EmitSound("physics/body/body_medium_impact_soft6.wav")
	end
end

function SWEP:Think()
	if self.Owner:KeyReleased(IN_ATTACK2) == true then
		if SERVER then
			self.Owner:Say("/me UnBlocks their arms!")
		end
		self:EmitSound("physics/body/body_medium_impact_soft6.wav")
	end
end
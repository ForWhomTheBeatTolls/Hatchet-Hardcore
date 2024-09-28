AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Unarmed"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "fist"

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
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 50
SWEP.Primary.StunTime = 0.1
SWEP.Primary.Automatic = true

SWEP.BlockDelay = CurTime()

function SWEP:CanPrimaryAttack()
	
	if self:GetNextPrimaryFire() > CurTime() then
		return false
	elseif self.Owner.IsBlocking == true then
		return false
	end
	
	return true
	
end

function SWEP:PrimaryAttack()
	
	if self:CanPrimaryAttack() then
	
	self:ShootEffects()
	
	if self.Owner.IsBlocking then
        return
    end
	
	if self.Owner:KeyDown(IN_WALK) == true then
		if SERVER then
			KMCheck(self.Owner)
		end
	end
		
	
	if self.PrePrimaryAttack then
		self.PrePrimaryAttack(self)
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
	
	local lsounds = {
	"yakuza0/kiryu/attack_s1.wav",
	"yakuza0/kiryu/attack_s2.wav",
	"yakuza0/kiryu/attack_s3.wav"
	}
	
	local msounds = {
	"yakuza0/kiryu/attack_l1.wav",
	"yakuza0/kiryu/attack_l2.wav",
	"yakuza0/kiryu/attack_l3.wav"
	}
	
	local swingsounds = {
	"yakuza0/weapons/fists/swing1.wav",
	"yakuza0/weapons/fists/swing2.wav",
	"yakuza0/weapons/fists/swing3.wav",
	"yakuza0/weapons/fists/swing4.wav"
	}
	
    --self:EmitSound( sounds[math.random(1, #sounds)] )
	self:EmitSound( swingsounds[math.random(1, #swingsounds)] )

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
end

end

function SWEP:ShootEffects()

	if self.DoFireAnim then
		self:PlayAnim(ACT_VM_PRIMARYATTACK)
	else
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
end

function SWEP:SecondaryAttack()
	
	if !self.Owner:KeyDown(IN_WALK) and self:GetNextPrimaryFire() < CurTime() then
		self:PrimaryAttack()
	end
	
	if self.Owner:KeyDown(IN_WALK) then
		if SERVER then
			if self.BlockDelay < CurTime() then
				self.Owner:Say("/me raises their guard.")
				self.Owner.IsBlocking = true
				self:EmitSound("physics/body/body_medium_impact_soft6.wav")
			else
				self.Owner:Notify("You must wait "..tostring(math.ceil(self.BlockDelay - CurTime())).." seconds before blocking again.")
				self.Owner.IsBlocking = false
			end
		end
	end
end

function SWEP:Think()
	if SERVER then
		if (self.Owner:KeyReleased(IN_WALK) == true) and self.Owner.IsBlocking == true then
			self.Owner:Say("/me lowers their guard.")
			self.Owner.IsBlocking = false
			self.BlockDelay = CurTime() + 4
			self:EmitSound("physics/body/body_medium_impact_soft6.wav")
		end
	end
end

AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Meat Cleaver"
SWEP.Category = "Hatchet"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.ViewModel = "models/weapons/hl2meleepack/v_pot.mdl"
SWEP.WorldModel = "models/props_lab/cleaver.mdl"
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false
SWEP.Primary.Sound = Sound("weapons/iceaxe/iceaxe_swing1.wav")
SWEP.Primary.ImpactSound = Sound("ambient/machines/slicer4.wav")
SWEP.Primary.Recoil = .7 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10.5 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.56
SWEP.Primary.HitDelay = 0.03
SWEP.Primary.HullSize = 12
SWEP.Primary.Range = 80
SWEP.Primary.StunTime = 1.5

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			local offsetVec = Vector(3, -1, 0) -- +forward -back / -left +right / -up +down
			local offsetAng = Angle(-90, 0, 0)

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)
			WorldModel:SetModelScale(0.8)

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end
end

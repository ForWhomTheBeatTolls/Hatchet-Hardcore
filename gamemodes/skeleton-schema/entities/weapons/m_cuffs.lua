AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Handcuffs"
SWEP.Category = "Hatchet-unobt"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"
SWEP.WorldModel = Model("models/chara/simplehandcuffs/w_handcuffs.mdl")
SWEP.ViewModel = Model("models/chara/simplehandcuffs/v_handcuffs.mdl")
SWEP.ViewModelFOV = 65
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.IsAlwaysRaised = true

if SERVER then

function SWEP:PrimaryAttack()

	local ply = self.Owner
	
	self:SetNextPrimaryFire(CurTime() + 1)
	
	if ply:HasInventoryItem("util_ziptie") then
	
		local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = ply
	} )
	
	local tar = tr.Entity
	
	if not IsValid(tar) or not tar:IsPlayer() or not tar:Alive() then
		return
	end
	
		local diff = tar:GetForward() - ply:GetForward()
	
		if tar:IsPlayer() and tar != ply then
		
			if ( (math.abs(diff.x) < 0.5 and math.abs(diff.y) < 0.5) ) or tar.Stunned == true then
			
				if not tar:GetSyncVar(SYNC_ARRESTED, false) then
					ply:SetAnimation( PLAYER_ATTACK1 )
					tar:Arrest()
					ply:Notify("You have detained "..tar:Name()..".")
					tar:Notify("You have been detained by "..ply:Name()..".")
					tar:EmitSound("chara/simplehandcuffs/handcuffs_close.mp3")
					hook.Run("PlayerArrested", tar, ply)
					ply:TakeInventoryItemClass("util_ziptie")
				else
					ply:Notify("Target already detained.")
				end
				
			else
			
				ply:Notify("The target has to be stunned, or you have to be behind them.")
				
			end
			
		end
		
	else ply:Notify("You don't have any remaining cuffs.")
	
	end
	
	--if tar:IsPlayer() then print("Yes") else print("No, it's ") end
	
end

end

function SWEP:SecondaryAttack()
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(4, -2, 0)
			local offsetAng = Angle(90, 90, 0)

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)
			WorldModel:SetModelScale(0.7)

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end
end

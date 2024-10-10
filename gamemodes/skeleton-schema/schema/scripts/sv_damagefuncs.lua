local dly = CurTime()
hook.Add("Think", "DamageFunctionsHatchet", function()

		for _, ply in pairs(player.GetAll()) do
		
			if (ply:GetModel() != "models/player.mdl") then
				local walk = ply:GetWalkSpeed()
				local run = ply:GetRunSpeed()
				
				if ply:IsCrippledLimb("LLeg") then
					ply.llegc = 1
				else
					ply.llegc = 0
				end
				if ply:IsCrippledLimb("RLeg") then
					ply.rlegc = 1
				else
					ply.rlegc = 0
				end
				
				if ply.TimesStunned == 0 then
					ply:SetRunSpeed( ( (impulse.Config.JogSpeed + (ply:GetSkillXP("vital") / 204.545))  /  (1 + ply.TimesDamaged / 3) ) / (1 + ply.rlegc + ply.llegc) )
					ply:SetWalkSpeed( impulse.Config.WalkSpeed / (1 + (ply.TimesDamaged / 3) ) / (1 + ply.rlegc + ply.llegc) )
				else
					ply:SetRunSpeed( ( (impulse.Config.JogSpeed + (ply:GetSkillXP("vital") / 204.545)) / ( 1 + (ply.TimesStunned / 2.5) ) ) / (1 + ply.rlegc + ply.llegc) )
					ply:SetWalkSpeed( (impulse.Config.WalkSpeed / ( 1 + (ply.TimesStunned / 2.5) ) ) / (1 + ply.rlegc + ply.llegc) )
				end
				
				if ply.TimesStunned > 2 then
					ply.Stunned = true
				else
					ply.Stunned = false
				end
					
				
				if ply.Stunned then
					ply:SetRunSpeed(1)
					ply:SetWalkSpeed(1)
					ply.CanCrouch = false
					ply.CanJump = false
				else
					ply.CanCrouch = true
					ply.CanJump = true
				end
				
			end
			
			---BLEED FUNCTIONS---
			
			
			if (ply:GetNWInt("BleedRate") > 0) and (ply.NextBleed < CurTime() or ply.NextBleed == nil) and ply:Alive() then
				ply.NextBleed = CurTime() + ( 7 - (0.5 * ply:GetNWInt("BleedRate")) )
				local bleeddmg = DamageInfo()
				bleeddmg:SetDamage(ply:GetNWInt("BleedRate") * 1.5)
				bleeddmg:SetAttacker( ply )
				bleeddmg:SetInflictor( Entity(0) )
				bleeddmg:SetDamageType( DMG_DIRECT )
				ply:TakeDamageInfo(bleeddmg)
				ply:SetViewPunchAngles( Angle(0,0,0) )
				util.BleedDecal(ply:GetPos(), ply, true)
				--ply:EmitSound("ambient/water/rain_drip"..math.random(1,4)..".wav", 65, math.random(45,80), 0.7, CHAN_AUTO)
				local rtd = math.random(1,10)
				if rtd > 8 then
					ply:SetNWInt("BleedRate", ply:GetNWInt("BleedRate") - 0.35)
				end
				if ply:GetNWInt("BleedRate") > 5 then
					ply:SetNWInt("BleedRate", 5)
				end
			end
			
			---EXTRA CHECKS---
			
			if ply:Health() > 100 and ply.HealOverTime == true then
				ply:SetHealth(100)
				ply.HealOverTime = false
			end
			
			if ply:GetNWInt("BleedRate") < 0 then
				ply:SetNWInt("BleedRate", 0)
			end
			
		end
		
		for _, ply in pairs(player.GetAll()) do
		
			if ply.TimesDamagedCool < CurTime() then
			
				if ply.TimesDamaged > 0 then
					ply.TimesDamaged = ply.TimesDamaged - 1
				else
					ply.TimesDamaged = 0
				end
				
				if ply.TimesDamagedCool > CurTime() then
					ply.TimesDamagedCool = ply.TimesDamagedCool + 0.8
				else
					ply.TimesDamagedCool = CurTime() + 0.8
				end
				
				if ply.CrouchCount > 0 then
					ply.CrouchCount = ply.CrouchCount - 1
				end
				
			end
			
			if ply.TimesStunnedCool < CurTime() then
				
				if ply.TimesStunned > 0 then
					ply.TimesStunned = ply.TimesStunned - 1
					ply.TimesStunnedCool = CurTime() + 1
				elseif ply.TimesStunned > 2 then
					ply.TimesStunned = 3
					ply.TimesStunnedCool = CurTime() + 3
				end
				
			end

			if ply.CombatCool < CurTime() then
				ply.IsInCombat = false
			end
			
			-- if dly < CurTime() then
			
				-- if ply:IsHurtLimb("LArm") then
					-- ply:GiveHealthLimb("LArm", 2.5)
				-- end
			
				-- if ply:IsHurtLimb("RArm") then
					-- ply:GiveHealthLimb("RArm", 2.5)
				-- end
				
				-- if ply:IsHurtLimb("LLeg") then
					-- ply:GiveHealthLimb("LLeg", 2.5)
				-- end
				
				-- if ply:IsHurtLimb("RLeg") then
					-- ply:GiveHealthLimb("RLeg", 2.5)
				-- end

			-- -- print(ply:Name() .. " LARM: " .. ply.Hurted_L_Arm_points)
			-- -- print(ply:Name() .. " RARM: " .. ply.Hurted_R_Arm_points)
				-- if _ == player.GetCount() then
					-- dly = CurTime() + 6
				-- end
			-- end
			
		end
		
end)

function GetNiceLimbName(limb)
	
	if limb == "LArm" then
		return "Left Arm"
	elseif limb == "RArm" then
		return "Right Arm"
	elseif limb == "LLeg" then
		return "Left Leg"
	elseif limb == "RLeg" then
		return "Right Leg"
	end
	
end


function meta:IsHurtLimb(limb)
	
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) < 100 then
		return true
	end
	
	return false

end

function meta:IsCrippledLimb(limb)
	
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) == 0 then
		return true
	end
	
	return false

end

function meta:TakeDamageLimb(limb, num)
	
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) then
		self:SetNWInt(limb, self:GetNWInt(limb) - num)
			if self:GetNWInt(limb) < 0 then
				self:SetNWInt(limb, 0)
			end
	if self:GetNWInt(limb) == 0 and self:GetNWBool(limb.."Crippled") == false then
		self:CrippleLimb(limb)
	end
		return true
	else
		return false
	end

end

function meta:CrippleLimb(limb)
	
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) then
		self:SetNWBool(limb.."Crippled", true)
		self:SetNWInt(limb, 0)
		self:Notify("Your "..GetNiceLimbName(limb).." has been crippled.")
		return true
	else
		return false
	end
	
end

function meta:UncrippleLimb(limb, num)
	
	if !num then num = 1 end
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) then
		self:SetNWBool(limb.."Crippled", false)
		self:SetNWInt(limb, num)
	
		self:Notify("Your "..GetNiceLimbName(limb).." has been healed.")
		return true
	else
		return false
	end
	
end

function meta:GiveHealthLimb(limb, num)
	
	local limb = tostring(limb)
	
	if self:GetNWInt(limb) then
		self:SetNWInt(limb, self:GetNWInt(limb) + num)
			if self:GetNWInt(limb) > 100 then
				self:SetNWInt(limb, 100)
			end
	if self:GetNWBool(limb.."Crippled") == true then
		self:UncrippleLimb(limb)
	end
		return true
	else
		return false
	end

end

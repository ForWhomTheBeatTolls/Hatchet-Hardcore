	hook.Add("Think", "DamageFunctionsHatchet", function()

		for _, ply in pairs(player.GetAll()) do
		
			if (ply:GetModel() != "models/player.mdl") then
				local walk = ply:GetWalkSpeed()
				local run = ply:GetRunSpeed()
				if ply.TimesStunned == 0 then
					ply:SetRunSpeed( (impulse.Config.JogSpeed + (ply:GetSkillXP("vital") / 204.545))  /  (1 + ply.TimesDamaged / 3) )
					ply:SetWalkSpeed( impulse.Config.WalkSpeed / (1 + (ply.TimesDamaged / 3) ))
				else
					ply:SetRunSpeed( (impulse.Config.JogSpeed + (ply:GetSkillXP("vital") / 204.545)) / ( 1 + (ply.TimesStunned / 2.5) ) )
					ply:SetWalkSpeed( (impulse.Config.WalkSpeed / ( 1 + (ply.TimesStunned / 2.5) ) ) )
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
					if dly < CurTime() then
			if ply.Hurted_L_Arm_points >= 0.2 and ply.Hurted_L_Arm != true then
				ply.Hurted_L_Arm_points = ply.Hurted_L_Arm_points - 0.2
			end
			if ply.Hurted_R_Arm_points >= 0.2 and ply.Hurted_R_Arm != true then
				ply.Hurted_R_Arm_points = ply.Hurted_R_Arm_points - 0.2
			end
			if ply.Hurted_L_Leg_points >= 0.2 and ply.Hurted_L_Leg != true then
				ply.Hurted_L_Leg_points = ply.Hurted_L_Leg_points - 0.2
			end
			if ply.Hurted_R_Leg_points >= 0.2 and ply.Hurted_R_Leg != true then
				ply.Hurted_R_Leg_points = ply.Hurted_R_Leg_points - 0.2
			end

			-- print(ply:Name() .. " LARM: " .. ply.Hurted_L_Arm_points)
			-- print(ply:Name() .. " RARM: " .. ply.Hurted_R_Arm_points)
			if _ == player.GetCount() then
				dly = CurTime() + 2
			end
		end
			
		end
		
	end)

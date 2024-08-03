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
			
			if (ply:GetNWInt("BleedRate") > 0) and (ply.NextBleed < CurTime() or ply.NextBleed == nil) then
				ply.NextBleed = CurTime() + ( 7 - (0.5 * ply:GetNWInt("BleedRate")) )
				ply:TakeDamage(ply:GetNWInt("BleedRate") * 1.5)
				util.PaintDown(ply:GetPos() - Vector(0,0,0.5), "Blood")
				EmitSound("ambient/water/rain_drip"..math.random(1,4)..".wav", ply:GetPos(), CHAN_AUTO, 0.75, 75, 0, math.random(75,100))
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
			
			if ply.BleedRate < 0 then
				ply.BleedRate = 0 
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
			
		end
		
	end)

	function SCHEMA:ScalePlayerDamage(ply, hitgroup, dmginfo)
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
		
		local dmga = dmginfo:GetDamage()
		local leg = {"LLeg", "RLeg"}
		--ply:DoCustomAnimEvent(PLAYERANIMEVENT_FLINCH_CHEST, 1)
		
		if dmginfo:GetAmmoType() == game.GetAmmoID("Snark") then
			if hitgroup == HITGROUP_HEAD then
				dmginfo:ScaleDamage(0.7)
			end
		end
		
		-- if dmginfo:GetDamageType() == DMG_FALL then
			-- ply:TakeDamageLimb(table.Random(leg), falldamage * 1.3)
			-- if ply:IsCrippledLimb("LLeg") and ply:GetNWBool("LLegCrippled") == false then
				-- ply:SetNWBool("LLegCrippled", true)
				-- ply:Notify("Your Left Leg feels numb!")
			-- end
			-- if ply:IsCrippledLimb("RLeg") and ply:GetNWBool("RLegCrippled") == false then
				-- ply:SetNWBool("RLegCrippled", true)
				-- ply:Notify("Your Left Leg feels numb!")
			-- end
		-- end

		if hitgroup == HITGROUP_LEFTARM then
			ply:TakeDamageLimb("LArm", dmga)
		elseif hitgroup == HITGROUP_RIGHTARM then
			ply:TakeDamageLimb("RArm", dmga)
		elseif hitgroup == HITGROUP_LEFTLEG then
			ply:TakeDamageLimb("LLeg", dmga)
		elseif hitgroup == HITGROUP_RIGHTLEG then
			ply:TakeDamageLimb("RLeg", dmga)
		end

		-- print("LARMPOINTS " .. ply.Hurted_L_Arm_points)
		-- print(ply.Hurted_L_Arm)
		-- print("RARMPOINTS " .. ply.Hurted_R_Arm_points)
		-- print(ply.Hurted_R_Arm)
		-- print("RLEGPOINTS " .. ply.Hurted_R_Leg_points)
		-- print(ply.Hurted_R_Leg)
		-- print("LLEGPOINTS " .. ply.Hurted_L_Leg_points)
		-- print(ply.Hurted_L_Leg)
		 
		if ply:Team(ply) == TEAM_CP then
			dmginfo:ScaleDamage(0.7)
		end
		if ply:Team(ply) == TEAM_CP and dmginfo:GetAmmoType() == game.GetAmmoID("Snark")  then
			dmginfo:ScaleDamage(1.5)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound"))  then
			dmginfo:ScaleDamage(1.45)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("357"))  then
			dmginfo:ScaleDamage(1.42)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2"))  then
			dmginfo:ScaleDamage(1.45)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot"))  then
			dmginfo:ScaleDamage(1.05)
		end
		if (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_LEFTARM) then
			dmginfo:ScaleDamage(2.8)
		end
		if ply:Team(ply) == TEAM_OTA then
			dmginfo:ScaleDamage(0.25)
		end
		if ply:Team(ply) == TEAM_OTA and ply:GetTeamClass() == 3 then
			dmginfo:ScaleDamage(0.8)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) then
			dmginfo:ScaleDamage(2.1)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) then
			dmginfo:ScaleDamage(2.4)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2")) then
			dmginfo:ScaleDamage(2.6)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) then
			dmginfo:ScaleDamage(1)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) and (hitgroup == HITGROUP_HEAD) then
			dmginfo:ScaleDamage(0.5)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) and (hitgroup == HITGROUP_HEAD) then
			dmginfo:ScaleDamage(0.6)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) and (hitgroup == HITGROUP_HEAD) then
			dmginfo:ScaleDamage(2.4)
		end
		if ply:Team(ply) == TEAM_CP and (hitgroup == HITGROUP_HEAD) then
			dmginfo:ScaleDamage(1.1)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) then
			dmginfo:ScaleDamage(0.7)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and dmginfo:GetAmmoType() == game.GetAmmoID("Snark")  then
			dmginfo:ScaleDamage(1.5)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound"))  then
			dmginfo:ScaleDamage(1.45)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("357"))  then
			dmginfo:ScaleDamage(1.42)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2"))  then
			dmginfo:ScaleDamage(1.45)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot"))  then
			dmginfo:ScaleDamage(1.05)
		end
		if (ply.WeldingMask == true) and (hitgroup == HITGROUP_HEAD) then
			dmginfo:ScaleDamage(0.55)
		end
		
		---BLEED FUNCTIONS---
		local rtd = math.random(1, 100)
		if dmginfo:GetDamage() > 4 and dmginfo:GetAttacker() != ply and (dmginfo:GetAmmoType() != game.GetAmmoID("Hornet") or dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_BLAST)) then
			if rtd > 15 then
			ply:SetNWInt("BleedRate",  ply:GetNWInt("BleedRate") + (dmginfo:GetDamage() / 20))
			ply.NextBleed = CurTime() + ( 7 - (0.5 * ply:GetNWInt("BleedRate")) )
			end
		end
		
	end

	hook.Add("EntityTakeDamage", "HatchetFFDamage", function(ent, dmg)
		if ent:IsPlayer() and dmg:GetAttacker():IsPlayer() then
			if ent.IsBlocking == true and dmg:GetAttacker():GetActiveWeapon():GetClass() == "m_unarmed" and !dmg:IsDamageType(DMG_BLAST) then
				dmg:SetDamage(dmg / 2.5)
			end
		end
	end)

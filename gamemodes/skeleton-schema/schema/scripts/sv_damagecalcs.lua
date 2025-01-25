	function SCHEMA:ScalePlayerDamage(ply, hitgroup, dmginfo)
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
		
		local dmga = dmginfo:GetDamage()
		local leg = {"LLeg", "RLeg"}
		local VESTmodifier = 0.75
		local OTAmodifier = 0.25
		local CPmodifier = 0.7
		
		if dmginfo:GetAmmoType() == game.GetAmmoID("Snark") then
			if hitgroup == HITGROUP_HEAD then
				dmginfo:ScaleDamage(0.7)
			end
		end

		if hitgroup == HITGROUP_LEFTARM then
			ply:TakeDamageLimb("LArm", dmga * 1.25)
		elseif hitgroup == HITGROUP_RIGHTARM then
			ply:TakeDamageLimb("RArm", dmga * 1.25)
		elseif hitgroup == HITGROUP_LEFTLEG then
			ply:TakeDamageLimb("LLeg", dmga * 1.25)
		elseif hitgroup == HITGROUP_RIGHTLEG then
			ply:TakeDamageLimb("RLeg", dmga * 1.25)
		end
	
		----------------------------
		-- CIVIL PROTECTION BEGIN --
		----------------------------
		
		if ply:Team(ply) == TEAM_CP then
			dmginfo:ScaleDamage(CPmodifier)
		end
		if ply:Team(ply) == TEAM_CP and dmginfo:GetAmmoType() == game.GetAmmoID("Snark")  then -- Cops VS. Melee
			dmginfo:ScaleDamage(CPmodifier + 0.75)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound"))  then -- Cops VS. AK-47
			dmginfo:ScaleDamage(CPmodifier + 0.75)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("357"))  then -- Cops VS. Revolver
			dmginfo:ScaleDamage(CPmodifier + 0.72)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2"))  then -- Cops VS. AR2
			dmginfo:ScaleDamage(1.45)
		end
		if ply:Team(ply) == TEAM_CP and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot"))  then -- Cops VS. Shotgun
			dmginfo:ScaleDamage(1.05)
		end
		if ply:Team(ply) == TEAM_CP and (hitgroup == HITGROUP_HEAD) then -- Cops Head Damage
			dmginfo:ScaleDamage(1.2)
		end
		
		----------------------------
		--- OTA REDUCTIONS BEGIN ---
		----------------------------
		
		if ply:Team(ply) == TEAM_OTA then
			dmginfo:ScaleDamage(OTAmodifier)
		end
		if ply:Team(ply) == TEAM_OTA and ply:GetTeamClass() == 3 then -- OTA Mace
			dmginfo:ScaleDamage(OTAmodifier + 0.55)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) then -- OTA Vs AK-47
			dmginfo:ScaleDamage(OTAmodifier + 1.85)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) then -- OTA Vs Revolver
			dmginfo:ScaleDamage(OTAmodifier + 2.15)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2")) then -- OTA Vs AR2
			dmginfo:ScaleDamage(OTAmodifier + 2.35)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) then -- OTA Vs Shotgun
			dmginfo:ScaleDamage(OTAmodifier + 0.75)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound")) and (hitgroup == HITGROUP_HEAD) then  -- OTA Vs AK-47 Headshot
			dmginfo:ScaleDamage(OTAmodifier + 0.25)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("357")) and (hitgroup == HITGROUP_HEAD) then  -- OTA Vs Revolver Headshot
			dmginfo:ScaleDamage(OTAmodifier + 0.35)
		end
		if ply:Team(ply) == TEAM_OTA and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot")) and (hitgroup == HITGROUP_HEAD) then -- OTA vs Shotgun Headshot
			dmginfo:ScaleDamage(OTAmodifier + 2.15)
		end
		
		----------------------------
		-- ARMOR REDUCTIONS BEGIN --
		----------------------------
		
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) then -- Vest Reduction
			dmginfo:ScaleDamage(VESTmodifier)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and dmginfo:GetAmmoType() == game.GetAmmoID("Snark")  then -- Vest VS Melee
			dmginfo:ScaleDamage(VESTmodifier + 0.7)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("12mmRound"))  then -- Vest VS. AK-47
			dmginfo:ScaleDamage(VESTmodifier + 0.7)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("357"))  then -- Vest VS. Revolver
			dmginfo:ScaleDamage(VESTmodifier + 0.67)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("AR2"))  then -- Vest VS. AR2
			dmginfo:ScaleDamage(VESTmodifier + 0.7)
		end
		if (ply.HasVest == true) and (hitgroup != HITGROUP_HEAD) and (dmginfo:GetAmmoType() == game.GetAmmoID("Buckshot"))  then -- Vest VS. Shotgun
			dmginfo:ScaleDamage(VESTmodifier + 0.35)
		end
		if (ply.WeldingMask == true) and (hitgroup == HITGROUP_HEAD) then -- Vest Headshot
			dmginfo:ScaleDamage(VESTmodifier - 0.20)
		end
		
		------------------------------
		-- REGULAR REDUCTIONS BEGIN --
		------------------------------
		
		if (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_LEFTARM) then -- LIMB DAMAGES
			dmginfo:ScaleDamage(2.8)
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

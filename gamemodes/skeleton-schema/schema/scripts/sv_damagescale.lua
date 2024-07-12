	function SCHEMA:ScalePlayerDamage(ply, hitgroup, dmginfo)
		ply:AddEFlags(EFL_NO_DAMAGE_FORCES)
		--ply:DoCustomAnimEvent(PLAYERANIMEVENT_FLINCH_CHEST, 1)
		
		if dmginfo:GetAmmoType() == game.GetAmmoID("Snark") then
			if hitgroup == HITGROUP_HEAD then
				dmginfo:ScaleDamage(0.7)
			end
		end
		 
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
		
	end

	hook.Add("EntityTakeDamage", "HatchetFFDamage", function(ent, dmg)
		if ent:IsPlayer() and dmg:GetAttacker():IsPlayer() then
			if ply.IsBlocking == true then
				dmg:SetDamage(dmg / 2.5)
			end
		end
	end)

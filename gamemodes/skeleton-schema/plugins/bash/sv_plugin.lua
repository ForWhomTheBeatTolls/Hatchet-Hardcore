local damageAmount = 100
local bashkillsfx = {
"physics/body/body_medium_break4.wav",
"physics/body/body_medium_impact_hard1.wav",
"physics/body/body_medium_impact_hard2.wav",
"physics/body/body_medium_impact_hard6.wav"
}
local bashcommand = {
    description = "Bash with your weapon.",
    requiresArg = false,
    requiresAlive = true,
    onRun = function(ply, arg, rawText)
        if not (ply:Team() == TEAM_OTA) then
            ply:Notify("You need to be an OS to use this command.")
            return
        end
		
		if not ply.NextBashTimer then 
            ply.NextBashTimer = 0 
        end

        local weapon = ply:GetActiveWeapon()
        if not IsValid(weapon) or not weapon:IsWeapon() then
            ply:Notify("You must have a weapon equipped to bash.")
            return
        end
		
		if CurTime() < ply.NextBashTimer then
			ply:Notify("You need to wait "..math.ceil(ply.NextBashTimer - CurTime()).." seconds before bashing again.")
		return
		end
		
		local dmgi = DamageInfo()
		dmgi:SetDamageType( DMG_CLUB )
		dmgi:SetDamage( damageAmount )
		dmgi:SetDamageForce( ply:GetAimVector() * 80000 )

        ply:DoCustomAnimEvent(PLAYERANIMEVENT_ATTACK_GRENADE, ply:LookupSequence("melee_gunhit"))
        ply:EmitSound("npc/combine_soldier/gear1.wav")

		timer.Simple(0.4, function()
        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 60,
            filter = ply
        })
		
        if trace.Hit and IsValid(trace.Entity) then
            if trace.Entity:IsPlayer() and trace.Entity:Team() != TEAM_OTA then
            trace.Entity:TakeDamageInfo(dmgi)
			trace.Entity:EmitSound(table.Random(bashkillsfx), 70, 90, 1, CHAN_BODY)
		local trace2 = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 60,
            filter = ply
			})
			
		timer.Simple(0.05, function()
			local ragdoll = trace2.Entity
			if IsValid(ragdoll) then
				for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
				local physObj = ragdoll:GetPhysicsObjectNum(i)
				physObj:SetVelocity(ply:GetAimVector() * 500)
				end
			end
			end)
			

                end
        end
		end)
		ply.NextBashTimer = CurTime() + 0.75
    end
}

impulse.RegisterChatCommand("/bash", bashcommand)
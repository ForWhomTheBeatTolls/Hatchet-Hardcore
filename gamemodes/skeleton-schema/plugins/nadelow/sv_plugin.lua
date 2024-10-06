local grenadelowcommand = {
    description = "Throw a nade.",
    requiresArg = false,
    requiresAlive = true,
    onRun = function(ply)
        if not ( ply:Team() == TEAM_OTA  or ply:Team() == TEAM_CA) then return
            ply:Notify("You must be a Soldier to use this command.")
        end

        if not ply.NextGrenadeTimer then 
            ply.NextGrenadeTimer = 0 
        end

        if CurTime() > ply.NextGrenadeTimer then
            local ent = ents.Create( "m_grenade" )
            ent:SetPos(ply:EyePos() + ( ply:GetAimVector()*22 )+(ply:GetRight()*1) )
            ent:Spawn()
            ent:SetNotSolid()
            ent:GetPhysicsObject():ApplyForceCenter( ply:GetAimVector() * 300 )
            ply:ForceSequence("grendrop")
            ply.NextGrenadeTimer = CurTime() + 60
        else
            ply:Notify("You must wait " .. tostring(math.ceil(ply.NextGrenadeTimer - CurTime())) .. " seconds before throwing another grenade.")
        end
    end
}
    
impulse.RegisterChatCommand("/grenadelow", grenadelowcommand)

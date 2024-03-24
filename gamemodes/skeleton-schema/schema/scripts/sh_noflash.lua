-- disables flashlight for os

if SERVER then
    hook.Add("PlayerSwitchFlashlight", "DisableFlashlightForTeamTA", function(ply)
        if ply:Team() == TEAM_TA then
            return false
        end
    end)
end

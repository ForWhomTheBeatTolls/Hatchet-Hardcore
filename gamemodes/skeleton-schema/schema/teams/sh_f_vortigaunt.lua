TEAM_VORTIGAUNT = impulse.Teams.Define({
    name = "Vortigaunt",
    color = Color(120, 139, 65),
    loadout = {"impulse_hands", "weapon_physgun", "gmod_tool", "ls_broom"},
    description = [[Clean the streets.]],
    salary = 10,
    model = "models/vortigaunt_slave.mdl",
    handModel = "models/weapons/c_arms_hev.mdl",
    percentLimit = false,
    nameFormat = "Vort",
    onBecome = function(ply)
        if ply:GetSyncVar(SYNC_RPVORTNAME) == "" then
            net.Start("HatchetVortRPName")
            net.Send(ply)
        else
            ply:SetRPName(ply:GetSyncVar(SYNC_RPVORTNAME))
        end
    end
})

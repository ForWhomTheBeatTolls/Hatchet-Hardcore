TEAM_VORTIGAUNT = impulse.Teams.Define({
    name = "Vortigaunt",
    color = Color(120, 139, 65),
    loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
    description = [[Clean the streets.]],
    salary = 10,
    model = "models/vortigaunt_slave.mdl",
    handModel = "models/weapons/c_arms_hev.mdl",
    percentLimit = false,
    nameFormat = "Vort",
    OnBecome = function(ply) print("Become") end
})
TEAM_OTA = impulse.Teams.Define({
    name = "Overwatch Soldier",
    color = Color(25, 25, 25),
    description = [[]],
    loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
    model = "models/player/soldier_stripped.mdl",
    handModel = "models/weapons/c_arms_combine.mdl",
    percentLimit = true,
    limit = 0.15,
    xp = 400,
    cp = true,
    blockNameChange = true,
    doorGroup = {1},

    rankRequired = false, // enable this if this team requires a rank for representative npc
    nameFormat = "OS:S17.%s-%s", // 1st "%s" is the tagline, 2nd "%s" is the numbers"

    taglines = {
        "BLADE",
        "FIST",
        "FLASH",
        "HAMMER",
        "HUNTER",
        "LEADER",
        "RANGER",
        "RAZOR",
        "SAVAGE",
        "SCAR",
        "SLASH",
        "SPEAR",
        "STAB",
        "SWEEPER",
        "SWIFT",
        "SWORD",
        "TRACKER",
    },

    classes = {
        {
            name = "ECHO",
            description = "",
            model = "models/combine_soldier.mdl",
            skin = 0,
            xp = 0,
            armour = 0,
            --itemsAdd = {
            --    {class = "wep_smg", amount = 1},
            --},
        },
        {
            name = "MACE",
            description = "",
            model = "models/combine_soldier.mdl",
            skin = 1,
            xp = 120,
            armour = 0,
            --itemsAdd = {
            --    {class = "wep_spas12", amount = 1},
            --},
        },
        {
            name = "APEX",
            description = "",
            model = "models/combine_super_soldier.mdl",
            skin = 1,
            xp = 120,
            armour = 0,
            --itemsAdd = {
            --    {class = "wep_ar2", amount = 1},
            --},
        },
    },
})

CLASS_TA_SOLDIER = 1
CLASS_TA_SHOTGUNNER = 2
CLASS_TA_ELITE = 3
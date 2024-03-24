TEAM_CP = impulse.Teams.Define({
	name = "Civil Protection",
	color = Color(212, 35, 35),
	description = [[Catch robbers]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 300,
	model = "models/Police.mdl",
	handModel = "models/weapons/c_arms_combine.mdl",
    percentLimit = true,
	limit = 0.2,
	xp = 50,
	cp = true,
    blockNameChange = true,
    doorGroup = {1},

    quiz = {
        {
            question = "Are robbers bad?",
            answers = {
                {"Yes", true},
                {"No", true}
            }
        },
        {
            question = "What should you do if you see a robber?",
            answers = {
                {"Shoot em", true},
                {"Let them go", true},
                {"Arrest them", true}
            }
        }
    },

    classes = {
        {
            name = "Patrol",
            description = "Patrols n stuff",
            model = "models/roots_characters/metropol/playermodels/roots_metropolice.mdl",
            skin = 0,
            xp = 10,
            armour = 0,
			nomenu = true,
            itemsAdd = {
                {class = "wep_pistol", amount = 1}
            }
        }
}
    -- ranks = {
        -- {
            -- name = "Recruit",
            -- description = "?",
            -- xp = 50,
            -- onBecome = function(ply, rank)
                -- -- you can run code here if you want, works with classes too
                -- print(ply)
            -- end
        -- }
    -- }
})

CLASS_PATROL = 1

RANK_RECRUIT = 1
RANK_OFFICER = 2
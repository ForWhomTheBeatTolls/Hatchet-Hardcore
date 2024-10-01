TEAM_RESISTANCE = impulse.Teams.Define({
	name = "Resistance",
	color =  Color(255, 161, 0),
	description = [[Kill.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 20,
	limit = 0,
	xp = 10,
	cp = false,
	classes = {
		{
			name = "Refugee",
			description = "temp desc",
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
			end
		},
		{
			name = "Runner",
			description = "temp desc",
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
			end
		},
		{
			name = "Medical",
			description = "temp desc",
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
			end
		},
		{
			name = "Engineer",
			description = "temp desc",
			--itemsAdd = {
			--	{class = "wep_pistol", amount = 1}
			--},
			doorGroup = {1, 2},
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
			end
		},
	},
})

CLASS_REFUGEE = 1
CLASS_RUNNER = 2
CLASS_MEDICAL = 3
CLASS_ENGINEER = 4

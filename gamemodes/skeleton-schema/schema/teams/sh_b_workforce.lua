TEAM_WORKFORCE = impulse.Teams.Define({
	name = "Workforce",
	color = Color(51, 214, 125),
	description = [[The workers.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 10,
	limit = 0,
	xp = 0,
	cp = false,
	canAdvert = true,

	classes = {
		{
			name = "Industrial Worker",
			description = "work and fix",
			xp = 0,
		},
		{
			name = "Commercial Worker",
			description = "sell",
			xp = 0,
		},
		{
			name = "Medical Worker",
			description = "heal",
			--itemsAdd = {
			--	{class = "wep_pistol", amount = 1}
			--},
			doorGroup = {1, 2},
			xp = 0,
		},
	},
})

CLASS_INDUSTRIAL = 1
CLASS_COMMERCIAL = 2
CLASS_MEDICAL = 3

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
				--ply:SetModel("models/Police.mdl")
			end
		},
		{
			name = "Rebel",
			description = "temp desc",
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
				--ply:SetModel("models/Police.mdl")
			end
		},
	},


	ranks = {
		{
			name = "Runner",
			description = "temp desc",
			xp = 0,
		},
		{
			name = "Medical",
			description = "temp desc",
			xp = 0,
		},
		{
			name = "Engineer",
			description = "temp desc",
			--itemsAdd = {
			--	{class = "wep_pistol", amount = 1}
			--},
			doorGroup = {1, 2},
			xp = 0,
		},
	},
})

CLASS_REFUGEE = 1
CLASS_REBEL = 1

RANK_RUNNER = 1
RANK_MEDICAL = 2
RANK_ENGINEER = 3

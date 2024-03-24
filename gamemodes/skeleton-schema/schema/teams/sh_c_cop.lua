TEAM_CP = impulse.Teams.Define({
	name = "Civil Protection",
	color = Color(65, 105, 200, 255),
	description = [[The opposition.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 250,
	model = "models/Police.mdl",
	handModel = "models/weapons/c_metrocop_hands.mdl",
	percentLimit = true,
	limit = 0,
	xp = 0,
	cp = true,
	doorGroup = {1},
	blockNameChange = true,
	runSpeed = 210,

    nameFormat = "CP:%s-%s", // 1st "%s" is the tagline, 2nd "%s" is the numbers"

    taglines = {
        "UNION",
        "TAP",
        "XRAY",
        "HELIX",
        "VICE",
        "KING",
        "ROLLER",
    },

	classes = {
		{
			name = "CP-1",
			description = "The main Civil Protection division, armed with stunsticks and pistols.",
			--model = "models/roots_characters/metropol/playermodels/roots_metropolice.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 0,
			noMenu = true,
			onBecome = function(ply)
				ply:SetModel("models/Police.mdl")
			end
		},
				{
			name = "CP-2",
			description = "The secondary Civil Protection division, armed with stunsticks and SMGs.",
			--model = "models/roots_characters/metropol/playermodels/roots_metropolice.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 800,
			noMenu = true,
			onBecome = function(ply)
				ply:SetModel("models/Police.mdl")
			end
		},
	},

	ranks = {
		{
			name = "i4",
			description = "i4",
			xp = 10,
			subMaterial = {
				[1] = "models/Police.mdl"
			}
		},
		{
			name = "i3",
			description = "i3",
			xp = 240,
			subMaterial = {
				[1] = "models/Police.mdl"
			}
		},
		{
			name = "i2",
			description = "i2",
			--itemsAdd = {
			--	{class = "wep_pistol", amount = 1}
			--},
			doorGroup = {1, 2},
			xp = 800,
			subMaterial = {
				[1] = "models/Police.mdl"
			}
		},
		{
			name = "i1",
			description = "i1",
			doorGroup = {1, 2, 3, 4},
			xp = 1200,
			subMaterial = {
				[1] = "models/Police.mdl"
			},
		},
		{
			name = "OfC",
			description = "OfC",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/Police.mdl"
			},
			whitelistLevel = 1,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
				end
			end
		},
		{
			name = "DvL",
			description = "DvL",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/Police.mdl"
			},
			whitelistLevel = 2,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 5,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
					ply:SetModel("models/Police.mdl")
				end
			end
		},
		{
			name = "DcO",
			description = "DcO",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_dco"
			},
			whitelistLevel = 3,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 3,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
					ply:SetModel("models/Police.mdl")
				end
			end
		},
		{
			name = "CmD",
			description = "CmD",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			model = "models/dpfilms/metropolice/elite_police.mdl",
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_cmd"
			},
			whitelistLevel = 4,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 2
		}
	}
})

CLASS_UNION = 1
--CLASS_GUNNER = 2

RANK_I4 = 1
RANK_I3 = 2
RANK_I2 = 3
RANK_I1 = 4
RANK_OFC = 5
RANK_DVL = 6
RANK_DCO = 7
RANK_CMD = 8

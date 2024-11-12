-- Framework related
impulse.Config.SchemaName = "HATCHET: HARDCORE"
impulse.Config.SchemaVersion = 430

impulse.Config.SchemaCredits = [[Developers
<font=Impulse-Elements23>Project Lead: WillMaster, Steve B.</font>
<font=Impulse-Elements23>Creative Lead: Steve B.</font>
<font=Impulse-Elements23>Map Design: Jokey</font>
<font=Impulse-Elements23>Lead Development: WillMaster, Steve B.</font>
<font=Impulse-Elements23>Junior Development: Thrumbo</font>
<font=Impulse-Elements23>Community Contributors:</font>
<font=Impulse-Elements23>TehRedd</font>
<font=Impulse-Elements23>Jokey</font>
<font=Impulse-Elements23>GhostfacedKillah</font>]]

impulse.Config.WhitelistedPlayers = {
"STEAM_0:1:204367223", -- SteveB.
--"STEAM_0:0:627119036", -- Thrumbo
"STEAM_0:0:193471001", -- WillMasterr
"STEAM_0:0:461693288", -- Nuj
"STEAM_0:0:526890129", -- Blurger
"STEAM_0:0:526356848", -- Z0as1
"STEAM_0:0:80736176", -- Gonk
"STEAM_0:0:222027191", -- Processed Grain
"STEAM_0:1:580569159", -- Esrah   
"STEAM_0:0:556861499", -- Garry  
"STEAM_0:0:215468222", -- Rubel
"STEAM_0:0:600025375", -- Joe Jenkins
"STEAM_0:0:543738924", -- Atan
"STEAM_1:0:757389970", -- Lil Martini
"STEAM_1:0:182975876", -- Parkinson peek
"STEAM_0:0:580927445" -- HL2Lover    
    
}

impulse.Config.MainColour = Color(196, 108, 26)
impulse.Config.InteractColour = Color(251, 197, 49)

impulse.Config.UserSlots = 999 -- how many slots to give to users, you may want to leave this at 999 as its kind of broken
impulse.Config.IntroMusic = "music/hl1_song20.mp3" -- song to play when character is made for first time players

impulse.Config.SignalsUpdateTime = 2

impulse.Config.WalkSpeed = 108
impulse.Config.JogSpeed = 194
impulse.Config.SlowWalkRatio = 0.6
impulse.Config.SideWalkRatio = 0.6

impulse.Config.TalkDistance = 300
impulse.Config.WhisperDistance = 90
impulse.Config.YellDistance = 550
impulse.Config.VoiceDistance = 950

impulse.Config.OOCLimit = 0
impulse.Config.OOCLimitVIP = 280

impulse.Config.PropLimit = 10
impulse.Config.PropLimitDonator = 170

impulse.Config.BuyableSpawnLimit = 6
impulse.Config.DroppedItemsLimit = 40
impulse.Config.DroppedMoneyLimit = 10
impulse.Config.ChairsLimit = 3

impulse.Config.StartingMoney = 50
impulse.Config.StartingBankMoney = 450
impulse.Config.StartingKills = 0
impulse.Config.StartingRankPoints = 0
impulse.Config.CurrencyPrefix = "T"
impulse.Config.CurrencyName = "tokens"
impulse.Config.ATMModel = "models/props_combine/combine_intwallunit.mdl"

impulse.Config.XPTime = 100
impulse.Config.XPGet = 5
impulse.Config.XPGetVIP = 10

impulse.Config.AFKTime = 360 -- 6 mins
impulse.Config.AFKKickRatio = 0.95

impulse.Config.TeamChangeTime = 40
impulse.Config.TeamChangeTimeDonator = 15

impulse.Config.ClassChangeTime = 60
impulse.Config.QuizWaitTime = 20 -- in mins

impulse.Config.RespawnTime = 10
impulse.Config.RespawnTimeDonator = 10

impulse.Config.BodyDeSpawnTime = 360 -- 6 mins

impulse.Config.BrokenLegsHealTime = 300 -- 5 mins

impulse.Config.PropPrice = 25
impulse.Config.PropPriceDonator = 2

impulse.Config.RPNameChangePrice = 60

impulse.Config.CosmeticGenderPrice = 600
impulse.Config.CosmeticModelSkinPrice = 120

impulse.Config.MaxLetters = 0

impulse.Config.HungerTime = 60
impulse.Config.HungerHealTime = 25

impulse.Config.InventoryMaxWeight = 25 -- in kg
impulse.Config.OSInventoryMaxWeight = 125
impulse.Config.InventoryStorageMaxWeight = 100
impulse.Config.InventoryStorageMaxWeightVIP = 100
impulse.Config.InventoryItemDeSpawnTime = 21474836
impulse.Config.InventoryStorageModel = "models/props/cs_militia/footlocker01_closed.mdl"
impulse.Config.InventoryStoragePublicModel = "models/props/cs_militia/footlocker01_closed.mdl"

impulse.Config.CitizenWage = 25

impulse.Config.GroupMakeCost = 10000
impulse.Config.GroupXPRequirement = 1500
impulse.Config.GroupMaxMembers = 20
impulse.Config.GroupMaxMembersVIP = 100
impulse.Config.GroupMaxRanks = 13
impulse.Config.GroupMaxRanksVIP = 20

impulse.Config.DiscordLeadModRoleID = ""
impulse.Config.AutoModCooldown = 130
impulse.Config.AutoModMaxRisk = 15

impulse.Config.CommunityURL = ""
impulse.Config.IACGuidelinesURL = ""
impulse.Config.PanelURL = ""
impulse.Config.DonateURL = ""
impulse.Config.DiscordURL = ""
impulse.Config.SupportURL = "" -- this can just be the forum url
impulse.Config.DiscordRelayURL = "" -- not required
impulse.Config.RulesURL = ""
impulse.Config.TutorialURL = ""

impulse.Config.CameraRepairTime = 60
impulse.Config.DefaultBOLTime = 60

impulse.Config.BoxTime = 15
impulse.Config.RationTime = 1800

impulse.Config.OSArea = Vector(1571, -1574, 191)


impulse.Config.BeepSounds = {
	[TEAM_CP] = {
		on = {
			"npc/overwatch/radiovoice/on1.wav",
			"npc/overwatch/radiovoice/on3.wav",
			"npc/metropolice/vo/on2.wav"
		},
		off = {
			"npc/metropolice/vo/off1.wav",
			"npc/metropolice/vo/off2.wav",
			"npc/metropolice/vo/off3.wav",
			"npc/metropolice/vo/off4.wav",
			"npc/overwatch/radiovoice/off2.wav",
			"npc/overwatch/radiovoice/off2.wav"
		}
	},

	[TEAM_OTA] = {
		on = {
			"npc/combine_soldier/vo/on1.wav",
			"npc/combine_soldier/vo/on2.wav"
		},
		off = {
			"npc/combine_soldier/vo/off1.wav",
			"npc/combine_soldier/vo/off2.wav",
			"npc/combine_soldier/vo/off3.wav"
		}
	}
}

-- Optional, if you don't have it delete the line below. Used for newsfeed. Requires: https://wordpress.org/plugins/better-rest-api-featured-images/
 impulse.Config.WordPressURL = ""
 impulse.Config.DefaultWordPressImage = ""

impulse.Config.DisabledPlugins = {
	["badplugin"] = true -- the bad plugin is disabled, remove this line to enable it
}

impulse.Config.DoorPrice = 10
impulse.Config.DoorGroups = {
	[1] = "CMB:CP",
	[2] = "CMB",
	[3] = " "
}

impulse.Config.RankColours = {
	["superadmin"] = Color(201, 15, 12),
	["communitymanager"] = Color(84, 204, 5),
	["leadadmin"] = Color(128, 0, 128),
	["admin"] = Color(34, 88, 216),
	["moderator"] = Color(34, 88, 216),
	["donator"] = Color(212, 185, 9)
}

impulse.Config.SaveableAmmo = { -- these ammo types will be saved on player disconnect
	["Pistol"] = true,
	["SMG1"] = true,
	["357"] = true,
	["Buckshot"] = true,
	["AR2"] = true,
	["Rifle"] = true
}

impulse.Config.Achievements = {
	["ach_plugincommand"] = {
		Name = "Plugin Command",
		Desc = "You entered the test plugin command",
		Icon = Material("impulse/icons/warning-36-128.png")
	},
	["ach_akill"] = {
		Name = "Giver of Death",
		Desc = "'In a past life, I killed hundreds. And in the life before that, I played trumpets.'",
		Icon = Material("impulse/icons/check-mark-128.png")
	},
	["ach_adie"] = {
		Name = "Taker of Death",
		Desc = "There's a billion ways to die.",
		Icon = Material("impulse/icons/toxic-256.png")
	},
	["ach_6feet"] = {
		Name = "6 Feet Deep",
		Desc = "I keep falling, but never falling six feet deep.",
		Icon = Material("icon16/keyboard.png")
	},
	["ach_combine1"] = {
		Name = "Killed a Civil Protection officer.",
		Desc = "For what the combine fear most...",
		Icon = Material("decals/lambdaspray_1a")
	},
	["ach_combine2"] = {
		Name = "Killed an Overwatch Soldier.",
		Desc = "...is not any tangible human weapon.",
		Icon = Material("decals/lambdaspray_2a")
	}
		
}

impulse.Config.ModQuickReplies = {
	"I am a quick report reply! Add more in sh_config.lua in your schema."
}

impulse.Config.AutoModDict = {
	{
		Terms = {"HI DALE", "HELLO DALE", "DALE", "WHAT IS DALE", "WHO IS DALE"},
		Specific = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hi! I'm Dale, the >>automated<< chipmunk moderator! I'll try to answer your questions before you speak to a staff member to solve your issue!"
	},
	{
		Terms = {"HELP", "JUST HELP", "HELP ME", "ADMIN HELP", "ADMIN", "COME HERE", "COME", "NEED STAFF", "NEED ADMIN", "ADMIN COME HERE", "ADMIN TO ME", "I NEED A ADMIN", "I NEED ADMIN", "TO ME", "MINGE", "HEY"},
		Specific = true,
		IgnorePunc = true,
		Reply = "Hi! I've noticed your report doesn't contain much detail about the situation. We'd really appricate it if you could provide some more information for us by updating the report! Thanks!"
	}
}

impulse.Config.DefaultTeam = TEAM_CITIZEN

impulse.Config.DefaultMaleModels = {
	Model("models/player/impulse_zelpa/male_01.mdl"),
	Model("models/player/impulse_zelpa/male_02.mdl"),
	Model("models/player/impulse_zelpa/male_03.mdl"),
	Model("models/player/impulse_zelpa/male_04.mdl"),
	Model("models/player/impulse_zelpa/male_05.mdl"),
	Model("models/player/impulse_zelpa/male_06.mdl"),
	Model("models/player/impulse_zelpa/male_07.mdl"),
	Model("models/player/impulse_zelpa/male_08.mdl"),
	Model("models/player/impulse_zelpa/male_09.mdl"),
	Model("models/player/impulse_zelpa/male_10.mdl"),
	Model("models/player/impulse_zelpa/male_11.mdl")
}

impulse.Config.DefaultFemaleModels = {
	Model("models/player/impulse_zelpa/female_01.mdl"),
	Model("models/player/impulse_zelpa/female_02.mdl"),
	Model("models/player/impulse_zelpa/female_03.mdl"),
	Model("models/player/impulse_zelpa/female_04.mdl"),
	Model("models/player/impulse_zelpa/female_06.mdl"),
	Model("models/player/impulse_zelpa/female_07.mdl")
}

impulse.Config.DefaultSkinBlacklist = {
	["models/player/impulse_zelpa/male_02.mdl"] = {14, 22, 6} -- bloody eye skins banned
}

impulse.Config.DefaultNameBlacklist = {
	"nigger",
	"nigga",
	"faggot",
	"bitch",
	"negro"
}

impulse.Config.LootPools = {
    ["good"] = {
        Items = {
            ["wep_axe"] = {Rarity = 970},
            ["util_scrapmetal"] = {Rarity = 300},
			["wep_crowbar"] = {Rarity = 970},
			["wep_pipe"] = {Rarity = 970}, 
			["wep_shovel"] = {Rarity = 970},
			["tool_knife"] = {Rarity = 955},
			["util_electronics"] = {Rarity = 980},
			["ammo_pistol"] = {Rarity = 990},
			["ammo_smg"] = {Rarity = 990},
			["ammo_revolver"] = {Rarity = 990},
			["ammo_rifle"] = {Rarity = 990},
			["ammo_shotgun"] = {Rarity = 990},
        },
        MaxItems = 2,
        MinItems = 1,
		MaxWait = 300,
		MinWait = 120
    },
	["metal"] = {
		Items = {
			["wep_axe"] = {Rarity = 999},
			["util_scrapmetal"] = {Rarity = 200},
			["wep_crowbar"] = {Rarity = 999},
			["util_electronics"] = {Rarity = 980},
			["ammo_sparerevolver"] = {Rarity = 980},
			["ammo_sparepistol"] = {Rarity = 980},
			["ammo_sparesmg"] = {Rarity = 980},
			["ammo_sparerifle"] = {Rarity = 980},
			["ammo_spareshotgun"] = {Rarity = 980},
			},
		MaxItems = 3,
        MinItems = 1,
		MaxWait = 300,
		MinWait = 120
		}
	}

--- ### OS WHITELISTS ### ---

impulse.Config.ECHOwl = {
"STEAM_0:1:204367223"
}

-- ########################################################################### --

impulse.Config.MACEwl = {
"STEAM_0:1:204367223"
}

-- ########################################################################### --

impulse.Config.APEXwl = {
"STEAM_0:1:204367223"
}

-- ########################################################################### --

impulse.Config.OSwl = {
	"STEAM_0:1:204367223"
}


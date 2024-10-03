if SERVER then
    util.AddNetworkString("opsGiveCombineBan")
end

local combineBanCommand = {
    description = "Gives the player a combine ban for the time specified (In seconds)",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
        local time = arg[2]
		local plyTarget = impulse.FindPlayer(name)

		if not time or not tonumber(time) then
			return ply:Notify("Please specific a valid time value in minutes.")
		end

		time = tonumber(time)

		if plyTarget and plyTarget.impulseData then
			local curT = os.time()
			local endT = curT + time

			plyTarget.impulseData.CombineBan = endT
			plyTarget:SaveData()

			if plyTarget:IsCP() then
				plyTarget:SetTeam(impulse.Config.DefaultTeam)
			end

			local howLong = string.NiceTime(time)

			ply:Notify("You have combine banned "..plyTarget:Nick().." for "..howLong..".")
			plyTarget:Notify("You have been banned from the combine faction for "..howLong.." by a game moderator ("..ply:SteamName()..").")

			net.Start("opsGiveCombineBan")
			net.WriteUInt(time, 16)
			net.Send(plyTarget)
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/combineban", combineBanCommand)

local combineUnBanCommand = {
    description = "Removes a combine ban from a player.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then
			plyTarget.impulseData.CombineBan = nil
			plyTarget:SaveData()

			ply:Notify("You have removed "..plyTarget:Nick().."'s combine ban.")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/uncombineban", combineUnBanCommand)









local GiveOSWhitelist = {
    description = "Gives a player the whitelist to the OS Faction.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then

			plyTarget.impulseData.OSWhitelist = true
			plyTarget:SaveData()

			ply:Notify("You have given OS whitelist to "..plyTarget:Nick()..".")
			plyTarget:Notify("You have been given OS Whitelist by a game moderator ("..ply:SteamName()..").")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/giveoswhitelist", GiveOSWhitelist)

local RemoveOSWhitelist = {
    description = "Remove a player's OS whitelist.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then
			plyTarget.impulseData.OSWhitelist = nil
			plyTarget:SaveData()

			plyTarget:Notify("Your OS Whitelist has been removed by a game moderator ("..ply:SteamName()..").")
			ply:Notify("You have removed the OS Whitelist from "..plyTarget:Nick()..".")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/removeoswhitelist", RemoveOSWhitelist)






local GiveEchoWhitelist = {
    description = "Gives a player the whitelist to the ECHO Rank.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then

			plyTarget.impulseData.EchoWhitelist = true
			plyTarget:SaveData()

			ply:Notify("You have given ECHO whitelist to "..plyTarget:Nick()..".")
			plyTarget:Notify("You have been given ECHO Whitelist by a game moderator ("..ply:SteamName()..").")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/giveechowhitelist", GiveEchoWhitelist)

local RemoveEchoWhitelist = {
    description = "Remove a player's Echo whitelist.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then
			plyTarget.impulseData.EchoWhitelist = nil
			plyTarget:SaveData()

			plyTarget:Notify("Your ECHO Whitelist has been removed by a game moderator ("..ply:SteamName()..").")
			ply:Notify("You have removed the ECHO Whitelist from "..plyTarget:Nick()..".")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/removeechowhitelist", RemoveEchoWhitelist)








local GiveMaceWhitelist = {
    description = "Gives a player the whitelist to the Mace Rank.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then

			plyTarget.impulseData.MaceWhitelist = true
			plyTarget:SaveData()

			ply:Notify("You have given Mace whitelist to "..plyTarget:Nick()..".")
			plyTarget:Notify("You have been given Mace Whitelist by a game moderator ("..ply:SteamName()..").")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/givemacewhitelist", GiveMaceWhitelist)

local RemoveMaceWhitelist = {
    description = "Remove a player's Mace whitelist.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then
			plyTarget.impulseData.MaceWhitelist = nil
			plyTarget:SaveData()

			plyTarget:Notify("Your Mace Whitelist has been removed by a game moderator ("..ply:SteamName()..").")
			ply:Notify("You have removed the Mace Whitelist from "..plyTarget:Nick()..".")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/removemacewhitelist", RemoveMaceWhitelist)










local GiveApexWhitelist = {
    description = "Gives a player the whitelist to the Apex Rank.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then

			plyTarget.impulseData.ApexWhitelist = true
			plyTarget:SaveData()

			ply:Notify("You have given Apex whitelist to "..plyTarget:Nick()..".")
			plyTarget:Notify("You have been given Apex Whitelist by a game moderator ("..ply:SteamName()..").")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/giveapexwhitelist", GiveApexWhitelist)

local RemoveApexWhitelist = {
    description = "Remove a player's Apex whitelist.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
		local plyTarget = impulse.FindPlayer(name)

		if plyTarget and plyTarget.impulseData then
			plyTarget.impulseData.ApexWhitelist = nil
			plyTarget:SaveData()

			plyTarget:Notify("Your Apex Whitelist has been removed by a game moderator ("..ply:SteamName()..").")
			ply:Notify("You have removed the Apex Whitelist from "..plyTarget:Nick()..".")
		else
			return ply:Notify("Could not find player: "..tostring(name))
		end
    end
}

impulse.RegisterChatCommand("/removeapexwhitelist", RemoveApexWhitelist)

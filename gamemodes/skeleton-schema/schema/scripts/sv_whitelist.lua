--hatchet.WhitelistedPlayers = hatchet.WhitelistedPlayers or {}

-- "STEAM_0:1:204367223", -- SteveB.
-- "STEAM_0:0:627119036", -- Thrumbo
-- "STEAM_0:0:193471001", -- WillMasterr
-- "STEAM_0:0:461693288", -- Nuj
-- "STEAM_0:0:526890129", -- Blurger
-- "STEAM_0:0:526356848", -- Z0as1
-- "STEAM_0:0:80736176", -- Gonk
-- "STEAM_0:0:222027191", -- Processed Grain
-- "STEAM_0:1:580569159", -- Esrah   
-- "STEAM_0:0:556861499", -- Garry  
-- "STEAM_0:0:215468222", -- Rubel
-- "STEAM_0:0:600025375", -- Joe Jenkins
-- "STEAM_0:0:543738924", -- Atan
-- "STEAM_1:0:757389970", -- Lil Martini
-- "STEAM_1:0:182975876", -- Parkinson peek
-- "STEAM_0:0:580927445", -- HL2Lover    
-- "STEAM_0:0:36683492", -- Jokey
-- "STEAM_0:0:457218367" -- Florida

--gameevent.Listen( "player_connect" )
hook.Add("PlayerInitialSpawn", "HatchetWhitelistHook", function( ply )
		local f = file.Open("hatchet_server_whitelist.json", "w", "DATA")
		local r = file.Read( "impulse/hatchet_server_whitelist.json", "DATA" )
		local strf = string.find(r, ply:SteamID(), 1, true)
        if !strf then
       		ply:Kick("Not whitelisted. Make an application on the discord to acquire a whitelist." )
        end
end)

local GiveServerWhitelist = {
    description = "Gives the entered STEAMID the whitelist to the server.",
    requiresArg = true,
    adminOnly = true,
    onRun = function(ply, arg, rawText)
        local steamid = arg[1]

		-- if file.Exists("hatchet_server_whitelist.json", "LUA") then
			file.Write("hatchet_server_whitelist.json", steamid)
			print(file.Write("hatchet_server_whitelist.json", steamid))
		--else
			--print("No ''hatchet_server_whitelist.json'' file found. Create it and then try again.")
		--end
    end
}
impulse.RegisterChatCommand("/givewhitelist", GiveServerWhitelist)

concommand.Add("givewhitelist", function(ply, cmd, args)

	local f = file.Open("hatchet_server_whitelist.json", "w", "DATA")
	local r = file.Read( "impulse/hatchet_server_whitelist.json", "DATA" )
	local strf = string.find(r, args[1], 1, true)
	
	if !strf and strf != args[1] then
		file.Append("impulse/hatchet_server_whitelist.json", tostring(args[1]))
		file.Append("impulse/hatchet_server_whitelist.json", "\n")
	else
		print("This value is already in the table!")
	end
	--print(file.Append("impulse/hatchet_server_whitelist.json", args[1].."\n"))
	print(tostring(args[1]))
	print(r)
	--print(string.len(strf))
	--print("--------------------")
	--PrintTable(t)
	f:Close()
	-- f:Skip(#args[1])
	-- print(f:ReadLine())
	-- print(f:Tell())
	-- f:Close()
end)

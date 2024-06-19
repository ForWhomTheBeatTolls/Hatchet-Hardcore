gameevent.Listen( "player_connect" )
hook.Add("player_connect", "HatchetWhitelistHook", function( data )
        if !table.HasValue(impulse.Config.WhitelistedPlayers, data.networkid) then
       		game.KickID( data.networkid, "Not whitelisted. Make an application on the discord to acquire a whitelist." )
        end
end)

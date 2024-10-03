function hatchet.CorrectRankpoints()
	for k,ply in pairs(player.GetAll()) do
	
		if ply:GetSyncVar(SYNC_RANKPOINTS, -1) < 0 then --This should never happen. There's no reason for it to, but you never know, so why not? :P
			ply:SetSyncVar(SYNC_RANKPOINTS, 0)
		end
		
		local query = mysql:Update("impulse_players")
		query:Update("rankpoints", ply:GetSyncVar(SYNC_RANKPOINTS))
		query:Where("steamid", ply:SteamID())
		query:Execute()
		
		print("Successfully initialized hatchet.Rankpoints")
	end
end

--------------------------------------------------------------------------------------------------

function hatchet.TakeRankpoints(ply, number, boolean) -- The player to take from / The amount / Whether it should be allowed to go below 0 or not

	if not boolean then boolean = false end
	if not ply then return end
	if not number then return end
	if not isnumber(number) then return end
	
	ply:SetSyncVar(SYNC_RANKPOINTS, ply:GetSyncVar(SYNC_RANKPOINTS, 0) - number)
	
	if boolean == false then
	
		if ply:GetSyncVar(SYNC_RANKPOINTS, -1) < 0 then -- This should never happen. There's no reason for it to, but you never know, so why not? :P
			ply:SetSyncVar(SYNC_RANKPOINTS, 0)
		end
		
	end
	
	local query = mysql:Update("impulse_players")
	query:Update("rankpoints", ply:GetSyncVar(SYNC_RANKPOINTS))
	query:Where("steamid", ply:SteamID())
	query:Execute()
	
end

--------------------------------------------------------------------------------------------------

function hatchet.GiveRankpoints(ply, number) -- The player to give to / The amount
	
	if not number then return end
	if not isnumber(number) then return end
	if not ply then return end
	
	ply:SetSyncVar(SYNC_RANKPOINTS, ply:GetSyncVar(SYNC_RANKPOINTS, 0) + number)
	
	local query = mysql:Update("impulse_players")
	query:Update("rankpoints", ply:GetSyncVar(SYNC_RANKPOINTS))
	query:Where("steamid", ply:SteamID())
	query:Execute()
	
end

--------------------------------------------------------------------------------------------------

function hatchet.SetRankpoints(ply, number) -- The player to set the amount of / The amount
	
	if not number then return end
	if not isnumber(number) then return end
	if not ply then return end
	
	ply:SetSyncVar(SYNC_RANKPOINTS, number)
	
	local query = mysql:Update("impulse_players")
	query:Update("rankpoints", ply:GetSyncVar(SYNC_RANKPOINTS))
	query:Where("steamid", ply:SteamID())
	query:Execute()
	
end

-------------------------------------Functions End-------------------------------------------------

local GiveRPFacingCommand = {
	adminOnly = true,
    description = "GIVE rankpoints to the person you're facing. Has limited range. (Amount)",
    onRun = function(ply, arg)
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 1050,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() then
			
			if isnumber(arg[1]) then
				ply:Notify("Gave "..trace.Entity:Nick().." "..arg[1].." rankpoints.")
			elseif !isnumber(arg[1]) or arg[1] < 0 then
				ply:Notify("Input value is NaN.")
			end
			
			hatchet.GiveRankpoints(trace.Entity, arg[1])
			
		end
	end
}
impulse.RegisterChatCommand("/giverp", GiveRPFacingCommand)

--------------------------------------------------------------------------------------------------

local TakeRPFacingCommand = {
	adminOnly = true,
    description = "TAKE rankpoints from the person you're facing. Has limited range. (Amount / Danger Mode)",
    onRun = function(ply, arg)
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 1050,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() then
		
			
			if isnumber(arg[1]) then
				ply:Notify("Took "..arg[1].." rankpoints from "..trace.Entity:Nick()".")
			elseif !isnumber(arg[1]) or arg[1] < 0 then
				ply:Notify("Input value is NaN or invalid.")
			end
			
			hatchet.TakeRankpoints(trace.Entity, arg[1], arg[2])
			
		end
	end
}
impulse.RegisterChatCommand("/takerp", TakeRPFacingCommand)

--------------------------------------------------------------------------------------------------

local SetRPFacingCommand = {
	adminOnly = true,
    description = "Set the rankpoints of the person you're facing. Has limited range. (Amount)",
    onRun = function(ply, arg)
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 1050,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() then
		
			
			if isnumber(arg[1]) then
				ply:Notify("Set the rankpoints of "..trace.Entity:Nick().." to "..arg[1]".")
			elseif !isnumber(arg[1]) then
				ply:Notify("Input value is NaN or invalid.")
			end
			
			hatchet.SetRankpoints(trace.Entity, arg[1])
			
		end
	end
}
impulse.RegisterChatCommand("/setrp", SetRPFacingCommand)

--------------------------------------------------------------------------------------------------

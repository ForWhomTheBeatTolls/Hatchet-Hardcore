

local randomgearreb = {

{ "ammo_pistol", "ammo_pistol", "wep_pistol" },
{ "wep_crowbar", "ammo_pistol", "ammo_pistol", "wep_pistol" },
{ "wep_crowbar" },
{ "wep_smg", "ammo_smg", "ammo_smg", "ammo_smg" },
{ "wep_pistol", "item_healthvial", "ammo_pistol", "ammo_pistol" }

}

local GiveRebelGearCommand = {
	adminOnly = true,
    description = "Gives the person you are facing rebel equipment. Args = low, med, high, rebel1, rebel2.",
    onRun = function(ply, arg)
	local name = arg[1]
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
	--local rollthedice = math.random(1, 5)
	--local chosengear = nil
	--for k,v in RandomPairs( randomgearreb ) do
	local hitplayer = trace.Entity
	if trace.Hit and IsValid(trace.Entity) then
		if name == "low" then
		hitplayer:GiveInventoryItem("wep_crowbar")
		elseif name == "med" then
		hitplayer:GiveInventoryItem("wep_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		--hitplayer:GiveInventoryItem("wep_crowbar")
		elseif name == "high" then
		hitplayer:GiveInventoryItem("wep_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		elseif name == "rebel1" then
		hitplayer:GiveInventoryItem("wep_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("clothing_greenrebeltop")
		elseif name == "rebel2" then
		hitplayer:GiveInventoryItem("wep_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("clothing_greenrebeltop")
	--end
end
ply:Notify("Gave "..trace.Entity:Nick().." the gear set: "..name)
	end
end
}
impulse.RegisterChatCommand("/giverebelgear", GiveRebelGearCommand)

local GiveCPGearCommand = {
	adminOnly = true,
    description = "Gives the person you are facing rebel equipment. Args = med1, med2, high1, high2.",
    onRun = function(ply, arg)
	local name = arg[1]
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
	--local rollthedice = math.random(1, 5)
	--local chosengear = nil
	--for k,v in RandomPairs( randomgearreb ) do
	local hitplayer = trace.Entity
	if trace.Hit and IsValid(trace.Entity) then
		--if name == "low" then
		--hitplayer:GiveInventoryItem("wep_crowbar")
		if name == "med1" then
		hitplayer:GiveInventoryItem("wep_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		--hitplayer:GiveInventoryItem("wep_crowbar")
		elseif name == "high1" then
		hitplayer:GiveInventoryItem("wep_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		elseif name == "high2" then
		hitplayer:GiveInventoryItem("wep_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("ammo_smg")
		hitplayer:GiveInventoryItem("item_healthvial")
		--hitplayer:GiveInventoryItem("clothing_greenrebeltop")
		elseif name == "med2" then
		hitplayer:GiveInventoryItem("wep_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("ammo_pistol")
		hitplayer:GiveInventoryItem("item_healthvial")
		--hitplayer:GiveInventoryItem("clothing_greenrebeltop")
	--end
end
ply:Notify("Gave "..trace.Entity:Nick().." the gear set: "..name)
	end
trace.Entity:SetTeamClass(1)	
end
}
impulse.RegisterChatCommand("/givecpgear", GiveCPGearCommand)

local FeedCommand = {
	adminOnly = true,
    description = "Feeds the person you are facing.",
    onRun = function(ply)
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) then
		trace.Entity:SetHunger(100)
		ply:Notify("Fed "..trace.Entity:Nick()..".")
		trace.Entity:Notify("You have been fed by "..ply:Nick()..".")
		end
	end
}
impulse.RegisterChatCommand("/feed", FeedCommand)

local ClearInvCommand = {
	adminOnly = true,
    description = "Clears the inventory of the person you are facing.",
    onRun = function(ply)
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) then
		--trace.Entity:SetHunger(100)
		ply:Notify("Cleared the items of "..trace.Entity:Nick()..".")
		trace.Entity:Notify("Your pockets shrink & shrivel... Your items have been cleared.")
		trace.Entity:ClearInventory(1)
		end
	end
}
impulse.RegisterChatCommand("/clearinv", ClearInvCommand)

local PlayGestureCommand = {
	adminOnly = false,
    description = "Pick a gesture. Any gesture!.",
    onRun = function(ply, arg)
	local name = arg[1]
		if arg != "" then
			ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
			ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_SEQUENCE, ply:LookupSequence(name))
			print(ply:LookupSequence(name))
		else
			ply:Notify("Invalid argument.")
	end
	end
}
impulse.RegisterChatCommand("/playgesture", PlayGestureCommand)

local GiveXPCommand = {
	adminOnly = true,
    description = "Gives XP to the person you are facing.",
    onRun = function(ply, arg)
		local amount = arg[1]
		local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
		if trace.Hit and IsValid(trace.Entity) then
		trace.Entity:SetSyncVar(SYNC_XP, trace.Entity:GetSyncVar(SYNC_XP, 0) + amount, true)
		ply:Notify("Gave "..trace.Entity:Nick().." "..amount.." XP.")
		--trace.Entity:Notify("Your pockets shrink & shrivel... Your items have been cleared.")
		--trace.Entity:ClearInventory(1)
		end
	end
}
impulse.RegisterChatCommand("/givexp", GiveXPCommand)

local OSwl = {
	"76561198369000175",
	"76561198171801299",
	"76561198145165181",
	"76561198391202172",
	"76561199214503800",
	" 76561199122120618",
	"76561198284996265"
	}
local OSDeploymentCommand = {
	adminOnly = false,
    description = "Begin your Overwatch deployment.",
    onRun = function(ply)
		local plyid64 = ply:SteamID64()
		if ( table.HasValue( OSwl, plyid64 ) ) && ply:Team() != TEAM_OTA then
		ply:Notify("Begun deployment.")
		ply:SetPos(impulse.Config.OSArea)
		--ply:SetTeam(TEAM_OTA)
		--predeploymentinv = ply:GetInventory(1)
		--PrintTable(predeploymentinv)
		--ply:ClearInventory(1)
		elseif ( !table.HasValue( OSwl, plyid64 ) ) then
		ply:Notify("You do not have permission to use this command.")
		elseif ply:Team() == TEAM_OTA then
		ply:Notify("You are already on a deployment. Finishing...")
		ply:SetTeam(TEAM_CITIZEN)
		--if predeploymentinv then
		--for v,k in ipairs(predeploymentinv) do
		--	print(k)
		--	ply:GiveInventoryItem(k)
		--	print(k)
		--end
		predeploymentinv = nil
		end
	end
}
impulse.RegisterChatCommand("/deploy", OSDeploymentCommand)

-- local OSDeploymentFinishCommand = {
	-- adminOnly = false,
    -- description = "Finish your Overwatch deployment.",
    -- onRun = function(ply)
		-- if ply:Team() == TEAM_OTA then
		-- ply:Notify("Deployment finished.")
		-- ply:SetTeam(TEAM_CITIZEN)
		-- --if predeploymentinv then
		-- for v,k in pairs(predeploymentinv) do
			-- ply:GiveInventoryItem(k , 1, false, false, false, false)
			-- print(k)
		-- end
		-- predeploymentinv = nil
		-- --end
	-- end
	-- end
-- }
-- impulse.RegisterChatCommand("/finishdeployment", OSDeploymentFinishCommand)

-- local DispatchCommand = {
	-- adminOnly = true,
    -- description = "Send a Dispatch message.",
    -- onRun = function(ply, arg)
	-- local text = arg[1]
		-- ply:Notify("Sent.")
	-- for v,k in pairs(player.GetAll()) do
		-- if k:IsCP() then
		-- if ( CLIENT ) then
			-- chat.AddText(dispatchCol, "[DISPATCH] " ..text)
		-- end
            -- --k:EmitSound(announcement.sound, announcement.volume or 80)
		-- end
	-- end
	-- end
-- }
-- impulse.RegisterChatCommand("/dispatch", DispatchCommand)

-- --impulse.RegisterChatCommand("/dispatch", DispatchCommand)

local DispatchFlagCommand = {
	adminOnly = true,
	description = "NULL.",
	onRun = function(ply)
	if not ply.IsDispatch then
	ply.IsDispatch = true
	ply:Notify("Flagged onto Dispatch.")
	else
	ply.IsDispatch = false
	ply:Notify("Flagged off Dispatch.")
	end
end
}

impulse.RegisterChatCommand("/df", DispatchFlagCommand)
	




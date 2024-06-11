--- A generic module that holds anything that doesnt fit elsewhere
-- @module Misc

function GM:ForceDermaSkin()
	return "impulse"
end

local blur = Material("pp/blurscreen")

local superTesters = {
	["STEAM_0:1:53542485"] = false, -- mats
	["STEAM_0:1:75156459"] = false, -- jamsu
	["STEAM_0:1:83204982"] = false, -- oscar
	["STEAM_0:1:43061896"] = false, -- jim wakelin
	["STEAM_0:0:24607430"] = false, -- stranger
	["STEAM_0:0:26121174"] = false, -- greasy
	["STEAM_0:1:40283833"] = false, -- tim cook
	["STEAM_0:0:157214263"] = false, -- loka
	["STEAM_0:0:73384910"] = false, -- avx/soviet
	["STEAM_0:1:175014750"] = false -- personwhoplaysgames
}

local hatchet_mappers = {
	["STEAM_0:0:36683492"] = true -- stranger
}

local hatchet_contributors = {
	[""] = true -- stranger
}

local hatchet_majorcontributors = {
	["STEAM_0:0:504346304"] = true -- TehRedd
}

local hatchet_leaddev = {
	["STEAM_0:0:193471001"] = true -- WillMaster
}

local hatchet_dev = {
	["STEAM_0:0:627119036"] = true -- stranger
}

local hatchet_projectlead = {
	["STEAM_0:0:193471001"] = true -- WillMaster
}

local mappers = {
	["STEAM_0:0:24607430"] = false -- stranger
}

local eventTeam = {
	["STEAM_0:1:462578059"] = false -- opiper
}

local winners = {}


-- Please don't ever remove credit or users/badges from this section. People worked hard on this. Thanks!
impulse.Badges = {
	staff = {Material("icon16/shield.png"), "This player is part of the Janitor team. (Staff)", function(ply) return not ply:IsIncognito() and ply:IsAdmin() end},
	donator = {Material("icon16/coins.png"), "This player is a donator.", function(ply) return ply:IsDonator() end},
	exdev = {Material("icon16/cog_go.png"), "This player is a ex impulse developer.", function(ply) return ply:SteamID() == "STEAM_0:1:102639297" end},
	dev = {Material("icon16/cog.png"), "This player is a impulse developer.", function(ply) return not ply:IsIncognito() and ply:IsDeveloper() end},
	vin = {Material("decals/lambdaspray_2a"), "Hello. I'm the creator of Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (ply:SteamID() == "STEAM_0:1:204367223") end},
	hatchetmapper = {Material("icon16/building_edit.png"), "This player is a mapper for Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_mappers[ply:SteamID()] or false) end},
	hatchetdev = {Material("icon16/cog.png"), "This player is a junior developer for Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_dev[ply:SteamID()] or false) end},
	hatchetleaddev = {Material("icon16/application_osx_terminal.png"), "This player is a Lead developer for Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_leaddev[ply:SteamID()] or false) end},
	hatchetcontributor = {Material("icon16/award_star_bronze_1.png"), "This Player contributed on Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_contributors[ply:SteamID()] or false) end},
	hatchetmajorcontributor = {Material("icon16/award_star_gold_3.png"), "This Player did Major contribution on Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_majorcontributors[ply:SteamID()] or false) end},
	hatchetprojectlead = {Material("icon16/application_osx.png"), "This player is a project leader for Hatchet HL2RPG.", function(ply) return not ply:IsIncognito() and (hatchet_projectlead[ply:SteamID()] or false) end},
	supertester = {Material("icon16/bug.png"), "This player made large contributions to the testing of impulse.", function(ply) return not ply:IsIncognito() and (superTesters[ply:SteamID()] or false) end},
	competition = {Material("icon16/rosette.png"), "This player has won a competition.", function(ply) return winners[ply:SteamID()] end},
	mapper = {Material("icon16/map.png"), "This player is a mapper that has collaborated with impulse.", function(ply) return mappers[ply:SteamID()] end},
	eventteam = {Material("icon16/controller.png"), "This player is the leader of the event team.", function(ply) return eventTeam[ply:SteamID()] end},
	communitymanager = {Material("icon16/transmit.png"), "This player is a community manager. Feel free to ask them questions.", function(ply) return ply:GetUserGroup() == "communitymanager" end}
}

local cheapBlur = Color(0, 0, 0, 205)

--- Renders a blur effect on a panel. Call this inside PANEL:Paint
-- @realm client
-- @panel panel The panel to blur
-- @int layers Unknown
-- @int density Density
-- @color alpha Alpha
function impulse.blur(panel, layers, density, alpha)
	local x, y = panel:LocalToScreen(0, 0)

	if not impulse.GetSetting("perf_blur") then
		draw.RoundedBox(0, -x, -y, ScrW(), ScrH(), cheapBlur)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(-x, -y, ScrW(), ScrH())
	else
		surface.SetDrawColor(255, 255, 255, alpha)
		surface.SetMaterial(blur)

		for i = 1, 3 do
			blur:SetFloat("$blur", (i / layers) * density)
			blur:Recompute()

			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
		end
	end
end

--- Creates a work bar on the players screen
-- @realm client
-- @int time The time it will take to complete the bar
-- @string[opt] text Text to display on the bar
-- @func[opt] onDone Called when bar is complete
-- @bool[opt=false] popup If the bar should stop player input
function impulse.MakeWorkbar(time, text, onDone, popup)
	local bar = vgui.Create("impulseWorkbar")
	bar:SetEndTime(CurTime() + time)

	if text then
		bar:SetText(text)
	end
	
	if onDone then
		bar.OnEnd = onDone
	end

	if popup then
		bar:MakePopup()
	end
end

local myscrw, myscrh = 1920, 1080

function SizeW(width)
    local screenwidth = myscrw
    return width*ScrW()/screenwidth
end

function SizeH(height)
    local screenheight = myscrh
    return height*ScrH()/screenheight
end

function SizeWH(width, height)
    local screenwidth = myscrw
    local screenheight = myscrh
    return width*ScrW()/screenwidth, height*ScrH()/screenheight
end

function HexColor(hex, alpha)
    hex = hex:gsub("#","")
    return Color (tonumber("0x" .. hex:sub(1,2)), tonumber("0x" .. hex:sub(3,4)), tonumber("0x" .. hex:sub(5,6)), alpha or 255)
end

local uColoursBase = {
	HexColor("#ff0000"),
	HexColor("#ff8c00"),
	HexColor("#00ff7f"),
	HexColor("#ff1493"),
	HexColor("#1e90ff"),
	HexColor("#adff2f"),
	HexColor("#eee8aa"),
	HexColor("#87cefa"),
	HexColor("#dda0dd"),
	HexColor("#ffd700"),
	HexColor("#808000"),
	HexColor("#2e8b57"),
	HexColor("#ba55d3"),
	HexColor("#000080"),
	HexColor("#b22222"),
	HexColor("#2e8b57"),
	HexColor("#696969"),
	HexColor("#e9967a")
}

local uColoursUsed = {}
local uColoursLive = {}
function impulse.GetUniqueColour(hash)
	if uColoursLive[hash] then
		return uColoursLive[hash]
	end
	
	for v,k in RandomPairs(uColoursBase) do
		if uColoursUsed[v] then
			continue
		end
		
		uColoursLive[hash] = k
		uColoursUsed[v] = true
	end

	if not uColoursLive[hash] then
		uColoursUsed = {}
	end

	return uColoursLive[hash]
end

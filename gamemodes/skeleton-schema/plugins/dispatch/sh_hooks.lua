local deathcount = deathcount or 0
local deathcountclear = CurTime()
local citycode = civil

local ajsfx = sound.Add( {
	name = "aj_suspense",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 0,
	pitch = {100, 100},
	sound = "music/hl2_song26_trainstation1.mp3"
} )

local rankpointsdelay = CurTime() + 300
hook.Add("Think", "RankPoints", function()
	if rankpointsdelay < CurTime() then
		if SERVER then
			for k,v in pairs(player.GetAll()) do
				if v:Team() == TEAM_CP or v:Team() == TEAM_OTA then
					if not v:GetSyncVar(SYNC_RANKPOINTS) then
						v:SetSyncVar(SYNC_RANKPOINTS, 0)
					end
					v:SetSyncVar(SYNC_RANKPOINTS, v:GetSyncVar(SYNC_RANKPOINTS) + math.random(7, 28))
					if v:GetSyncVar(SYNC_RANKPOINTS) > 1000 then
						v:SetSyncVar(SYNC_RANKPOINTS, 1000)
					end
				end
			end
			rankpointsdelay = CurTime() + 300
		end
	end
end)
	
hook.Add("PostPlayerDeath", "AddToBSLCount", function(ply)

	if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
		deathcount = deathcount + 1
		deathcountclear = CurTime() + 600
	end
	
		if deathcount == 6 and (ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA) then
			SetGlobalInt("CityCode", 4)
			for k,v in pairs(player.GetAll()) do
				if v:IsCP() then
					v:SendCombineMessage("CODE CHANGED: AUTONOMOUS JUDGEMENT.", Color(255, 0, 0))
					timer.Simple(5, function()  v:SendChatClassMessage(16, "Attention all Civil Protection members. Conduct searches on all citizens & areas within city-limits, and punish those breaking lockdown.", ply) end)
					deathcountclear = CurTime() + 900
				end
			end
		end
	end)
	
hook.Add("Think", "BSLCountKeepCounting", function()
	if CurTime() > deathcountclear and deathcount > 0 then

		if GetGlobalInt("CityCode", 1) == 4 then
			SetGlobalInt("CityCode", 1)
				for k,v in pairs(player.GetAll()) do
					if v:IsCP() then
						v:SendCombineMessage("CODE CHANGED: CIVIL.", Color(0, 225, 0))
						timer.Simple(5, function()  v:SendChatClassMessage(16, "Attention all Civil Protection members. CODE: CIVIL is now in effect. Return to your duties.", ply) end)
					end
				end
		end
			deathcount = 0
			deathcountclear = CurTime()
	
	elseif GetGlobalInt("CityCode") == 4 then
		deathcountclear = deathcountclear + 180
	end
	
end)
	
local randomambiencenum = math.random(1,5)
local mysound = "music/hl2_song26_trainstation1.mp3" 
local isplaying = false
NextAJAmbienceThink = CurTime()
hook.Add("Think", "CCAmbient", function()
	if GetGlobalInt("CityCode") == 4 then
		if NextAJAmbienceThink < CurTime() then
			for k,v in pairs (player.GetAll()) do
				if isplaying == false then
					isplaying = true
					Entity(0):EmitSound(mysound, 0, 100, 0.05, CHAN_STATIC)
				end
			end
		end
	else
		isplaying = false
		Entity(0):StopSound(mysound)
		NextAJAmbienceThink = CurTime() + 120
	end
end)

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



-- local filter = RecipientFilter()
-- filter:AddAllPlayers()
--local ajsfxalt = CreateSound(Entity(0), "music/hl2_song26_trainstation1.mp3", filter)
hook.Add("PostPlayerDeath", "AddToBSLCount", function(ply)
	if ply:IsCP() then
	deathcount = deathcount + 1
	deathcountclear = CurTime() + 600
	print("CurTime = "..CurTime())
	print("DCClear = "..deathcountclear)
	print(deathcount)
	end
	-- if deathcountclear < CurTime() then
	-- deathcount = 0
	-- deathcountclear = CurTime()
	-- print("cleared count."..deathcount.."/"..deathcountclear)
	-- end
	if deathcount > 5 and ply:IsCP() then
	SetGlobalInt("CityCode", 4)
	for k,v in pairs(player.GetAll()) do
		--local mysound = CreateSound( v, "music/hl2_song26_trainstation1.mp3" )
		--mysound:PlayEx(0.4, 100)
		if v:IsCP() then
		 v:SendCombineMessage("CODE CHANGED: AUTONOMOUS JUDGEMENT.", Color(255, 0, 0))
		timer.Simple(5, function()  v:SendChatClassMessage(16, "Attention all Civil Protection members. Conduct searches on all citizens & areas within city-limits, and punish those breaking lockdown.", ply) end)
end
	end
	end
	end)
	
hook.Add("Think", "BSLCountKeepCounting", function()
-- if deathcountclear < CurTime() and deathcount > 0 then
	-- deathcount = 0
	-- deathcountclear = CurTime()
	-- SetGlobalInt("CityCode", 1)
	-- Entity(0):StopLoopingSound(Entity(0):StartLoopingSound("aj_suspense"))
if CurTime() > deathcountclear and deathcount > 0 then
	print("cleared count via think hook."..deathcount.."/"..deathcountclear)
	SetGlobalInt("CityCode", 1)
for k,v in pairs(player.GetAll()) do
		if v:IsCP() then
		 v:SendCombineMessage("CODE CHANGED: CIVIL.", Color(0, 225, 0))
		timer.Simple(5, function()  v:SendChatClassMessage(16, "Attention all Civil Protection members. CODE: CIVIL is now in effect. Return to your duties.", ply) end)
end
	end
	deathcount = 0
	deathcountclear = CurTime()
elseif GetGlobalInt("CityCode") == 4 then
	deathcountclear = deathcountclear + 180
			
end
	end)
	
	local randomambiencenum = math.random(1,5)
	NextAJAmbienceThink = CurTime()
hook.Add("Think", "CCAmbient", function()
if GetGlobalInt("CityCode") != 4 then return end
	if NextAJAmbienceThink < CurTime() then
	for k,v in pairs (player.GetAll()) do
		local mysound = "music/hl2_song26_trainstation1.mp3" 
		local mysound2 = "ambient/alarms/apc_alarm_pass1.wav" 
		local mysound3 = "ambient/alarms/citadel_alert_loop2.wav" 
		local mysound4 = "ambient/levels/streetwar/strider_distant3.wav"
		local mysound5 = "ambient/alarms/manhack_alert_pass1.wav"
		
		--if not mysound:IsPlaying() then
		if randomambiencenum == 1 then
			Entity(0):EmitSound(mysound, 0, 100, 0.1, CHAN_STATIC)
		elseif randomambiencenum == 2 then
			Entity(0):EmitSound(mysound2, 0, 100, 0.1, CHAN_STATIC)
		elseif randomambiencenum == 3 then
			Entity(0):EmitSound("null.wav", 0, 100, 0.1, CHAN_STATIC)
		elseif randomambiencenum == 4 then
			Entity(0):EmitSound(mysound4, 0, 100, 0.1, CHAN_STATIC)
		elseif randomambiencenum == 5 then
			Entity(0):EmitSound(mysound5, 0, 100, 0.1, CHAN_STATIC)
		end
		
		
		
		
		--end
	end
	NextAJAmbienceThink = CurTime() + 120
	end
end)

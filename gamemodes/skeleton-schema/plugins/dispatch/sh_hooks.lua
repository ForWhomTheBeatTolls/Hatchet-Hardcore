
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
	
	NextAJAmbienceThink = CurTime() + 100
hook.Add("Think", "CCAmbient", function()
if GetGlobalInt("CityCode") != 4 then return end
	if NextAJAmbienceThink > CurTime() then
	for k,v in pairs (player.GetAll()) do
		local mysound = CreateSound( v, "music/hl2_song26_trainstation1.mp3" )
		--if not mysound:IsPlaying() then
			mysound:PlayEx(0.05, 100)
		--end
	end
	NextAJAmbienceThink = CurTime() + 100
	end
end)
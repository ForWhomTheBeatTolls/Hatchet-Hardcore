local deathcount = deathcount or 1
local deathcountclear = deathcountclear or CurTime()
local citycode = civil

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
	local aj_begin_ent = ents.FindByName("JudgementWaiverStartWidget")[1]
	local aj_end_ent = ents.FindByName("JudgementWaiverEndWidget")[1]
	print(deathcount)
	
	
	if ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA then
		deathcount = deathcount + 1
		if deathcountclear < CurTime() then
			deathcountclear = CurTime() + 300
		else
			deathcountclear = deathcountclear + 300
		end
	end
	
	if deathcount > 1 and (ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA) then
		if GetGlobalInt("CityCode", 1) != 4 then
			SetGlobalInt("CityCode", 4)
			if SERVER then
				aj_begin_ent:Fire("trigger")
			end
				
			for k,v in pairs(player.GetAll()) do
				if v:IsCP() then
					v:SendCombineMessage("CODE CHANGED: AUTONOMOUS JUDGEMENT.", Color(255, 0, 0))
					timer.Simple(5, function()  v:SendChatClassMessage(16, "Anti-citizen activity detected. Administer JUDGEMENT.", ply) end)
					deathcountclear = CurTime() + 900
				end
			end
		end
	end
end)
	
hook.Add("Think", "BSLCountKeepCounting", function()
	if CurTime() > deathcountclear and deathcount > 1 then

		if GetGlobalInt("CityCode", 1) == 4 then
			SetGlobalInt("CityCode", 1)
			if SERVER then
				aj_end_ent:Fire("trigger")
			end
				for k,v in pairs(player.GetAll()) do
					if v:IsCP() then
						v:SendCombineMessage("CODE CHANGED: CIVIL.", Color(0, 225, 0))
						timer.Simple(5, function()  v:SendChatClassMessage(16, "Attention all Civil Protection members. CODE: CIVIL is now in effect. Return to your duties.", ply) end)
					end
				end
		end
			deathcount = 1
			deathcountclear = CurTime()
	
	elseif GetGlobalInt("CityCode") == 4 then
	
		deathcountclear = CurTime() + 300
		
	end
	
end)

local team
local CanApplyTeams = {
TEAM_CP,
TEAM_CITIZEN,
TEAM_WORKFORCE
}
local CitizenApplyCommand = {
	description = "State your credentials.",
	requiredArg = false,
	adminOnly = false,
	onRun = function(ply, rawText)
		if ply:Team() == TEAM_CITIZEN then team = "Citizen"
		elseif ply:Team() == TEAM_WORKFORCE then team = "Workforce"
		elseif ply:Team() == TEAM_CP then team = "Civil Protection"
		end		
		
		if table.HasValue(CanApplyTeams, ply:Team()) then
			ply:SetNWBool("Applied", true)
			ply:SetNWInt("ApplyWearTime", CurTime() + 5)
			for v,k in pairs(player.GetAll()) do
				if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then 
					k:SendChatClassMessage(20, (ply:Nick().." | "..team), ply)
				end
			end
		else
			ply:Notify("You don't have an identification card.")
		end
	end
}

hook.Add("Think", "PlayerApplyWearHatchet", function()
	for _, ply in pairs(player.GetAll()) do
		if ply:GetNWInt("ApplyWearTime") < CurTime() then
			ply:SetNWBool("Applied", false)
			ply:SetNWInt("ApplyWearTime", CurTime() + 5)
		end
	end
end)

impulse.RegisterChatCommand("/apply", CitizenApplyCommand)

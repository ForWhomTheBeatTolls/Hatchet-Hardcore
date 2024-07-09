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
			ply:SetNWInt("ApplyWearTime", CurTime() + 300 )

			for v,k in pairs(player.GetAll()) do
				if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then
					k:SendChatClassMessage(20, ply:Nick() .. " | " .. team, ply)
					local tabl = util.JSONToTable(k:GetSyncVar(SYNC_RECOGNIZES))

					if k:SteamID() == ply:SteamID() then continue end

					if k:IsCP() then return end

					if tabl[ply:SteamID()] then
						return
					else

						AddIntroduction(ply, k)

						if tabl[k:SteamID()] then
							ply:Notify( "You introduced yourself to " .. k:Name() .. " while you were applying." )
							k:Notify(ply:Name() .. " Introduced himself to you while they were applying.")
						else
							ply:Notify( "You introduced yourself to an unknown person while you were applying." )
							k:Notify(ply:Name() .. " Introduced himself to you while they were applying.")
						end
					end


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
			ply:SetNWInt("ApplyWearTime", CurTime() + 300)
		end
	end
end)

impulse.RegisterChatCommand("/apply", CitizenApplyCommand)

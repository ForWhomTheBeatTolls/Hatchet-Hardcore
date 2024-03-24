hook.Add("Think", "LOSCheck", function()

	if not IsValid(LocalPlayer()) then return end


	if not nextLOSCheck then nextLOSCheck = CurTime() end

	for k,v in pairs(ents.FindInSphere(LocalPlayer():EyePos(), 2500)) do

		if v == LocalPlayer() then continue end
		if not (v:IsPlayer() or v:IsNPC()) then continue end

		local isNoClipping

		if v:GetMoveType() == MOVETYPE_NOCLIP then--will def break shit like seats and maybe even anims
			isNoClipping = true
		else
			isNoClipping = nil
		end

		local voiceScaleFactor = 1


		if LocalPlayer():IsLineOfSightClear(v) then
			AdjustVolume(v, 1*voiceScaleFactor)
		else
			AdjustVolume(v, 0.2*voiceScaleFactor)
		end

		if impulse.GetSetting("view_thirdperson") or isNoClipping then
			v:SetNoDraw(true)
			if IsValid(v:GetActiveWeapon()) then
				v:GetActiveWeapon():SetNoDraw(true)
			end
		end

				if LocalPlayer():IsLineOfSightClear(v) and not isNoClipping then

						v:SetNoDraw(false)
						if IsValid(v:GetActiveWeapon()) then
							v:GetActiveWeapon():SetNoDraw(false)
						end

				end

		if v:IsNPC() and v:Health() <= 0 then
			v:SetNoDraw(true)
		end
		
	end



	nextLOSCheck = CurTime() + 0.2

end)

function AdjustVolume(ply, newVol)
	if (not IsValid(ply)) or ply == LocalPlayer() or (not ply:IsPlayer()) then return end

	if ply:Team() == TEAM_COMBINE then newVol = 1 end

	ply:SetVoiceVolumeScale(newVol)

end
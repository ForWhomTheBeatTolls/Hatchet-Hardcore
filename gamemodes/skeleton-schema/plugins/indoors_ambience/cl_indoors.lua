function IsIndoors()

	local eyePos = LocalPlayer():GetPos()
	local outdoorscheck = util.TraceLine( {
	start = eyePos,
	endpos = eyePos + Vector(0, 0, 99999),
	filter = LocalPlayer()
} )

	indoor = outdoorscheck.HitSky
end



local doneItOnce = false
function DaMachine()

	local day = CreateSound(LocalPlayer(), "ambient/forest_day.wav")
	local ambience = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = -0.04,
		["$pp_colour_contrast"] = 1.5,
		["$pp_colour_colour"] = 0.8,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	IsIndoors()

	if indoor then
		-- if impulse.GetSetting("ambience_sounds") then
			-- day:PlayEx(0.17, 60)
		-- end
		if not doneItOnce then
			doneItOnce = true
			if impulse.GetSetting("hud_ambience") then
				hook.Add("RenderScreenspaceEffects", "HatchetAmbienceColor", function()
					DrawColorModify( ambience )
				end )
			end
			//print("Outside")
		end
	end

	if not indoor then
		-- if impulse.GetSetting("ambience_sounds") then
			-- day:Stop()
		-- end
		if doneItOnce then
			doneItOnce = false
			if impulse.GetSetting("hud_ambienceindoors") then
				hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
			end
			//print("Inside")
		end
	end
end


local delay = CurTime()
hook.Add("Think", "AmbienceInDoors", function()
	if CurTime() > delay then 
		DaMachine()

		if not impulse.GetSetting("hud_ambience") then
			hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
		end
		delay = CurTime() + 1
	end
end)




/*
	if not impulse.GetSetting("hud_ambience") then
		hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
	end

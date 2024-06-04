function IsIndoors()
	local day = CreateSound(LocalPlayer(), "ambient/forest_day.wav")
	local eyePos = LocalPlayer():GetPos()
	local outdoorscheck = util.TraceLine( {
	start = eyePos,
	endpos = eyePos + Vector(0, 0, 99999),
	filter = LocalPlayer()
} )
	if outdoorscheck.HitSky then
		--print("true")
		day:PlayEx(0.17, 60)
		return false
	else
		--print("false")
		day:Stop()
		return true
	end
end


local delay = CurTime()
hook.Add("Think", "AmbienceInDoors", function()
	
	local ambience = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.04,
	["$pp_colour_contrast"] = 1.4,
	["$pp_colour_colour"] = 0.8,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
	}

	if CurTime() > delay then 
		IsIndoors()
		--print(tobool(IsIndoors()))
		if impulse.GetSetting("hud_ambience") then
			if IsIndoors() == false then
				hook.Add("RenderScreenspaceEffects", "HatchetAmbienceColor", function()
					DrawColorModify( ambience )
				end )
			else
				hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
			end
		end

		if not impulse.GetSetting("hud_ambience") then
			hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
		end
		
		delay = CurTime() + 1
	end
end)

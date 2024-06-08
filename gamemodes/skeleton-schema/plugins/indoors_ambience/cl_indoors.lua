function IsIndoors()
	
	local eyePos = LocalPlayer():GetPos()
	local outdoorscheck = util.TraceLine( {
	start = eyePos,
	endpos = eyePos + Vector(0, 0, 99999),
	filter = LocalPlayer()
} )
	if outdoorscheck.HitSky then
		--print("true")
		return false
	else
		--print("false")
		
		return true
	end
end




local delay = CurTime()
hook.Add("Think", "AmbienceInDoors", function()

	local day = CreateSound(LocalPlayer(), "ambient/forest_day.wav")
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
				day:PlayEx(0.17, 60)
				hook.Add("RenderScreenspaceEffects", "HatchetAmbienceColor", function()
					DrawColorModify( ambience )
				end )
				--print("Outside!")
			else
				--print("Inside!")
				day:FadeOut(1)
				timer.Simple(6,function() day:Stop() end)
				hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
			end
		end

		if not impulse.GetSetting("hud_ambience") then
			hook.Remove("RenderScreenspaceEffects", "HatchetAmbienceColor")
		end

		if IsIndoors() == false then
			return
		else
			return
		end
		
		delay = CurTime() + 3
	end
end)

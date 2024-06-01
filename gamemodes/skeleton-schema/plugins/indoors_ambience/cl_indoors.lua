local color_red = Color( 255, 0, 0 )
local mins, maxs = Vector( -4, -4, -4 ), Vector( 4, 4, 4 )

hook.Add( "PostDrawTranslucentRenderables", "trace_visualize", function()
	local eyePos = Entity( 1 ):GetPos()

	local outdoorscheck = util.TraceLine( {
		start = eyePos,
		endpos = eyePos + Vector(0, 0, 9999),
		filter = Entity( 1 )
	} )
	--render.DrawLine( eyePos, outdoorscheck.HitPos, color_red, true )

	-- Show that the traceline is a line, not a hull
	--render.DrawWireframeBox( outdoorscheck.HitPos, Angle( 0, 0, 0 ), mins, maxs, color_red, true )
	-- listen here GLUA, if you dont fucking play how i want it to i will rape your wife and make you suffer by adding 500 hook.add(thinks)
	-- do you understand what im saying you faggot?

	function IsIndoors()
		local night = CreateSound(LocalPlayer(), "ambient/forest_night.wav")
		if outdoorscheck.HitSky == true then
			--print("true")
			night:PlayEx(0.1, 100)
		else
			--print("false")
			night:Stop()
		end
	end



end)


local delay = 0
hook.Add("Think", "AmbienceOutside", function()
	if CurTime() < delay then return end	
    IsIndoors()
	delay = CurTime() + 3 -- Makes every 4 secs run the code
end)

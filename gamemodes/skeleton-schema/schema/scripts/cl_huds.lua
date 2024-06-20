function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

local crosshaircolor = Color(0, 0, 0)
local delay = 0

// Im so sorry for this

hook.Add("Think", "ColorCaller", function()
	if CurTime() < delay then return end

	if impulse.GetSetting("crosshair_color") == "White" then
		crosshaircolor = Color(255, 255, 255)
	elseif impulse.GetSetting("crosshair_color") == "Green" then
		crosshaircolor = Color(0, 255, 0)
	elseif impulse.GetSetting("crosshair_color") == "Yellow" then
		crosshaircolor = Color(255, 238, 0)
	elseif impulse.GetSetting("crosshair_color") == "Red" then
		crosshaircolor = Color(255, 0, 0)
	elseif impulse.GetSetting("crosshair_color") == "Blue" then
		crosshaircolor = Color(65, 125, 255)
	elseif impulse.GetSetting("crosshair_color") == "Purple" then
		crosshaircolor = Color(162, 0, 255)
	elseif impulse.GetSetting("crosshair_color") == "Orange" then
		crosshaircolor = Color(255, 145, 0)
	end

	delay = CurTime() + 2
end)

function InitializeHuds()
	

	hook.Add("HUDPaint", "LegacyHatchetHUD", function()

		if impulse.GetSetting("hud_selection") != "Hatchet Legacy" then
            return
        end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end

		if LocalPlayer():GetTeamRank() == RANK_I1 or LocalPlayer():GetTeamRank() == RANK_I2 or LocalPlayer():GetTeamRank() == RANK_I3 or LocalPlayer():GetTeamRank() == RANK_I4 or LocalPlayer():GetTeamRank() == RANK_OFC or LocalPlayer():GetTeamRank() == RANK_DVL or LocalPlayer():GetTeamRank() == RANK_DCO or LocalPlayer():GetTeamRank() == RANK_CMD or LocalPlayer():GetTeamClass() == 1 or LocalPlayer():GetTeamClass() == 2 or LocalPlayer():GetTeamClass() == 3 then
			return
		end



		local scrW = ScrW()
		local scrH = ScrH()
		local health = LocalPlayer():Health()
		local hunger = LocalPlayer():GetSyncVar(SYNC_HUNGER, 100)
		local money = LocalPlayer():GetSyncVar(SYNC_MONEY, 100)
		local maxhealth = LocalPlayer():GetMaxHealth()
		local maxhunger = 100
		local hudWidth, hudHeight = 300, 178
		local warningIcon = Material("impulse/icons/warning-128.png")
		local darkCol = Color(30, 30, 30, 190)
		local y = scrH-hudHeight-8-10
		--BlurRect(10, y, hudWidth, hudHeight)
		surface.SetDrawColor(darkCol)
		if impulse.GetSetting("hud_jim") then
		surface.DrawRect(10, y, hudWidth, hudHeight)
		elseif !impulse.GetSetting("hud_hunger") and !impulse.GetSetting("hud_jim") then
		surface.DrawRect(10, y + 145, hudWidth, hudHeight - 145)
		else
		surface.DrawRect(10, y + 112, hudWidth, hudHeight - 112)
		end
	
	
		surface.SetDrawColor(140, 0, 0, 100)
		surface.DrawRect(10, y + 145, hudWidth * (health / maxhealth), hudHeight - 145)
		--surface.SetMaterial(gradient)
		--surface.DrawTexturedRect(10, y, hudWidth, hudHeight)
		//surface.SetFont("Impulse-Elements19")
		//surface.SetTextColor(20, 20, 20, 200)
		//surface.SetTextPos(140, y+155)
		//surface.DrawText(LocalPlayer():Health())
		
		-- ### HUNGERBAR ###
		
		if impulse.GetSetting("hud_hunger") then
		
		surface.SetDrawColor(183, 139, 67, 100)
		surface.DrawRect(10, y + 112, hudWidth * (hunger / maxhunger), hudHeight - 145)
		surface.SetFont("Impulse-Elements19")
		//surface.SetTextColor(83, 39, 7, 200)
		//surface.SetTextPos(142, y+122)
		//surface.DrawText(hunger)
	
		local weapon = LocalPlayer():GetActiveWeapon()
		if IsValid(weapon) then
			if weapon:GetMaxClip1() != -1 then
				surface.SetDrawColor(25, 25, 25, 100)
				surface.DrawRect(scrW-70, scrH-45, 70, 30)
				surface.SetTextPos(scrW-50, scrH-40)
				surface.SetTextColor(5, 5, 5, 200)
				surface.DrawText(weapon:Clip1().."/"..LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()))
			elseif weapon:GetClass() == "weapon_physgun" or weapon:GetClass() == "gmod_tool" then
				draw.DrawText("Don't have this weapon out in RP.", "Impulse-Elements16", scrW-10, scrH-20, color_white, TEXT_ALIGN_RIGHT)
				surface.SetDrawColor(color_white)
				surface.SetMaterial(warningIcon)
				surface.DrawTexturedRect(scrW-250, scrH-20, 18, 18)
				aboveHUDUsed = true
	
				surface.SetDrawColor(darkCol)
				surface.DrawRect(scrW-140, scrH-55, 140, 30)
	
				surface.SetFont("Impulse-Elements18-Shadow")
				surface.SetTextPos(scrW-130, scrH-50)
				surface.DrawText("Props: "..LocalPlayer():GetSyncVar(SYNC_PROPCOUNT, 0).."/"..((LocalPlayer():IsDonator() and impulse.Config.PropLimitDonator) or impulse.Config.PropLimit))
			end
		end
		
		end
	
	end)
	
	hook.Add("HUDPaint", "AxeHUD", function()

		if impulse.GetSetting("hud_selection") != "Axe" then
            return
        end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end

		if LocalPlayer():GetTeamRank() == RANK_I1 or LocalPlayer():GetTeamRank() == RANK_I2 or LocalPlayer():GetTeamRank() == RANK_I3 or LocalPlayer():GetTeamRank() == RANK_I4 or LocalPlayer():GetTeamRank() == RANK_OFC or LocalPlayer():GetTeamRank() == RANK_DVL or LocalPlayer():GetTeamRank() == RANK_DCO or LocalPlayer():GetTeamRank() == RANK_CMD or LocalPlayer():GetTeamClass() == 1 or LocalPlayer():GetTeamClass() == 2 or LocalPlayer():GetTeamClass() == 3 then
			return
		end

		local y = ScrW()
		local w = ScrH()
		local hudWidth, hudHeight = 500, 14
		local health = LocalPlayer():Health()
		local hunger = LocalPlayer():GetSyncVar(SYNC_HUNGER, 100)
		local money = LocalPlayer():GetSyncVar(SYNC_MONEY, 100)

		local background = Color(146, 146, 146)
		local outline = Color(0, 0, 0, 230)

		surface.SetDrawColor(background)
		surface.DrawRect(w * .01, y * .005, hudWidth, hudHeight)
		surface.DrawRect(w * .01, y * .015, hudWidth, hudHeight)
		surface.SetDrawColor(Color(145, 12, 12))
		surface.DrawRect(w * .01, y * .005, health * 5, hudHeight)
		surface.SetDrawColor(Color(223, 138, 28))
		surface.DrawRect(w * .01, y * .015, hunger * 5, hudHeight)
		surface.SetDrawColor(outline)
		surface.DrawOutlinedRect(w * .01, y * .005, hudWidth, hudHeight, 2)
		surface.DrawOutlinedRect(w * .01, y * .015, hudWidth, hudHeight, 2)

		//draw.DrawText(health, "Impulse-Elements14-Shadow", w * .25, y * .0045, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		//draw.DrawText(hunger, "Impulse-Elements14-Shadow", w * .25, y * .0145, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		draw.DrawText("Money on you: "..money..impulse.Config.CurrencyPrefix, "Impulse-Elements18-Shadow", w * .01, y * .025, Color(255, 255, 255), TEXT_ALIGN_LEFT)


		local weapon = LocalPlayer():GetActiveWeapon()
		if IsValid(weapon) then
			if weapon:GetMaxClip1() != -1 then
				surface.SetFont("Impulse-Elements32-Shadow")
				surface.SetDrawColor(25, 25, 25, 100)
				surface.SetTextPos(y-100, w-40)
				surface.SetTextColor(255, 255, 255, 200)
				surface.DrawText(weapon:Clip1().."/"..LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()))
			elseif weapon:GetClass() == "weapon_physgun" or weapon:GetClass() == "gmod_tool" then
				aboveHUDUsed = true
	
				surface.SetFont("Impulse-Elements32-Shadow")
				surface.SetTextPos(y-180, w-40)
				surface.DrawText("Props: "..LocalPlayer():GetSyncVar(SYNC_PROPCOUNT, 0).."/"..((LocalPlayer():IsDonator() and impulse.Config.PropLimitDonator) or impulse.Config.PropLimit))
			end
		end
	end)
	

	hook.Add("HUDPaint", "MinimalCrosshair", function()

		if impulse.GetSetting("crosshair_selection") != "Default" then
			return
		end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end
	
		surface.SetDrawColor(crosshaircolor)
		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, radius, radius)
		end
	end)
	
	hook.Add("HUDPaint", "LegacyHatchetCrosshair", function()
	
		if impulse.GetSetting("crosshair_selection") != "Hatchet Legacy" then
			return
		end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end
	
		surface.SetDrawColor(crosshaircolor)

		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
		end
	end)

	hook.Add("HUDPaint", "HalfLifeTwoCrosshair", function()

		if impulse.GetSetting("crosshair_selection") != "Half-Life 2" then
			return
		end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end
		

		surface.SetDrawColor(crosshaircolor)

		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 9, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 7, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y + 8, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 8, 2, 2)
		end
	end)

	hook.Add("HUDPaint", "CircleDotCrosshair", function()
	
		if impulse.GetSetting("crosshair_selection") != "Circle + Dot" then
			return
		end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end
	
		surface.SetDrawColor(crosshaircolor)

		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 1, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
		end
	end)

	hook.Add("HUDPaint", "HatchetHUD", function()

		if impulse.GetSetting("hud_selection") != "Hatchet" then
            return
        end

		if impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then
			return
		end
		
		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
		
		if IsValid(impulse.SplashScreen) then
			return
		end

		if LocalPlayer():GetTeamRank() == RANK_I1 or LocalPlayer():GetTeamRank() == RANK_I2 or LocalPlayer():GetTeamRank() == RANK_I3 or LocalPlayer():GetTeamRank() == RANK_I4 or LocalPlayer():GetTeamRank() == RANK_OFC or LocalPlayer():GetTeamRank() == RANK_DVL or LocalPlayer():GetTeamRank() == RANK_DCO or LocalPlayer():GetTeamRank() == RANK_CMD or LocalPlayer():GetTeamClass() == 1 or LocalPlayer():GetTeamClass() == 2 or LocalPlayer():GetTeamClass() == 3 then
			return
		end

		local w, h = ScrW(), ScrH()
		local hudWidth, hudHeight = 400, 100
		local healthIcon = Material("hatchet/plus.png")
		local moneyIcon = Material("hatchet/money.png")
		local hungerIcon = Material("hatchet/food.png")
		local gradient = Material("gui/gradient_up")
		//local configcolor = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
		local configcolor = Color(238, 163, 0)

		surface.SetDrawColor(82, 82, 82)
		surface.DrawRect(w * .035, h * .022, w * .13, h * .008)
		surface.DrawRect(w * .035, h * .042, w * .13, h * .008)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.SetDrawColor(configcolor)
		surface.DrawRect(w * .035, h * .022, LocalPlayer():Health() * 2.49, h * .008)
		surface.DrawRect(w * .035, h * .042, LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) * 2.49, h * .008)
		surface.SetMaterial(healthIcon)
		surface.DrawTexturedRect(w * .022, h * .018, w * .01, h * .017)
		surface.SetMaterial(hungerIcon)
		surface.DrawTexturedRect(w * .022, h * .038, w * .01, h * .017)
		surface.SetMaterial(moneyIcon)
		surface.DrawTexturedRect(w * .022, h * .057, w * .01, h * .017)
		surface.SetDrawColor(0, 0, 0, 135)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(w * .035, h * .022, w * .13, h * .008)
		surface.DrawTexturedRect(w * .035, h * .042, w * .13, h * .008)
		surface.SetDrawColor(255, 255, 255)

		//draw.SimpleText(LocalPlayer():Health(), "Impulse-Elements14-Shadow", w * .1, h * .018, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		//draw.SimpleText(LocalPlayer():GetSyncVar(SYNC_HUNGER, 100), "Impulse-Elements14-Shadow", w * .1, h * .038, Color(255, 255, 255), TEXT_ALIGN_CENTER)

		draw.SimpleText(LocalPlayer():GetSyncVar(SYNC_MONEY, 100), "Impulse-Elements19-Shadow", w * .034, h * .058, Color(255, 255, 255), TEXT_ALIGN_LEFT)

		local weapon = LocalPlayer():GetActiveWeapon()
		if IsValid(weapon) then
			if weapon:GetMaxClip1() != -1 then
				surface.SetFont("Impulse-Elements24-Shadow")
				surface.SetDrawColor(25, 25, 25, 100)
				surface.SetTextPos(w-80, h-40)
				surface.SetTextColor(255, 255, 255, 200)
				surface.DrawText(weapon:Clip1().."/"..LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()))
			elseif weapon:GetClass() == "weapon_physgun" or weapon:GetClass() == "gmod_tool" then
				aboveHUDUsed = true
	
				surface.SetFont("Impulse-Elements24-Shadow")
				surface.SetTextPos(w-140, h-40)
				surface.DrawText("Props: "..LocalPlayer():GetSyncVar(SYNC_PROPCOUNT, 0).."/"..((LocalPlayer():IsDonator() and impulse.Config.PropLimitDonator) or impulse.Config.PropLimit))
			end
		end
	end)
	
end



InitializeHuds()

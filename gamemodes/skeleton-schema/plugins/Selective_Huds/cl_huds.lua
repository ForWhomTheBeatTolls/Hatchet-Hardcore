function InitializeHuds()

	hook.Add("HUDPaint", "LegacyHatchetHUD", function()

		if impulse.GetSetting("hud_selection") != "Hatchet Legacy" then
            		return
        	end

		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end


		local scrW = ScrW()
		local scrH = ScrH()
		local hudWidth, hudHeight = 300, 178
		local health = LocalPlayer():Health()
		local warningIcon = Material("impulse/icons/warning-128.png")
		local maxhealth = LocalPlayer():GetMaxHealth()
		local hunger = LocalPlayer():GetSyncVar(SYNC_HUNGER, 100)
		local maxhunger = 100
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
		surface.SetFont("Impulse-Elements19")
		surface.SetTextColor(20, 20, 20, 200)
		surface.SetTextPos(140, y+155)
		surface.DrawText(LocalPlayer():Health())
		
		-- ### HUNGERBAR ###
		
		if impulse.GetSetting("hud_hunger") then
		
		surface.SetDrawColor(183, 139, 67, 100)
		surface.DrawRect(10, y + 112, hudWidth * (hunger / maxhunger), hudHeight - 145)
		surface.SetFont("Impulse-Elements19")
		surface.SetTextColor(83, 39, 7, 200)
		surface.SetTextPos(142, y+122)
		surface.DrawText(hunger)
	
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
	
	hook.Add("HUDPaint", "HatchetHUD", function()

		if impulse.GetSetting("hud_selection") != "Hatchet" then
            return
        end

		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end

		if IsValid(impulse.SplashScreen) then
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

		draw.DrawText("Money on you: "..money..impulse.Config.CurrencyPrefix, "Impulse-Elements18-Shadow", w * .01, y * .025, Color(255, 255, 255), TEXT_ALIGN_LEFT)


		local weapon = LocalPlayer():GetActiveWeapon()
		if IsValid(weapon) then
			if weapon:GetMaxClip1() != -1 then
				surface.SetFont("Impulse-Elements32-Shadow")
				surface.SetDrawColor(25, 25, 25, 100)
				surface.SetTextPos(scrW-100, scrH-40)
				surface.SetTextColor(255, 255, 255, 200)
				surface.DrawText(weapon:Clip1().."/"..LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()))
			elseif weapon:GetClass() == "weapon_physgun" or weapon:GetClass() == "gmod_tool" then
				aboveHUDUsed = true
	
				surface.SetFont("Impulse-Elements32-Shadow")
				surface.SetTextPos(scrW-180, scrH-40)
				surface.DrawText("Props: "..LocalPlayer():GetSyncVar(SYNC_PROPCOUNT, 0).."/"..((LocalPlayer():IsDonator() and impulse.Config.PropLimitDonator) or impulse.Config.PropLimit))
			end
		end
	end)
	

	hook.Add("HUDPaint", "MinimalCrosshair", function()

		if impulse.GetSetting("crosshair_selection") != "Default" then
			return
		end

		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
	
		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			surface.SetDrawColor(255, 255, 255)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, 3, 3)
		end
	end)
	
	hook.Add("HUDPaint", "HatchetCrosshair", function()
	
		if impulse.GetSetting("crosshair_selection") != "Hatchet Legacy" then
			return
		end

		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
	
		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.SetDrawColor(255, 123, 0)
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, 246, 163, 67, 200)
		end
	end)

	hook.Add("HUDPaint", "HalfLifeTwoCrosshair", function()

		if impulse.GetSetting("crosshair_selection") != "Half-Life 2" then
			return
		end

		if ( IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible() ) then
			return
		end
	
		if LocalPlayer():IsValid() && LocalPlayer():Alive() then
			local x, y = 0,0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			surface.SetDrawColor(255, 255, 255)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 9, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 7, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y + 8, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 8, 2, 2)
		end
	end)	


end

InitializeHuds()

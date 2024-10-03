local crosshaircolor = Color(0, 0, 0)
local delay = 0
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
	hook.Add("HUDPaint", "MinimalCrosshair", function()
		if (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or IsValid(impulse.SplashScreen) or impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false or impulse.GetSetting("crosshair_selection") ~= "Default" then return end
		surface.SetDrawColor(crosshaircolor)
		if LocalPlayer():IsValid() and LocalPlayer():Alive() then
			local x, y = 0, 0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, radius, radius)
		end
	end)

	hook.Add("HUDPaint", "LegacyHatchetCrosshair", function()
		if (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or IsValid(impulse.SplashScreen) or impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false or impulse.GetSetting("crosshair_selection") ~= "Hatchet Legacy" then return end
		surface.SetDrawColor(crosshaircolor)
		if LocalPlayer():IsValid() and LocalPlayer():Alive() then
			local x, y = 0, 0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
		end
	end)

	hook.Add("HUDPaint", "HalfLifeTwoCrosshair", function()
		if (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or IsValid(impulse.SplashScreen) or impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false or impulse.GetSetting("crosshair_selection") ~= "Half-Life 2" then return end
		surface.SetDrawColor(crosshaircolor)
		if LocalPlayer():IsValid() and LocalPlayer():Alive() then
			local x, y = 0, 0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 6, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 4, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y + 5, 2, 2)
			surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x + 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 5, 2, 2)
		end
	end)

	hook.Add("HUDPaint", "CircleDotCrosshair", function()
		if (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or IsValid(impulse.SplashScreen) or impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false or impulse.GetSetting("crosshair_selection") ~= "Circle + Dot" then return end
		surface.SetDrawColor(crosshaircolor)
		if LocalPlayer():IsValid() and LocalPlayer():Alive() then
			local x, y = 0, 0
			local crosshairGap = 2
			local crosshairLength = crosshairGap + 2
			local radius = impulse.GetSetting("crosshair_radius")
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
			surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 1, crosshaircolor.r, crosshaircolor.g, crosshaircolor.b, 255)
		end
	end)

	hook.Add("HUDPaint", "HatchetHUD", function()
		if LocalPlayer():IsValid() and LocalPlayer():Team() == (TEAM_CP or TEAM_OTA) and LocalPlayer():GetTeamRank() ~= nil or IsValid(impulse.SplashScreen) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or impulse.hudEnabled == false or (impulse.CinematicIntro and LocalPlayer():Alive()) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) or hook.Run("ShouldDrawHUDBox") == false then return end
		local w, h = ScrW(), ScrH()
		local hudWidth, hudHeight = 280, 8
		local healthIcon = Material("hatchet/plus.png")
		local hungerIcon = Material("hatchet/food.png")
		local gradient = Material("gui/gradient_up")
		local bleedind = Material("hatchet/overlays/screendamage.png")
		local basecol = Color(85, 85, 85)
		local basecol2 = Color(0, 0, 0, 130)
		local basecol3 = Color(0, 0, 0, 255)
		local basecol4 = Color(226, 226, 226)
		local hpcolor = Color(252, 50, 50)
		local bleedcol = Color(255,255,255,255)
		local hungercolor = Color(252, 164, 50)
		local superstaminacolor = Color(71, 201, 20)
		surface.SetDrawColor(basecol)
		surface.DrawRect(w * .018, h * .9, hudWidth * 100 / 100, hudHeight) --hp
		surface.DrawRect(w * .018, h * .918, hudWidth * 100 / 100, hudHeight) --hunger
		surface.SetDrawColor(basecol4)
		surface.SetMaterial(healthIcon)
		surface.DrawTexturedRect(w * .006, h * .897, 16, 16)
		surface.SetMaterial(hungerIcon)
		surface.DrawTexturedRect(w * .006, h * .914, 16, 16)
		surface.DrawRect(w * .018, h * .9, hudWidth * LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), hudHeight) --hp
		surface.DrawRect(w * .018, h * .918, hudWidth * LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) / 100, hudHeight) --hunger
		surface.SetDrawColor(basecol2)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(w * .018, h * .9, hudWidth * 100 / 100, hudHeight) --hp
		surface.DrawTexturedRect(w * .018, h * .918, hudWidth * 100 / 100, hudHeight) --hunger
		surface.SetDrawColor(basecol3)
		surface.DrawOutlinedRect(w * .018, h * .9, hudWidth * 100 / 100, hudHeight, 1) --hp
		surface.DrawOutlinedRect(w * .018, h * .918, hudWidth * 100 / 100, hudHeight, 1) --hunger
		local ammocounter = ""
		local weapon = LocalPlayer():GetActiveWeapon()
		local pos
		local boneindex = LocalPlayer():LookupBone("ValveBiped.Bip01_L_Hand") or 1
		if IsValid(weapon) then
			if weapon:Clip1() == 0 then
				ammocounter = "Empty"
			elseif weapon:Clip1() <= ((weapon:GetMaxClip1() / 2) - 3) then
				ammocounter = "Near Empty"
			elseif weapon:Clip1() < weapon:GetMaxClip1() and weapon:Clip1() >= ((weapon:GetMaxClip1() / 2) + 3) then
				ammocounter = "Near Full"
			elseif weapon:Clip1() > ((weapon:GetMaxClip1() / 2) - 3) and weapon:Clip1() < ((weapon:GetMaxClip1() / 2) + 3) then
				ammocounter = "Around Half"
			elseif weapon:Clip1() == weapon:GetMaxClip1() then
				ammocounter = "Full"
			end

			if LocalPlayer():Team() == TEAM_VORTIGAUNT then

				pos = LocalPlayer():GetPos()
			else
				pos = LocalPlayer():GetBonePosition(boneindex):ToScreen()
			end

			if weapon:GetMaxClip1() ~= -1 then
				if LocalPlayer():Team() ~= TEAM_VORTIGAUNT then
					surface.SetTextColor(255, 255, 255, 200)
					surface.SetFont("HatchetFont34")
					surface.SetTextPos(pos.x, pos.y)
					surface.DrawText("Ammo: " .. ammocounter)
				end
			elseif weapon:GetClass() == "weapon_physgun" or weapon:GetClass() == "gmod_tool" then
				aboveHUDUsed = true
				surface.SetTextColor(255, 255, 255, 200)
				surface.SetFont("HatchetFont20")
				surface.SetTextPos(w * .008, h - 134)
				surface.DrawText("Props: " .. LocalPlayer():GetSyncVar(SYNC_PROPCOUNT, 0) .. "/" .. ((LocalPlayer():IsDonator() and impulse.Config.PropLimitDonator) or impulse.Config.PropLimit))
			end

			---BLEED---
		
			if LocalPlayer():GetNWInt("BleedRate") > 0 then
				surface.SetMaterial(bleedind)
				surface.SetDrawColor(255, 255, 255, 51 * LocalPlayer():GetNWInt("BleedRate"))
				surface.DrawTexturedRect(0, 0, w, h, 1)
			end

			----
		end
	end)
end

InitializeHuds()

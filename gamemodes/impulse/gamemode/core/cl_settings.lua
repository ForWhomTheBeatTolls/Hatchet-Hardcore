local PANEL = {}

function PANEL:Init()
	local w, h = ScrW(), ScrH()

	local addedCategories = {}
	self:SetSize(w * .5, h * .7)
	self:Center()
	self:SetTitle("Settings")
	self:MakePopup()

	local settingsPages = vgui.Create("DPropertySheet", self)
	settingsPages:Dock(FILL)

	for v, k in pairs(impulse.Settings) do
		if k.category == "ops" and not LocalPlayer():IsAdmin() then continue end -- ops settings can only be viewed by admins
		if not addedCategories[k.category] then -- If category does not exist, create it
			local settingSheetScroll = vgui.Create("DScrollPanel", settingsPages)
			settingsPages:AddSheet(k.category, settingSheetScroll)
			addedCategories[k.category] = settingSheetScroll
		end

		local settingBase = addedCategories[k.category]:Add("DPanel")
		settingBase:Dock(TOP)
		settingBase:SetPos(w * .1, h * 0.04)
		settingBase:SetHeight(h * 0.035)

		function settingBase:Paint(w, h)
			surface.DrawRect(0, 0, w, 1.2)
		end

		local settingLabel = vgui.Create("DLabel", settingBase)
		settingLabel:SetText(k.name)
		settingLabel:SetFont("HatchetFont-Settings")
		settingLabel:SizeToContents()
		settingLabel:CenterVertical()
		settingLabel:SetPos(5, 0)

		local settingType = k.type
		if settingType == "tickbox" then
			local tickbox = vgui.Create("DCheckBox", settingBase)
			tickbox:CenterVertical()
			tickbox:SetPos(w * .46, settingLabel.y + 8)
			tickbox:SetSize(24, 24)
			tickbox:SetValue(impulse.GetSetting(v))

			function tickbox:OnChange(value)
				impulse.SetSetting(v, value)

				if k.needsRestart then
					Derma_Message("You may need to reconnect to the server to fully activate this setting.", "impulse", "Ok")
				end
			end
		elseif settingType == "plainint" then
			local numberEntry = vgui.Create("DNumberWang", settingBase)
			numberEntry:CenterVertical()
			numberEntry:SetPos(w * .46, numberEntry.y + 8)
			numberEntry:SetSize(30,20)
			numberEntry:SetValue(impulse.GetSetting(v))
			numberEntry:SetNumeric(true)

			function numberEntry:OnValueChanged(value)
				impulse.SetSetting(v, value)
			end
		elseif settingType == "slider" then
			local numSlider = vgui.Create("DNumSlider", settingBase)
			numSlider:CenterVertical()
			numSlider:SetMin(k.minValue or 0)
			numSlider:SetMax(k.maxValue or 100)
			numSlider:SetDecimals(0)
			numSlider:SetValue(impulse.GetSetting(v))
			numSlider:SetSize(w * 0.17,30)
			numSlider:SetPos(w * .32, numSlider.y)

			function numSlider:OnValueChanged(value)
				impulse.SetSetting(v, value)
			end
		elseif settingType == "dropdown" then
			local dropdown = vgui.Create("DComboBox", settingBase)
			dropdown:SetSize(120, 20)
			dropdown:CenterVertical()
			dropdown:SetPos(w * .3, dropdown.y)
			dropdown:SetValue(impulse.GetSetting(v))
			dropdown:SetSortItems(false)
			for _, option in pairs(k.options) do
				dropdown:AddChoice(option)
			end

			function dropdown:OnSelect(index, value)
				impulse.SetSetting(v, value)
			end
		end
	end
end


vgui.Register("impulseSettings", PANEL, "DFrame")

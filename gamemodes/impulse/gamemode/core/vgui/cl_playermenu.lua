local PANEL = {}
function PANEL:Init()
	self:SetSize(700, 450)
	self:Center()
	self:SetTitle("Player menu")
	self:MakePopup()
	self.darkOverlay = Color(40, 40, 40, 160)
	self.tabSheet = vgui.Create("DColumnSheet", self)
	self.tabSheet:Dock(FILL)
	self.tabSheet.Navigation:SetWidth(100)
	-- actions
	self.quickActions = vgui.Create("DPanel", self.tabSheet)
	self.quickActions:Dock(FILL)
	function self.quickActions:Paint(w, h)
		return true
	end

	-- business
	self.business = vgui.Create("DPanel", self.tabSheet)
	self.business:Dock(FILL)
	function self.business:Paint()
		return true
	end

	-- info
	self.info = vgui.Create("DPanel", self.tabSheet)
	self.info:Dock(FILL)
	function self.info:Paint(w, h)
		return true
	end

	local defaultButton = self:AddSheet("Actions", Material("impulse/icons/banknotes-256.png"), self.quickActions, self.QuickActions)
	self:AddSheet("Information", Material("impulse/icons/info-256.png"), self.info, self.Info)
	self:AddSheet("Business", Material("impulse/icons/cart-73-256.png"), self.business, self.Business)
	self.tabSheet:SetActiveButton(defaultButton)
	defaultButton.loaded = true
	self:QuickActions()
	self.tabSheet.ActiveButton.Target:SetVisible(true)
	self.tabSheet.Content:InvalidateLayout()
end

function PANEL:QuickActions()
	self.quickActionsInner = vgui.Create("DPanel", self.quickActions)
	self.quickActionsInner:Dock(FILL)
	local panel = self
	function self.quickActionsInner:Paint(w, h)
		surface.SetDrawColor(panel.darkOverlay)
		surface.DrawRect(0, 0, w, h)
		return true
	end

	self.collapsableOptions = vgui.Create("DCollapsibleCategory", self.quickActionsInner)
	self.collapsableOptions:SetLabel("Actions")
	self.collapsableOptions:Dock(TOP)
	local colInv = Color(0, 0, 0, 0)
	function self.collapsableOptions:Paint()
		self:SetBGColor(colInv)
	end

	function self.collapsableOptions:Toggle() -- allowing them to accordion causes bugs
		return
	end

	self.collapsableOptionsScroll = vgui.Create("DScrollPanel", self.collapsableOptions)
	self.collapsableOptionsScroll:Dock(FILL)
	self.collapsableOptions:SetContents(self.collapsableOptionsScroll)
	self.list = vgui.Create("DIconLayout", self.collapsableOptionsScroll)
	self.list:Dock(FILL)
	self.list:SetSpaceY(5)
	self.list:SetSpaceX(5)
	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Drop money")
	function btn:DoClick()
		panel:Remove()
		Derma_StringRequest("impulse", "Enter amount of money to drop:", nil, function(amount) LocalPlayer():ConCommand("say /dropmoney " .. amount) end)
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Change Description")
	function btn:DoClick()
		panel:Remove()
		Derma_StringRequest("impulse", "Enter your new description:", nil, function(text)
			net.Start("impulseChangeDescription")
			net.WriteString(text)
			net.SendToServer()
		end)
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Write a letter")
	function btn:DoClick()
		panel:Remove()
		Derma_StringRequest("impulse", "Write letter content:", nil, function(text) LocalPlayer():ConCommand("say /write " .. text) end)
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Introduce yourself to the person infront of you")
	function btn:DoClick()
		LocalPlayer():ConCommand("say /introduceinfront")
		panel:Remove()
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Introduce yourself to anyone around your talking radius")
	function btn:DoClick()
		LocalPlayer():ConCommand("say /introducetalk")
		panel:Remove()
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Introduce yourself to anyone around your yelling radius")
	function btn:DoClick()
		LocalPlayer():ConCommand("say /introducewhisper")
		panel:Remove()
	end

	local btn = self.list:Add("DButton")
	if impulse.IsHighRes() then
		btn:SetTall(30)
		btn:SetFont("Impulse-Elements17-Shadow")
	end

	btn:Dock(TOP)
	btn:SetText("Introduce yourself to anyone around your whispering radius")
	function btn:DoClick()
		LocalPlayer():ConCommand("say /introduceyell")
		panel:Remove()
	end
end

function PANEL:Business()
	self.businessInner = vgui.Create("DPanel", self.business)
	self.businessInner:Dock(FILL)
	local panel = self
	function self.businessInner:Paint(w, h)
		surface.SetDrawColor(panel.darkOverlay)
		surface.DrawRect(0, 0, w, h)
		return true
	end

	self.itemsScroll = vgui.Create("DScrollPanel", self.businessInner)
	self.itemsScroll:Dock(FILL)
	self.utilItems = self.itemsScroll:Add("DCollapsibleCategory")
	self.utilItems:SetLabel("Utilities")
	self.utilItems:Dock(TOP)
	local colInv = Color(0, 0, 0, 0)
	function self.utilItems:Paint()
		self:SetBGColor(colInv)
	end

	local utilList = vgui.Create("DIconLayout", self.utilItems)
	utilList:Dock(FILL)
	utilList:SetSpaceY(5)
	utilList:SetSpaceX(5)
	self.utilItems:SetContents(utilList)
	self.cat = {}
	for name, k in pairs(impulse.Business.Data) do
		if not LocalPlayer():CanBuy(name) then continue end
		local parent = nil
		if k.category then
			if self.cat[k.category] then
				parent = self.cat[k.category]
			else
				local cat = self.itemsScroll:Add("DCollapsibleCategory")
				cat:SetLabel(k.category)
				cat:Dock(TOP)
				local colInv = Color(0, 0, 0, 0)
				function cat:Paint()
					self:SetBGColor(colInv)
				end

				self.cat[k.category] = vgui.Create("DIconLayout", cat)
				self.cat[k.category]:Dock(FILL)
				self.cat[k.category]:SetSpaceY(5)
				self.cat[k.category]:SetSpaceX(5)
				cat:SetContents(self.cat[k.category])
				parent = self.cat[k.category]
			end
		end

		local item = (parent or utilList):Add("SpawnIcon")
		if k.item then
			local x = impulse.Inventory.Items[impulse.Inventory.ClassToNetID(k.item)]
			item:SetModel(x.Model)
		else
			item:SetModel(k.model)
		end

		if impulse.IsHighRes() then
			item:SetSize(78, 78)
		else
			item:SetSize(58, 58)
		end

		item:SetTooltip(name .. " \n" .. impulse.Config.CurrencyPrefix .. k.price)
		item.id = table.KeyFromValue(impulse.Business.DataRef, name)
		function item:DoClick()
			net.Start("impulseBuyItem")
			net.WriteUInt(item.id, 8)
			net.SendToServer()
		end

		local costLbl = vgui.Create("DLabel", item)
		costLbl:SetPos(5, HIGH_RES(35, 55))
		costLbl:SetFont(HIGH_RES("Impulse-Elements20-Shadow", "Impulse-Elements22-Shadow"))
		costLbl:SetText(impulse.Config.CurrencyPrefix .. k.price)
		costLbl:SizeToContents()
	end
end

function PANEL:Info()
	self.infoSheet = vgui.Create("DPropertySheet", self.info)
	self.infoSheet:Dock(FILL)
	local RulesPage = vgui.Create("DPanel", self.infoSheet)
	function RulesPage:Paint(w, h)
		surface.SetFont("Impulse-Elements20-Shadow")
		surface.SetTextColor(255, 255, 255)
		surface.SetTextPos(0, 0)
		surface.DrawText("1. Dont edge.")
		surface.SetTextPos(0, 20)
		surface.DrawText("1. Dont edge.")
		surface.SetTextPos(0, 40)
		surface.DrawText("1. Dont edge.")
	end

	self.infoSheet:AddSheet("Rules", RulesPage)
	local webTutorial = vgui.Create("DHTML", self.infoSheet)
	webTutorial:OpenURL(impulse.Config.TutorialURL)
	self.infoSheet:AddSheet("Help & Tutorials", webTutorial)
	local commands = vgui.Create("DScrollPanel", self.infoSheet)
	commands:Dock(FILL)
	local isAdmin = LocalPlayer():IsAdmin()
	local isLeadAdmin = LocalPlayer():IsLeadAdmin()
	local isSuperAdmin = LocalPlayer():IsSuperAdmin()
	for k, v in pairs(impulse.chatCommands) do
		local c = impulse.Config.MainColour
		if v.adminOnly then
			if isAdmin then
				c = impulse.Config.InteractColour
			else
				continue
			end
		end

		if v.leadAdminOnly then
			if isLeadAdmin or isSuperAdmin then
				c = Color(128, 0, 128)
			else
				continue
			end
		end

		if v.superAdminOnly then
			if isSuperAdmin then
				c = Color(255, 0, 0, 255)
			else
				continue
			end
		end

		local command = commands:Add("DPanel", commands)
		command:SetTall(40)
		command:Dock(TOP)
		command.name = k
		command.desc = v.description
		command.col = c
		function command:Paint()
			draw.SimpleText(self.name, "Impulse-Elements22-Shadow", 5, 0, self.col)
			draw.SimpleText(self.desc, "Impulse-Elements18-Shadow", 5, 20, color_white)
			return true
		end
	end

	self.infoSheet:AddSheet("Commands", commands)
end

function PANEL:AddSheet(name, icon, pnl, loadFunc)
	local tab = self.tabSheet:AddSheet(name, pnl)
	local panel = self
	tab.Button:SetSize(120, 130)
	function tab.Button:Paint(w, h)
		if panel.tabSheet.ActiveButton == self then
			surface.SetDrawColor(impulse.Config.MainColour)
		else
			surface.SetDrawColor(color_white)
		end

		surface.SetMaterial(icon)
		surface.DrawTexturedRect(0, 0, w - 10, h - 40)
		draw.DrawText(name, HIGH_RES("Impulse-Elements18", "Impulse-Elements20A-Shadow"), (w - 10) / 2, 95, color_white, TEXT_ALIGN_CENTER)
		return true
	end

	local oldClick = tab.Button.DoClick
	function tab.Button:DoClick()
		oldClick()
		if loadFunc and not self.loaded then
			loadFunc(panel)
			self.loaded = true
		end
	end
	return tab.Button
end

vgui.Register("impulsePlayerMenu", PANEL, "DFrame")

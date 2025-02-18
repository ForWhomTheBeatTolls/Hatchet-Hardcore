local PANEL = {}
local vignette = Material("gui/gradient")

local function CreateWindow(panel, id)
	if (IsValid( panel.window )) then
		panel.window:Remove()
	end

	timer.Simple(0, function()
		panel.window = vgui.Create(id)
		panel.window:SetAlpha(0)
		panel.window:Center()
		panel.window:MakePopup()
		panel.window:ShowCloseButton(false)
		panel.window:SetDraggable(false)
		local ww = panel.window:GetSize()
		panel.window:SetPos(ScrW() - ww - 64, ScrH() * .2)
		panel.window:AlphaTo(255, .2, 0)
		if (id == "impulseInventory") then
			impulse_inventory = panel.window
		end
	end)

	LastTabMenuScreen_Opened = id
end

local function CreateButton(panel, id, name, NeedsFunction, func)
	if NeedsFunction then
		local button = vgui.Create("DButton", panel.buttonlist)
		button:Dock(TOP)
		button:SetHeight(80)
		button:SetText(name)
		button:SetFont("Impulse-Elements32-Shadow")
		button:SetMaterial("gui/spawnmenu_toggle")

		button.DoClick = function()
			surface.PlaySound("hatchet/buttonclickrelease.wav")
			func()
			hatchet_tabmenu:Remove()
		end

		function button:Paint()
		end

	else
		local button = vgui.Create("DButton", panel.buttonlist)
		button:Dock(TOP)
		button:SetHeight(80)
		button:SetText(name)
		button:SetFont("Impulse-Elements32-Shadow")
		button:SetMaterial("gui/spawnmenu_toggle")

		button.DoClick = function()
			CreateWindow(panel, id)
			surface.PlaySound("hatchet/buttonclickrelease.wav")
		end

		function button:Paint()
		end
	end
end

function PANEL:Init()

	local ButtonList = {
		[1] = {name = "Inventory", id = "impulseInventory",},
		[2] = {name = "Settings", id = "impulseSettings"},
		[3] = {name = "Player List", id = "impulseScoreboard"},
		[4] = {name = "Main Menu", id = "impulseScoreboard", funcenable = true, func = function()
			local mainMenu = impulse.MainMenu or vgui.Create("impulseMainMenu")
			mainMenu:SetVisible(true)
			mainMenu:SetAlpha(0)
			mainMenu:AlphaTo(255, .3)
			-- mainMenu:MenuShowScreen()
			mainMenu.popup = true

			hook.Run("DisplayMenuMessages", mainMenu)
		end},
	}

	self:SetSize(ScrW(), ScrH())

	local pn = self
	surface.PlaySound("hatchet/buttonrollover.wav")
	self.window = nil
	self.RemovedEarly = false


	if (LastTabMenuScreen_Opened)  then
		CreateWindow(pn, LastTabMenuScreen_Opened)
	end


	self.buttonlist = vgui.Create("DScrollPanel", self)
	self.buttonlist:SetSize(ScrW() * .2, ScrH())
	self.buttonlist:SetPos(0 - ScrW() * .2, 0)
	self.buttonlist:MoveTo(0, 0, .3, 0, 2)
	self.buttonlist:SetAlpha(0)
	self.buttonlist:AlphaTo(255, .5, 0)
	self:MakePopup()


	function self.buttonlist:Paint(w, h)
		surface.SetMaterial(vignette)
		surface.SetDrawColor(color_black)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	for k, v in pairs(ButtonList) do
		if (v.funcenable) then
			CreateButton(self, v.id, v.name, true, v.func)
		else
			CreateButton(self, v.id, v.name, false)
		end
	end

end


// RemovedEarly Removes the window early to make it look cooler.
function PANEL:RemoveEarly()
	self.RemovedEarly = true
	if (IsValid(self.window)) then
		self.window:Remove()
	end
	surface.PlaySound("hatchet/buttonrollback.mp3")

end

function PANEL:OnRemove()
	if (not self.RemovedEarly) then
		if (IsValid(self.window)) then
			self.window:Remove()
		end
		surface.PlaySound("hatchet/buttonrollback.mp3")
	end

end

function PANEL:Paint(w, h)
end

vgui.Register("HatchetTabMenu", PANEL, "DPanel")

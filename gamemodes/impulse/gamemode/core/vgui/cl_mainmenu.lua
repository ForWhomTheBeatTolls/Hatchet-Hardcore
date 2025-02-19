local PANEL = {}

local function CreateButton(panel, title, todoonclick)
	local button = vgui.Create("DButton", panel)
	button:Dock(TOP)
	button:SetFont("HatchetFont-Menu")
	button:SetText(title)
	button:SetHeight(30)
	button:SetContentAlignment(5)

	local highlightCol = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
	function button:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(color_white)
		end
	end

	function button:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
	end

	function button:DoClick()
		todoonclick()
	end
end

function PANEL:Init()
	if IsValid(impulse.MainMenu) then
		impulse.MainMenu:Remove()
	end
	impulse.MainMenu = self
	impulse.hudEnabled = false

	self.menumusic = nil
	local menumusic = self.menumusic

	menumusic = CreateSound(LocalPlayer(), "music/hl1_song3.mp3")
	menumusic:Play()
	menumusic:ChangePitch(90, 0.1)
	menumusic:ChangeVolume(1)

	self:SetPos(0,0)
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	self:SetPopupStayAtBack(true)

	local panel = self

	self.core = vgui.Create("DPanel", self)
	self.core:SetPos(0, 0)
	self.core:SetSize(ScrW(), ScrH())

	local bodyCol = Color(30, 30, 30, 190)
	function self.core:Paint(w, h)
		local isPreview = GetConVar("impulse_ispreview"):GetBool()
		if isPreview then
			draw.SimpleText("preview build", "Impulse-SpecialFont", 260, 115, Color(255, 242, 0))
		end
	end

	self.buttonlist = vgui.Create("DPanel", self)
	self.buttonlist:SetPos(0, ScrH() * .6)
	self.buttonlist:SetSize(ScrW(), ScrH() * .65)

	function self.buttonlist:Paint(w, h)
		HatchetDrawRect(0, 0, w, h / 2)
	end

	CreateButton(self.buttonlist, "HATCHET: HARDCORE - (TEMP LOGO :( )", function()

		surface.PlaySound("ui/buttonclick.wav")
		surface.PlaySound("common/bugreporter_failed.wav")
	end)

	CreateButton(self.buttonlist, "Play", function()
		local selfPanel = self.buttonlist:GetParent()

		surface.PlaySound("ui/buttonclick.wav")
		if impulse_isNewPlayer == true then
			vgui.Create("impulseCharacterCreator", selfPanel)
		elseif not impulse.MainMenu.popup then
			LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 1, .6)
			impulse.MainMenu:AlphaTo(0, .5)
			timer.Simple(1.5, function()
    			LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 4, 0)
    			selfPanel:Remove()
				impulse.hudEnabled = true
				FORCE_FADESPAWN = true
			end)
			menumusic:FadeOut(2)
			timer.Simple(3, function() menumusic:Stop() end)
		else
			selfPanel:Remove()
			impulse.hudEnabled = true
			menumusic:FadeOut(2)
			timer.Simple(3, function() menumusic:Stop() end)
		end

		CRASHSCREEN_ALLOW = true
	end)

	CreateButton(self.buttonlist, "Settings", function()

		surface.PlaySound("ui/buttonclick.wav")
		vgui.Create("impulseSettings")
	end)

	CreateButton(self.buttonlist, "Achievements", function()

		surface.PlaySound("ui/buttonclick.wav")
		vgui.Create("impulseAchievements")
	end)
	
	CreateButton(self.buttonlist, "Select Species", function()
		surface.PlaySound("ui/buttonclick.wav")

		vgui.Create("HatchetCharacterSelectionScreen")
	end)

	CreateButton(self.buttonlist, "Community", function()
		surface.PlaySound("ui/buttonclick.wav")
		gui.OpenURL(impulse.Config.CommunityURL or "https://www.google.com/")
	end)


	CreateButton(self.buttonlist, "Donate", function()

		surface.PlaySound("ui/buttonclick.wav")
		gui.OpenURL(impulse.Config.DonateURL or "https://www.google.com/")
	end)

	CreateButton(self.buttonlist, "Credits", function()
		if self.popup then return end
		if impulseCredits and IsValid(impulseCredits) then return end

		impulseCredits = vgui.Create("impulseCredits")
		impulseCredits:AlphaTo(255, 2, 1.5)
		mainmenu:AlphaTo(0, 2, 0)
	end)

	CreateButton(self.buttonlist, "Disconnect", function()
		print("Bye. :(")
		LocalPlayer():ConCommand("disconnect")
	end)

	local year = os.date("%Y", os.time())
	local copyrightLabel = vgui.Create("DLabel", self.core)
	copyrightLabel:SetFont("Impulse-Elements14")
	copyrightLabel:SetText("Powered by impulse\nCopyright 2i.games "..year.."\nimpulse version: "..impulse.Version)
	copyrightLabel:SizeToContents()
	copyrightLabel:SetPos(ScrW()-copyrightLabel:GetWide(), ScrH()-copyrightLabel:GetTall()-5)

	-- local schemaLabel = vgui.Create("DLabel", self.core)
	-- schemaLabel:SetFont("Impulse-Elements32")
	-- schemaLabel:SetText(impulse.Config.SchemaName)
	-- --schemaLabel:SetTextColor(Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)) not sure if i like this
	-- schemaLabel:SizeToContents()
	-- schemaLabel:SetPos(100,140)

	-- if schemaLabel:GetWide() > 300 then
	-- 	schemaLabel:SetFont("Impulse-Elements27")
	-- end

	local testMessage = function()
		hook.Run("ShowMenuModalMessage", self)
	end

	timer.Simple(0, function()
		if impulse.MainMenu.popup then return end
		hook.Run("DisplayMenuMessages", self)
		hook.Run("OnMenuFirstLoad", self)

		if REFUND_MSG then
			Derma_Message(REFUND_MSG, "impulse", "Claim Refund")
		end

		if not steamworks.IsSubscribed("3010264401") then -- checks if User subscribed to Impulse: Enhanced framework content.
			Derma_Query("You are not subscribed to the impulse framework content!\nIf you do not subscribe you will experience missing textures and errors.\nAfter subscribing, rejoin the server.",
				"impulse",
				"Subscribe",
				function()
					gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3010264401")
				end,
				"No thanks")
		end
		
		if impulse.GetSetting("perf_mcore") == false then
			Derma_Query("Would you like to enable Multi-core rendering?\nThis will often greatly improve your FPS, however if your computer has a low core count and/or\na small amount of RAM, it can cause crashes and performance problems.",
				"impulse",
				"Enable Multi-core rendering",
				function()
					impulse.SetSetting("perf_mcore", true)
					testMessage()
				end,
				"No thanks")
		else
			testMessage()
		end
	end)
end

local fullRemove = PANEL.Remove 
function PANEL:Remove()
	self:SetVisible(false)
end

local konamiCode = {KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A}
local keyPos = 1
function PANEL:OnKeyCodePressed(key)
	if key == konamiCode[keyPos] then
		if key == KEY_A then
			vgui.Create("impulseMinigame", self)
			keyPos = 1	
		end

		keyPos = keyPos + 1
	end
end

function PANEL:MenuShowScreen()
	self.menumusic = CreateSound(LocalPlayer(), "music/hl1_song3.mp3")
	self.menumusic:Play()
	self.menumusic:ChangePitch(90, 0.1)
	self.menumusic:ChangeVolume(1)
end

function PANEL:OnChildAdded(child)
	if self.AddingMsgs then
		return
	end

	if IsValid(self.openElement) then
		self.openElement:Remove()
	end
	self.openElement = child
end

function PANEL:Paint(w,h)
	-- Derma_DrawBackgroundBlur(self)
end

vgui.Register("impulseMainMenu", PANEL, "DPanel")

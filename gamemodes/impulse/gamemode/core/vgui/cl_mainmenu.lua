local PANEL = {}

function PANEL:Init()
	local w, h = ScrW(), ScrH()
	if IsValid(impulse.MainMenu) then
		impulse.MainMenu:Remove()
	end
	impulse.MainMenu = self
	impulse.hudEnabled = false

	self:SetPos(0,0)
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	self:SetPopupStayAtBack(true)

	local panel = self

	self.core = vgui.Create("DPanel", self)
	self.core:SetPos(0, 0)
	self.core:SetSize(ScrW(), ScrH())

	local menumusic = CreateSound(LocalPlayer(), "music/hl1_song3.mp3")
	menumusic:Play()
	menumusic:ChangePitch(90, 0.1)
	menumusic:ChangeVolume(1)


	local bodyCol = Color(36, 36, 36)
	function self.core:Paint(w, h)
		local gradient = surface.GetTextureID("vgui/gradient-d")
		local gradientUp = surface.GetTextureID("vgui/gradient-u")
		local gradientLeft = surface.GetTextureID("vgui/gradient-l")
		local vignette = Material("impulse/vignette.png")
		local hatcheticon = Material("impulse/hatchet2.png")

		surface.SetDrawColor(bodyCol) -- menu body
		surface.SetTexture(gradientLeft)
		--surface.DrawRect(0,0,300,h)
		surface.DrawTexturedRect(0,0,900,h)
		surface.SetMaterial(vignette)
		surface.SetDrawColor(Color(0, 0, 0))
		surface.DrawTexturedRect(0,0,w,h)

		surface.SetMaterial(hatcheticon)
		surface.SetDrawColor(Color(255,255,255))
		surface.DrawTexturedRect(w/1.34,100, 100,100)

		local isPreview = GetConVar("impulse_ispreview"):GetBool()

		if isPreview then
			draw.SimpleText("preview build", "Impulse-SpecialFont", w/1.25,150, Color(255, 242, 0))
		end
	end

	self.playbutton = vgui.Create("DButton", self.core)
	self.playbutton:SetPos(24,11)
	self.playbutton:SetFont("HatchetFont-Menu48")
	if impulse_isNewPlayer == true then
		self.playbutton:SetText("Create your character")
	else
		self.playbutton:SetText("Play")
	end
	self.playbutton:SizeToContents()

	local highlightCol = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
	local selfPanel = self
	function self.playbutton:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(color_white)
		end
	end

	function self.playbutton:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
	end

	function self.playbutton:DoClick()
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
	end

	local plybutton_width, plybutton_height = self.playbutton:GetTextSize()

	local white_color = Color(255, 255, 255)

	local button = vgui.Create("DButton", self.core)
	button:SetPos(plybutton_width + 740,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Change your species")
	button:SizeToContents()


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
		vgui.Create("HatchetCharacterSelectionScreen")
	end

	local button = vgui.Create("DButton", self.core)
	button:SetPos(plybutton_width + 30,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Settings")
	button:SizeToContents()

	local normalCol = button:GetColor()
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
		surface.PlaySound("ui/buttonclick.wav")
		vgui.Create("impulseSettings", selfPanel)
	end

	local button = vgui.Create("DButton", self.core)
	button:SetPos(plybutton_width + 150,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Achievements")
	button:SizeToContents()

	local normalCol = button:GetColor()
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
		surface.PlaySound("ui/buttonclick.wav")
		vgui.Create("impulseAchievements", selfPanel)
	end

	local button = vgui.Create("DButton", self.core)
	button:SetPos(plybutton_width + 350,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Community")
	button:SizeToContents()

	local normalCol = button:GetColor()
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
		surface.PlaySound("ui/buttonclick.wav")
		gui.OpenURL(impulse.Config.CommunityURL or "www.google.com")
	end

	local button = vgui.Create("DButton", self.core)

	button:SetPos(plybutton_width + 524,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Donate")
	button:SizeToContents()

	local normalCol = button:GetColor()
	local goldCol = Color(218, 165, 32)
	function button:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(goldCol)
		end
	end

	function button:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
	end

	function button:DoClick()
		surface.PlaySound("ui/buttonclick.wav")
		gui.OpenURL(impulse.Config.DonateURL or "www.google.com")
	end

	local button = vgui.Create("DButton", self.core)
	button:SetPos(plybutton_width + 634,22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Credits")
	button:SizeToContents()

	local normalCol = button:GetColor()
	local highlightCol = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
	function button:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(color_white)
		end
	end

	local mainmenu = self
	function button:DoClick()
		if self.popup then return end
		if impulseCredits and IsValid(impulseCredits) then return end
		
		impulseCredits = vgui.Create("impulseCredits")
		impulseCredits:AlphaTo(255, 2, 1.5)
		mainmenu:AlphaTo(0, 2, 0)
	end

	-- function button:Think()
	-- 	if impulse.MainMenu.popup then
	-- 		self:Hide()
	-- 	else
	-- 		self:Show()
	-- 	end
	-- end

	local button = vgui.Create("DButton", self)
	button:SetPos(w/1.2, 22)
	button:SetFont("HatchetFont-Menu32")
	button:SetText("Disconnect")
	button:SizeToContents()

	local normalCol = button:GetColor()
	local highlightCol = Color(240, 0, 0)
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
		print("Bye. :(")
		LocalPlayer():ConCommand("disconnect")
	end

	local button = vgui.Create("DImageButton", self)
	button:SetPos(self:GetWide() - 30 - 53, 10)
	button:SetImage("impulse/icons/social/discord.png")
	button:SetSize(62, 55)

	local normalCol = button:GetColor()
	local highlightCol = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
	function button:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(normalCol)
		end
	end

	function button:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
	end

	function button:DoClick()
		surface.PlaySound("ui/buttonclick.wav")
		gui.OpenURL(impulse.Config.DiscordURL or "www.viniscool.com")
	end

	local year = os.date("%Y", os.time())
	local copyrightLabel = vgui.Create("DLabel", self.core)
	copyrightLabel:SetFont("Impulse-Elements14")
	copyrightLabel:SetText("A Project made by SteveB, Inspired by Roots\nProject Lead: WillMaster, SteveB.\nCreative Lead: Steve B.\nMap Design: Jokey\nLead Development: WillMaster, Steve B.\nJunior Development: Thrumbo\nCommunity Contributors: TehRedd, Jokey, GhostfacedKillah\nPowered by impulse\nCopyright 2i.games "..year.."\nimpulse version: "..impulse.Version)
	copyrightLabel:SizeToContents()
	copyrightLabel:SetPos(ScrW()-copyrightLabel:GetWide(), ScrH()-copyrightLabel:GetTall()-5)

	local schemaLabel = vgui.Create("DLabel", self.core)
	schemaLabel:SetTextColor(Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b))
	schemaLabel:SetFont("HatchetFont-Menu32")
	schemaLabel:SetText("HATCHET: HL2 HARDCORE")
	schemaLabel:SetTextInset(0, 0)
	--schemaLabel:SetTextColor(Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)) not sure if i like this
	schemaLabel:SizeToContents()
	schemaLabel:SetPos(w/1.25,124)

	if schemaLabel:GetWide() > 300 then
		schemaLabel:SetFont("HatchetFont-Menu32")
	end

	--local newsLabel = vgui.Create("DLabel", self.core)
	--newsLabel:SetFont("Impulse-Elements32")
	--newsLabel:SetText("News")
	--newsLabel:SizeToContents()
	--newsLabel:SetPos(self:GetWide()-530, 60)

	local newsfeed = vgui.Create("impulseNewsfeed", self.core)
	newsfeed:SetSize(500,270)
	newsfeed:SetPos(self:GetWide()-530, 100)

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
	local gradient = Material("vgui/gradient_up")
	local bottompart = Color(255, 136, 25)
	local bodycol = Color(0,0,0)

	surface.SetMaterial(gradient)
	surface.SetDrawColor(bodycol)
	surface.DrawTexturedRect(0, 2, w, 80)

	surface.SetDrawColor(bottompart)
	surface.DrawRect(0, 80, w, 2)
end

vgui.Register("impulseMainMenu", PANEL, "DPanel")

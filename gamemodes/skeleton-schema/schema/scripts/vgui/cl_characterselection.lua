local PANEL = {}

function PANEL:Init()

    self:SetSize(ScrW(), ScrH())
    self:Center()
    self:MakePopup()
    self:SetAlpha(0)
    self:AlphaTo(255, .2, 0)
    surface.PlaySound("hatchet/buttonclickrelease.wav")

    local panel = self
    local w = ScrW()
    local h = ScrH()

    local button = vgui.Create("DButton", self)
    button:SetPos(w * .0,900)
    button:SetSize(480,40)
	button:SetFont("Impulse-Elements48")
	button:SetText("Exit")

    function button:Paint(w, h)
    end

	local highlightCol = Color(impulse.Config.MainColour.r, impulse.Config.MainColour.g, impulse.Config.MainColour.b)
    local white = Color(255, 255, 255)
	function button:Paint()
		if self:IsHovered() then
			self:SetColor(highlightCol)
		else
			self:SetColor(white)
		end
	end

	function button:OnCursorEntered()
		surface.PlaySound("ui/buttonrollover.wav")
	end

    if self.invScroll and IsValid(self.invScroll) then
		self.invScroll:Remove()
	end

	self.invScroll = vgui.Create("DScrollPanel", self.tabs)
 	self.invScroll:SetPos(0, 0)

    function button:DoClick()
        panel:Remove()
	end

    -- speciesbox options for future usage: TeamName, TeamBackground, TeamID (So when you click on it it changes your team)

    local Citizenbox = self:Add("HatchetSpeciesBox")
    Citizenbox:SpeciesBox("Citizen", "hatchet/background/species/citizenspecies.png", 1)
    Citizenbox:DockMargin(0, 0, 0, 0)
    Citizenbox:Dock(RIGHT)

    function Citizenbox:OnRemove()
        panel:Remove()
    end

    local VortBox = self:Add("HatchetSpeciesBox")
    VortBox:SpeciesBox("Vortigaunt", "hatchet/background/species/vortigauntspecies.png", 1)
    VortBox:DockMargin(0, 0, 0, 0)
    VortBox:Dock(RIGHT)

    function VortBox:OnRemove()
        panel:Remove()
    end

    local DispatchBox = self:Add("HatchetSpeciesBox")
    DispatchBox:SpeciesBox("Dispatch", "hatchet/background/species/dispatchspecies.png", 6)
    DispatchBox:DockMargin(0, 0, 0, 0)
    DispatchBox:Dock(RIGHT)

    function DispatchBox:OnRemove()
        panel:Remove()
    end

    -- local playerCard = self:Add("impulseScoreboardCard")
    -- playerCard:SetPlayer(LocalPlayer())
    -- playerCard:SetHeight(60)
    -- playerCard:Dock(TOP)
    -- playerCard:DockMargin(0,0,0,0)



end

function PANEL:Paint(w, h)
    local gradient = Material("gui/gradient_up")
    local colr = Color(0, 0, 0, 255)
    surface.SetMaterial(gradient)
    surface.SetDrawColor(colr)
    surface.DrawTexturedRect(0, 0, w, h)

    Derma_DrawBackgroundBlur(self)
end

function PANEL:OnRemove()
    surface.PlaySound("ui/buttonrollover.wav")
end

vgui.Register("HatchetCharacterSelectionScreen", PANEL, "DPanel")
local PANEL = {}

function PANEL:Init()
    local w = ScrW()
    local h = ScrH()
    self:SetSize(480, 480)
    self:Center()
end

local white = Color(255, 255, 255)

function PANEL:SpeciesBox(teamname, backgroundname, teamidselect)
    self.background = backgroundname
    self.cardname = teamname

    local panel = self

    local label = vgui.Create("DLabel", self)
    label:CenterVertical(.04)
    label:CenterHorizontal(.1)
    label:SetFont("Impulse-Elements32-Shadow")
    label:SetText(self.cardname)
    label:SetTextColor(white)
    label:SizeToContents()


    local button = vgui.Create("DButton", self)
    button:SetSize(ScrW(),ScrH())
	button:SetFont("Impulse-Elements48")
	button:SetText("Exit")

    function button:Paint(w, h)
    end

    function button:DoClick()
        self.teamselectionid = teamidselect
        panel:Remove()
        if LocalPlayer():GetZoneName() == "Spawn" or LocalPlayer():Team() == TEAM_DISPATCH then
            net.Start("impulseTeamChange")
            net.WriteUInt(self.teamselectionid, 8)
            net.SendToServer()
        else
            LocalPlayer():Notify("You have to be in spawn to change your species type!")
        end
    end
end

function PANEL:Paint(w, h)

    local background = Material(self.background)
    local vignette = Material("hatchet/overlays/vignette.png")
    local white = Color(255, 255, 255)
    local black = Color(0, 0, 0)

    surface.SetDrawColor(white)
    surface.SetMaterial(background)
    surface.DrawTexturedRect(0, 0, w, h)
    surface.SetDrawColor(black)
    surface.SetMaterial(vignette)
    surface.DrawTexturedRect(0, 0, w, h)
    surface.SetDrawColor(white)
    surface.DrawOutlinedRect(0, 0, w, h, 2)
end

vgui.Register("HatchetSpeciesBox", PANEL, "DPanel")
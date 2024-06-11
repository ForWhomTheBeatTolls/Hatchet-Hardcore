local PANEL = {}

local baseSizeW, baseSizeH = ScrW(), ScrH()

function PANEL:Init()
    self:SetSize(baseSizeW, baseSizeH)
    self:SetAlpha(0)
end

function PANEL:Paint()
    local w, h = ScrW(), ScrH()
    local gradient = Material("vgui/gradient_up")
	surface.SetDrawColor(Color(0, 0, 0))
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0, h / h  + 700,w,h - 700)
end

vgui.Register("HatchetNotify", PANEL, "DPanel")
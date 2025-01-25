local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW()/2, ScrH()/2)
 	self:MoveToFront()
	self:Center()
	self:MakePopup()
	self:SetTitle("Limbs Status")
	self:SetBGColor( Color(200,200,255,255) )
	self:SetFGColor( Color(200,200,255,255) )
	self:SetAlpha(200)
	hatchet_limbhealthmenu = self
	
	local panel = self

	surface.PlaySound("garrysmod/ui_click.wav")

	self:SetMouseInputEnabled(true)

 	local w, h = self:GetSize()

	surface.PlaySound("hatchet/buttonclickrelease.wav")
	
	self.LeftArm = vgui.Create("DButton", self)
	self.LeftArm:SetText("L_ARM: \n"..LocalPlayer():GetNWInt("LArm").."/100")
    self.LeftArm:SetSize(40,160)
	self.LeftArm:SetPos(panel:GetWide() / 2.47, panel:GetTall() / 3.3)
	
	self.RightArm = vgui.Create("DButton", self)
	self.RightArm:SetText("R_ARM: \n"..LocalPlayer():GetNWInt("RArm").."/100")
    self.RightArm:SetSize(40,160)
	self.RightArm:SetPos(panel:GetWide() / 1.81, panel:GetTall() / 3.3)
	
	self.LeftLeg = vgui.Create("DButton", self)
	self.LeftLeg:SetText("L_LEG: \n"..LocalPlayer():GetNWInt("LLeg").."/100")
    self.LeftLeg:SetSize(40,160)
	self.LeftLeg:SetPos(panel:GetWide() / 2.2, panel:GetTall() / 1.6)
	
	self.RightLeg = vgui.Create("DButton", self)
	self.RightLeg:SetText("R_LEG: \n"..LocalPlayer():GetNWInt("RLeg").."/100")
    self.RightLeg:SetSize(40,160)
	self.RightLeg:SetPos(panel:GetWide() / 1.98, panel:GetTall() / 1.6)
	
	self.LeftArm.OnCursorEntered = function()
        surface.PlaySound("ui/buttonrollover.wav")
    end
	
	self.RightArm.OnCursorEntered = function()
        surface.PlaySound("ui/buttonrollover.wav")
    end
	
	self.LeftArm.DoClick = function()
		surface.PlaySound("hatchet/buttonclickrelease.wav")
		net.Start("PlayerHealSelfLimbBegin")
		net.WriteString("LArm")
		net.WritePlayer(LocalPlayer())
		net.SendToServer()
	end
   
	self.RightArm.DoClick = function()
		surface.PlaySound("hatchet/buttonclickrelease.wav")
		net.Start("PlayerHealSelfLimbBegin")
		net.WriteString("RArm")
		net.WritePlayer(LocalPlayer())
		net.SendToServer()
	end
	
	self.LeftLeg.DoClick = function()
		surface.PlaySound("hatchet/buttonclickrelease.wav")
		net.Start("PlayerHealSelfLimbBegin")
		net.WriteString("LLeg")
		net.WritePlayer(LocalPlayer())
		net.SendToServer()
	end
   
	self.RightLeg.DoClick = function()
		surface.PlaySound("hatchet/buttonclickrelease.wav")
		net.Start("PlayerHealSelfLimbBegin")
		net.WriteString("RLeg")
		net.WritePlayer(LocalPlayer())
		net.SendToServer()
	end
	
end

function PANEL:OnRemove()
	surface.PlaySound("ui/buttonrollover.wav")
end

function PANEL:Paint(w, h)
	
	local panel = self
	
	draw.RoundedBox(0, 0, 0, w, h, Color(48, 48, 48))

	local figure_col = Color(255, 255, 255, 40)
	local injured_figure_col = Color(170, 41, 41)
	local body = Material("hatchet/limbs/body.png")

	local figure_larm = Material("hatchet/limbs/larm.png")
	local figure_rarm = Material("hatchet/limbs/rarm.png")
	local figure_lleg = Material("hatchet/limbs/lleg.png")
	local figure_rleg = Material("hatchet/limbs/rleg.png")
	local figure_head = Material("hatchet/limbs/head.png")
	local figure_chest = Material("hatchet/limbs/chest.png")
	
	local centerh = panel:GetTall() / 6
	local centerw = panel:GetWide() / 2.57

	surface.SetDrawColor(figure_col)
	surface.SetMaterial(body)
	surface.DrawTexturedRect(centerw, centerh, 210, 400)
	
	self.LeftArm:SetText("L_ARM: \n"..LocalPlayer():GetNWInt("LArm").."/100")
	self.RightArm:SetText("R_ARM: \n"..LocalPlayer():GetNWInt("RArm").."/100")
	self.LeftLeg:SetText("L_LEG: \n"..LocalPlayer():GetNWInt("LLeg").."/100")
	self.RightLeg:SetText("R_LEG: \n"..LocalPlayer():GetNWInt("RLeg").."/100")
	
	
	if LocalPlayer():GetNWBool("RLegCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_rleg)
		surface.DrawTexturedRect(centerw, centerh, 210, 400)
	end

	if LocalPlayer():GetNWBool("LLegCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_lleg)
		surface.DrawTexturedRect(centerw, centerh, 210, 400)
	end

	if LocalPlayer():GetNWBool("RArmCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_rarm)
		surface.DrawTexturedRect(centerw, centerh, 210, 400)
	end

	if LocalPlayer():GetNWBool("LArmCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_larm)
		surface.DrawTexturedRect(centerw, centerh, 210, 400)
	end
end


vgui.Register("HatchetLimbsSystem", PANEL, "DFrame")

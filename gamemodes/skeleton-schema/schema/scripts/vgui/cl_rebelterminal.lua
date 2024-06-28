local PANEL = {}

function PANEL:Init()
	self:SetSize(350, 450)
	self:SetPos(ScrW() / 2, ScrH() / 2)
	self:Center()
	self:SetBGColor( Color(200,200,255,255) )
	self:SetFGColor( Color(200,200,255,255) )
	self:SetTitle("AMPUTATION TERMINAL")
	self:MakePopup()
	
	LocalPlayer():EmitSound("buttons/combine_button7.wav", 100, 100, 0.33)

	local panel = self


	self.titleText = vgui.Create("DLabel", self)
	self.titleText:SetPos(50,50)
	self.titleText:SetSize(150,25)
	self.titleText:SetText("ENTER CID.INFO.NAME")

	self.textBox = vgui.Create("DTextEntry", self)
	self.textBox:SetTextColor( Color(100,100,200,255) )
	self.textBox:SetPlaceholderColor( Color(128, 128, 255, 255) )
	self.textBox:SetPos(50,75)
	self.textBox:SetSize(250,20)
	self.textBox:SetPaintBackground(true)

	self.descText = vgui.Create("RichText", self)
	self.descText:SetPos(50,125)
	self.descText:SetSize(250,200)
	self.descText:AppendText("// ADMINISTRATIVE MODE ENGAGED // \n // DATABASE CLEANSING // \n // INPUT CITIZEN NAME //	\n \n     +++++\n           +++      \n            =++        \n         +=.++       \n        ++++++       \n       +++  +++      \n     ++++    +++     \n    ++++     ++++++  \n +++++        ++++++ \n ")


	self.nextButton = vgui.Create("DButton", self)
	self.nextButton:SetPos(75,350)
	self.nextButton:SetSize(200,25)
	self.nextButton:SetText("SEND QUERY")
	self.nextButton:SetEnabled(false)

	

	self.textBox.OnLoseFocus = function()
		if not (self.textBox:GetText() != nil and self.textBox:GetText() != "") then

		end

		if (self.textBox:GetText():upper() == LocalPlayer():Nick():upper()) then
			self.nextButton:SetEnabled(true)
			LocalPlayer():EmitSound("buttons/combine_button5.wav", 100, math.random(95,100), 0.2)
		end
	end

	self.textBox.OnKeyCodeTyped = function()
		LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav", 100, math.random(95,100), 0.2)
	end

	self.nextButton.DoClick = function()
		if ( self.textBox:GetText():upper() != LocalPlayer():Nick():upper() ) then
			surface.PlaySound("buttons/combine_button_locked.wav")
			LocalPlayer():Notify("INVALID CREDENTIALS.")
		  return
		end

			net.Start("HatchetBecomeRebelEnd")
			net.WritePlayer(LocalPlayer())
			net.WriteUInt(LocalPlayer():Team(), 4)
			net.SendToServer()
			LocalPlayer():EmitSound("buttons/combine_button1.wav", 100, math.random(95,100), 0.33)
		self:Remove()
	end

end
vgui.Register("hatchetRebelTerminal", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	self:SetSize(240, 150)
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:MakePopup()

	local bankBalance = LocalPlayer():GetSyncVar(SYNC_BANKMONEY, 0)
	local prefix = impulse.Config.CurrencyPrefix
	local parent = self

	local exit = vgui.Create("DButton", self)
	exit:SetSize(16, 16)
    exit:SetPos(215, 8)
	exit:SetText("X")
    exit.DoClick = function()
        self:Close()
    end

	self.balance = vgui.Create("DLabel", self)
	self.balance:SetText("Balance: "..prefix..bankBalance)
	self.balance:SetFont("Impulse-Elements18")
	self.balance:SizeToContents()
	self.balance:SetPos(124 - (self.balance:GetWide()/2), 40)

	self.withdrawInput = vgui.Create("DTextEntry", self)
	self.withdrawInput:SetPos(10, 70)
	self.withdrawInput:SetSize(162, 20)
	self.withdrawInput:SetNumeric(true)

	self.withdrawButton = vgui.Create("DButton", self)
	self.withdrawButton:SetText("Withdraw")
	self.withdrawButton:SetPos(176, 70)
	self.withdrawButton:SetSize(55, 20)
	function self.withdrawButton:DoClick()
		if parent.withdrawInput:GetValue() == "" then return true end
		local num = tonumber(parent.withdrawInput:GetValue())

		if not num then
			return
		end

		net.Start("impulseATMWithdraw")
		net.WriteUInt(math.floor(num), 32)
		net.SendToServer()
	end
	function self.withdrawButton:Paint(w, h)
        local gray = Color(37, 37, 37)
        local blue = Color(29, 77, 209)
        surface.SetDrawColor(gray)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(blue)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end

	self.depositInput = vgui.Create("DTextEntry", self)
	self.depositInput:SetPos(10, 100)
	self.depositInput:SetSize(162, 20)
	self.depositInput:SetNumeric(true)

	self.despoitButton = vgui.Create("DButton", self)
	self.despoitButton:SetText("Deposit")
	self.despoitButton:SetPos(176, 100)
	self.despoitButton:SetSize(55, 20)
	function self.despoitButton:DoClick()
		if parent.depositInput:GetValue() == "" then return true end
		local num = tonumber(parent.depositInput:GetValue())

		if not num then
			return
		end

		net.Start("impulseATMDeposit")
		net.WriteUInt(math.floor(num), 32)
		net.SendToServer()
	end

	function self.despoitButton:Paint(w, h)
        local gray = Color(37, 37, 37)
        local blue = Color(29, 77, 209)
        surface.SetDrawColor(gray)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(blue)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end
end

function PANEL:SetBalance(m)
	self.balance:SetText("Balance: "..impulse.Config.CurrencyPrefix..m)
	self.balance:SizeToContents()
	self.balance:SetPos(124 - (self.balance:GetWide()/2), 40)
end

function PANEL:Think()
	local curMoney = LocalPlayer():GetSyncVar(SYNC_BANKMONEY, 0)
	self.lastMoney = self.lastMoney or curMoney

	if self.lastMoney != curMoney then
		self:SetBalance(curMoney)
	end
end

function PANEL:Paint(w, h)
    local static = Material("effects/tvscreen_noise002a")
    local black = Color(0, 0, 0)
    local white = Color(255, 255, 255)
    local blue = Color(20, 112, 218)
    local gray = Color(37, 37, 37)

    surface.SetDrawColor(black)

    surface.SetMaterial(static)
    surface.DrawRect(0, 0, w, h)
    surface.DrawTexturedRect(0, 0, w, h)


    surface.SetDrawColor(gray)
    surface.DrawRect(0, 0, w, 26)

    surface.SetFont("Trebuchet18")
    surface.SetTextPos(10, 7    )
    surface.SetTextColor(white)
    surface.DrawText("CITIZEN-TERMINAL: ATM")

    surface.SetDrawColor(blue)
    surface.DrawOutlinedRect(0, 0, w, h, 5)
    surface.SetDrawColor(gray)
    surface.DrawOutlinedRect(0, 0, w, h, 3)

end


vgui.Register("impulseATMMenu", PANEL, "DFrame")

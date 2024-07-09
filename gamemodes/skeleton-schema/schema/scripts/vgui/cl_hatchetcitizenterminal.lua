local PANEL = {}

function PANEL:Init()
self:SetSize(760, 120)
self:Center()
self:SetTitle("")
self:MakePopup()
self:ShowCloseButton(false)
surface.PlaySound( "ambient/machines/keyboard" .. math.random(1, 7) .. "_clicks.wav")

    local exit = vgui.Create("DImageButton", self)
    exit:SetSize(16, 16)
    exit:SetPos(736, 8)
    exit:SetImage("gui/close_32")
    exit:SetColor(Color(202, 35, 35))
    exit.DoClick = function()
        self:Close()
    end


    local btn = vgui.Create("DButton", self)
    btn:SetPos(24, 42)
    btn:SetSize(self:GetSize() - 45, 24)
    btn:SetFont("Trebuchet18")
    btn:SetText("ATM")
    btn.DoClick = function()
        surface.PlaySound("buttons/blip1.wav")

        vgui.Create("impulseATMMenu")
    end

    btn.OnCursorEntered = function()
        surface.PlaySound("hatchet/buttonrollover.wav")
    end

    function btn:Paint(w, h)
        local gray = Color(37, 37, 37)
        local blue = Color(29, 77, 209)
        surface.SetDrawColor(gray)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(blue)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end

    local btn1 = vgui.Create("DButton", self)
    btn1:SetPos(24, 42 * 1.75)
    btn1:SetSize(self:GetSize() - 45, 24)
    btn1:SetFont("Trebuchet18")
    btn1:SetText("Information")
    btn1.DoClick = function()
        surface.PlaySound("buttons/blip1.wav")

        local dframe = vgui.Create("DFrame")
        dframe:SetSize(840, 540)
        dframe:Center()
        dframe:SetTitle("")
        dframe:MakePopup()
        dframe:ShowCloseButton(false)

        local exitterminal = vgui.Create("DImageButton", dframe)
        exitterminal:SetSize(16, 16)
        exitterminal:SetPos(816, 8)
        exitterminal:SetImage("gui/close_32")
        exitterminal:SetColor(Color(202, 35, 35))
        exitterminal.DoClick = function()
            dframe:Close()
        end

        local model = vgui.Create("DModelPanel", dframe)
        model:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
        model:SetSize(200, 540)
        model:SetPos(14, 14)
        model:SetMouseInputEnabled(false)
        model:SetFOV(30)

        function model:PaintOver(w, h)
            local green = Color(17, 181, 17)

            surface.SetDrawColor(green)
            surface.DrawOutlinedRect(0, 60, w, h - 100, 2)
        end

        function dframe:Paint(w, h)
            local static = Material("effects/tvscreen_noise002a")
            local black = Color(0, 0, 0)
            local red = Color(161, 23, 23)
            local white = Color(255, 255, 255)
            local blue = Color(20, 112, 218)
            local gray = Color(37, 37, 37)
            surface.SetDrawColor(black)

            surface.SetMaterial(static)
            surface.DrawRect(0, 0, w, h)

            surface.DrawTexturedRect(0, 0, w, h)


            surface.SetDrawColor(red)
            surface.DrawRect(0, 0, w, 26)

            surface.SetFont("Trebuchet18")
            surface.SetTextPos(10, 7    )
            surface.SetTextColor(white)
            surface.DrawText("CITIZEN-TERMINAL: CITIZEN INFORMATION")

            surface.SetDrawColor(blue)
            surface.DrawOutlinedRect(0, 0, w, h, 5)
            surface.SetDrawColor(gray)
            surface.DrawOutlinedRect(0, 0, w, h, 3)

            surface.SetFont("BudgetLabel")
            surface.SetTextPos(220, 74)
            surface.DrawText("Name: " .. LocalPlayer():Name() )
            surface.SetTextPos(220, 74 * 1.2)
            surface.DrawText("Networth: " .. LocalPlayer():GetSyncVar(SYNC_BANKMONEY) )

        end
    end

    btn1.OnCursorEntered = function()
        surface.PlaySound("hatchet/buttonrollover.wav")
    end

    function btn1:Paint(w, h)
        local gray = Color(37, 37, 37)
        local blue = Color(29, 77, 209)
        surface.SetDrawColor(gray)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(blue)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end
end

function PANEL:Paint(w, h)

    if impulse.GetSetting("perf_blur") == true then
        Derma_DrawBackgroundBlur(self)
    end

    local static = Material("effects/tvscreen_noise002a")
    local black = Color(0, 0, 0)
    local red = Color(161, 23, 23)
    local white = Color(255, 255, 255)
    local blue = Color(20, 112, 218)
    local gray = Color(37, 37, 37)

    surface.SetDrawColor(black)

    surface.SetMaterial(static)
    surface.DrawRect(0, 0, w, h)
    surface.DrawTexturedRect(0, 0, w, h)


    surface.SetDrawColor(red)
    surface.DrawRect(0, 0, w, 26)

    surface.SetFont("Trebuchet18")
    surface.SetTextPos(10, 7    )
    surface.SetTextColor(white)
    surface.DrawText("CITIZEN-TERMINAL: HOME PAGE")

    surface.SetDrawColor(blue)
    surface.DrawOutlinedRect(0, 0, w, h, 5)
    surface.SetDrawColor(gray)
    surface.DrawOutlinedRect(0, 0, w, h, 3)

end

vgui.Register("HatcherCitizenTerminalMenu", PANEL, "DFrame")
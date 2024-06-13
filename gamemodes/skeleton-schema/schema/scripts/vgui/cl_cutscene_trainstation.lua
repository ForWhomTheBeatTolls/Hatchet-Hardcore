local PANEL = {}

local text = "Press the ''Continue'' Button to\nProceed to the next slide."
local mat1 = Material("gamepadui/chapter14")

function PANEL:Init()

    local counter = counter or 0

    Music = CreateSound(LocalPlayer(), "music/hl2_song30.mp3")
    Trailer = CreateSound(LocalPlayer(), "music/hl1_song3.mp3")
    local SoundClick = Sound("ui/buttonrollover.wav")

	if impulse.TrainstationCutscene and IsValid(impulse.TrainstationCutscene) then
		impulse.TrainstationCutscene:Remove()
	end

    impulse.TrainstationCutscene = self
    impulse.hudEnabled = false

    self:SetSize(ScrW(), ScrH())
    self:Center()
    self:MakePopup()
    self:SetAlpha(0)

    counter = 0

    self:AlphaTo(255, 2, 2)

    local panel = self

    self.doneBtn = vgui.Create("DButton", self)
    self.doneBtn:SetFont("Impulse-SpecialFont")
    self.doneBtn:SetPos(ScrW() * .4,ScrH() * .8)
    self.doneBtn:SetSize(ScrW() * .2, 100)
    self.doneBtn:SetText("Continue")
    self.doneBtn:SetDisabled(false)

    function self.doneBtn:Paint(w, h)
        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)
    end

    function self.doneBtn:DoClick()

        Music:PlayEx(1, 60)
        counter = counter + 1
        if counter == 1 then
            surface.PlaySound(SoundClick)
            text = "The combine invaded earth and took over within 3 hours.\nYou find yourself in a trainstation unsure still on where fate will bring you.\nYou see a figure named Dr.Breen in a giant television of sort giving speeches\nIt gives you chills, but its probably better to ignore it."
            mat1 = Material("gamepadui/chapter1")
        elseif counter == 2 then
            surface.PlaySound(SoundClick)
            text = "Caption1"
            mat1 = Material("gamepadui/chapter2")
        elseif counter == 3 then
            surface.PlaySound(SoundClick)
            text = "Caption2"
            mat1 = Material("gamepadui/chapter3")
        elseif counter == 4 then
            surface.PlaySound(SoundClick)
            text = "Caption3"
            mat1 = Material("gamepadui/chapter4")
        elseif counter == 5 then
            surface.PlaySound(SoundClick)
            panel:AlphaTo(0, 4, 0)
            timer.Simple(5, function()
                panel:Remove()
            end)

            LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 7, 11)
            timer.Create("StupidFuckingShitCode_"..LocalPlayer():SteamID(), 18, 1, function()
                impulse.hudEnabled = true
            end)
        end

        self:InvalidateLayout()
    end
end

function PANEL:Paint(w, h)
    local vignette = Material("impulse/vignette.png")
    local Gradient = Material("vgui/gradient-d")

    surface.SetMaterial(mat1)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
    surface.SetDrawColor(0, 0, 0)
    surface.SetMaterial(vignette)
    surface.DrawTexturedRect(0, 0, w, h)
    surface.SetDrawColor(0, 0, 0)
    surface.SetMaterial(Gradient)
    surface.DrawTexturedRect(0, 0, w, h)
    draw.DrawText(text, "Impulse-SpecialFont", w * .5, h * .5, Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)
end

function PANEL:OnRemove()
    Music:FadeOut(4)
    timer.Simple(4, function() if IsValid(LocalPlayer()) then LocalPlayer():ConCommand("snd_restart") end end)
    timer.Simple(4.6, function() if IsValid(LocalPlayer()) then Trailer:Play() end end)
    timer.Simple(14, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("Welcome to Hatchet: HL2 Hardcore! We are in a development stage, so expect Bugs or exploits.") end end)
    timer.Simple(17, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("To get up in date with Hatchet's development, Join our discord!") end end)
    counter = -1
end

vgui.Register("HatchetCutsceneTrainstation", PANEL, "DPanel")

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
	
	local cities = {
	"City 8",
	"City 24",
	"City 27",
	"City 13",
	"City 11",
	"City 15",
	"City 16",
	"City 12",
	"City 14"
	}
	local randomcity = table.Random(cities)
    function self.doneBtn:DoClick()

        Music:PlayEx(1, 60)
        counter = counter + 1
        if counter == 1 then
            surface.PlaySound(SoundClick)
            text = "The Combine invaded earth and dissolved all governments within 7 hours.\nYou find yourself in a trainstation still unsure on where fate will bring you.\nOn one of the combine video monitors, a man referring to himself as Dr. Breen is giving a speech.\nHe speaks in a welcoming tone to the newly arrived citizens exiting the trainstation."
            mat1 = Material("gamepadui/chapter1")
        elseif counter == 2 then
            surface.PlaySound(SoundClick)
            text = "You have entered City 17, after being relocated from "..randomcity..".\n You are within the heart of the combine occupation of Earth.\n At the center of the city lies the center of the occupation:\n the Citadel, towering over the clouds."
            mat1 = Material("gamepadui/chapter2")
        elseif counter == 3 then
            surface.PlaySound(SoundClick)
            text = "The city is heavily combine controlled.\n Any form of resistance is typically met with execution.\n The Combine forces are controlled by an entity known as ''Overwatch''."
            mat1 = Material("gamepadui/chapter3")
        elseif counter == 4 then
            surface.PlaySound(SoundClick)
            text = "Surviving and living are not the same.\n You can choose to scrape by, surviving under the Combine,\n living luxuriously with the Combine,\n or dying slowly against the Combine.\n The choice is yours. Nothing good ever comes easy."
            mat1 = Material("gamepadui/chapter4")
        elseif counter == 5 then
            surface.PlaySound(SoundClick)
			self:SetText(" ")
			self:SetDisabled(true)
			mat1 = Material("black_outline")
			timer.Simple(2, function()
			panel:AlphaTo(0, 2, 0)
			end)
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

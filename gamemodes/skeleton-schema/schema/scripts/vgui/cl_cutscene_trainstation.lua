local PANEL = {}

local text = "Press the ''Continue'' Button to\nProceed to the next slide."
local mat1 = Material("gamepadui/chapter14")

function PANEL:Init()

    local counter = counter or 0

    Music = CreateSound(LocalPlayer(), "music/hl2_song30.mp3")
    Trailer = CreateSound(LocalPlayer(), "music/hl1_song3.mp3")

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


    // these need grammar fixes, cant bother right now
    local part1 = {
        "I've departed from City 8 after a mass evacuation due to \n an infestation of Xenian life forms.",
        "I've departed from City 34 following a massive series of antlion attacks from the coast. \n I've managed to gain tokens from working as \n an Industrial labourer during my stay in City 34. The extra money could prove helpful.",
        "I've departed from City 11 after being forced out of the city \n due to a lack of workers in the city. \n I should probably look into how I can get a job.",
        "I've departed from Industrial Sector 6 after all the citizens have been forced to move out \n due to a demolition of the city's housing blocks. \n The place is now a combine manufacturing plant, spanning a few miles. "
    }
	
    randompart1 = table.Random(part1)
    function self.doneBtn:DoClick()

        Music:PlayEx(1, 60)
        counter = counter + 1
        if counter == 1 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Hello, my name is "..LocalPlayer():Name()..", and I've just arrived at City 17. \n"..randompart1.."''"
            mat1 = Material("hatchet/background/trainstation_1.png")
        elseif counter == 2 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''I've heard a few things about City 17, one of which is the friendly community there, \n the cheap shops, and the apartment housing blocks.''"
            mat1 = Material("hatchet/background/trainstation_2.png")
        elseif counter == 3 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Even though City 17 is notorious for having frequent combine raids, \n I should be fine so long as I don't get involved in shady business.''"
            mat1 = Material("hatchet/background/trainstation_3.png")
        elseif counter == 4 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Im not sure what to do in this city, I don't know \n if I should be scared or... Excited, with the path I'm headed down. \n Here's hoping for the best...''"
            mat1 = Material("hatchet/background/trainstation_4.png")
        elseif counter == 5 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
			self:SetDisabled(true)
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
    timer.Simple(4.1, function() if IsValid(LocalPlayer()) then LocalPlayer():ConCommand("snd_restart") end end)
    timer.Simple(4.6, function() if IsValid(LocalPlayer()) then Trailer:Play() end end)
    timer.Simple(14, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("Welcome to Hatchet: HL2 Hardcore! We are in a development stage, so expect bugs or exploits.") end end)
	timer.Simple(17, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("Reporting bugs and exploits is highly recommended, and may even get you ingame rewards.") end end)
    timer.Simple(21, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("To get up to date with Hatchet's development, Join our discord!") end end)
    counter = -1
end

vgui.Register("HatchetCutsceneTrainstation", PANEL, "DPanel")

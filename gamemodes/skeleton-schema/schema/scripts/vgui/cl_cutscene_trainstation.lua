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
        "I've departed from City 8 after an Mass-City evacuation ordered by \n The Civil Protection Officers there after there has been \n a Xen Infestation Outbreak from a Laboratory",
        "I've departed from City 34 after saving up on tokens from working on \n Workshifts and Rations, Even though there was a crisis there",
        "I've departed from city 11 after moving out due to \n getting bored from the city ghost-town activity",
        "I've departed from Industrial 6 after all the citizens have been told to move out \n due to a project that fixes and improves the City's Structure and Security"
    }
	
    randompart1 = table.Random(part1)
    function self.doneBtn:DoClick()

        Music:PlayEx(1, 60)
        counter = counter + 1
        if counter == 1 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Hi, my name is "..LocalPlayer():Name()..", and I've moved to City17 Today. \n"..randompart1..".''"
            mat1 = Material("hatchet/background/trainstation_1.png")
        elseif counter == 2 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''I've heard a few things about City 17, One if which is the friendly community there, \n the cheap shops, and the apartment housing blocks.''"
            mat1 = Material("hatchet/background/trainstation_2.png")
        elseif counter == 3 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Even though City 17 is notorious for having ALOT of rebel activity, \n I think you're fine if you dont intervene with their businesses by like, Snitching and stuff.''"
            mat1 = Material("hatchet/background/trainstation_3.png")
        elseif counter == 4 then
            surface.PlaySound(Sound("ui/buttonrollover.wav"))
            text = "''Im not sure what to do in this new City, I dont know \n if i should be scared or.. Excited with the path im going for... \n i hope It's not going to be that bad.''"
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
    timer.Simple(14, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("Welcome to Hatchet: HL2 Hardcore! We are in a development stage, so expect Bugs or exploits.") end end)
    timer.Simple(17, function() if IsValid(LocalPlayer()) then LocalPlayer():Notify("To get up in date with Hatchet's development, Join our discord!") end end)
    counter = -1
end

vgui.Register("HatchetCutsceneTrainstation", PANEL, "DPanel")

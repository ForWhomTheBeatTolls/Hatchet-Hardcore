local PANEL = {}

impulse.PuzzleWorkforce1 = impulse.PuzzleWorkforce1 or nil

function PANEL:Init()

	// Looking to steal this clientside code?
	// dont be like Kazootoa :-)

	if impulse.PuzzleWorkforce1 and IsValid(impulse.PuzzleWorkforce1) then
		impulse.PuzzleWorkforce1:Remove()
	end

	impulse.PuzzleWorkforce1 = self
	impulse.hudEnabled = true


	self:Center()
	self:SetPos(340, 250)
	self:SetSize(1200, 140)
	self:SetTitle("Minigame")
	self:MakePopup()
end

function PANEL:Paint(w, h)

	local barposheight = 24

	draw.RoundedBox(0, 0, 0, w, h, Color(48, 48, 48))



	// point box's

	surface.SetDrawColor(255, 94, 0)
	surface.DrawRect(310, barposheight, 600, 100)

	surface.SetDrawColor(255, 217, 0)
	surface.DrawRect(390, barposheight, 450, 100)

	surface.SetDrawColor(31, 117, 247)
	surface.DrawRect(490, barposheight, 240, 100)

	surface.SetDrawColor(26, 88, 6)
	surface.DrawRect(555, barposheight, 110, 100)

	//line

	local speed = 0.1
	local range = 1
	local offset = range * math.sin(CurTime() * speed)
	local animation = Lerp(0, 50, 555)


	surface.SetDrawColor(255, 0, 0)
	surface.DrawRect(w * offset, barposheight, 6, 100)

	// base
	
	surface.SetDrawColor(0, 0, 0)
	surface.DrawOutlinedRect(-4, barposheight, w * 2, 100, 2)

	//draw.RoundedBox(2, 0, 0, w, h, Color(219, 214, 135))
	//draw.RoundedBox(1, 0, 0, w, h - 574, Color(0, 4, 255))
end

vgui.Register("impulseWorkforcePuzzle1", PANEL, "DFrame")
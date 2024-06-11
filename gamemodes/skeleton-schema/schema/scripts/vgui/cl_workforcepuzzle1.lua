local PANEL = {}

impulse.PuzzleWorkforce1 = impulse.PuzzleWorkforce1 or nil

local success
local nextclickdecay = CurTime() + 5
local endtime
function PANEL:Init()

	// Looking to steal this clientside code? It would have been munch simpler to ask. FUCK YOU!
	// dont be like Kazotoa :-)

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
	
	pzlwrkfc1_clickometer = vgui.Create( "DShape", self )
	pzlwrkfc1_clickometer:SetType( "Rect" ) -- This is the only type it can be
	pzlwrkfc1_clickometer:SetPos( 0, 24 ) 
	pzlwrkfc1_clickometer:SetColor( Color(255, 165, 0, 255) )
	pzlwrkfc1_starttime = CurTime()
	
end

local x = 0
function PANEL:Paint(w, h)

	local barposheight = 24

	draw.RoundedBox(0, 0, 0, w, h, Color(48, 48, 48))



	// clickometer 
	
	pzlwrkfc1_clickometer:SetSize( x, 100 )


	// base

	surface.SetDrawColor(0, 0, 0)
	surface.DrawOutlinedRect(-4, barposheight, w * 2, 100, 2)

	//draw.RoundedBox(2, 0, 0, w, h, Color(219, 214, 135))
	//draw.RoundedBox(1, 0, 0, w, h - 574, Color(0, 4, 255))
end

local increment = 32
local clickamount = 0
function PANEL:OnMousePressed(MOUSE_LEFT)
	if x < 1200 then
		x = x + increment
		clickamount = clickamount + 1
		nextclickdecay = CurTime() + 1
		--pzlwrkfc1_clickometer:SetSize( x, 100 )
		print(x)
		print(clickamount)
	else
		success = true
		print(success)
		LocalPlayer():Notify("You did it! CPS: "..math.Truncate(clickamount / (CurTime() - pzlwrkfc1_starttime), 1))
		nextclickdecay = CurTime() + 1
		clickamount = 0
		self:Close()
	end
end

function PANEL:Think()
	pzlwrkfc1_clickometer:SetSize( x, 100 )
	if nextclickdecay != nil and nextclickdecay < CurTime() then
		--clickamount = clickamount - 1
		x = x - increment
		--pzlwrkfc1_clickometer:SetSize( x, 100 )
		nextclickdecay = CurTime() + 1.5
		
		if x < 0 then
			nextclickdecay = nil
			x = 0
			LocalPlayer():Notify("You have failed.")
			success = false
			print(success)
			self:Close()
		end
		
	end
end

function PANEL:OnRemove()
	if success == true then
		nextclickdecay = nil
		x = 0
	else
		LocalPlayer():Notify("You have failed.")
		success = false
	end
end










vgui.Register("impulseWorkforcePuzzle1", PANEL, "DFrame")

local PANEL = {}

local baseSizeW, baseSizeH = 300, 20

function PANEL:Init()
	self.message = markup.Parse("")
	self:SetSize(baseSizeW, baseSizeH)
	self.startTime = CurTime()
	self.endTime = CurTime() + 7.5
	self.bordercol = impulse.Config.MainColour
	self.notifsound = "hatchet/hint.wav"
end

function PANEL:SetPanelSettings(col, snd)
	self.bordercol = col
	self.notifsound = snd

	surface.PlaySound(self.notifsound)
end

function PANEL:SetMessage(...)
	-- Encode message into markup
	local msg = "<font=Impulse-Elements18>"

	for k, v in ipairs({...}) do
		if type(v) == "table" then
			msg = msg.."<color="..v.r..","..v.g..","..v.b..">"
		elseif type(v) == "Player" then
			local col = team.GetColor(v:Team())
			msg= msg.."<color="..col.r..","..col.g..","..col.b..">"..tostring(v:Name()):gsub("<", "&lt;"):gsub(">", "&gt;").."</color>"
		else
			msg = msg..tostring(v):gsub("<", "&lt;"):gsub(">", "&gt;")
		end
	end
	msg = msg.."</font>"

	-- parse
	self.message = markup.Parse(msg, baseSizeW-20)

	-- set frame position and height to suit the markup
	local shiftHeight = self.message:GetHeight()
	self:SetHeight(shiftHeight+baseSizeH)
	surface.PlaySound(self.notifsound)

end

local gradient = Material("gui/gradient_up")
local gradient2 = Material("vgui/gradient-r")
local darkCol = Color(0, 0, 0, 227)
local lightCol = Color(0,0,0,208)
local hudBlackGrad = Color(40,40,40,120)
local lifetime = 10

function PANEL:Paint(w,h)
	-- draw frame
	impulse.blur(self, 10, 20, 255)
	surface.SetDrawColor(darkCol)
	surface.DrawRect(0,0,w,h)
	surface.SetDrawColor(darkCol)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0,0,w,h)

	-- draw message
	self.message:Draw(10,10, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	-- draw timebar
	local w2 = math.TimeFraction(self.startTime, self.endTime, CurTime()) * w
	surface.SetDrawColor(self.bordercol)
	surface.DrawRect(w2, h-2, w - w2, 2)
	//surface.SetDrawColor(self.bordercol)
	surface.DrawRect(285, 0, 20, h)
	surface.SetDrawColor(lightCol)
	surface.SetMaterial(gradient2)
	surface.DrawTexturedRect(265, 0, 40, h)
end

vgui.Register("impulseNotify", PANEL, "DPanel")

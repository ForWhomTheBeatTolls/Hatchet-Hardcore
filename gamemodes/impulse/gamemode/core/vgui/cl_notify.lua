local PANEL = {}

local baseSizeW, baseSizeH = 500, 14

function PANEL:Init()
	self.message = markup.Parse("")
	self:SetSize(baseSizeW, baseSizeH)
	self.startTime = CurTime()
	self.endTime = CurTime() + 7.5

	self.colnotif = impulse.Config.MainColour
	self.soundnotif = "hatchet/hint.wav"
end

function PANEL:SetPanelSettings(col, snd)
	self.colnotif = col
	self.soundnotif = snd

	surface.PlaySound(self.soundnotif)
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
	surface.PlaySound(self.soundnotif)
end

local gradient = Material("vgui/gradient-d")
local gradient2 = Material("vgui/gradient-r")
local darkCol = Color(0, 0, 0, 190)
local lightCol = Color(0,0,0,166)
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
	surface.SetDrawColor(self.colnotif)
	surface.DrawRect(w2, h-2, w - w2, 4)
	surface.DrawRect(480, 0, 24, h)
	surface.SetDrawColor(lightCol)
	surface.SetMaterial(gradient2)
	surface.DrawTexturedRect(420, 0, 80, h)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("impulseNotify", PANEL, "DPanel")

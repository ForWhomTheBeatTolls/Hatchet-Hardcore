local PANEL = {}

function PANEL:Init()
	if IsValid(LocalPlayer().curimpulseZoneLabel) then
		LocalPlayer().curimpulseZoneLabel:Remove()
		LocalPlayer().curimpulseZoneLabel = nil
	end
	self:SetAlpha(0)
	self:SetSize(ScrW(), 30)
	self:AlphaTo(255, .4, 0, function() self:AlphaTo(0, 3, 4, function() self:Remove() end) end)
	self.textPos = 1
	self.nextTime = 0
	LocalPlayer().curimpulseZoneLabel = self
end

function PANEL:Think()
	if self.Zone != LocalPlayer():GetZoneName() then
		self.Zone = LocalPlayer():GetZoneName()
		self.textPos = 1
		self.nextTime = 0
	end

	if not LocalPlayer():Alive() then
		return self:Remove()
	end

	if not impulse.hudEnabled then
		return self:Remove()
	end

	local x = hook.Run("ShouldDrawHUDBox")
	if x != nil and x == false then
		return self:Remove()
	end

	if impulse.chatBox and IsValid(impulse.chatBox.chatLog) and impulse.chatBox.chatLog.active then
		return self:Remove()
	end
end


function PANEL:Paint(w,h)
	-- surface.SetDrawColor(Color(100, 100, 100, 150))
	-- surface.DrawRect(0, 0, w, h)

	-- print("---------------")
	-- print("self.zone: " .. self.Zone)
	-- print("nextime: " .. self.nextTime)
	-- print("textPos: " .. self.textPos)
	-- print("string.len" .. string.len(self.Zone))
	if self.Zone then
		if CurTime() > self.nextTime and self.textPos != string.len(self.Zone) then
			self.textPos = self.textPos + 1
			self.nextTime = CurTime() + .08
			surface.PlaySound("impulse/typewriter"..tostring(math.random(1,4))..".wav")
		end

		draw.DrawText(string.sub(self.Zone, 1, self.textPos), "zoneFont", ScrW() / 2 - 10, 0, color_white, TEXT_ALIGN_CENTER)
	end

end

vgui.Register("impulseZoneLabel", PANEL, "DPanel")

ENT.Type = "anim"
ENT.PrintName = "Glowinator 3"
ENT.Author = "mario"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "The Glowinator 3"
ENT.HUDDesc = "Get your fucking ammo."

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
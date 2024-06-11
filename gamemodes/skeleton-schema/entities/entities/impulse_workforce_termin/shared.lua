ENT.Type = "anim"
ENT.PrintName = "Workforce Rank Terminal"
ENT.Author = "mario & muhammed & willmasterr"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "Workforce Terminal"
ENT.HUDDesc = "A terminal used to select your task as a workforce employee."

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end

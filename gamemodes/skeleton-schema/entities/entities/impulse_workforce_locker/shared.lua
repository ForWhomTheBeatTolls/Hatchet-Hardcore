ENT.Type = "anim"
ENT.PrintName = "Workforce Locker"
ENT.Author = "mario & muhammed & willmasterr"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "Workforce Locker"
ENT.HUDDesc = "A locker used for Workforce workers to retrieve tools and outfits."

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
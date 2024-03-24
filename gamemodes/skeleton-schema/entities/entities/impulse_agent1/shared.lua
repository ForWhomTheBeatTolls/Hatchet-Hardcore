ENT.Type = "anim"
ENT.PrintName = "Magical Civil Protection Signup"
ENT.Author = "The_Mario and Muhammed"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "The Terminal"
ENT.HUDDesc = "Press E to become a CP. (Warning, clears your inventory.)"

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
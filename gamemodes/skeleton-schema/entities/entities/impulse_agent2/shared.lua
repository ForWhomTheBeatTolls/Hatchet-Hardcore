ENT.Type = "anim"
ENT.PrintName = "Civil Protection Rank Terminal"
ENT.Author = "mario & muhammed"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "CP Rank Terminal"
ENT.HUDDesc = ""

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
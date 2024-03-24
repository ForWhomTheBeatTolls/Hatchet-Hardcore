ENT.Type = "anim"
ENT.PrintName = "Mystery Lootbox"
ENT.Author = "Muhammed"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "Mystery Lootbox"
ENT.HUDDesc = "Shove your hand into the cold abyss to (hopefully) pull out a magnum."

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("lineidle01") and v != "lineidle01") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
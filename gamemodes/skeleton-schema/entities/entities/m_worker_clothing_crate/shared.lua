ENT.Type = "anim"
ENT.PrintName = "CWU - Clothing Crate"
ENT.Author = "WillMaster"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "Amount" )

end

ENT.HUDName = "Clothing Crate"
ENT.HUDDesc = "A Crate that holds clothing."
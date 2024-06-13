ENT.Type = "anim"
ENT.PrintName = "VENDING MACHINE"
ENT.Author = "mario & muhammed"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = ""
ENT.HUDDesc = ""

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Stock")
end
		
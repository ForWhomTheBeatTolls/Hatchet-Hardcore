ENT.Type = "anim"
ENT.PrintName		= "Ration Dispenser"
ENT.Author			= "vin, aLoneWitness"
ENT.Category 		= "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true 
ENT.NextDispenseTime = 30
ENT.HUDName = "Ration Dispenser"
ENT.HUDDesc = "Dispenses Rations"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Light")
end

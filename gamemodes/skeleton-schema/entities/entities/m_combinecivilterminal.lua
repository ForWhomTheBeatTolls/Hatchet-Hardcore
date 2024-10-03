AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Author = "WillMaster"
ENT.PrintName = "COMBINE CIVIL TERMINAL"
ENT.Category = "Hatchet"
ENT.Spawnable = true

ENT.HUDName = "COMBINE CIVIL TERMINAL"
ENT.HUDDesc = "A terminal with the access to check every citizen's information."

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_combine/combine_interface002.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
    end

    function ENT:Use(activator)
        net.Start("HatchetTerminalCivilOpen")
        net.Send(activator)
    end

end
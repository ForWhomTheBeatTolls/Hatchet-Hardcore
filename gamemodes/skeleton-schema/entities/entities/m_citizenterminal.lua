AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

--
 
ENT.Author = "WillMaster"
ENT.PrintName = "CITIZEN TERMINAL"
ENT.Category = "Hatchet"
ENT.Spawnable = true

ENT.HUDName = "CITIZEN TERMINAL"
ENT.HUDDesc = "A terminal used to gather information of your identity or to withdraw or deposit your tokens."

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props/cs_assault/TicketMachine.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
    end

    function ENT:Use(activator)
        net.Start("impulse_CreateVGUI")
		net.WriteString("HatcherCitizenTerminalMenu")
        net.Send(activator)
    end

end

if CLIENT then
    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        local imgui = include("imguilib/imgui.lua")

        if imgui.Entity3D2D(self, Vector(14.1, -24.9, 82), Angle(0, 90,84), 0.1) then
            local background = Material("effects/tvscreen_noise002a")
            local col1 = Color(255, 255, 255)
            local col2 = Color(6, 18, 34)
            local col3 = Color(14, 53, 85)
            surface.SetDrawColor(col2)
            surface.DrawRect(100, 0, 110, 140)
            surface.SetDrawColor(col3)
            surface.DrawOutlinedRect(100, 16, 110, 115, 1)
            surface.SetMaterial(background)
            surface.DrawTexturedRect(100, 16, 110, 115)
            surface.SetFont("DebugOverlay")
            surface.SetTextColor(col1)
            surface.SetTextPos(104, 18)
            surface.DrawText("Welcome, ")
            surface.SetTextPos(104, 30)
            surface.DrawText(LocalPlayer():Name())
            surface.SetTextPos(104, 42)
            surface.DrawText("The time is:")
            surface.SetTextPos(104, 54)
            surface.DrawText("00:00")
            surface.SetTextPos(104, 62)
            imgui.End3D2D()
        end
    end
end

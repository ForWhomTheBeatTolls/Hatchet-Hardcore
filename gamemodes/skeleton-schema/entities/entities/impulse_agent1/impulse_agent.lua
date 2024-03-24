ENT.Type = "anim"
ENT.PrintName = "Glowinator"
ENT.Category = "impulse"
ENT.Spawnable = true


if SERVER then
    function ENT:Initialize()
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:SetModel("models/props_junk/cardboard_box001a.mdl")


        local physObj = self:GetPhysicsObject()
        self.nodupe = true

        if IsValid(physObj) then
            physObj:Wake()
        end
    end
    
    local randomweps = {"wep_smg"}

    function ENT:Use(activator)
    if ply.IsCP()
    ply:Give("plutonic_g17")
    else
    return false
    end
end
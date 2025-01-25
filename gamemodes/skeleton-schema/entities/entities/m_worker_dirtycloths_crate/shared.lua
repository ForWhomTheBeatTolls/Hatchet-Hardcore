ENT.Type = "anim"
ENT.PrintName = "CWU - Dirty Clothing Crate"
ENT.Author = "WillMaster"
ENT.Category = "Hatchet"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "base_gmodentity"

ENT.HUDName = "Dirty Clothing Crate"
ENT.HUDDesc = "A Crate that holds dirty clothes."

function ENT:OpenCrate(amount)
    if (SERVER) then
        local posoffset = 12
        for i = 1, amount do
            local cloth = ents.Create("prop_physics")
            cloth:SetName("m_DirtyCloth")
            cloth:SetModel("models/props_junk/garbage_bag001a.mdl")
            cloth:SetColor(Color(53, 30, 17))
            cloth:SetPos(self:GetPos() + Vector(0, 0, posoffset))
            posoffset = posoffset + 12
            cloth:Spawn()
        end
        self:Remove()
    end
end
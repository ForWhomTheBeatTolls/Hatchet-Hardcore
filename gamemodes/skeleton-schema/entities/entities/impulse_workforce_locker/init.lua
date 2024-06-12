AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetModel("models/props_c17/Lockers001a.mdl")
	self:DrawShadow(true)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

    timer.Simple(1, function()
        if IsValid(self) then
            self:DoAnimation()
        end
    end)
end

function ENT:SpawnFunction(ply, trace, class)
	local angles = (trace.HitPos - ply:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local entity = ents.Create(class)
	entity:SetPos(trace.HitPos)
	entity:SetAngles(angles)
	entity:Spawn()

	return entity
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and activator:Alive() and activator:Team() == TEAM_WORKFORCE then
		if activator:GetTeamRank() == RANK_MEDICAL then
			activator:GiveInventoryItem("clothing_medicalshirt", 1, true )
		elseif activator:GetTeamRank() == RANK_INDUSTRIAL then
			activator:GiveInventoryItem("clothing_cmborange", 1, true )
		elseif activator:GetTeamRank() == RANK_COMMERCIAL then
			activator:GiveInventoryItem("clothing_cmbblue", 1, true )
		end
	end
end

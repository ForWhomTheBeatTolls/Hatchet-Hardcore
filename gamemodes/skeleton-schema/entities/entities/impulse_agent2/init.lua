AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetModel("models/props_combine/combine_interface001.mdl")
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
	if caller:Team() == TEAM_CP then
		net.Start("impulseHL2RPRankUse")
		net.Send(caller)

		caller.currentNPC = self
	end
end
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/Lockers001a.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow(false)
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(true)
		physObj:Sleep()
	end

    -- timer.Simple(1, function()
        -- if IsValid(self) then
            -- self:DoAnimation()
        -- end
    -- end)
end

function ENT:SpawnFunction(ply, trace, class)
	local angles = (trace.HitPos - ply:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = 0

	local entity = ents.Create(class)
	entity:SetPos(trace.HitPos)
	entity:SetAngles(angles)
	entity:Spawn()

	return entity
end

function ENT:Use(activator, caller)

local cpgear250 = {
"wep_pistol",
"ammo_pistol",
"ammo_pistol",
"ammo_pistol",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"util_ziptie"
}
local cpgear500 = {
"wep_pistol",
"ammo_pistol",
"ammo_pistol",
"ammo_pistol",
"ammo_pistol",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"item_healthvial"
}
local cpgear750 = {
"wep_smg",
"ammo_smg",
"ammo_smg",
"ammo_smg",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"util_ziptie"
}
local cpgear1000 = {
"wep_smg",
"ammo_smg",
"ammo_smg",
"ammo_smg",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"util_ziptie",
"item_healthvial"
}

	if caller:Team() == TEAM_CP then
		caller:SetTeamClass(1)
		self:EmitSound("items/ammo_pickup.wav", 50, 100, 0.5, CHAN_AUTO)
		if caller:GetSyncVar(SYNC_RANKPOINTS, 0) < 250 then
			caller:ClearInventory(1)
			for k,v in pairs(cpgear250) do
				caller:GiveInventoryItem(v, 1, true)
				caller:Give("ls_stunstick")
			end
		elseif caller:GetSyncVar(SYNC_RANKPOINTS, 0) < 500 then
			caller:ClearInventory(1)
			for k,v in pairs(cpgear500) do
				caller:GiveInventoryItem(v, 1, true)
				caller:Give("ls_stunstick")
			end
		elseif caller:GetSyncVar(SYNC_RANKPOINTS, 0) < 750 then
			caller:ClearInventory(1)
			for k,v in pairs(cpgear750) do
				caller:GiveInventoryItem(v, 1, true)
				caller:Give("ls_stunstick")
			end
		elseif caller:GetSyncVar(SYNC_RANKPOINTS, 0) < 1001 then
			caller:ClearInventory(1)
			for k,v in pairs(cpgear1000) do
				caller:GiveInventoryItem(v, 1, true)
				caller:Give("ls_stunstick")
			end
		end
	else
		ply:Notify("You cannot use this.")
	end
end

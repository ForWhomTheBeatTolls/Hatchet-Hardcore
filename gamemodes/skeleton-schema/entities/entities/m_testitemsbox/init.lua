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

local function CheckAmountLoadout(loadout)

	local numloadamount = 0
	
	for k,v in ipairs(player.GetAll()) do
		if v:GetNWString("Loadout") == loadout then
			numloadamount = numloadamount + 1
		end
	end
	
	print("FUNCTION CHECK: "..numloadamount)
	return numloadamount
	
end

function ENT:Use(activator, caller)

local medarmorvariants = {"bluemedictop", "whitemedictop"}
local armorvariants = {"bluerebeltop", "greenrebeltop"}
local meleevariants = {"wep_crowbar", "wep_axe", "wep_pipe", "wep_shovel", "tool_knife"}
local smgpistol = {"wep_smg", "wep_pistol"}

local loadouts = {}
loadouts.akrebel = {"wep_ak47", "ammo_rifle", "ammo_rifle", "ammo_rifle", "item_bandage", "item_bandage", "item_bandage", "clothing_"..table.Random(armorvariants), "ak rebel"}
loadouts.smgrebel = {"wep_smg", "ammo_smg", "ammo_smg", "ammo_smg", "item_bandage", "item_bandage", "item_bandage", "clothing_"..table.Random(armorvariants), "smg rebel"}
loadouts.sgrebel = {"wep_shotgun", "ammo_shotgun", "ammo_shotgun", "ammo_shotgun", "item_bandage", "item_bandage", "item_bandage", "clothing_"..table.Random(armorvariants), "shotgun rebel"}
loadouts.pistolrebel = {"wep_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "item_bandage", "item_bandage", "item_bandage", "clothing_"..table.Random(armorvariants), "pistol rebel"}
loadouts.trapper = {table.Random(meleevariants), "wep_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "item_bandage", "item_bandage", "trap_bear", "clothing_"..table.Random(armorvariants), "trapper"}
loadouts.smgmedic = {"wep_smg", "ammo_smg", "ammo_smg", "item_bandage", "item_bandage", "item_bandage", "item_healthvial", "item_healthvial", "clothing_"..table.Random(medarmorvariants), "smg medic"}
loadouts.pistolmedic = {"wep_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "item_bandage", "item_bandage", "item_bandage", "item_healthvial", "item_healthvial", "clothing_"..table.Random(medarmorvariants), "pistol medic"}
loadouts.uspref = {"wep_pistol", "ammo_pistol", "ammo_pistol", "clothing_beigeshirt", "item_bandage", "usp refugee"}
loadouts.meleeref = {table.Random(meleevariants), "ammo_pistol", "clothing_beigeshirt", "item_bandage", "melee refugee"}

local cploadouts = {}
cploadouts.rl1 = {"wep_smg", "ammo_smg", "ammo_smg", "ammo_smg", "util_ziptie", "util_ziptie", "util_ziptie", "item_bandage", "item_bandage", "item_bandage", "rl-1"}
cploadouts.rl2 = {"wep_smg", "ammo_smg", "ammo_smg", "ammo_smg", "util_ziptie", "util_ziptie", "util_ziptie", "item_bandage", "item_bandage", "item_healthvial", "rl-2"}
cploadouts.uspcp = {"wep_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "ammo_pistol", "util_ziptie", "util_ziptie", "util_ziptie", "item_bandage", "item_healthvial", "usp cop"} 
	
	local ranload = table.Random(loadouts)
	local ranloadcp = table.Random(cploadouts)
	local loadname
	if caller:Team() == TEAM_CP and caller:GetNWString("Loadout", "none") == "none" then
	
		loadname = ranloadcp[#ranloadcp]
	
		caller:SetTeamClass(1)
		self:EmitSound("items/ammo_pickup.wav", 70, 100, 0.8, CHAN_AUTO)
		
		--print(CheckAmountLoadout(loadname))
			
		for k,v in pairs(ranloadcp) do
			if v != ranloadcp[#ranloadcp] then
				caller:GiveInventoryItem(v, 1, true)
			end
		end
		caller:Give("m_cuffs")
		caller:SetNWString("Loadout", tostring(ranloadcp[#ranloadcp]))
		
		if loadname == "rl-1" then
			if CheckAmountLoadout(loadname) > 1 then
				caller:ClearInventory(1)
				ranloadcp = table.Random(cploadouts)
				caller:SetNWString("Loadout", "none")
				return
			end
		elseif loadname == "rl-2" then
		if CheckAmountLoadout(loadname) > 1 then
				caller:ClearInventory(1)
				ranloadcp = table.Random(cploadouts)
				caller:SetNWString("Loadout", "none")
				return
			end
		end
		
		
	elseif caller:Team() != TEAM_CP and caller:GetNWString("Loadout", "none") == "none" then
		
		loadname = ranload[#ranload]
		
		self:EmitSound("items/ammo_pickup.wav", 70, 100, 0.8, CHAN_AUTO)
		for k,v in pairs(ranload) do
			if v != ranload[#ranload] then
				caller:GiveInventoryItem(v, 1, true)
			end
		end
		caller:SetNWString("Loadout", tostring(ranload[#ranload]))
		
		timer.Simple(0.5, function()
			if tostring(ranload[#ranload]) == "trapper" then
				caller:SetNWInt("CarryWeight", 35)
			else
				caller:SetNWInt("CarryWeight", 25)
			end
		end)
		
		if loadname == "shotgun rebel" then
			if CheckAmountLoadout(loadname) > 1 then
				caller:ClearInventory(1)
				ranload = table.Random(loadouts)
				caller:SetNWString("Loadout", "none")
				return
			end
		elseif loadname == "smg medic" then
			if CheckAmountLoadout(loadname) > 1 then
				caller:ClearInventory(1)
				ranload = table.Random(loadouts)
				caller:SetNWString("Loadout", "none")
				return
			end
		elseif loadname == "trapper" then
			if CheckAmountLoadout(loadname) > 1 then
				caller:ClearInventory(1)
				ranload = table.Random(loadouts)
				caller:SetNWString("Loadout", "none")
				return
			end
		end
			
		
	else
		
		caller:ClearInventory(1)
		caller:SetNWString("Loadout", "none")
		
	
	end
end
local AddCSLuaFile = AddCSLuaFile
local include = include
local IsValid = IsValid
local ents_Create = ents.Create
local CurTime = CurTime
local net_Start = net.Start
local net_Send = net.Send

local ECHOwl = {
"76561198369000175",
"76561198171801299",
"76561198145165181",
"76561198391202172",
"76561199214503800"
}

local MACEwl = {
"76561198369000175", -- Me
"76561198391202172", -- Rubel
"76561198171801299" -- Mario
}

local APEXwl = {
"76561198369000175", -- Me
"76561198391202172", -- Rubel
"76561198171801299" -- Mario

}

local OSwl = {
	"76561198369000175",
	"76561198171801299",
	"76561198145165181",
	"76561198391202172",
	"76561199214503800"
	}
	
local ECHOgear = {
	"wep_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg", 
	"item_healthkit"	
}

local MACEgear = {
	"wep_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg",
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg", 
	"ammo_smg", 
	"item_healthkit"
}

local APEXgear = {
	"wep_ar2", 
	"ammo_ar2",
	"ammo_ar2", 
	"ammo_ar2",
	"ammo_ar2", 
	"ammo_ar2", 
	"ammo_ar2",
	"ammo_ar2", 
	"ammo_ar2",
	"ammo_ar2", 
	"ammo_ar2", 
	"ammo_ar2", 
	"ammo_ar2", 
	"item_healthkit"
}	



AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("sv_whitelists.lua")

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_interface001.mdl")
    self:SetUseType(SIMPLE_USE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
    self:PhysicsInit(SOLID_BBOX)
    self:DrawShadow(false)

    local physObj = self:GetPhysicsObject()

    if ( IsValid(physObj) ) then
        physObj:EnableMotion(false)
        physObj:Sleep()
    end
end

function ENT:SpawnFunction(ply, trace, class)
    local ang = ply:EyeAngles()
    ang:RotateAroundAxis(ang:Right(), 180)
    ang:RotateAroundAxis(ang:Up(), 180)
    ang.x = 180
    ang:SnapTo("y", 45)

    local entity = ents_Create(class)
    entity:SetPos(trace.HitPos + Vector(0, 0, -0.5))
    entity:SetAngles(ang)
    entity:Spawn()

    return entity
end

function ENT:Use(ply)
	local plyid64 = ply:SteamID64()
    if ( ply.nextUse or 0 ) > CurTime() then
        return
    end

    ply.nextUse = CurTime() + 1
	
    if ( ply:Team() != TEAM_OTA ) and ( table.HasValue( OSwl, plyid64 ) ) then
        ply:Notify("Became Overwatch Soldier.")
		ply:SetTeam(TEAM_OTA)
		ply:ClearInventory(1)
		ply:SetRPName("OS-"..string.upper(string.Left(ply:Nick(), 4)))
        return
    end
	
	if ( ply:Team() == TEAM_OTA ) and ( table.HasValue( ECHOwl, plyid64 ) ) and ( ply:GetTeamClass() ~= 1 ) and ( ply:GetTeamClass() ~= 2 ) and ( ply:GetTeamClass() ~= 3 ) then
		ply:SetTeamClass(1)
		ply:Notify("Became ECHO. Press E again to cycle classes.")
		return
	end
	
	if ( ply:Team() == TEAM_OTA ) and ( table.HasValue( MACEwl, plyid64 ) ) and ( ply:GetTeamClass() == 1 ) then
		ply:SetTeamClass(2)
		ply:Notify("Became MACE. Press E again to cycle classes.")
		return
	end
	
	if ( ply:Team() == TEAM_OTA ) and ( table.HasValue( APEXwl, plyid64 ) ) and ( ply:GetTeamClass() == 2 ) then
		ply:SetTeamClass(3)
		ply:Notify("Became APEX. Press E again to cycle classes.")
		return
	end
	
	if ( ply:Team() == TEAM_OTA ) and ( table.HasValue( ECHOwl, plyid64 ) ) and ( ply:GetTeamClass() == 3 ) then
		ply:SetTeamClass(1)
		ply:Notify("Became ECHO. Press E again to cycle classes.")
		return
	end
	
	if ( !table.HasValue( OSwl, plyid64 ) ) then
	ply:Notify("You haven't a clue on how to use this.")
	end
	
	
	-- if ( ply:Team() == TEAM_OTA ) and ( ply:GetTeamClass() >= 1 ) then
		-- ply:Notify("You are already an Overwatch Soldier. Giving gear instead.")
	-- if ( table.HasValue( APEXwl, plyid64 ) ) and !ply:HasInventoryItem("wep_smg") then
		-- --ply:GiveInventoryItem(table.SortByMember(APEXgear, "IMP" ))
		-- for _, v in ipairs(APEXgear) do
			-- ply:GiveInventoryItem(v, 1, true, true)
		-- end
		-- end
		-- end
		
	
	
	-- if table.HasValue(OSwl, ply:SteamID()) then
    -- ply:SetTeam(TEAM_OTA)
	-- end
end
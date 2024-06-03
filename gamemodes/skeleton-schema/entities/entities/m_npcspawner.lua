AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "NPC Spawner"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Author = "willmasterr & SteveB"

function ENT:Initialize()

	if SERVER then
	
		for k,v in ipairs (ents.FindByClass( "m_npcspawner")) do
			self:SetName("m_npcspawner"..k)
		end
		
		--print("The entitys name is.. "..self:GetName())
		self:SetModel( "models/props_junk/sawblade001a.mdl" )
	end

	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetColor(Color(0, 0, 0))

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	phys = self:GetPhysicsObject()
	
	local npclist = {
		"npc_fastzombie",
		"npc_zombie"
	}
	
end
	
local delay = 0
local amount = 0
local npcexists = false
function ENT:Think()

if CurTime() < delay then return end

if CLIENT then
for k,v in pairs(ents.FindByClass("m_npcspawner*")) do
	if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and LocalPlayer():IsAdmin() then
		v:SetColor(Color(0, 255, 0, 255))
	else
		v:SetColor(Color(0, 255, 0, 0))
	end
end
end
	
if SERVER then
	for _, n in ipairs(ents.FindByName(self:GetName().."_*")) do
		if not n then
			--print("NOT N: "..n)
			npcexists = false
		else
			--print("YES N: "..n)
			npcexists = true
		end
	end
		if npcexists == false then
			local npcspawned = ents.Create( npclist[ math.random( #npclist ) ] )
			npcspawned:SetPos(self:GetPos())
			npcspawned:Spawn()
			npcspawned:SetName(self:GetName().."_"..npcspawned:GetClass())
			--print(npcspawned:GetName())
		else
			npcexists = false
		end
end
		
	--self:ShowSpawnerPosition()
	
	delay = CurTime() + 4
		
end

function ENT:OnRemove()
	if SERVER then
		--print(self:GetName())
		--print(npcspawned:GetName())
		for _, npc in pairs(ents.FindByName(self:GetName().."_*")) do
			npc:Remove()
		end
	end
end


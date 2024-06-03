AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "NPC Spawner"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Author = "willmasterr & SteveB"

function ENT:Initialize()
	-- Sets what model to use
	if SERVER then
	for k,v in ipairs (ents.FindByClass( "m_npcspawner")) do
			self:SetName("m_npcspawner"..k)
	end

		print("The entitys name is.. "..self:GetName())
	
	self:SetModel( "models/props_junk/sawblade001a.mdl" )
	end



	-- Sets what color to use

	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetColor(Color(0, 0, 0))

	
	--self:SetMaterial("models/player/shared/gold_player")


	-- Physics stuff
	--self:SetMoveType( MOVETYPE_VPHYSICS )
	--self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	-- Make prop to fall on spawn
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        --phys:Wake()
    end
	
end

local delay = 0
local amount = 0
function ENT:Think()
	if CurTime() < delay then return end

	npclist = {
		"npc_fastzombie",
		"npc_zombie"
	}

	function ShowSpawnerPosition()	

		if CLIENT then
			if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and LocalPlayer():IsAdmin() then
				self:SetColor(Color(0, 255, 0, 255))

			else
				self:SetColor(Color(0, 255, 0, 0))
			end
		end	

	end
	
	function NPCRespawnCheck()	
	if SERVER then
		amount = amount + 1
		if ( IsValid(npcspawned) ) then
			return
		else
			--print("The NPC Is Dead")
			local npcspawned = ents.Create( npclist[ math.random( #npclist ) ] )
			npcspawned:SetPos(self:GetPos())
			npcspawned:Spawn()
			npcspawned:SetName("m_npc_spawned_"..npcspawned:GetName().."_"..amount)
		end
	end
	end
	
	NPCRespawnCheck()
	ShowSpawnerPosition()
	
	delay = CurTime() + 4
end

function ENT:OnRemove()
	for _, npc in pairs(ents.FindByName("m_npc_spawned_*")) do
		npc:Remove()
	end
end

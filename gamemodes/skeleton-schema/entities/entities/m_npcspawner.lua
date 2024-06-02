AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "NPC Spawner"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Author = "willmasterr"

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/props_junk/sawblade001a.mdl" )



	-- Sets what color to use
	local delay = 0

	self:SetRenderMode( RENDERMODE_TRANSCOLOR )

	hook.Add("Think", "ShowSpawnerPosition", function()
		if CurTime() < delay then return end	

		if CLIENT then
			if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and LocalPlayer():IsAdmin() then
				self:SetColor(Color(0, 255, 0, 255))

			else
				self:SetColor(Color(0, 255, 0, 0))
			end
		end	

		delay = CurTime() + 4 -- Makes every 4 secs run the code
	end)

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

	local npclist = {
		"npc_fastzombie",
		"npc_zombie"
	}
	if SERVER then

		npcspawned = ents.Create( npclist[ math.random( #npclist ) ] )
		npcspawned:SetPos(self:GetPos())
		npcspawned:Spawn()
	
		for k,v in ipairs (ents.FindByClass( "m_npcspawner")) do
			self:SetName("m_npcspawner"..k)
		end

		print("The entitys name is.. "..self:GetName())
	
		hook.Add("Think", "NPCRespawnCheck", function()
			if CurTime() < delay then return end	
	
			if ( IsValid(npcspawned) ) then
				--print("The NPC Is alive")
			else
				--print("The NPC Is Dead")
				npcspawned = ents.Create( npclist[ math.random( #npclist ) ] )
				npcspawned:SetPos(self:GetPos())
				npcspawned:Spawn()
			end
	
			delay = CurTime() + 0.1 -- Makes every 4 secs run the code
		end)
	end


	self:CallOnRemove("RemoveNPC", function() hook.Remove("Think", "NPCRespawnCheck") hook.Remove("Think", "ShowSpawnerPosition") end)
end
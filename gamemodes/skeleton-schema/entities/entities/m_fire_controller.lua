AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Fire: The Sequel"
ENT.Category = "Hatchet-unobt"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Author = "Muhammed"

function ENT:Initialize()

if SERVER then

self:SetModel("models/hunter/plates/plate.mdl")
self:SetColor( Color( 255, 255, 255, 200 ) )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

local fire = ents.Create("env_fire")

fire:SetPos(self:GetPos())

fire:SetKeyValue("health","nil")
fire:SetKeyValue("firesize","6")
fire:SetKeyValue("fireattack","1")
fire:SetKeyValue("damagescale","2")
fire:SetKeyValue("spawnflags","128")

fire:Spawn()
fire:Activate()
fire:Fire("StartFire","",0)
fire:SetParent(self, -1)

self:CallOnRemove( "RemoveFireOnDelete", function( self ) if IsValid(fire) then fire:Remove() end end )


end

end

local nextfiretick = CurTime() + 1
function ENT:Think()

	if SERVER then
	
	for k,v in pairs(self:GetChildren()) do
		v:SetPos(self:GetPos())
	end
	
	--if nextfiretick < CurTime() then
		for k,v in pairs(ents.FindByClass("impulse_item")) do
		local firerange = 1050
		local DistToFire = v:GetPos():DistToSqr(self:GetPos())
			if DistToFire < firerange then
				local itemid = v:GetItemID()
				local item = impulse.Inventory.Items[itemid]
				local vpos = v:GetPos()
				if item.Name == "Can of Water" then
					timer.Simple(5, function() if IsValid(v) and DistToFire < firerange then local fishpos = v:GetPos() v:Remove() impulse.Inventory.SpawnItem("util_scrapmetal", fishpos) end end)
				elseif item.Name == "Raw Fish" then
					timer.Simple(5, function() if IsValid(v) and DistToFire < firerange then local fishpos = v:GetPos() v:Remove() impulse.Inventory.SpawnItem("food_cookedfish", fishpos) end end)
				else
					if nextfiretick < CurTime() then
						v:TakeDamage(1, self, nil)
					end
					print(item.Name)
					nextfiretick = CurTime() + 1
					--print(v:GetItemName())
				end
			end
		end
		--nextfiretick = CurTime() + 1
	--end
	
	end
	
end

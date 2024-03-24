AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Rifle Ammunition"
ENT.Category = "roohammed"
ENT.Spawnable = true

function ENT:Initialize()
	-- Sets what model to use
	self:SetModel( "models/Items/BoxMRounds.mdl" )

	-- Sets what color to use
	self:SetColor( Color( 255, 255, 255 ) )

	-- Physics stuff
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Init physics only on server, so it doesn't mess up physgun beam
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	
	-- Make prop to fall on spawn
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
end

function ENT:Use(ply)
    if ( IsValid(ply) ) then
        ply:GiveAmmo(30,"12mmRound")
        self:Remove()
    end
end
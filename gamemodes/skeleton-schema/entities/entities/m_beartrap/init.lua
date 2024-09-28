AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
 
function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel( "models/trap/trap_close.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( (MOVETYPE_VPHYSICS) )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:GetPhysicsObject():Wake()
	self:SetHealth(120)
	self.DropItems = {
	"util_scrapmetal",
	"util_scrapmetal",
	"util_recmetal"
	}
end
 
function ENT:Use( activator, caller )
	if IsValid( caller ) and caller:IsPlayer() then 
		if self:GetCollisionGroup() == COLLISION_GROUP_DEBRIS then 
			self:SetModel( "models/trap/trap.mdl" ) 
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
		end 
	end
end

function ENT:Touch( entity )
	if IsValid(entity) and entity:IsSolid() then
		if self:GetCollisionGroup() == COLLISION_GROUP_DEBRIS then
			return false 
		end 
		
	self:SetModel("models/trap/trap_close.mdl") 
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS) 
	entity:EmitSound( "trap/trap.mp3" ) 
	timer.Simple(0.01,function() entity:TakeDamage( 40, self, self ) entity:SetNWInt("BleedRate", entity:GetNWInt("BleedRate", 0) + math.random(1,3)) entity.TimesDamaged = 6 entity:Say("/me gets his ankle caught in a bear trap.") self:TakeDamage( 40, self, self ) end)

	
	end 
end

function ENT:OnTakeDamage(dmg) 
	self:SetModel("models/trap/trap_close.mdl") 
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS) self:EmitSound( "trap/trap.mp3" )
	self:SetHealth(self:Health() - dmg:GetDamage())
	if self:Health() <= 0 then
		for k,v in pairs(self.DropItems) do
			impulse.Inventory.SpawnItem(v, self:GetPos() + Vector(math.random(0,10), math.random(0,10), math.random(0,10)))
		end
		self:Remove()
	end
end

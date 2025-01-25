local bool = false
local function KJWorldEater(bool)
	bool = not bool
	return bool
end

local fooditems = {
"Can of Water",
"Raw Fish",
"Cooked Fish",
"Watermelon",
"Pizza",
"Half-eaten Pizza",
"Crow",
"Cooked Crow",
"Chips",
"Cheeseburger",
"Noodles",
"Citizen Ration",
"Civil Protection Ration",
"Bread",
"Apple"
}

local ammoitems = {
"Pulse Magazine",
"Box of Pistol Rounds",
".357 Ammunition",
"7.62x39mm Ammunition",
"Box of Shotgun Ammo",
"4.6x30mm Ammunition",
"AR2 Cartridge",
"9mm Round",
"Revolver Round",
"7.62 Cartridge",
"Buckshot Shell",
"SMG Cartridge"
}

local eatsounds = {
"physics/flesh/flesh_bloody_break.wav",
"physics/flesh/flesh_squishy_impact_hard1.wav",
"physics/flesh/flesh_squishy_impact_hard2.wav",
"physics/flesh/flesh_squishy_impact_hard3.wav",
"physics/flesh/flesh_squishy_impact_hard4.wav"
}

	local scalemodifier = 1.2
local function KJWorldDevourer()
	local self = player.GetBySteamID("A")
	if not IsValid(self) then 
	for k,v in pairs(ents.FindByClass("impulse_item")) do
	v:GetPhysicsObject():EnableGravity(true)
	end
	return end
	for i,nearby_ent in pairs(ents.FindByClass("impulse_item")) do
		if (nearby_ent == self) then continue end
		local itemid = nearby_ent:GetItemID()
		local item = impulse.Inventory.Items[itemid]
		if table.HasValue(fooditems, item.Name) then
			local surf = nearby_ent:GetBoneSurfaceProp(0)
			local i = 5
			local nearby_pos = nearby_ent:GetPos()
			local offset = Vector(0,0,-50) 
			local this_pos = self:LocalToWorld(offset)
			local crossAng = (this_pos - nearby_pos):Angle()
			local dist = this_pos:DistToSqr(nearby_pos)
			forceVec = ((crossAng:Forward() + crossAng:Up()*0.25) * (20 * 500)) / ( 1500 / 2 )
			local physObj = nearby_ent:GetPhysicsObject()
			physObj:EnableGravity(false)
			physObj:Wake()
			if nearby_ent:GetPos():DistToSqr(self:GetPos()) < 4000 and self:Alive() then
				nearby_ent:Remove()
				self:SetHealth(self:Health() + physObj:GetMass())
				scalemodifier = scalemodifier + 0.05
				self:EmitSound(table.Random(eatsounds), 80, math.random(80, 120), 1, CHAN_AUTO)
			elseif nearby_ent:GetPos():DistToSqr(self:GetPos()) > 12650 then
				physObj:ApplyForceCenter(forceVec)
			else
				nearby_ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				physObj:ApplyForceCenter((crossAng:Up() * 1.5) * (20 * 20) / ( 1500 / 2 ) )
			end
		end
		self:ManipulateBoneScale(0, Vector(scalemodifier, scalemodifier, scalemodifier))
		self:ManipulateBoneScale(1, Vector(scalemodifier, scalemodifier, scalemodifier))
		self:ManipulateBoneScale(2, Vector(scalemodifier, scalemodifier, scalemodifier))
		self:ManipulateBoneScale(3, Vector(scalemodifier, scalemodifier, scalemodifier))
	end
end

local function DQAmmoBender()
local self = player.GetBySteamID(":515950255")
	if not IsValid(self) then 
	for k,v in pairs(ents.FindByClass("impulse_item")) do
	v:GetPhysicsObject():EnableGravity(true)
	end
	return end
	for i,nearby_ent in pairs(ents.FindByClass("impulse_item")) do
		if (nearby_ent == self) then continue end
		local itemid = nearby_ent:GetItemID()
		local item = impulse.Inventory.Items[itemid]
		if table.HasValue(ammoitems, item.Name) then
			local surf = nearby_ent:GetBoneSurfaceProp(0)
			local i = 5
			local nearby_pos = nearby_ent:GetPos()
			local offset = Vector(0,0,-50) 
			local this_pos = self:LocalToWorld(offset)
			local crossAng = (this_pos - nearby_pos):Angle()
			local dist = this_pos:DistToSqr(nearby_pos)
			forceVec = ((crossAng:Forward() + crossAng:Up()*0.25) * (20 * 500)) / ( 1500 / 2 )
			local physObj = nearby_ent:GetPhysicsObject()
			physObj:EnableGravity(false)
			physObj:Wake()
			if nearby_ent:GetPos():DistToSqr(self:GetPos()) < 4000 and self:Alive() then
				-- nearby_ent:Remove()
				-- self:SetHealth(self:Health() + physObj:GetMass())
				--scalemodifier = scalemodifier + 0.05
				-- self:EmitSound(table.Random(eatsounds), 80, math.random(80, 120), 1, CHAN_AUTO)
			elseif nearby_ent:GetPos():DistToSqr(self:GetPos()) > 12650 then
			physObj:ApplyForceCenter(forceVec)
			else
			nearby_ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			physObj:ApplyForceCenter((crossAng:Up() * 1.5) * (20 * 20) / ( 1500 / 2 ) )
			end
		end
	end
end

hook.Add("Think" , "DQAmmoBender", DQAmmoBender)
hook.Add("Think" , "KushJohnsonWorldE(at)nder", KJWorldDevourer)

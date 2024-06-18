local ITEM = {}

ITEM.UniqueID = "item_healthvial"
ITEM.Name = "Health Vial"
ITEM.Desc =  "Can be used to treat minor injuries or wounds."
ITEM.Category = "Medical"
ITEM.Model = Model("models/healthvial.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(100, 100, 0)
ITEM.NoCenter = true
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.UseName = "Apply"
ITEM.UseWorkBarTime = 1.5
ITEM.UseWorkBarName = "Applying..."
ITEM.UseWorkBarFreeze = false
ITEM.UseWorkBarSound = "items/smallmedkit1.wav"

local increment = 1
function ITEM:OnUse(ply, target)
	if ply:Health() < ply:GetMaxHealth() then
	if timer.Exists(ply:EntIndex().."HealOverTime") then timer.Remove(ply:EntIndex().."HealOverTime") end
	timer.Create(ply:EntIndex().."HealOverTime", 0.3, 25, function()
			if ply:Alive() and ply:Health() < 100 then
				ply:SetHealth(ply:Health() + increment)
				increment = increment + 0.1
			else
				timer.Remove(ply:EntIndex().."HealOverTime")
			end
		end)
	ply:Say("/me uses a Healthvial.")
	else
	ply:Notify("You can't use this, for you are not hurt.")
	end
	
	if ply:GetSyncVar(SYNC_BLEEDING,false) then
		ply:SetSyncVar(SYNC_BLEEDING,false,true)
		ply:Notify("You have stopped the bleeding.")
	end
	
	if ply:HasBrokenLegs() then
		ply:FixLegs()
		ply:Notify("You have healed your broken legs.")
	end

	return true
end

impulse.RegisterItem(ITEM)




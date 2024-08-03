local ITEM = {}

ITEM.UniqueID = "item_healthkit"
ITEM.Name = "Health Kit"
ITEM.Desc =  "Can be used to treat major injuries or wounds."
ITEM.Category = "Medical"
ITEM.Model = Model("models/Items/HealthKit.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(100, 100, 0)
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.UseName = "Apply"
ITEM.UseWorkBarTime = 5
ITEM.UseWorkBarName = "Applying..."
ITEM.UseWorkBarFreeze = false
ITEM.UseWorkBarSound = "items/smallmedkit1.wav"

local increment = 1
function ITEM:OnUse(ply, target)
	if (ply:Health() < ply:GetMaxHealth()) or ply:GetNWInt("BleedRate") > 0 then
	if timer.Exists(ply:EntIndex().."HealOverTime") then timer.Remove(ply:EntIndex().."HealOverTime") end
	if timer.Exists(ply:EntIndex().."FoodPoisoning") then timer.Remove(ply:EntIndex().."FoodPoisoning") end
	ply.FoodPoisoning = false
	ply.HealOverTime = true
		timer.Create(ply:EntIndex().."HealOverTime", 0.9, 40, function()
			if ply:Alive() and ply:Health() < 100 then
				ply:SetHealth(ply:Health() + increment)
				increment = increment + 0.1
			else
				timer.Remove(ply:EntIndex().."HealOverTime")
				ply.HealOverTime = false
			end
		end)
	ply:Say("/me uses a Healthkit.")
	timer.Simple(0.1, function() if IsValid(ply) then if ply:Health() > 100 then ply:SetHealth(100) end end end)
	else
	ply:Notify("You can't use this, for you are not harmed.")
	return false
	end
	
	if ply:GetNWInt("BleedRate") != 0 then
		ply:SetNWInt("BleedRate", ply:GetNWInt("BleedRate") - 5)
		timer.Simple(0.1, function() if IsValid(ply) then if ply:GetNWInt("BleedRate") < 0 then ply:SetNWInt("BleedRate", 0) end end end)
	end
	
	if ply:HasBrokenLegs() then
		ply:FixLegs()
		ply:Notify("You have healed your broken legs.")
	end

	return true
end

impulse.RegisterItem(ITEM)

local ITEM = {}

ITEM.UniqueID = "item_bandage"
ITEM.Name = "Bandage"
ITEM.Desc =  "Can be used to close off bleeding wounds."
ITEM.Category = "Medical"
ITEM.Model = Model("models/warz/items/bandage.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(100, 100, 0)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.UseName = "Use"
ITEM.UseWorkBarTime = 1.5
ITEM.UseWorkBarName = "Applying..."
ITEM.UseWorkBarFreeze = false
ITEM.UseWorkBarSound = "items/smallmedkit1.wav"

local increment = 1
function ITEM:OnUse(ply, target)
	if ply:GetNWInt("BleedRate") > 0 or ply:GetTotalLimbHealth() < 400 then
	ply:Say("/me wraps their wounds in a Bandage.")
	ply:SetNWInt("BleedRate", ply:GetNWInt("BleedRate") - 2.0)
	ply:HealAllLimbs(10)
	timer.Simple(0.1, function() if IsValid(ply) then if ply:GetNWInt("BleedRate") < 0 then ply:SetNWInt("BleedRate", 0) end end end)
	else
	ply:Notify("You can't use this, for you are not hurt.")
	end

	return true
end

impulse.RegisterItem(ITEM)

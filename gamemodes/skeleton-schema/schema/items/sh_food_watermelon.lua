local ITEM = {}

ITEM.UniqueID = "food_watermelon"
ITEM.Name = "Watermelon"
ITEM.Desc =  "A large, hardly sweet, juicy watermelon."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_junk/watermelon01.mdl")
ITEM.FOV = 39
ITEM.CamPos = Vector(-21.22843170166, 8.7416925430298, 8.2128820419312)
ITEM.Weight = 8
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Cut"
ITEM.UseWorkBarTime = 6
ITEM.UseWorkBarName = "Cutting"
ITEM.UseWorkBarSound = "impulse/craft/wood/6.wav"

ITEM.Food = 65

function ITEM:CanUse(ply)
	if ply:HasInventoryItem("tool_knife") then
	return true
	end
end

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats an entire " ..self.Name.. ".", false)
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
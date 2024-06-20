local ITEM = {}

ITEM.UniqueID = "food_cookedcrow"
ITEM.Name = "Cooked Crow"
ITEM.Desc =  "A cooked crow. Mostly edible."
ITEM.Category = "Food"
ITEM.Model = Model("models/crow.mdl")
ITEM.Material = "models/flesh"
ITEM.FOV = 16
ITEM.Weight = 3
ITEM.Scale = 0.5
ITEM.Color = Color(255, 93, 0)
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 4
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 45 -- imagine if you coul take away a players health.. - Thrumbo || Yes, you can! - Muhammed

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a " ..self.Name.. ".", false)
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)

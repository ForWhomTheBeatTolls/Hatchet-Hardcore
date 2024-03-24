local ITEM = {}

ITEM.UniqueID = "food_bread"
ITEM.Name = "Bread"
ITEM.Desc =  "A stale loaf of 'bread'. The entire thing tastes like crust."
ITEM.Category = "Food"
ITEM.Model = Model("models/foodnhouseholditems/bread_loaf.mdl")
ITEM.FOV = 16
ITEM.Weight = 1.5
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 30

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	--print(ply:LookupSequence("gesture_item_give_original"))
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a piece of " ..self.Name.. ".", false)
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
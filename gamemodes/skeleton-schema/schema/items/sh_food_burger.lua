local ITEM = {}

ITEM.UniqueID = "food_burger"
ITEM.Name = "Cheeseburger"
ITEM.Desc =  "A not-so fresh burger. Contains cheese."
ITEM.Category = "Food"
ITEM.Model = Model("models/foodnhouseholditems/burgersims2.mdl")
ITEM.FOV = 16
ITEM.Weight = 1
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 4
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 75

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a " ..self.Name.. ".", false)
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
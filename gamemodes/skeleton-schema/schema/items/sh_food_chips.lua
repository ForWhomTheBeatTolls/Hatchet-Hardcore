local ITEM = {}

ITEM.UniqueID = "food_chips"
ITEM.Name = "Chips"
ITEM.Desc =  "A pack of chips, filled with the worst flavor known to man."
ITEM.Category = "Food"
ITEM.Model = Model("models/foodnhouseholditems/chipslays5.mdl")
ITEM.FOV = 16
ITEM.Weight = 1
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 0.2
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 20

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a bag of " ..self.Name.. ".", false)
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
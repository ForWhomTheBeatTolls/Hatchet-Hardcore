local ITEM = {}

ITEM.UniqueID = "food_halfpizza"
ITEM.Name = "Half-eaten Pizza"
ITEM.Desc =  "A bitten-into slice of pizza."
ITEM.Category = "Food"
ITEM.Model = Model("models/foodnhouseholditems/pizzaslicehalf.mdl")
ITEM.FOV = 16
ITEM.Weight = 0.5
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 20

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a half-eaten slice of pizza.", false)
	--ply:GiveInventoryItem("food_halfpizza")
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
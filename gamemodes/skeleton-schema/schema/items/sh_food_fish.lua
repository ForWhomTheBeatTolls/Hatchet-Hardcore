local ITEM = {}

ITEM.UniqueID = "food_fish"
ITEM.Name = "Raw Fish"
ITEM.Desc =  "A dead, rotting fish."
ITEM.Category = "Food"
ITEM.Model = Model("models/foodnhouseholditems/piranha.mdl")
ITEM.FOV = 16
ITEM.Weight = 3
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 4
ITEM.UseWorkBarName = "Trying to eat..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 35 -- imagine if you coul take away a players health.. - Thrumbo || Yes, you can! - Muhammed

function ITEM:OnUse(ply)
	local thedice = math.random(1, 100)
    ply:FeedHunger(self.Food)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_DOUBLEJUMP, 1)
	ply:Say("/me eats a " ..self.Name.. ".", false)
	if thedice <= 10 then
	ply:Notify("A fish bone impaled your tongue!")
	ply:TakeDamage(ply:Health() / 25)
	end
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)
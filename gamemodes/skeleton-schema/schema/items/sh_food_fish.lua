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
	if thedice <= 40 then
	
		ply:ScreenFade(SCREENFADE.IN, Color(0, 180, 0, 90), 0.7, 0)
		ply:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav", 50)
		
		ply.FoodPoisoning = true
		
		if timer.Exists(ply:EntIndex().."FoodPoisoning") then timer.Remove(ply:EntIndex().."FoodPoisoning") end
			
		timer.Create(ply:EntIndex().."FoodPoisoning", 30, 30, function()
			if ply:Alive() and ply.FoodPoisoning == true then
				dmg:SetDamage(math.random(0,2))
				dmg:SetDamageType( DMG_NERVEGAS )
				ply:TakeDamageInfo(dmg)
				--ply:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav", 50)
			else
				timer.Remove(ply:EntIndex().."FoodPoisoning")
				ply.FoodPoisoning = false
			end
		end)
	end
    return true -- returning true removes the item after use
end

impulse.RegisterItem(ITEM)

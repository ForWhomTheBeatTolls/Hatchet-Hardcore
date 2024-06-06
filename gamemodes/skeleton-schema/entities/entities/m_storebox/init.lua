AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

if SERVER then
	function ENT:Initialize() 
		self:SetUseType(SIMPLE_USE)
		self:SetModel("models/props/CS_militia/footlocker01_open.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)  
		self:SetMoveType(SOLID_VPHYSICS)  
		self:SetSolid(SOLID_VPHYSICS)  
		self.Loot = "lootbox"
		self:AddEffects(EF_ITEM_BLINK)


    	local physObj = self:GetPhysicsObject()
    	self.nodupe = true

    	if IsValid(physObj) then
			physObj:Wake()
		end
	end
			local ran = math.random(1, 1000)
			local badloot = "util_scrapmetal"
			local meleeloot = {
			"wep_axe",
			"wep_crowbar",
			"wep_pipe",
			"wep_shovel"
			}
			local medloot = {
			"util_electronics",
			"tool_flashlight",
			"util_battery"
			}
			local clothingloot = {
			"clothing_fadedshirt",
			"clothing_blueofficeshirt",
			"clothing_brownpants",
			"clothing_graypants",
			"clothing_fingerlessgloves",
			"clothing_gloves",
			"clothing_glasses",
			"clothing_graybeanie",
			"clothing_greenbeanie",
			"clothing_blackpants",
			"clothing_greenshirt",
			"clothing_medicalshirt",
			"clothing_beigeshirt",
			"clothing_whiteofficeshirt",
			"clothing_officepants"
			}
			local foodloot = {
			"food_chips",
			"food_watermelon",
			"food_halfpizza",
			"food_pizza"
			}	
			local highloot = {
			"ammo_smg",
			"ammo_pistol",
			"ammo_shotgun",
			"ammo_revolver",
			"ammo_rifle"
			}
			local superloot = "wep_revolver"
			
	-- ##########################################################
	-- ###Shitty unoptimal code because tables suck. Womp womp###
	-- ##########################################################
	
	util_battery = "util_battery"
	tool_flashlight = "tool_flashlight"
	util_scrapmetal = "util_scrapmetal"
	ammo_smg = "ammo_smg"
	ammo_pistol = "ammo_pistol"
	ammo_revolver = "ammo_revolver"
	ammo_shotgun = "ammo_shotgun"
	ammo_rifle = "ammo_rifle"
	wep_revolver = "wep_revolver"
	util_electronics = "util_electronics"
	wep_crowbar = "wep_crowbar"
	wep_axe = "wep_axe"
	wep_pipe = "wep_pipe"
	wep_shovel = "wep_shovel"
	clothing_fadedshirt = "clothing_fadedshirt"
	clothing_blueofficeshirt = "clothing_blueofficeshirt"
	clothing_brownpants = "clothing_brownpants"
	clothing_graypants = "clothing_graypants"
	clothing_fingerlessgloves = "clothing_fingerlessgloves"
	clothing_gloves = "clothing_gloves"
	clothing_glasses = "clothing_glasses"
	clothing_graybeanie = "clothing_graybeanie"
	clothing_greenbeanie = "clothing_greenbeanie"
	clothing_blackpants = "clothing_blackpants"
	clothing_greenshirt = "clothing_greenshirt"
	clothing_medicalshirt = "clothing_medicalshirt"
	clothing_beigeshirt = "clothing_beigeshirt"
	clothing_whiteofficeshirt = "clothing_whiteofficeshirt"
	clothing_officepants = "clothing_officepants"
	food_chips = "food_chips"
	food_watermelon = "food_watermelon"
	food_halfpizza = "food_halfpizza"
	food_pizza = "food_pizza"
	
	
	
	local NextLoot = CurTime() --+ 1
	--local boxloot = table.Random(lootbox)
	local niceitemnames = {
	[util_scrapmetal] = "Scrap Metal",
	[ammo_smg] = "a Box of SMG Ammo",
	[ammo_pistol] = "a Box of Pistol Ammo",
	[ammo_revolver] = "a Box of Revolver Ammo",
	[wep_revolver] = "a Magnum Revolver",
	[ammo_rifle] = "a Box of Rifle Ammo",
	[util_electronics] = "Functional Electronics",
	[wep_axe] = "an Axe",
	[wep_crowbar] = "a Crowbar",
	[wep_pipe] = "a Pipe",
	[wep_shovel] = "a Shovel",
	[clothing_fadedshirt] = "a Faded Shirt",
	[clothing_blueofficeshirt] = "a Blue Office Shirt",
	[clothing_brownpants] = "Brown Pants",
	[clothing_graypants] = "Gray Pants",
	[clothing_fingerlessgloves] = "a set of Fingerless Gloves",
	[clothing_gloves] = "a set of Gloves",
	[clothing_glasses] = "a pair of Glasses",
	[clothing_graybeanie] = "a Gray Beanie",
	[clothing_greenbeanie] = "a Green Beanie",
	[clothing_blackpants] = "Black Pants",
	[clothing_greenshirt] = "a Green Shirt",
	[clothing_medicalshirt] = "a Medic Shirt",
	[clothing_beigeshirt] = "a Beige Shirt",
	[clothing_whiteofficeshirt] = "a White Office Shirt",
	[clothing_officepants] = "Office Pants",
	[food_chips] = "a bag of Chips",
	[food_watermelon] = "a Watermelon",
	[food_halfpizza] = "half a slice of Pizza",
	[food_pizza] = "a slice of Pizza",
	[util_battery] = "a Battery",
	[tool_flashlight] = "a Flashlight"
	}
	local niceloottables = {
	[superloot] = "a Super Rare",
	[highloot] = "a Very Rare",
	[foodloot] = "an Uncommon",
	[clothingloot] = "an Uncommon",
	[medloot] = "an Uncommon",
	[badloot] = "a Common"
	}
	
	function ENT:Use(activator, caller)
	if NextLoot < CurTime() and !caller:IsCP() then
	if ran < 500 then
	looteditem = badloot
	looteditemtable = "a Common"
	caller:EmitSound("physics/concrete/concrete_impact_soft2.wav", 50, 80, 0.8)
	elseif ran < 600 and ran > 500 then
	looteditem = table.Random(medloot)
	looteditemtable = "an Uncommon"
	caller:EmitSound("physics/concrete/concrete_impact_soft1.wav", 50, 85, 0.8)
	elseif ran < 700 and ran > 600 then
	looteditem = table.Random(clothingloot)
	looteditemtable = "an Uncommon"
	caller:EmitSound("physics/concrete/rock_impact_hard5.wav", 50, 90, 0.8)
	elseif ran < 820 and ran > 700 then
	looteditem = table.Random(foodloot)
	looteditemtable = "an Uncommon"
	caller:EmitSound("physics/concrete/rock_impact_hard6.wav", 50, 95, 0.8)
	elseif ran < 900 and ran > 820 then
	looteditem = table.Random(meleeloot)
	looteditemtable = "an Uncommon"
	caller:EmitSound("physics/concrete/concrete_impact_hard3.wav", 50, 100, 0.8)
	elseif ran < 998 and ran > 900 then
	looteditem = table.Random(highloot)
	looteditemtable = "a Very Rare"
	caller:EmitSound("physics/concrete/concrete_impact_hard1.wav", 50, 105, 0.8)
	elseif ran >= 998 then
	looteditem = superloot
	looteditemtable = "a Super Rare"
	caller:EmitSound("physics/concrete/concrete_impact_hard2.wav", 50, 120, 0.8)
	end
	
	local lootitem = caller:GiveInventoryItem(looteditem, 1, false)
	caller:Notify("You looted " ..niceitemnames[looteditem].. " from the box.")
	caller:Say("/me looted "..looteditemtable.." item from the box.")
	NextLoot = CurTime() + 300
	self:RemoveEffects(EF_ITEM_BLINK)
	timer.Create(self:EntIndex().."StartBlink", NextLoot, 1, function() self:AddEffects(EF_ITEM_BLINK) end )
	elseif caller:IsCP() then
	caller:Notify("You need to be a Citizen to interact with this entity.")
	elseif NextLoot > CurTime() then
	caller:Notify("It's empty.")
	end
end

	function ENT:OnRemove()
	 timer.Remove("StartBlink")
	 end
	
	--function ENT:Think()
	--if CurTime() == NextLoot then
	--self:AddEffects(EF_ITEM_BLINK)
	--else
	--self:RemoveEffects(EF_ITEM_BLINK)
	end
--end
--end

local ITEM = {}

ITEM.UniqueID = "util_fuel"
ITEM.Name = "Gasoline Canister"
ITEM.Desc = "A jerry can filled with flammable fuel."
ITEM.Weight = 10
ITEM.Model = Model("models/props_junk/gascan001a.mdl")
ITEM.FOV = 16.568767908309
ITEM.CamPos = Vector(-17.191976547241, 16.618911743164, 100)

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.UseName = "Fill"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Filling..."
ITEM.UseWorkBarSound = "ambient/water/leak_1.wav"
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSoundLooping = true 

function ITEM:OnUse(ply, door)

		ply:DoCustomAnimEvent( PLAYERANIMEVENT_ATTACK_GRENADE, 279 )
			if door:GetClass() == "m_barrel" and door:GetNWInt("Filled") == false then
				door:EmitSound("ambient/water/water_spray1.wav")
				door:SetNWInt("Filled", true)
				ply:Say("/me fills up a barrel with fuel.")	
				return true
			else 
				ply:Notify("You need something to pour this into.")
			end
		


	    -- --ply:EmitSound("weapons/357/357_reload4.wav")
		-- --ply:Notify("You have successfully lockpicked the door.")
	
	end

function ITEM:ShouldTraceUse(ply, ent)
    -- if ent:IsPropDoor() then
        -- return false
    -- end
	
	-- if not ent:IsDoor() then
		-- return false
	-- end

	local group = ent:GetSyncVar(SYNC_DOOR_GROUP, nil)

	if ent:GetNWInt("Filled", true) == false then
		return true
	else
		return false
	end
end

impulse.RegisterItem(ITEM)

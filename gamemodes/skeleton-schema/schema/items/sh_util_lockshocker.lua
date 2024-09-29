local ITEM = {}

ITEM.UniqueID = "util_lockshocker"
ITEM.Name = "Combine Lock Shocker"
ITEM.Desc = "Can be used to fry combine locks."
ITEM.Weight = 2.5
ITEM.Model = Model("models/props_citizen_tech/transponder.mdl")
ITEM.FOV = 16.568767908309
ITEM.CamPos = Vector(-17.191976547241, 16.618911743164, 100)

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.CanStack = false

local zapsounds = {
"ambient/energy/zap3.wav",
"ambient/energy/zap2.wav",
"ambient/energy/zap1.wav",
"ambient/energy/zap7.wav"
}

local openabledoors = {
"introom_door_1",
"barney_door_2",
"storage_room_door",
"CombineLockedDoor_01",
"CombineLockedDoor_02"
}

function ITEM:OnUse(ply, door)
	local returnedlsh
	if table.HasValue(openabledoors, door:GetName()) then
		returnedlsh = true
	else
		returnedlsh = false
	end
	--print("what")
	--local chance = math.random(1, 100)
	--local skill = ply:GetSkillLevel("lockpick")

	--if chance < (75 + ((skill * 2) * 1.4)) then
		ply:DoCustomAnimEvent( PLAYERANIMEVENT_ATTACK_GRENADE, 279 )

		if door:IsPlayer() and door:GetModel() == "models/vortigaunt_slave.mdl" then
			door:SetModel("models/vortigaunt.mdl")
			ply:Notify("You freed the vortigaunt from his shackles.")
			door:Notify("You have been freed from your shackles.")
			return
		end
		timer.Simple( 1, function ()
		if returnedlsh == true then
			door:EmitSound("buttons/combine_button2.wav")
		else 
			ply:Notify("There's no lock to use this on.")
		end
		
		end)
		
		timer.Simple( 3, function()
		if door:IsPropDoor() then
			if returnedlsh == true then
			door:EmitSound(table.Random(zapsounds[ math.random( #zapsounds ) ]))
			door:Fire("open", "", 0)
            door:Fire("setanimation", "open", 0)
			end
        else
			if returnedlsh == true then
			door:EmitSound(zapsounds[ math.random( #zapsounds ) ])
        	door:Fire("unlock", "", 0)
			door:Fire("open", "", 0)
			end
		end
		end)
		timer.Simple( 6, function()
			

		door:Fire("close", "", 0)

	    -- --ply:EmitSound("weapons/357/357_reload4.wav")
		-- --ply:Notify("You have successfully lockpicked the door.")
	end)
	
	return returnedlsh
	
	end

function ITEM:ShouldTraceUse(ply, ent)
    if ent:IsPropDoor() then
        return false
    end
	
	-- if not ent:IsDoor() then
	-- 	return false
	-- end

	if ent:GetModel() == "models/vortigaunt_slave.mdl" then
		return true
	end

	local group = ent:GetSyncVar(SYNC_DOOR_GROUP, nil)

	if ent:GetClass() == "func_door" then
		return false
	else
		return true
	end
end

impulse.RegisterItem(ITEM)

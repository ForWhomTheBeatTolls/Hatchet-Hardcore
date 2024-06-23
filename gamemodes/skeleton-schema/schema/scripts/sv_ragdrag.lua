function DragTheBody(ply,key)
	if ( key == IN_WALK ) then
	local tr = ply:GetEyeTrace()
	local ragdoll = tr.Entity
	local bone = tr.PhysicsBone
	if !(ragdoll:GetClass() == "prop_ragdoll") then return end
	local Distance = ply:GetPos():Distance( ragdoll:GetPos() )
	if ( Distance < 100 ) then
	if !constraint.HasConstraints(ply or ragdoll) then
	if ply.knropedragdelay then return end
	if ply:Crouching() then return end
	if constraint.HasConstraints(ply) then return end
	local draghack = ents.Create ("entity_ropedraghackkn")
	draghack:SetPos(ply:GetEyeTrace().HitPos)
	draghack:SetCollisionGroup(COLLISION_GROUP_WORLD)
	draghack:Spawn()
	constraint.Weld(ragdoll,draghack,tr.PhysicsBone,0,0,true,false)
	constraint.Rope(ply,draghack,0,0,(ply:GetRight() * 0) + (ply:GetForward() * 0) + (ply:GetUp() * 50),Vector(0,0,0),0,-60,8000,0,"cable/rope",false)
	ply.knropedragdelay = true
	timer.Simple(1,function() ply.knropedragdelay = false end)
	end
		end
	end
end
hook.Add("KeyPress","DragTheBodyKNROPE",DragTheBody)

hook.Add( "KeyPress", "key_press_speedremoveropeknragdoll", function( ply, ent )
    if ( key == IN_SPEED ) then
    constraint.RemoveAll(ply)
	end
end )

hook.Add( "PlayerUse", "WowDisknragdoll", function( ply, ent )
	if constraint.HasConstraints(ply) then
	local canenter = false
	constraint.RemoveAll(ply)
    return false
	end
end )

hook.Add( "KeyPress", "keypress_jump_superknragdoll", function( ply, key )
	if ( key == IN_SPEED ) then
		constraint.RemoveAll(ply)
	end
end )

hook.Add( "KeyRelease", "makehimwalkslooowanddontsprintman__superknragdoll", function( ply, key )
	if ( key == IN_WALK ) then
	if constraint.HasConstraints(ply) then
	constraint.RemoveAll(ply)
		end
	end
end )

hook.Add("VC_CanEnterPassengerSeat", "VC_CanEnterPassengerSeatknragdoll", function(ply, seat, veh)
	if constraint.HasConstraints(ply) then
	local canenter = false
	constraint.RemoveAll(ply)
	return canenter
	end
end)

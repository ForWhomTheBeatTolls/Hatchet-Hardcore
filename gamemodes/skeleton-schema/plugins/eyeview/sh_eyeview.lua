-- Eye View is a addon that sets the player's view to any attachment on the playermodel.

impulse.DefineSetting("eyeview_fov", {name="Firstperson FOV", category="View", type="slider", default=90, minValue=70, maxValue=100})
function EYEVIEW_Initialize()

	if ( CLIENT ) then
		
        --eyeview_enabled = true
		EYEVIEW_THINK_DELAY = 0
		CreateClientConVar( "eyeview_enabled", "0", true, true )
		CreateClientConVar( "eyeview_radius", "1", true, true)
        
	end

end

local crossr = GetConVarNumber( "eyeview_crossr" )
local crossg = GetConVarNumber( "eyeview_crossg" )
local crossb = GetConVarNumber( "eyeview_crossb" )
local fov = impulse.GetSetting("eyeview_fov")

hook.Add( "Initialize", "EYEVIEW_Initialize", EYEVIEW_Initialize )


function EYEVIEW_Think()

	if ( CLIENT ) then
	
		if ( EYEVIEW_THINK_DELAY < CurTime() ) then
			
			if LocalPlayer():IsPlayer() and ( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ) ) then
			
				-- if ( GetConVar( "eyeview_enabled" ):GetBool() && ( LocalPlayer():IsValid() && LocalPlayer():Alive() ) ) then
				
					-- LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 0, 0, 0 ) )
				
				-- else
					if eyeview_enabled != false then
					--LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 0, 0, 0 ) )
					LocalPlayer():SetBodygroup(5,0)
                    else
                    --LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 1, 1, 1 ) )
					--LocalPlayer():SetBodygroup(5,0)
                    end
					--ply:SetSyncVar(SYNC_COS_HEAD, nil, true)
				--end
			
			end
			EYEVIEW_THINK_DELAY = CurTime() + 0.1
		
		end
		
	end
	
end

hook.Add( "Think", "EYEVIEW_Think", EYEVIEW_Think )


if ( CLIENT ) then

function EYEVIEW_CalcView( ply, origin, angles, fov, near, far )
	if impulse.GetSetting("view_thirdperson") then return end
	
	if ply:Alive() and ply:GetActiveWeapon():IsValid() then

	if ( ply:IsValid() && ply:Alive() && ply:GetMoveType() != MOVETYPE_NOCLIP && (ply:GetActiveWeapon():GetClass() != "gmod_tool") && ( IsValid(impulse.MainMenu) and not impulse.MainMenu:IsVisible() ) && (ply:GetActiveWeapon():GetClass() != "weapon_physgun") && ply:Ping() < 240 ) then
		
		---------------------###CHECKS START###---------------------
		local headcheck = {}
		headcheck.start =  LocalPlayer():GetBonePosition(LocalPlayer():LookupBone("ValveBiped.Bip01_Head1"))
		headcheck.endpos = headcheck.start + Vector(0,0,5)
		--headcheck.endpos = headcheck.start - Vector(0,0,5)
		headcheck.filter = function(ent)
			return ( ent:GetClass() == "prop_physics" )
		end
		local hc = util.TraceLine(headcheck)
		hpos = hc.HitPos
		hent = hc.Entity
		hit = hc.Hit
		
		local headcheck2 = {}
		headcheck2.start =  LocalPlayer():GetBonePosition(LocalPlayer():LookupBone("ValveBiped.Bip01_Head1"))
		headcheck2.endpos = headcheck2.start - Vector(0,0,25)
		--headcheck.endpos = headcheck.start - Vector(0,0,5)
		headcheck2.filter = function(ent)
			return ( ent:GetClass() == "prop_physics" )
		end
		local hc2 = util.TraceLine(headcheck2)
		hpos2 = hc2.HitPos
		hent2 = hc2.Entity
		hit2 = hc2.Hit
		
		local clipcheck = util.TraceHull( {
	start = LocalPlayer():GetBonePosition(LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")) + Vector(1,0,-3)	,
	endpos = LocalPlayer():GetBonePosition(LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")) + Vector(1,0,-3) ,
	filter = LocalPlayer()	,
	mins = Vector( -7.5, -7.5, -7.5 ),
	maxs = Vector( 7.5, 7.5, 7.5 ),
	mask = LocalPlayer()
} )
		local clipcheckhit = clipcheck.Hit
		
		---------------------###CHECKS END###---------------------
		
		local eyeview = {}
		if ( ply:LookupAttachment( "eyes" ) ) then
		
		if hit then
			eyeview.origin = hpos - Vector(0,0,5)
		elseif hit2 then
			eyeview.origin = hpos2 - Vector(0,0,15)
		elseif clipcheckhit and clipcheck.Entity:Class() != "player" then
			LocalPlayer():ScreenFade( SCREENFADE.IN, Color(0,0,80,255), 0.1, 0 )
		else
			eyeview.origin = LocalPlayer():GetAttachment( LocalPlayer():LookupAttachment("eyes") ).Pos
		end
		
		else
		
			eyeview.origin = origin
		
		end
		
			eyeview.angles = angles
            eyeview.znear = 4.8
		
		eyeview.fov = impulse.GetSetting("eyeview_fov")
		
		if impulse.GetSetting("view_thirdperson") then
		eyeview_enabled = false
        --LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 1, 1, 1 ) )
		--print(eyeview_enabled)
		local angles = LocalPlayer():GetAimVector():Angle()
		local targetpos = Vector(0, 0, 60)

		if LocalPlayer():KeyDown(IN_DUCK) then
			if LocalPlayer():GetVelocity():Length() > 0 then
				targetpos.z = 50
			else
				targetpos.z = 40
			end
		end

		LocalPlayer():SetAngles(angles)

		local pos = targetpos

		local offset = Vector(5, 5, 5)

		offset.x = 75
		offset.y = 20
		offset.z = 5
		angles.yaw = angles.yaw + 3
		
		local t = {}

		t.start = LocalPlayer():GetPos() + pos
		t.endpos = t.start + angles:Forward() * -offset.x

		t.endpos = t.endpos + angles:Right() * offset.y
		t.endpos = t.endpos + angles:Up() * offset.z
		t.filter = function(ent)
			if ent == LocalPlayer() then
				return false
			end
			
			if ent.GetNoDraw(ent) then
				return false
			end

			return true
		end
		
		local tr = util.TraceLine(t)

		pos = tr.HitPos

		if (tr.Fraction < 1.0) then
			pos = pos + tr.HitNormal * 5
		end

		local fov = impulse.GetSetting("view_thirdperson_fov")
		local wep = LocalPlayer():GetActiveWeapon()

		if wep and IsValid(wep) and wep.GetIronsights and not wep.NoThirdpersonIronsights then
			fov = Lerp(FrameTime() * 15, wep.FOVMultiplier, wep:GetIronsights() and wep.IronsightsFOV or 1) * fov
		end
		
		local delta = LocalPlayer():EyePos() - origin + Vector(0,0,0)
		
		--LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 1, 1, 1 ) )
		
		return {
			origin = pos + delta,
			angles = angles,
			fov = fov,
            znear = 25
		}
		else 
		eyeview_enabled = true
		--print(eyeview_enabled)
	end

		return eyeview
	
	end

end
end
hook.Add( "CalcView", "EYEVIEW_CalcView", EYEVIEW_CalcView )

function EYEVIEW_ShouldDrawLocalPlayer( ply )
	
	if ply:GetActiveWeapon():IsValid() then

	if ( ply:IsValid() && ply:Alive() && ply:GetMoveType() != MOVETYPE_NOCLIP && (ply:GetActiveWeapon():GetClass() != "gmod_tool") && ( IsValid(impulse.MainMenu) and not impulse.MainMenu:IsVisible() ) && (ply:GetActiveWeapon():GetClass() != "weapon_physgun") && ply:Ping() < 240 ) then
	
		return true
	
	end

end
end
hook.Add( "ShouldDrawLocalPlayer", "EYEVIEW_ShouldDrawLocalPlayer", EYEVIEW_ShouldDrawLocalPlayer )

/*
function EYEVIEW_HUDPaint()

    if LocalPlayer():IsValid() && LocalPlayer():Alive() then

        --surface.SetDrawColor( Color( 0, 0, 0, 125 ) )
        --surface.DrawRect( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 2, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 2, 6, 6 )
        --surface.SetDrawColor( Color( crossr, crossg, crossb, 255 ) )
        --surface.DrawLine( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, 4, 4 )
	local x, y = 0,0
	local crosshairGap = 2
	local crosshairLength = crosshairGap + 2
	local radius = impulse.GetSetting("crosshair_radius")
	surface.SetDrawColor(255, 255, 255)
	--surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, radius, 246, 163, 67, 200)
	surface.DrawRect(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 2, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 2, 4, 4)
    end

end
--hook.Add( "HUDPaint", "EYEVIEW_HUDPaint", EYEVIEW_HUDPaint )



*/
end

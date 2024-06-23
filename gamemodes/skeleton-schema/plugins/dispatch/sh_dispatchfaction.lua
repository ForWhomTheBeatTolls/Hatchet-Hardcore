function DispatchGameplay()
    for k,v in pairs(player.GetAll()) do
        local ply = Entity(v:EntIndex())
        if SERVER then
            if ply:Team() == TEAM_DISPATCH then
                if IsValid(ply) and ply:Alive() then
                    local trace = ply:GetEyeTrace()
                    local angle = trace.HitNormal:Angle()
                    local pos = ply:GetPos()

                    if ply:KeyPressed(IN_ATTACK) then
                        ply:SetPos(Vector(trace.HitPos.x, trace.HitPos.y, trace.HitPos.z + 906))
                    end

                    if ply:GetMoveType() == 8 then
                        return 
                    else
                        ply:SetMoveType(MOVETYPE_NOCLIP)
                        ply:SetNoDraw(true)
                        ply:SetEyeAngles( Angle(90, 0, 0) )
                        ply:SetPos(Vector(-2800.254639, -1782.679443, 906))
                    end
                else
                    return
                end
            elseif ply:Team() != TEAM_DISPATCH then
                if IsValid(ply) and ply:Alive() then
                    if not ply:IsAdmin() then
                        if ply:GetMoveType() == 8 then
                            ply:Spawn() -- weird fix for spectator freezing..
                            ply:SetMoveType(MOVETYPE_WALK)
                            ply:SetNoDraw(false)
                        else
                            return
                        end
                    end
                end
            end
        end

        local function DispatchHUD()


            hook.Add("HUDPaint", "DispatchHUD", function()
                local background = Material("effects/tvscreen_noise002a")
                surface.SetMaterial(background)
                surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

                CMB_OVERLAY = Material("effects/combine_binocoverlay")
                CMB_OVERLAY:SetFloat("$salpha", "0.2")
                CMB_OVERLAY:Recompute()

                surface.SetMaterial(CMB_OVERLAY)
                surface.DrawTexturedRect(0, 0, ScrW(), ScrH())


                for _, x in pairs(player.GetAll()) do
                    if x:Team() == TEAM_CP or x:Team() == TEAM_OTA then
                        local pos = x:GetPos():ToScreen()
                        local name = x:Name()
                        local TeamCol = Color(team.GetColor(x:Team()).r, team.GetColor(x:Team()).g, team.GetColor(x:Team()).b, 255)

                        surface.SetDrawColor(TeamCol)
                        surface.DrawRect(pos.x, pos.y, 8, 8)

                        surface.SetTextPos(pos.x, pos.y + 8)
                        surface.SetTextColor(TeamCol)
                        surface.SetFont("Impulse-Elements32")
                        surface.DrawText(name)

                    end
                end

                surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 6, 0, 0, 255, 255)
                surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 4, 0, 0, 0, 255)
                surface.DrawCircle(LocalPlayer():GetEyeTrace().HitPos:ToScreen().x, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y, 7, 0, 0, 0, 255)
            end)
        end

        if CLIENT then
            if LocalPlayer():Team() == TEAM_DISPATCH then
                if LocalPlayer():Alive() then
                    DispatchHUD()

                    local tab = {
                        [ "$pp_colour_addr" ] = 0.02,
                        [ "$pp_colour_addg" ] = 0.02,
                        [ "$pp_colour_addb" ] = 0,
                        [ "$pp_colour_brightness" ] = 0,
                        [ "$pp_colour_contrast" ] = 2,
                        [ "$pp_colour_colour" ] = 0,
                        [ "$pp_colour_mulr" ] = 0,
                        [ "$pp_colour_mulg" ] = 0.02,
                        [ "$pp_colour_mulb" ] = 0
                    }
                    
                    hook.Add( "RenderScreenspaceEffects", "DispatchColorView", function()
                        DrawColorModify( tab )
                    end )

                    hook.Add("CalcView", "DispatchView", function(player, origin, angles, fov)
                        local view = {
                            origin = LocalPlayer():GetPos(),
                            angles = Angle(90, 0, 0),
                            fov = fov,
                            drawviewer = true
                        }
                    
                        return view
                    end)

                    --sound.PlayFile( "sound/ambient/machines/combine_terminal_loop1.wav", "noplay", function( ambience, errCode, errStr )
                    --    if ( IsValid( ambience ) ) then
                    --        ambience:Play()
                    --        ambience:EnableLooping(true)
                    --    else
                    --        print( "Error playing sound!", errCode, errStr )
                    --    end
                    --end )

                    if LocalPlayer():KeyPressed(IN_ATTACK) then
                        LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0), .1, 4)

                        LocalPlayer():SetEyeAngles( Angle(90, 0, 0) )

                        surface.PlaySound("buttons/button19.wav")
                        surface.PlaySound("ambient/machines/combine_terminal_idle3.wav")
                        --ambient/machines/combine_terminal_loop1.wav
                    end
                end
            else
                hook.Remove("HUDPaint", "DispatchHUD")
                hook.Remove("CalcView", "DispatchView")
                hook.Remove( "RenderScreenspaceEffects", "DispatchColorView")
            end
        end
    end
end

local delay = 0
hook.Add("Think", "GameplayThinker", function()
	--if CurTime() < delay then return end
	DispatchGameplay()
	--delay = CurTime() + .5
end)

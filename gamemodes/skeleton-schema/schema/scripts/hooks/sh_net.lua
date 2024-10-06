net.Receive("HatchetBubbleChatCall", function()
    local msg = net.ReadString()
    local clr = net.ReadColor()
    local font = net.ReadString()
    local chatradius = net.ReadUInt(10)
    local ply = net.ReadPlayer()
    local sender = Entity(ply:EntIndex())
    local team
    if sender:Team() == TEAM_CITIZEN then
        team = "Citizen"
    elseif sender:Team() == TEAM_WORKFORCE then
        team = "Workforce"
    elseif sender:Team() == TEAM_CP then
        team = "Civil Protection"
    else
        team = " "
    end

    if string.StartsWith(msg, "/") and not string.StartsWith(msg, "/apply") then msg = "" end
    if string.StartsWith(msg, "/apply") and team ~= " " then
        msg = "[ID] " .. sender:Nick() .. " | " .. team
    elseif string.StartsWith(msg, "apply") and team == " " then
        msg = ""
    end

--     pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.head")) + sender:OBBCenter()):ToScreen()
-- else
--     pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.Bip01_Spine1")) + sender:OBBCenter()):ToScreen()

    local textPos = 1
    local nextTime = 0
    local boneindex
    local boneindex2

    hook.Add("HUDPaint", ply:SteamID() .. "_OverheadChatHUD", function()
        if sender:IsValid() and sender:Alive() and (sender:GetMoveType() ~= MOVETYPE_NOCLIP) then

            -- if sender:Team() == TEAM_VORTIGAUNT then
            --     pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.head")) + sender:OBBCenter()):ToScreen()
            -- elseif sender:GetModel() == "models/player.mdl" then
            --     pos = sender:GetPos()
            -- end

            if ply:Team() == TEAM_VORTIGAUNT then
                boneindex = sender:LookupBone("ValveBiped.head") or 1
            elseif sender:GetModel() == "models/player.mdl" then
                boneindex = 1
            else
                boneindex = sender:LookupBone("ValveBiped.Bip01_Head1") or 1
            end
            local pos = sender:GetBonePosition(boneindex):ToScreen() or sender:GetPos()

            local posdist = sender:GetPos()
            if sender:IsValid() and LocalPlayer():GetPos():Distance(posdist) <= chatradius and LocalPlayer():IsLineOfSightClear(sender) then
                if CurTime() > nextTime and textPos ~= string.len(msg) then
                    textPos = textPos + 1
                    nextTime = CurTime() + .04
                    if string.len(msg) > 1 and font ~= "BubbleChat-Me" then
                        sender:EmitSound("vo/npc/male01/answer" .. math.random(10, 40) .. ".wav", 10, 100, 0.0001, CHAN_VOICE)
                        if sender:Team() == TEAM_CITIZEN or sender:Team() == TEAM_RESISTANCE or sender:Team() == TEAM_WORKFORCE then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 80, .2)
                        elseif sender:Team() == TEAM_CP then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 50, .2)
                        elseif sender:Team() == TEAM_OTA then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 40, .2)
                        elseif sender:Team() == TEAM_VORTIGAUNT then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 60, .2)
                        end
                    end
                end

                draw.SimpleTextOutlined(string.sub(msg, 1, textPos), font, pos.x, pos.y - 120, clr, TEXT_ALIGN_CENTER, nil, 1, Color(0, 0, 0))
            end
        end
    end)

    local textremovetime
    local leng = string.len(msg)
    if leng <= 20 then
        textremovetime = 3
    elseif leng <= 40 then
        textremovetime = 5
    elseif leng <= 80 then
        textremovetime = 8
    elseif leng <= 120 then
        textremovetime = 12
    else
        textremovetime = 18
    end

    if IsValid(ply) then timer.Create(ply:SteamID() .. "_RemoveOverheadChat", textremovetime, 1, function() if IsValid(ply) then hook.Remove("HUDPaint", ply:SteamID() .. "_OverheadChatHUD") end end) end
end)

net.Receive("HatchetBubbleChatCall", function()
    local msg = net.ReadString()
    local clr = net.ReadColor()
    local font = net.ReadString()
    local chatradius = net.ReadUInt(10)
    local ply = net.ReadPlayer()
    local sender = Entity(ply:EntIndex())

    if string.StartsWith(msg, "/") then
        msg = ""
    end

    local textPos = 1
	local pos
    local nextTime = 0

    hook.Add("HUDPaint", ply:SteamID().."_OverheadChatHUD", function()
        if ( sender:IsValid() and sender:Alive() and (sender:GetMoveType() != MOVETYPE_NOCLIP) ) then
			if (sender:GetModel() != "models/player.mdl") then
            pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.Bip01_Spine1")) + sender:OBBCenter()):ToScreen()
			end
            local posdist = sender:GetPos()
            if sender:IsValid() and LocalPlayer():GetPos():Distance( posdist ) <= chatradius and LocalPlayer():IsLineOfSightClear(sender) then
                if CurTime() > nextTime and textPos != string.len(msg) then
                    textPos = textPos + 1
                    nextTime = CurTime() + .08
                    if string.len(msg) > 1 and font != "BubbleChat-Me" then
                        sender:EmitSound("vo/npc/male01/answer"..math.random(10,40)..".wav", 10, 100, 0.0001, CHAN_VOICE)
                        if sender:Team() == TEAM_CITIZEN or sender:Team() == TEAM_RESISTANCE or sender:Team() == TEAM_WORKFORCE then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 80, 1)
                        elseif sender:Team() == TEAM_CP then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 50, 1)
                        elseif sender:Team() == TEAM_OTA then
                            sender:EmitSound("hatchet/buttonrollover.wav", 100, 40, 1)
                        end
                    end
                end
                draw.SimpleTextOutlined(string.sub(msg, 1, textPos), font, pos.x, pos.y, clr, TEXT_ALIGN_CENTER, nil, 1, Color(0, 0, 0))
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

    timer.Create(ply:SteamID().."_RemoveOverheadChat", textremovetime, 1, function()
        //print("Removed: "..ply:SteamID())
        if IsValid(ply) then
            hook.Remove("HUDPaint", ply:SteamID().."_OverheadChatHUD")
        end
    end)



    //print(ply:SteamID().."_OverheadChatHUD")
end)

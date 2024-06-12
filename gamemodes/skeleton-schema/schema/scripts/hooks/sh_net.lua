

net.Receive("HatchetBubbleChatCall", function()
    local msg = net.ReadString()
    local clr = net.ReadColor()
    local font = net.ReadString()
    local ply = net.ReadPlayer()
    local sender = Entity(ply:EntIndex())

    local textt = msg.."."

    local textappear = true

    hook.Add("HUDPaint", ply:SteamID().."_OverheadChatHUD", function()
        local pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.Bip01_Pelvis")) + sender:OBBCenter()):ToScreen()
        if textappear then
            draw.SimpleTextOutlined(textt, font, pos.x, pos.y, clr, TEXT_ALIGN_CENTER, nil, 1, Color(0, 0, 0))
        end
    end)

    timer.Create("RemoveTheHook", 4, 1, function()
        //print("Removed: "..ply:SteamID())
        textt = ""
    end)



    //print(ply:SteamID().."_OverheadChatHUD")
end)

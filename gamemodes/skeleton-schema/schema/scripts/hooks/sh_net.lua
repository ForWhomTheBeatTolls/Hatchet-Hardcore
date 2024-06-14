

net.Receive("HatchetBubbleChatCall", function()
    local msg = net.ReadString()
    local clr = net.ReadColor()
    local font = net.ReadString()
    local ply = net.ReadPlayer()
    local sender = Entity(ply:EntIndex())

    local textappear = true

    // This is fucking 100% cancerous dude, i swear this is like the devil of all coding.
    // If you're a code stealer and want to steal this code, Please dont, not that its because we worked hard on it, but its more that
    // we hope you will not follow this method of coding.
    // (also fuck you if ur gonna use this by stealing)

    // I hope there will be a better way

    if string.StartsWith(msg, "/ac") then
        msg = ""
    elseif string.StartsWith(msg, "/ooc") then
        msg = ""
    elseif string.StartsWith(msg, "/looc") then
        msg = ""
    elseif string.StartsWith(msg, "//.") then
        msg = ""
    elseif string.StartsWith(msg, "//") then
        msg = ""
    elseif string.StartsWith(msg, "/event") then
        msg = ""
    elseif string.StartsWith(msg, "/itemspawner") then
        msg = ""
    elseif string.StartsWith(msg, "/bring") then
        msg = ""
    elseif string.StartsWith(msg, "/goto") then
        msg = ""
    elseif string.StartsWith(msg, "/giveitem") then
        msg = ""
    elseif string.StartsWith(msg, "/kick") then
        msg = ""
    elseif string.StartsWith(msg, "/ban") then
        msg = ""
    end

    //i want to kill myself with a shotgun.

    hook.Add("HUDPaint", ply:SteamID().."_OverheadChatHUD", function()
        if ( sender:IsValid() and sender:Alive() and sender:GetMoveType() != MOVETYPE_NOCLIP and sender:IsEffectActive(EF_NODRAW) != true ) then
            local pos = (sender:GetBonePosition(sender:LookupBone("ValveBiped.Bip01_Spine1")) + sender:OBBCenter()):ToScreen()
            local posdist = sender:GetPos()
            if sender:IsValid() and LocalPlayer():GetPos():Distance( posdist ) <= 418 then
                if textappear then
                    draw.SimpleTextOutlined(msg, font, pos.x, pos.y, clr, TEXT_ALIGN_CENTER, nil, 1, Color(0, 0, 0))
                end
            end
        end
    end)

    timer.Create("RemoveTheHook", 4, 1, function()
        //print("Removed: "..ply:SteamID())
        textt = ""
    end)



    //print(ply:SteamID().."_OverheadChatHUD")
end)

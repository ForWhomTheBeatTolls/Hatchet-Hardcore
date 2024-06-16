net.Receive("HatchetBubbleChatCall", function()
    local msg = net.ReadString()
    local clr = net.ReadColor()
    local font = net.ReadString()
    local ply = net.ReadPlayer()
    local sender = Entity(ply:EntIndex())
    local grabthatname = ply:SteamID().."_OverheadChatHUD"

    local textappear = true

	if string.StartsWith(msg, "/") then
        msg = ""
    end

    hook.Add("HUDPaint", grabthatname, function()
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
	
    local HookTbl = hook.GetTable()

    timer.Create("RemoveTheHook", 4, 1, function()
        //print("Removed: "..ply:SteamID())
        if HookTbl["HUDPaint"][grabthatname] then
            hook.Remove("HUDPaint", grabthatname)
            textt = ""
        else
            return
            print("Avoided!")
        end
    end)
end)

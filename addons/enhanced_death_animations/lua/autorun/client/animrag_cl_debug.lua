

local Draw_Tb = {}

hook.Add("HUDPaint", "Animrag_DrawHpBar", function()
	for ent, v in pairs(Draw_Tb) do
		if IsValid(ent) then
			local DrawPos
			local headID = ent:LookupBone("ValveBiped.Bip01_Head1")
			if headID then
				DrawPos = (ent:GetBonePosition(headID) + Vector(0, 0, 10)):ToScreen()
			else
				DrawPos = (ent:GetPos() + Vector(0, 0, 75)):ToScreen()
			end
			local x = DrawPos.x
			local y = DrawPos.y
			local w = 200
			local h = 20
			local w_hp
			local hp_convert = tonumber(ent.hp, 10)
			local maxhp_convert = tonumber(ent.maxhp, 10)
			if hp_convert and maxhp_convert then
				w_hp = (hp_convert/maxhp_convert)*w
			else
				w_hp = w
			end
			
			draw.NoTexture()
			draw.RoundedBox(10, x-w/2, y-h/2, w, h, Color(50, 50, 50, 200))
			draw.RoundedBox(10, x-w/2, y-h/2, w_hp, h, Color(255, 0, 0, 200))
			draw.SimpleText("HP: " .. ent.hp .. " / " .. ent.maxhp, "DermaDefault", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(ent.anim, "DermaDefault", x, y-25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			Draw_Tb[ent] = nil
		end
	end
end)


net.Receive("AnimRag_DrawHPDebugBar_sTc", function()
	local ent = Entity(net.ReadInt(32))
	ent.hp = net.ReadString()
	ent.maxhp = net.ReadString()
	ent.anim = net.ReadString()
	
	Draw_Tb[ent] = true
end)
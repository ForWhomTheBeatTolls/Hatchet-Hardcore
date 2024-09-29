
file.CreateDir("enhanced_death_animations")


concommand.Add("ARag_panel_update", function()

	local window = vgui.Create("DFrame")
	window:SetSize(600, 800)
	window:Center()
	window:SetTitle("")
	window:SetDraggable(true)
	window:MakePopup()
	window.Paint = function(self, w, h)
		draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 235))
		draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 235))
		draw.SimpleText("Enhanced Death Animations", "DermaLarge", 300, 20, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	function window:OnClose()
		RunConsoleCommand("ARag_panel")
	end


	local SubTitle = vgui.Create("DLabel", window)
	SubTitle:SetPos(230, 65)
	SubTitle:SetFont("CreditsOutroText")
	SubTitle:SetText("Something Newwwwww!")
	SubTitle:SetColor(Color(100, 100, 100, 100))
	SubTitle:SizeToContents()

	local Red_panel = vgui.Create("DPanel", window)
	Red_panel:SetPos(70, 105)
	Red_panel:SetSize(460, 35)
	Red_panel:SetBackgroundColor( Color(255, 51, 51, 255) )

	---------------------------
	local label_1= vgui.Create("RichText", window)
	label_1:SetPos(70, 120)
	label_1:SetSize(800, 800)

	surface.CreateFont("UpdateFont", {
		font = "Louis George Cafe",
		size = 16,
		weight = 1000,
		antialias = true,
	})

	label_1:InsertColorChange(235, 235, 235, 255)
	function label_1:PerformLayout()
		self:SetFontInternal("UpdateFont")
	end

	label_1:AppendText(" Sorry for interruption but there have been some HUUUGE Updates! ")



	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n01 -----------------------------------------------------------------------01")

	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nA Whole Revive System!")
	
	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\nWith this system, the following functions can be realized")
	label_1:AppendText("\n\n1-NPCs can sneakily revive themselves if there's no enemy watching")
	label_1:AppendText("\n2-If a NPC is down, his nearby allies will rush to revive him")
	label_1:AppendText("\n3-You can revive yourself if you got killed")
	label_1:AppendText("\n4-You can revive your allies, or EVEN revive enemies and make them ally")
	label_1:AppendText("\n5-And many other details")



	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n02 -----------------------------------------------------------------------02")

	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nA New Settings Panel (Better than nothing)")

	//label_1:InsertColorChange(10, 10, 10, 200)
	//label_1:AppendText("\n\nBetter than nothing")


	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n03 -----------------------------------------------------------------------04")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nOther Changes")

	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\n1-Finger Animation now works")
	label_1:AppendText("\n2-Better DeathCam, now you can rotate your head during crawling")
	label_1:AppendText("\n3-A more detailed Overkill System")
	label_1:AppendText("\n4-Animations now can fit NPCs of all sizes, from biggest to smallest")
	label_1:AppendText("\n5-Haven't teseted in MultiPlayer, and feel free to report bugs")


	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n04 -----------------------------------------------------------------------03")

	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nConvars Reset !!!☢☢☢")

	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\nDue to the Overhaul in codes, ehhh, I think it's better to reset all settings")
	label_1:AppendText("\nOnly Menu Convars, Your changes in Animation Selector remain untouched")
	label_1:AppendText("\nVery very sorry for that")
end)


local function ARag_Update_Detect()

	local update_file = file.Open("enhanced_death_animations/UpdateInfo4.txt", "r", "DATA")

	if not update_file then
		file.Write("enhanced_death_animations/UpdateInfo4.txt", "0")
		RunConsoleCommand("ARag_panel_update")

		--server
		RunConsoleCommand("ARag_enab_d", 1)
		RunConsoleCommand("ARag_odds_d", 1)
		RunConsoleCommand("ARag_headshot", 0)
		RunConsoleCommand("ARag_natural", 2)
		RunConsoleCommand("ARag_nobackshot", 0)

		RunConsoleCommand("ARag_enab_c", 1)
		RunConsoleCommand("ARag_odds_c", 0.6)
		RunConsoleCommand("ARag_odds_c_hp", 1)
		RunConsoleCommand("ARag_delay_min", 4)
		RunConsoleCommand("ARag_delay_max", 8)
		RunConsoleCommand("ARag_avoid_p", 0)
		RunConsoleCommand("ARag_avoid_e", 1)
		RunConsoleCommand("ARag_avoid_dist", 100)
		RunConsoleCommand("ARag_random", 1)
		RunConsoleCommand("ARag_ply_allycrawl", 1)

		RunConsoleCommand("ARag_enab_ally_r", 1)
		RunConsoleCommand("ARag_enab_self_r", 1)
		RunConsoleCommand("ARag_r_hp_portion", 0)
		RunConsoleCommand("ARag_r_hp_portion_v", 0.5)
		RunConsoleCommand("ARag_r_hp_portion_p", 0)
		RunConsoleCommand("ARag_r_hp_inherit", 1)
		RunConsoleCommand("ARag_r_hp_inherit_p", 1)
		RunConsoleCommand("ARag_no_2nd_crawl", 1)
		RunConsoleCommand("ARag_no_2nd_crawl_p", 1)

		RunConsoleCommand("ARag_player_1", 0)
		RunConsoleCommand("ARag_player_2", 1)
		RunConsoleCommand("ARag_player_crawl", 1)

		RunConsoleCommand("ARag_female", 0)
		RunConsoleCommand("ARag_zombie", 1)
		RunConsoleCommand("ARag_zombie_crawl", 0)
		RunConsoleCommand("ARag_clean_e", 0)
		RunConsoleCommand("ARag_clean", 30)
		RunConsoleCommand("ARag_finger", 1)
		RunConsoleCommand("ARag_scalerag", 1)
		RunConsoleCommand("ARag_blood", 1)
		RunConsoleCommand("ARag_blood_usetime", 0)
		RunConsoleCommand("ARag_blood_time", 0.3)
		RunConsoleCommand("ARag_blood_dist", 10)
		RunConsoleCommand("ARag_healthbar", 0)

		RunConsoleCommand("ARag_overkill_fix_enable_d", 0)
		RunConsoleCommand("ARag_overkill_fix_value_d", 50)
		RunConsoleCommand("ARag_overkill_max_enable_d", 1)
		RunConsoleCommand("ARag_overkill_max_value_d", 1)

		RunConsoleCommand("ARag_overkill_fix_enable_c", 0)
		RunConsoleCommand("ARag_overkill_fix_value_c", 50)
		RunConsoleCommand("ARag_overkill_max_enable_c", 0)
		RunConsoleCommand("ARag_overkill_max_value_c", 1)
		RunConsoleCommand("ARag_overkill_inherit_hp", 1)

		RunConsoleCommand("ARag_overkill_overflow_enable", 0)
		RunConsoleCommand("ARag_overkill_overflow_value", 0.5)

		RunConsoleCommand("ARag_overkill_crush_damage", 0.1)
		--server
		---------------
		--client
		RunConsoleCommand("ARag_cam", 1)
		RunConsoleCommand("ARag_hair", 0)
		RunConsoleCommand("ARag_camz", 75)

		RunConsoleCommand("ARag_ply_key", 17)
		RunConsoleCommand("ARag_ply_r_ally", 1)
		RunConsoleCommand("ARag_ply_r_enemy", 1)
		RunConsoleCommand("ARag_ply_r_self", 1)

		RunConsoleCommand("ARag_ply_hud_cir", 0)
		RunConsoleCommand("ARag_ply_hud_r", 80)
		RunConsoleCommand("ARag_ply_hud_g", 180)
		RunConsoleCommand("ARag_ply_hud_b", 152)
		RunConsoleCommand("ARag_ply_hud_a", 152)
		RunConsoleCommand("ARag_ply_hud_rad", 70)
		RunConsoleCommand("ARag_ply_hud_seg", 6)
		--client
	end

end


ARag_Update_Detect()
include("autorun/client/00_animrag_panel_preset_sum.lua")
include("autorun/server/animrag_allconvar.lua")

local Menu_Name_Tb = {
	["menu_empty"] = "Enhancing Death/menu_empty.png",
	["menu_death"] = "Enhancing Death/menu_death.png",
	["menu_crawl"] = "Enhancing Death/menu_crawl.png",
	["menu_revive"] = "Enhancing Death/menu_revive.png",
	["menu_overkill"] = "Enhancing Death/menu_overkill.png",
	["menu_player"] = "Enhancing Death/menu_player.png",
	["menu_others"] = "Enhancing Death/menu_others.png"
}


----------------------------------------------------------------------------------------
--下面要用到的函数，用于在切换“大标题”时，更新菜单里各个元素（按钮、滑块等）的显示
local function Menu_Refresh_Menu(Window, Menu, Category, ElementTb, ElementTb_AllTb)
	for _, Tb in pairs(ElementTb_AllTb) do
		if Tb == ElementTb then
			for _, Element in pairs(Tb) do
				Element:SetVisible(true)
			end
		else
			for _, Element in pairs(Tb) do
				Element:SetVisible(false)
			end
		end
	end
end


----------------------------------------------------------------------------------------
--创建最左边的“大标题”的DButton
local function Menu_Create_Button_Category(Window, Menu, y, Category, ElementTb, ElementTb_AllTb)
	local Created_Button = vgui.Create("DButton", Window)	
	Created_Button:SetPos(0, y)
	Created_Button:SetSize(326, 90)
	Created_Button:SetText("")
	Created_Button.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end

	Created_Button.DoClick = function()
		Menu:SetImage(Menu_Name_Tb[Category])
		Menu_Refresh_Menu(Window, Menu, Category, ElementTb, ElementTb_AllTb)
		surface.PlaySound("Enhancing Death/menu_button1.wav")
		surface.PlaySound("Enhancing Death/slider.wav")
	end

	return Created_Button
end


----------------------------------------------------------------------------------------
--创建大号的DButton（都是用于打开新菜单的DButton）
local function Menu_Create_Button_Big(Window, y, CvarOrFunction)
	local Created_Button = vgui.Create("DImageButton", Window)	
	Created_Button:SetPos(423, y)
	Created_Button:SetSize(777, 55)
	Created_Button:SetText("")
	Created_Button:SetImage("Enhancing Death/bigbutton_off.png")
	Created_Button.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end

	Created_Button.OnCursorEntered = function()
		Created_Button:SetImage("Enhancing Death/bigbutton_on.png")
	end
	Created_Button.OnCursorExited = function()
		Created_Button:SetImage("Enhancing Death/bigbutton_off.png")
	end

	Created_Button.DoClick = function()
		if isstring(CvarOrFunction) then
			RunConsoleCommand(CvarOrFunction)
		else
			CvarOrFunction()
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	return Created_Button
end


----------------------------------------------------------------------------------------
--创建两个在一起的DButton
local function Menu_Create_Button_Double(Window, y, Cvar1, Cvar2)
	local B1 = vgui.Create("DImageButton", Window)	
	B1:SetPos(900, y)
	B1:SetSize(95, 14)
	B1:SetText("")
	if GetConVar(Cvar1):GetBool() then
		B1:SetImage("Enhancing Death/button_on_m.png")
	else
		B1:SetImage("Enhancing Death/button_off_m.png")
	end
	B1.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	B1.DoClick = function()
		if GetConVar(Cvar1):GetBool() then
			RunConsoleCommand(Cvar1, "0")
			B1:SetImage("Enhancing Death/button_off_m.png")
		else
			RunConsoleCommand(Cvar1, "1")
			B1:SetImage("Enhancing Death/button_on_m.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end


	local B2 = vgui.Create("DImageButton", Window)	
	B2:SetPos(1005, y)
	B2:SetSize(95, 14)
	B2:SetText("")
	if GetConVar(Cvar2):GetBool() then
		B2:SetImage("Enhancing Death/button_on_m.png")
	else
		B2:SetImage("Enhancing Death/button_off_m.png")
	end
	B2.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	B2.DoClick = function()
		if GetConVar(Cvar2):GetBool() then
			RunConsoleCommand(Cvar2, "0")
			B2:SetImage("Enhancing Death/button_off_m.png")
		else
			RunConsoleCommand(Cvar2, "1")
			B2:SetImage("Enhancing Death/button_on_m.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	return B1, B2
end


----------------------------------------------------------------------------------------
--创建普通型的DButton
local function Menu_Create_Button(Window, y, Cvar)
	local Created_Button = vgui.Create("DImageButton", Window)	
	Created_Button:SetPos(900, y)
	Created_Button:SetSize(200, 14)
	Created_Button:SetText("")
	if GetConVar(Cvar):GetBool() then
		Created_Button:SetImage("Enhancing Death/button_on.png")
	else
		Created_Button:SetImage("Enhancing Death/button_off.png")
	end
	Created_Button.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	Created_Button.DoClick = function()
		if GetConVar(Cvar):GetBool() then
			RunConsoleCommand(Cvar, "0")
			Created_Button:SetImage("Enhancing Death/button_off.png")
		else
			RunConsoleCommand(Cvar, "1")
			Created_Button:SetImage("Enhancing Death/button_on.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	return Created_Button
end


----------------------------------------------------------------------------------------
--创建普通型的DNumSlider
local function Menu_Create_Slider(Window, y, Cvar, min, max, decimal, round)
	//local Created_Slider_Back = vgui.Create("DImage", Window)
	//Created_Slider_Back:SetPos(900, y)
	//Created_Slider_Back:SetSize(200, 14)
	//Created_Slider_Back:SetImage("Enhancing Death/slider_back.png")

	local Created_Slider = vgui.Create("DNumSlider", Window)	
	Created_Slider:SetPos(745, y)
	Created_Slider:SetSize(355, 14)
	Created_Slider:SetDark(true)
	//Created_Slider:GetTextArea():SetPaintBackground(true)
	Created_Slider:GetTextArea():SetSize(35, 14)
	Created_Slider:GetTextArea():SetTextColor(Color(255, 0, 0, 100))
	Created_Slider:GetTextArea():SetFont("DefaultFixed")
	Created_Slider:SetMin(min)
	Created_Slider:SetMax(max)
	Created_Slider:SetDecimals(decimal)
	Created_Slider:SetConVar(Cvar)
	Created_Slider.Tm = CurTime()
	Created_Slider.OnValueChanged = function(self, value)
		if round then
			self:SetValue(math.Round(value))
		end
		if CurTime() >= Created_Slider.Tm then
			surface.PlaySound("Enhancing Death/slider.wav")
			Created_Slider.Tm = CurTime() + 0.1
		end
	end

	return Created_Slider
end


----------------------------------------------------------------------------------------
--创建Min/Max型的DNumSlider
local function Menu_Create_Slider_MinMax(Window, y, Cvar_min, Cvar_max, min, max, decimal, round)
	//local Created_Slider_Back = vgui.Create("DImage", Window)
	//Created_Slider_Back:SetPos(900, y)
	//Created_Slider_Back:SetSize(200, 14)
	//Created_Slider_Back:SetImage("Enhancing Death/slider_back_2.png")

	local Created_Slider_Max = vgui.Create("DNumSlider", Window)	
	Created_Slider_Max:SetPos(925, y)
	Created_Slider_Max:SetSize(175, 14)
	Created_Slider_Max:SetDark(true)
	Created_Slider_Max:GetTextArea():SetSize(35, 14)
	Created_Slider_Max:GetTextArea():SetTextColor(Color(255, 0, 0, 100))
	Created_Slider_Max:GetTextArea():SetFont("DefaultFixed")
	Created_Slider_Max:SetMin(min)
	Created_Slider_Max:SetMax(max)
	Created_Slider_Max:SetDecimals(decimal)
	Created_Slider_Max:SetConVar(Cvar_max)
	Created_Slider_Max.Tm = CurTime()
	Created_Slider_Max.OnValueChanged = function(self, value)
		if round then
			self:SetValue(math.Round(value))
		end
		if CurTime() >= Created_Slider_Max.Tm then
			surface.PlaySound("Enhancing Death/slider.wav")
			Created_Slider_Max.Tm = CurTime() + 0.1
		end
	end

	local Created_Slider_Min = vgui.Create("DNumSlider", Window)	
	Created_Slider_Min:SetPos(820, y)
	Created_Slider_Min:SetSize(175, 14)
	Created_Slider_Min:SetDark(true)
	Created_Slider_Min:GetTextArea():SetSize(35, 14)
	Created_Slider_Min:GetTextArea():SetTextColor(Color(255, 0, 0, 100))
	Created_Slider_Min:GetTextArea():SetFont("DefaultFixed")
	Created_Slider_Min:SetMin(min)
	Created_Slider_Min:SetMax(max)
	Created_Slider_Min:SetDecimals(decimal)
	Created_Slider_Min:SetConVar(Cvar_min)
	Created_Slider_Min.Tm = CurTime()
	Created_Slider_Min.OnValueChanged = function(self, value)
		if round then
			self:SetValue(math.Round(value))
		end
		if CurTime() >= Created_Slider_Min.Tm then
			surface.PlaySound("Enhancing Death/slider.wav")
			Created_Slider_Min.Tm = CurTime() + 0.1
		end
	end

	return Created_Slider_Min, Created_Slider_Max
end


----------------------------------------------------------------------------------------
--创建DButton与DNumSlider的混合
local function Menu_Create_Button_AND_Slider(Window, y, Cvar_button, Cvar_slider, min, max, decimal, round)
	--DNumSlider
	//local Created_Slider_Back = vgui.Create("DImage", Window)
	//Created_Slider_Back:SetPos(960, y)
	//Created_Slider_Back:SetSize(140, 14)
	//Created_Slider_Back:SetImage("Enhancing Death/slider_back_3.png")

	local Created_Slider = vgui.Create("DNumSlider", Window)	
	Created_Slider:SetPos(848, y)
	Created_Slider:SetSize(252, 14)
	Created_Slider:SetDark(true)
	Created_Slider:GetTextArea():SetSize(35, 14)
	Created_Slider:GetTextArea():SetTextColor(Color(255, 0, 0, 100))
	Created_Slider:GetTextArea():SetFont("DefaultFixed")
	Created_Slider:SetMin(min)
	Created_Slider:SetMax(max)
	Created_Slider:SetDecimals(decimal)
	Created_Slider:SetConVar(Cvar_slider)
	Created_Slider.Tm = CurTime()
	Created_Slider.OnValueChanged = function(self, value)
		if round then
			self:SetValue(math.Round(value))
		end
		if CurTime() >= Created_Slider.Tm then
			surface.PlaySound("Enhancing Death/slider.wav")
			Created_Slider.Tm = CurTime() + 0.1
		end
	end

	--DButton
	local Created_Button = vgui.Create("DImageButton", Window)	
	Created_Button:SetPos(900, y)
	Created_Button:SetSize(50, 14)
	Created_Button:SetText("")
	if GetConVar(Cvar_button):GetBool() then
		Created_Button:SetImage("Enhancing Death/button_on_s.png")
	else
		Created_Button:SetImage("Enhancing Death/button_off_s.png")
	end
	Created_Button.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	Created_Button.DoClick = function()
		if GetConVar(Cvar_button):GetBool() then
			RunConsoleCommand(Cvar_button, "0")
			Created_Button:SetImage("Enhancing Death/button_off_s.png")
		else
			RunConsoleCommand(Cvar_button, "1")
			Created_Button:SetImage("Enhancing Death/button_on_s.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	return Created_Button, Created_Slider
end


----------------------------------------------------------------------------------------
--REIVIE SYSTME中的Player的那三个按钮的专用
local function Menu_Create_Button_3PLY(Window, y, Cvar1, Cvar2, Cvar3)
	--第一个按钮
	local B1 = vgui.Create("DImageButton", Window)
	B1:SetPos(672, y)
	B1:SetSize(50, 14)
	B1:SetText("")
	if GetConVar(Cvar1):GetBool() then
		B1:SetImage("Enhancing Death/button_on_s.png")
	else
		B1:SetImage("Enhancing Death/button_off_s.png")
	end
	B1.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	B1.DoClick = function()
		if GetConVar(Cvar1):GetBool() then
			RunConsoleCommand(Cvar1, "0")
			B1:SetImage("Enhancing Death/button_off_s.png")
		else
			RunConsoleCommand(Cvar1, "1")
			B1:SetImage("Enhancing Death/button_on_s.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	--第二个按钮
	local B2 = vgui.Create("DImageButton", Window)
	B2:SetPos(876, y)
	B2:SetSize(50, 14)
	B2:SetText("")
	if GetConVar(Cvar2):GetBool() then
		B2:SetImage("Enhancing Death/button_on_s.png")
	else
		B2:SetImage("Enhancing Death/button_off_s.png")
	end
	B2.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	B2.DoClick = function()
		if GetConVar(Cvar2):GetBool() then
			RunConsoleCommand(Cvar2, "0")
			B2:SetImage("Enhancing Death/button_off_s.png")
		else
			RunConsoleCommand(Cvar2, "1")
			B2:SetImage("Enhancing Death/button_on_s.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	--第三个按钮
	local B3 = vgui.Create("DImageButton", Window)
	B3:SetPos(1050, y)
	B3:SetSize(50, 14)
	B3:SetText("")
	if GetConVar(Cvar3):GetBool() then
		B3:SetImage("Enhancing Death/button_on_s.png")
	else
		B3:SetImage("Enhancing Death/button_off_s.png")
	end
	B3.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	B3.DoClick = function()
		if GetConVar(Cvar3):GetBool() then
			RunConsoleCommand(Cvar3, "0")
			B3:SetImage("Enhancing Death/button_off_s.png")
		else
			RunConsoleCommand(Cvar3, "1")
			B3:SetImage("Enhancing Death/button_on_s.png")
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	return B1, B2, B3
end


----------------------------------------------------------------------------------------
--有时候需要让两个按钮互斥（一个为true则另一个为false），这个函数是用来当任何一方被按下时，同时更新这两个互斥的DButton的
local function DButton_Make_Exclusive(B1, B2, Cvar1, Cvar2, Img1_ON, Img1_OFF, Img2_ON, Img2_OFF)
	B1.DoClick = function()
		if GetConVar(Cvar1):GetBool() then
			RunConsoleCommand(Cvar1, "0")
			B1:SetImage(Img1_OFF)
		else
			RunConsoleCommand(Cvar1, "1")
			B1:SetImage(Img1_ON)
			if GetConVar(Cvar2):GetBool() then
				B2:SetImage(Img2_OFF)
			end
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end

	B2.DoClick = function()
		if GetConVar(Cvar2):GetBool() then
			RunConsoleCommand(Cvar2, "0")
			B2:SetImage(Img2_OFF)
		else
			RunConsoleCommand(Cvar2, "1")
			B2:SetImage(Img2_ON)
			if GetConVar(Cvar1):GetBool() then
				B1:SetImage(Img1_OFF)
			end
		end
		surface.PlaySound("Enhancing Death/menu_button2.wav")
	end
end
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Functions To Make Buttons AND Sliders


-- ↓ Functions To Make New Pannels
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--Ragdoll Crawl Away Settings的菜单
local function NewPanel_Crawl_Away_Settings()
	local CrawlAway_Window = vgui.Create("DFrame")
	CrawlAway_Window:SetSize(560, 800)
	CrawlAway_Window:Center()
	CrawlAway_Window:SetTitle("Setting for how Ragdoll crawls away")
	CrawlAway_Window:SetDraggable(true)
	CrawlAway_Window:MakePopup()

	local CrawlAway_Window_txt_S = vgui.Create("DLabel", CrawlAway_Window)
	CrawlAway_Window_txt_S:SetPos(52, 35)
	CrawlAway_Window_txt_S:SetFont("DefaultSmall")
	CrawlAway_Window_txt_S:SetText("The Ragdolls can crawl away from what they think is Dangerous" .. 
								"\nSettings below will determine what they should consider as \"Dangerous\"" .. 
								"\nYou can also decide how close an enemy should be, for them to crawl away" )
	CrawlAway_Window_txt_S:SetColor(Color(230, 230, 230, 235))
	CrawlAway_Window_txt_S:SizeToContents()


	---------------------------
	local Crawl_Player_Check_back = vgui.Create("DPanel", CrawlAway_Window)
	Crawl_Player_Check_back:SetPos(50, 90)
	Crawl_Player_Check_back:SetSize(455, 60)
	Crawl_Player_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Crawl_Player_Check = vgui.Create("DCheckBox", CrawlAway_Window)
	Crawl_Player_Check:SetPos(60, 95)
	Crawl_Player_Check:SetConVar("ARag_avoid_p")

	local Crawl_Player_Check_txt_L = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Player_Check_txt_L:SetPos(85, 95)
	Crawl_Player_Check_txt_L:SetFont("TargetIDSmall")
	Crawl_Player_Check_txt_L:SetText("NPC Crawl Away From Player")
	Crawl_Player_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Crawl_Player_Check_txt_L:SizeToContents()

	local Crawl_Player_Check_txt_S = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Player_Check_txt_S:SetPos(85, 115)
	Crawl_Player_Check_txt_S:SetFont("DefaultSmall")
	Crawl_Player_Check_txt_S:SetText("NPC will try to crawl away from all players, when you guys get too close to them")
	Crawl_Player_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Crawl_Player_Check_txt_S:SizeToContents()


	---------------------------
	local Crawl_Hostile_Check_back = vgui.Create("DPanel", CrawlAway_Window)
	Crawl_Hostile_Check_back:SetPos(50, 150)
	Crawl_Hostile_Check_back:SetSize(455, 60)
	Crawl_Hostile_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Crawl_Hostile_Check = vgui.Create("DCheckBox", CrawlAway_Window)
	Crawl_Hostile_Check:SetPos(60, 155)
	Crawl_Hostile_Check:SetConVar("ARag_avoid_e")

	local Crawl_Hostile_Check_txt_L = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Hostile_Check_txt_L:SetPos(85, 155)
	Crawl_Hostile_Check_txt_L:SetFont("TargetIDSmall")
	Crawl_Hostile_Check_txt_L:SetText("NPC Crawl Away From Hostile")
	Crawl_Hostile_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Crawl_Hostile_Check_txt_L:SizeToContents()

	local Crawl_Hostile_Check_txt_S = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Hostile_Check_txt_S:SetPos(85, 175)
	Crawl_Hostile_Check_txt_S:SetFont("DefaultSmall")
	Crawl_Hostile_Check_txt_S:SetText("NPC will try to crawl away from all hositle NPCs, it's a tricky math issue")
	Crawl_Hostile_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Crawl_Hostile_Check_txt_S:SizeToContents()		


	---------------------------
	local Crawl_Notice_back = vgui.Create("DPanel", CrawlAway_Window)
	Crawl_Notice_back:SetPos(50, 210)
	Crawl_Notice_back:SetSize(455, 65)
	Crawl_Notice_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Crawl_Notice_txt_S = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Notice_txt_S:SetPos(58, 225)
	Crawl_Notice_txt_S:SetFont("DefaultSmall")
	Crawl_Notice_txt_S:SetText("When lots of Hostiles are spreading all over, it will be tircky for the\nRagdoll to determine which direction they should be crawling towards")
	Crawl_Notice_txt_S:SetColor(Color(100, 100, 100, 150))
	Crawl_Notice_txt_S:SizeToContents()


	---------------------------
	local Crawl_Dist_Slider_back = vgui.Create("DPanel", CrawlAway_Window)
	Crawl_Dist_Slider_back:SetPos(50, 275)
	Crawl_Dist_Slider_back:SetSize(455, 80)
	Crawl_Dist_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Crawl_Dist_Slider = vgui.Create("DNumSlider", Crawl_Dist_Slider_back)
	Crawl_Dist_Slider:SetPos(-292, 0)
	Crawl_Dist_Slider:SetSize(710, 20)
	Crawl_Dist_Slider:SetDark(true)
	Crawl_Dist_Slider:SetMin(0)
	Crawl_Dist_Slider:SetMax(1000)
	Crawl_Dist_Slider:SetDecimals(0)
	Crawl_Dist_Slider:SetConVar("ARag_avoid_dist")

	local Crawl_Dist_Slider_txt_S = vgui.Create("DLabel", CrawlAway_Window)
	Crawl_Dist_Slider_txt_S:SetPos(58, 305)
	Crawl_Dist_Slider_txt_S:SetFont("DefaultSmall")
	Crawl_Dist_Slider_txt_S:SetText("When you are this distance close to the NPCs, they will crawl away.\nRecommend 100")
	Crawl_Dist_Slider_txt_S:SetColor(Color(100, 100, 100, 150))
	Crawl_Dist_Slider_txt_S:SizeToContents()


	---------------------------
	local Crawl_Blank = vgui.Create("DPanel", CrawlAway_Window)
	Crawl_Blank:SetPos(50, 355)
	Crawl_Blank:SetSize(455, 415)
	Crawl_Blank.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
end


----------------------------------------------------------------------------------------
--Player Revive Settings的菜单
local function NewPanel_Player_Revive_Settings()
	local Revive_Window = vgui.Create("DFrame")
	Revive_Window:SetSize(560, 800)
	Revive_Window:Center()
	Revive_Window:SetTitle("Setting for Player's Ability To Revive NPC/Self")
	Revive_Window:SetDraggable(true)
	Revive_Window:MakePopup()

	local Revive_Window_txt_S = vgui.Create("DLabel", Revive_Window)
	Revive_Window_txt_S:SetPos(52, 35)
	Revive_Window_txt_S:SetFont("DefaultSmall")
	Revive_Window_txt_S:SetText("Player can press a button to Revive a NPC, or Player himself (Must Be Crawling!)" .. 
								"\nTo Revive a NPC, simply get close to Crawling Ragdoll, and press the button" .. 
								"\nTo Revive Player self, simply press the button when your Ragdoll is Crawling" )
	Revive_Window_txt_S:SetColor(Color(230, 230, 230, 235))
	Revive_Window_txt_S:SizeToContents()


	---------------------------
	local Revive_Binder_back = vgui.Create("DPanel", Revive_Window)
	Revive_Binder_back:SetPos(50, 90)
	Revive_Binder_back:SetSize(455, 60)
	Revive_Binder_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Binder = vgui.Create("DBinder", Revive_Window)
	Revive_Binder:SetPos(250, 95)
	Revive_Binder:SetSize(210, 18)
	Revive_Binder:SetValue(GetConVar("ARag_ply_key"):GetInt())
	Revive_Binder.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 1, 1, w-2, h-2, Color(220, 220, 220, 235))
	end
	function Revive_Binder:OnChange(num)
		RunConsoleCommand("ARag_ply_key", num)
	end

	local Revive_Binder_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Binder_txt_L:SetPos(85, 95)
	Revive_Binder_txt_L:SetFont("TargetIDSmall")
	Revive_Binder_txt_L:SetText("Bind Your Revive KEY")
	Revive_Binder_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Binder_txt_L:SizeToContents()

	local Revive_Binder_txt_S = vgui.Create("DLabel", Revive_Window)
	Revive_Binder_txt_S:SetPos(85, 115)
	Revive_Binder_txt_S:SetFont("DefaultSmall")
	Revive_Binder_txt_S:SetText("This is the Key you will press when you want to revive somebody")
	Revive_Binder_txt_S:SetColor(Color(100, 100, 100, 150))
	Revive_Binder_txt_S:SizeToContents()


	---------------------------
	local Revive_Ally_Check_back = vgui.Create("DPanel", Revive_Window)
	Revive_Ally_Check_back:SetPos(50, 150)
	Revive_Ally_Check_back:SetSize(455, 60)
	Revive_Ally_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Ally_Check = vgui.Create("DCheckBox", Revive_Window)
	Revive_Ally_Check:SetPos(60, 155)
	Revive_Ally_Check:SetConVar("ARag_ply_r_ally")

	local Revive_Ally_Check_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Ally_Check_txt_L:SetPos(85, 155)
	Revive_Ally_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Ally_Check_txt_L:SetText("Player Can Revive Friendly NPC")
	Revive_Ally_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Ally_Check_txt_L:SizeToContents()

	local Revive_Ally_Check_txt_S = vgui.Create("DLabel", Revive_Window)
	Revive_Ally_Check_txt_S:SetPos(85, 175)
	Revive_Ally_Check_txt_S:SetFont("DefaultSmall")
	Revive_Ally_Check_txt_S:SetText("The NPC Must Be Crawling! Just go nearby and press your Key")
	Revive_Ally_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Revive_Ally_Check_txt_S:SizeToContents()


	---------------------------
	local Revive_Enemy_Check_back = vgui.Create("DPanel", Revive_Window)
	Revive_Enemy_Check_back:SetPos(50, 210)
	Revive_Enemy_Check_back:SetSize(455, 75)
	Revive_Enemy_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Enemy_Check = vgui.Create("DCheckBox", Revive_Window)
	Revive_Enemy_Check:SetPos(60, 215)
	Revive_Enemy_Check:SetConVar("ARag_ply_r_enemy")

	local Revive_Enemy_Check_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Enemy_Check_txt_L:SetPos(85, 215)
	Revive_Enemy_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Enemy_Check_txt_L:SetText("Player Can Revive Enemy NPC")
	Revive_Enemy_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Enemy_Check_txt_L:SizeToContents()

	local Revive_Enemy_Check_txt_S = vgui.Create("DLabel", Revive_Window)
	Revive_Enemy_Check_txt_S:SetPos(85, 235)
	Revive_Enemy_Check_txt_S:SetFont("DefaultSmall")
	Revive_Enemy_Check_txt_S:SetText("After Revive, the Enemy NPC will become your Ally instead" .. 
									"\nThis relationship may malfunction due to other NPC AI Addons")
	Revive_Enemy_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Revive_Enemy_Check_txt_S:SizeToContents()


	---------------------------
	local Revive_Self_Check_back = vgui.Create("DPanel", Revive_Window)
	Revive_Self_Check_back:SetPos(50, 285)
	Revive_Self_Check_back:SetSize(455, 75)
	Revive_Self_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Self_Check = vgui.Create("DCheckBox", Revive_Window)
	Revive_Self_Check:SetPos(60, 290)
	Revive_Self_Check:SetConVar("ARag_ply_r_self")

	local Revive_Self_Check_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Self_Check_txt_L:SetPos(85, 290)
	Revive_Self_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Self_Check_txt_L:SetText("Player Can Revive Himself")
	Revive_Self_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Self_Check_txt_L:SizeToContents()

	local Revive_Self_Check_txt_S = vgui.Create("DLabel", Revive_Window)
	Revive_Self_Check_txt_S:SetPos(85, 310)
	Revive_Self_Check_txt_S:SetFont("DefaultSmall")
	Revive_Self_Check_txt_S:SetText("When you are killed, At the time your Ragdoll starts to crawl," .. 
									"\nYou can press the Revive Key to Revive yourself")
	Revive_Self_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Revive_Self_Check_txt_S:SizeToContents()


	------------------------------------------------------
	---------------------------
	local Revive_Gap1 = vgui.Create("DPanel", Revive_Window)
	Revive_Gap1:SetPos(50, 360)
	Revive_Gap1:SetSize(455, 10)
	Revive_Gap1.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
	end

	local Revive_Gap = vgui.Create("DPanel", Revive_Window)
	Revive_Gap:SetPos(50, 370)
	Revive_Gap:SetSize(455, 40)
	Revive_Gap.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Gap_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Gap_txt_L:SetPos(185, 385)
	Revive_Gap_txt_L:SetFont("HudSelectionText")
	Revive_Gap_txt_L:SetText("Revive HUD CustomizatioN")
	Revive_Gap_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Gap_txt_L:SizeToContents()
	---------------------------
	------------------------------------------------------


	---------------------------
	local Revive_HUD_Demo_back = vgui.Create("DPanel", Revive_Window)
	Revive_HUD_Demo_back:SetPos(50, 410)
	Revive_HUD_Demo_back:SetSize(455, 200)
	Revive_HUD_Demo_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_HUD_Demo_StartTime = CurTime()
	local Revive_HUD_Demo = vgui.Create("DPanel", Revive_Window)
	Revive_HUD_Demo:SetPos(50, 410)
	Revive_HUD_Demo:SetSize(455, 200)
	Revive_HUD_Demo.Paint = function(self, w, h)

		local DrawCircle = GetConVar("ARag_ply_hud_cir"):GetBool()
		local R = GetConVar("ARag_ply_hud_r"):GetInt()
		local G = GetConVar("ARag_ply_hud_g"):GetInt()
		local B = GetConVar("ARag_ply_hud_b"):GetInt()
		local Alpha = GetConVar("ARag_ply_hud_a"):GetInt()
		local Rad = GetConVar("ARag_ply_hud_rad"):GetInt()
		local Segment = GetConVar("ARag_ply_hud_seg"):GetInt()

		local x = w/2
		local y = h/2	
		local RGB1 = Vector(255, 51, 51)
		local RGB2 = Vector(R, G, B)
		local Progress = math.min((CurTime() - Revive_HUD_Demo_StartTime)/4, 1)
		if Progress >= 1 then
			Progress = 0
			Revive_HUD_Demo_StartTime = CurTime()
		end
		local DrawCircle_Tb_Alpha = {}
		local DrawCircle_Tb_RGB = {}
		for i=1, Segment do
			DrawCircle_Tb_Alpha[i] = 0
			DrawCircle_Tb_RGB[i] = Vector(0, 0, 0)
		end

		if DrawCircle then
			------------------------------------
			--画圆形
			local cir = {}
			table.insert(cir, {x = x, y = y})
			for i=0, 100*Progress do 	--100为这个圆的边数（因为并不是圆，而是一个超级多边形）
				local a = math.rad((i/100) * -360)
				table.insert(cir, {x=x+math.sin(a)*Rad, y=y+math.cos(a)*Rad})
			end

			draw.NoTexture()
			surface.SetDrawColor(RGB2.x, RGB2.y, RGB2.z, Alpha)
			surface.DrawPoly(cir)
		else
			------------------------------------
			--画多边形			
			local Interval = 1/Segment
			
			--计算得到多边形每一片在这一帧的 RGB 和 Alpha
			for i = 1, Segment do
				if Progress >= (i-1)*Interval and Progress < i*Interval then
					local Progress_sub = Progress/Interval - (i-1)
					DrawCircle_Tb_Alpha[i] = Progress_sub*Alpha
					DrawCircle_Tb_RGB[i] = LerpVector(Progress_sub, RGB1, RGB2)
				elseif Progress >= i*Interval then
					DrawCircle_Tb_Alpha[i] = Alpha
					DrawCircle_Tb_RGB[i] = RGB2
				end
			end
			
			--根据上边得到的每一片 RGB 和 Alpha，开画
			local Angle_Cur = math.rad(270)
			for i = 1, Segment do
				local Angle_Next = Angle_Cur + math.rad(360/Segment)
				local V1 = {x = x+math.cos(Angle_Cur)*Rad, y = y+math.sin(Angle_Cur)*Rad}
				local V2 = {x = x+math.cos(Angle_Next)*Rad, y = y+math.sin(Angle_Next)*Rad}
				local V3 = {x = x, y = y}
				local RGB = DrawCircle_Tb_RGB[i]
				local Alpha = DrawCircle_Tb_Alpha[i]
				Angle_Cur = Angle_Next
				
				draw.NoTexture()
				surface.SetDrawColor(RGB.x, RGB.y, RGB.z, Alpha)
				surface.DrawPoly({V1, V2, V3})
			end
		end
	end


	---------------------------
	local Revive_ColorMixer_back = vgui.Create("DPanel", Revive_Window)
	Revive_ColorMixer_back:SetPos(50, 610)
	Revive_ColorMixer_back:SetSize(280, 160)
	Revive_ColorMixer_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_ColorMixer_back = vgui.Create("DColorMixer", Revive_Window)
	Revive_ColorMixer_back:SetPos(60, 620)
	Revive_ColorMixer_back:SetSize(260, 140)
	Revive_ColorMixer_back:SetPalette(false)
	Revive_ColorMixer_back:SetWangs(false)
	Revive_ColorMixer_back:SetConVarR("ARag_ply_hud_r")
	Revive_ColorMixer_back:SetConVarG("ARag_ply_hud_g")
	Revive_ColorMixer_back:SetConVarB("ARag_ply_hud_b")
	Revive_ColorMixer_back:SetConVarA("ARag_ply_hud_a")


	---------------------------
	local Revive_Circle_Check_back = vgui.Create("DPanel", Revive_Window)
	Revive_Circle_Check_back:SetPos(330, 610)
	Revive_Circle_Check_back:SetSize(175, 40)
	Revive_Circle_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Circle_Check = vgui.Create("DCheckBox", Revive_Window)
	Revive_Circle_Check:SetPos(475, 615)
	Revive_Circle_Check:SetConVar("ARag_ply_hud_cir")

	local Revive_Circle_Check_txt_L = vgui.Create("DLabel", Revive_Window)
	Revive_Circle_Check_txt_L:SetPos(340, 615)
	Revive_Circle_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Circle_Check_txt_L:SetText("Use Circle")
	Revive_Circle_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Circle_Check_txt_L:SizeToContents()


	---------------------------
	local Revive_Rad_Slider_back = vgui.Create("DPanel", Revive_Window)
	Revive_Rad_Slider_back:SetPos(330, 650)
	Revive_Rad_Slider_back:SetSize(175, 60)
	Revive_Rad_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Rad_Slider = vgui.Create("DNumSlider", Revive_Rad_Slider_back)
	Revive_Rad_Slider:SetPos(-130, 30)
	Revive_Rad_Slider:SetSize(320, 20)
	Revive_Rad_Slider:SetDark(true)
	Revive_Rad_Slider:SetMin(0)
	Revive_Rad_Slider:SetMax(200)
	Revive_Rad_Slider:SetDecimals(0)
	Revive_Rad_Slider:SetConVar("ARag_ply_hud_rad")
	Revive_Rad_Slider.OnValueChanged = function(self, value)
		self:SetValue(math.Round(value))
	end

	local Revive_Circle_Check_txt_L = vgui.Create("DLabel", Revive_Rad_Slider_back)
	Revive_Circle_Check_txt_L:SetPos(10, 5)
	Revive_Circle_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Circle_Check_txt_L:SetText("HUD Size")
	Revive_Circle_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Circle_Check_txt_L:SizeToContents()


	---------------------------
	local Revive_Seg_Slider_back = vgui.Create("DPanel", Revive_Window)
	Revive_Seg_Slider_back:SetPos(330, 710)
	Revive_Seg_Slider_back:SetSize(175, 60)
	Revive_Seg_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Revive_Seg_Slider = vgui.Create("DNumSlider", Revive_Seg_Slider_back)
	Revive_Seg_Slider:SetPos(-130, 30)
	Revive_Seg_Slider:SetSize(320, 20)
	Revive_Seg_Slider:SetDark(true)
	Revive_Seg_Slider:SetMin(0)
	Revive_Seg_Slider:SetMax(20)
	Revive_Seg_Slider:SetDecimals(0)
	Revive_Seg_Slider:SetConVar("ARag_ply_hud_seg")
	Revive_Seg_Slider.OnValueChanged = function(self, value)
		self:SetValue(math.Round(value))
	end

	local Revive_Circle_Check_txt_L = vgui.Create("DLabel", Revive_Seg_Slider_back)
	Revive_Circle_Check_txt_L:SetPos(10, 5)
	Revive_Circle_Check_txt_L:SetFont("TargetIDSmall")
	Revive_Circle_Check_txt_L:SetText("HUD Segment")
	Revive_Circle_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Revive_Circle_Check_txt_L:SizeToContents()
end


----------------------------------------------------------------------------------------
--Death Animation Overkill的菜单
local function NewPanel_Death_Animation_Overkill()
	local Overkill_Window = vgui.Create("DFrame")
	Overkill_Window:SetSize(560, 800)
	Overkill_Window:Center()
	Overkill_Window:SetTitle("Settings for Overkill Damage")
	Overkill_Window:SetDraggable(true)
	Overkill_Window:MakePopup()

	local Overkill_Window_txt_S = vgui.Create("DLabel", Overkill_Window)
	Overkill_Window_txt_S:SetPos(52, 35)
	Overkill_Window_txt_S:SetFont("DefaultSmall")
	Overkill_Window_txt_S:SetText("Make Ragdolls have HP, So you can \"Kill\" a Ragdoll and end its animation" .. 
								"\nFor Example, if you set Ragdoll's HP to 50, Then if you shoot the Ragdoll" .. 
								"\nAnd Dealt over 50 damage, Then the Ragdoll will stop animation and Die for real" )
	Overkill_Window_txt_S:SetColor(Color(230, 230, 230, 235))
	Overkill_Window_txt_S:SizeToContents()		


	---------------------------
	local Overkill_D_FixNumber_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_D_FixNumber_back:SetPos(50, 90)
	Overkill_D_FixNumber_back:SetSize(455, 60)
	Overkill_D_FixNumber_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_D_FixNumber_Slider = vgui.Create("DNumSlider", Overkill_D_FixNumber_back)
	Overkill_D_FixNumber_Slider:SetPos(-250, 5)
	Overkill_D_FixNumber_Slider:SetSize(660, 20)
	Overkill_D_FixNumber_Slider:SetDark(true)
	Overkill_D_FixNumber_Slider:SetMin(0)
	Overkill_D_FixNumber_Slider:SetMax(500)
	Overkill_D_FixNumber_Slider:SetDecimals(0)
	Overkill_D_FixNumber_Slider:SetConVar("ARag_overkill_fix_value_d")

	local Overkill_D_FixNumber_Check = vgui.Create("DCheckBox", Overkill_D_FixNumber_back)
	Overkill_D_FixNumber_Check:SetPos(10, 10)
	Overkill_D_FixNumber_Check:SetConVar("ARag_overkill_fix_enable_d")
	
	local Overkill_D_FixNumber_txt_S = vgui.Create("DLabel", Overkill_D_FixNumber_back)
	Overkill_D_FixNumber_txt_S:SetPos(10, 30)
	Overkill_D_FixNumber_txt_S:SetFont("DefaultSmall")
	Overkill_D_FixNumber_txt_S:SetText("Use Fixed Number as Ragdoll's HP for [Death Animation]")
	Overkill_D_FixNumber_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_D_FixNumber_txt_S:SizeToContents()


	---------------------------
	local Overkill_D_MaxHealth_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_D_MaxHealth_back:SetPos(50, 150)
	Overkill_D_MaxHealth_back:SetSize(455, 100)
	Overkill_D_MaxHealth_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_D_MaxHealth_Slider = vgui.Create("DNumSlider", Overkill_D_MaxHealth_back)
	Overkill_D_MaxHealth_Slider:SetPos(-250, 5)
	Overkill_D_MaxHealth_Slider:SetSize(660, 20)
	Overkill_D_MaxHealth_Slider:SetDark(true)
	Overkill_D_MaxHealth_Slider:SetMin(0)
	Overkill_D_MaxHealth_Slider:SetMax(5)
	Overkill_D_MaxHealth_Slider:SetDecimals(2)
	Overkill_D_MaxHealth_Slider:SetConVar("ARag_overkill_max_value_d")

	local Overkill_D_MaxHealth_Check = vgui.Create("DCheckBox", Overkill_D_MaxHealth_back)
	Overkill_D_MaxHealth_Check:SetPos(10, 10)
	Overkill_D_MaxHealth_Check:SetConVar("ARag_overkill_max_enable_d")
	
	local Overkill_D_MaxHealth_txt_S = vgui.Create("DLabel", Overkill_D_MaxHealth_back)
	Overkill_D_MaxHealth_txt_S:SetPos(10, 30)
	Overkill_D_MaxHealth_txt_S:SetFont("DefaultSmall")
	Overkill_D_MaxHealth_txt_S:SetText("Use Max Health as Ragdoll's HP for [Death Animation]" .. 
											"\ne.g - If bar set to \"0.4\" and your NPC's max health is 50," .. 
											"\nThen This NPC's Death Ragdoll's HP will be 50*0.4 = 20")
	Overkill_D_MaxHealth_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_D_MaxHealth_txt_S:SizeToContents()


	---------------------------
	local Overkill_D_txt_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_D_txt_back:SetPos(50, 250)
	Overkill_D_txt_back:SetSize(455, 50)
	Overkill_D_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_D_txt_S = vgui.Create("DLabel", Overkill_D_txt_back)
	Overkill_D_txt_S:SetPos(10, 10)
	Overkill_D_txt_S:SetFont("DefaultSmall")
	Overkill_D_txt_S:SetText("If both of above are disabled, then Death Ragdoll won't get Overkilled")
	Overkill_D_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_D_txt_S:SizeToContents()

	---------------------------
	local Overkill_D_Blank = vgui.Create("DPanel", Overkill_Window)
	Overkill_D_Blank:SetPos(50, 300)
	Overkill_D_Blank:SetSize(455, 470)
	Overkill_D_Blank.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
end


----------------------------------------------------------------------------------------
--Crawl Animation Overkill的菜单
local function NewPanel_Crawl_Animation_Overkill()
	local Overkill_Window = vgui.Create("DFrame")
	Overkill_Window:SetSize(560, 800)
	Overkill_Window:Center()
	Overkill_Window:SetTitle("Settings for Overkill Damage")
	Overkill_Window:SetDraggable(true)
	Overkill_Window:MakePopup()

	local Overkill_Window_txt_S = vgui.Create("DLabel", Overkill_Window)
	Overkill_Window_txt_S:SetPos(52, 35)
	Overkill_Window_txt_S:SetFont("DefaultSmall")
	Overkill_Window_txt_S:SetText("Make Ragdolls have HP, So you can \"Kill\" a Ragdoll and end its animation" .. 
								"\nFor Example, if you set Ragdoll's HP to 50, Then if you shoot the Ragdoll" .. 
								"\nAnd Dealt over 50 damage, Then the Ragdoll will stop animation and Die for real" )
	Overkill_Window_txt_S:SetColor(Color(230, 230, 230, 235))
	Overkill_Window_txt_S:SizeToContents()		


	---------------------------
	local Overkill_C_FixNumber_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_C_FixNumber_back:SetPos(50, 90)
	Overkill_C_FixNumber_back:SetSize(455, 60)
	Overkill_C_FixNumber_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_C_FixNumber_Slider = vgui.Create("DNumSlider", Overkill_C_FixNumber_back)
	Overkill_C_FixNumber_Slider:SetPos(-250, 5)
	Overkill_C_FixNumber_Slider:SetSize(660, 20)
	Overkill_C_FixNumber_Slider:SetDark(true)
	Overkill_C_FixNumber_Slider:SetMin(0)
	Overkill_C_FixNumber_Slider:SetMax(500)
	Overkill_C_FixNumber_Slider:SetDecimals(0)
	Overkill_C_FixNumber_Slider:SetConVar("ARag_overkill_fix_value_c")

	local Overkill_C_FixNumber_Check = vgui.Create("DCheckBox", Overkill_C_FixNumber_back)
	Overkill_C_FixNumber_Check:SetPos(10, 10)
	Overkill_C_FixNumber_Check:SetConVar("ARag_overkill_fix_enable_c")
	
	local Overkill_C_FixNumber_txt_S = vgui.Create("DLabel", Overkill_C_FixNumber_back)
	Overkill_C_FixNumber_txt_S:SetPos(10, 30)
	Overkill_C_FixNumber_txt_S:SetFont("DefaultSmall")
	Overkill_C_FixNumber_txt_S:SetText("Use Fixed Number as Ragdoll's HP for [Crawl Animation]")
	Overkill_C_FixNumber_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_C_FixNumber_txt_S:SizeToContents()


	---------------------------
	local Overkill_C_MaxHealth_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_C_MaxHealth_back:SetPos(50, 150)
	Overkill_C_MaxHealth_back:SetSize(455, 100)
	Overkill_C_MaxHealth_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_C_MaxHealth_Slider = vgui.Create("DNumSlider", Overkill_C_MaxHealth_back)
	Overkill_C_MaxHealth_Slider:SetPos(-250, 5)
	Overkill_C_MaxHealth_Slider:SetSize(660, 20)
	Overkill_C_MaxHealth_Slider:SetDark(true)
	Overkill_C_MaxHealth_Slider:SetMin(0)
	Overkill_C_MaxHealth_Slider:SetMax(5)
	Overkill_C_MaxHealth_Slider:SetDecimals(2)
	Overkill_C_MaxHealth_Slider:SetConVar("ARag_overkill_max_value_c")

	local Overkill_C_MaxHealth_Check = vgui.Create("DCheckBox", Overkill_C_MaxHealth_back)
	Overkill_C_MaxHealth_Check:SetPos(10, 10)
	Overkill_C_MaxHealth_Check:SetConVar("ARag_overkill_max_enable_c")
	
	local Overkill_C_MaxHealth_txt_S = vgui.Create("DLabel", Overkill_C_MaxHealth_back)
	Overkill_C_MaxHealth_txt_S:SetPos(10, 30)
	Overkill_C_MaxHealth_txt_S:SetFont("DefaultSmall")
	Overkill_C_MaxHealth_txt_S:SetText("Use Max Health as Ragdoll's HP for [Crawl Animation]" .. 
											"\ne.g - If bar set to \"0.4\" and your NPC's max health is 50," .. 
											"\nThen This NPC's Crawling Ragdoll's HP will be 50*0.4 = 20")
	Overkill_C_MaxHealth_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_C_MaxHealth_txt_S:SizeToContents()


	---------------------------
	local Overkill_Inherit_Check_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_Inherit_Check_back:SetPos(50, 250)
	Overkill_Inherit_Check_back:SetSize(455, 190)
	Overkill_Inherit_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Overkill_Inherit_Check = vgui.Create("DCheckBox", Overkill_Window)
	Overkill_Inherit_Check:SetPos(60, 255)
	Overkill_Inherit_Check:SetConVar("ARag_overkill_inherit_hp")

	local Overkill_Inherit_Check_txt_S = vgui.Create("DLabel", Overkill_Window)
	Overkill_Inherit_Check_txt_S:SetPos(60, 275)
	Overkill_Inherit_Check_txt_S:SetFont("DefaultSmall")
	Overkill_Inherit_Check_txt_S:SetText("Inherit Ragdoll's HP from Death Animation for [Crawl Animation]"..
										"\n\ne.g - If you set Death Ragdoll's HP to 50 in \"Death Aniamtion Overkill\"" ..
										"\nAnd now there's a NPC killed and its Ragdoll is playing Death Aniamtion," ..
										"\nNow, you shoot the Ragdoll, dealt 20 damage to it, Reducing its HP to 30," ..
										"\nSo, when the Death Animation ends and Crawl Animation starts," ..
										"\nThe Crawling Ragdoll will Inherit the HP of 30" ..
										"\n\n■ Make sure you set Death Ragdoll's HP in \"Death Animation Overkill\"" ..
										"\nOr this function won't work and your Crawling Ragdoll won't get Overkilled")
	Overkill_Inherit_Check_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_Inherit_Check_txt_S:SizeToContents()


	---------------------------
	local Overkill_C_txt_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_C_txt_back:SetPos(50, 440)
	Overkill_C_txt_back:SetSize(455, 50)
	Overkill_C_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_C_txt_S = vgui.Create("DLabel", Overkill_C_txt_back)
	Overkill_C_txt_S:SetPos(10, 10)
	Overkill_C_txt_S:SetFont("DefaultSmall")
	Overkill_C_txt_S:SetText("If All three above are disabled, then Crawling Ragdoll won't get Overkilled")
	Overkill_C_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_C_txt_S:SizeToContents()

	------------------------------------------------------
	---------------------------
	local Overkill_Gap = vgui.Create("DPanel", Overkill_Window)
	Overkill_Gap:SetPos(50, 490)
	Overkill_Gap:SetSize(455, 10)
	Overkill_Gap.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
	end
	---------------------------
	------------------------------------------------------


	---------------------------
	local Overkill_C_Overflow_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_C_Overflow_back:SetPos(50, 500)
	Overkill_C_Overflow_back:SetSize(455, 100)
	Overkill_C_Overflow_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
	
	local Overkill_C_Overflow_Slider = vgui.Create("DNumSlider", Overkill_C_Overflow_back)
	Overkill_C_Overflow_Slider:SetPos(-250, 5)
	Overkill_C_Overflow_Slider:SetSize(660, 20)
	Overkill_C_Overflow_Slider:SetDark(true)
	Overkill_C_Overflow_Slider:SetMin(0)
	Overkill_C_Overflow_Slider:SetMax(10)
	Overkill_C_Overflow_Slider:SetDecimals(2)
	Overkill_C_Overflow_Slider:SetConVar("ARag_overkill_overflow_value")

	local Overkill_C_Overflow_Check = vgui.Create("DCheckBox", Overkill_C_Overflow_back)
	Overkill_C_Overflow_Check:SetPos(10, 10)
	Overkill_C_Overflow_Check:SetConVar("ARag_overkill_overflow_enable")

	local Overkill_C_Overflow_txt_S = vgui.Create("DLabel", Overkill_C_Overflow_back)
	Overkill_C_Overflow_txt_S:SetPos(10, 30)
	Overkill_C_Overflow_txt_S:SetFont("DefaultSmall")
	Overkill_C_Overflow_txt_S:SetText("If NPC took way too much damage in one shot, then Ragdoll won't crawl" .. 
										"\ne.g - A NPC with 70 HP was killed by a Sniper Bullet of 130 damage," .. 
										"\nAnd this bar is set to \"0.4\", then 130-70=60, >(0.4*70), so no crawl.")
	Overkill_C_Overflow_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_C_Overflow_txt_S:SizeToContents()


	---------------------------
	local Overkill_C_Nocrawl_txt_back = vgui.Create("DPanel", Overkill_Window)
	Overkill_C_Nocrawl_txt_back:SetPos(50, 600)
	Overkill_C_Nocrawl_txt_back:SetSize(455, 70)
	Overkill_C_Nocrawl_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Overkill_C_Nocrawl_txt_S = vgui.Create("DLabel", Overkill_C_Nocrawl_txt_back)
	Overkill_C_Nocrawl_txt_S:SetPos(10, 10)
	Overkill_C_Nocrawl_txt_S:SetFont("DefaultSmall")
	Overkill_C_Nocrawl_txt_S:SetText("The two above are different." .. 
										"\nThe 1st: After NPC Dies, if you shoot ragdoll, then no crawl" .. 
										"\nThe 2st: Before NPC Dies, if taken overflowing damage, then no crawl")
	Overkill_C_Nocrawl_txt_S:SetColor(Color(100, 100, 100, 235))
	Overkill_C_Nocrawl_txt_S:SizeToContents()


	---------------------------
	local Overkill_Blank = vgui.Create("DPanel", Overkill_Window)
	Overkill_Blank:SetPos(50, 670)
	Overkill_Blank:SetSize(455, 100)
	Overkill_Blank.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
end


----------------------------------------------------------------------------------------
--Blood Trace Settings的菜单
local function NewPanel_Blood_Trace_Settings()
	local Blood_Window = vgui.Create("DFrame")
	Blood_Window:SetSize(560, 800)
	Blood_Window:Center()
	Blood_Window:SetTitle("Setting for Blood Trace during crawling")
	Blood_Window:SetDraggable(true)
	Blood_Window:MakePopup()

	local Blood_Window_txt_S = vgui.Create("DLabel", Blood_Window)
	Blood_Window_txt_S:SetPos(52, 35)
	Blood_Window_txt_S:SetFont("DefaultSmall")
	Blood_Window_txt_S:SetText("The Crawling Ragdoll can leave a blood trace behind, you can swith between:" .. 
								"\nA: Leave a blood trace every certain distance the Ragdoll crawls" .. 
								"\nB: Leave a blood trace every certain seconds during crawling" )
	Blood_Window_txt_S:SetColor(Color(230, 230, 230, 235))
	Blood_Window_txt_S:SizeToContents()


	---------------------------
	local Blood_Enable_Check_back = vgui.Create("DPanel", Blood_Window)
	Blood_Enable_Check_back:SetPos(50, 90)
	Blood_Enable_Check_back:SetSize(455, 60)
	Blood_Enable_Check_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Blood_Enable_Check = vgui.Create("DCheckBox", Blood_Window)
	Blood_Enable_Check:SetPos(60, 95)
	Blood_Enable_Check:SetConVar("ARag_blood")

	local Blood_Enable_Check_txt_L = vgui.Create("DLabel", Blood_Window)
	Blood_Enable_Check_txt_L:SetPos(85, 95)
	Blood_Enable_Check_txt_L:SetFont("TargetIDSmall")
	Blood_Enable_Check_txt_L:SetText("Enable Blood Trace")
	Blood_Enable_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Blood_Enable_Check_txt_L:SizeToContents()

	local Blood_Enable_Check_txt_S = vgui.Create("DLabel", Blood_Window)
	Blood_Enable_Check_txt_S:SetPos(85, 115)
	Blood_Enable_Check_txt_S:SetFont("DefaultSmall")
	Blood_Enable_Check_txt_S:SetText("Leave a blood trace behind when NPC is crawling")
	Blood_Enable_Check_txt_S:SetColor(Color(100, 100, 100, 150))
	Blood_Enable_Check_txt_S:SizeToContents()


	---------------------------
	local Blood_UseTime_Slider_back = vgui.Create("DPanel", Blood_Window)
	Blood_UseTime_Slider_back:SetPos(50, 150)
	Blood_UseTime_Slider_back:SetSize(455, 120)
	Blood_UseTime_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Blood_Dist_Slider_back = vgui.Create("DPanel", Blood_Window)
	local Blood_Time_Slider_back = vgui.Create("DPanel", Blood_Window)
	local Blood_UseTime_Slider = vgui.Create("DNumSlider", Blood_UseTime_Slider_back)
	Blood_UseTime_Slider:SetPos(10, 3)
	Blood_UseTime_Slider:SetSize(300, 20)
	Blood_UseTime_Slider:SetDark(true)
	Blood_UseTime_Slider:SetMin(0)
	Blood_UseTime_Slider:SetMax(1)
	Blood_UseTime_Slider:SetDecimals(0)
	Blood_UseTime_Slider:SetConVar("ARag_blood_usetime")
	function Blood_UseTime_Slider:OnValueChanged(value)
		if value <= 0.5 then
			Blood_UseTime_Slider:SetValue(0)
			Blood_Dist_Slider_back.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
			end
			Blood_Time_Slider_back.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
			end
		else
			Blood_UseTime_Slider:SetValue(1)
			Blood_Dist_Slider_back.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
			end
			Blood_Time_Slider_back.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
			end
		end
	end

	local Blood_UseTime_Slider_cover = vgui.Create("DPanel", Blood_Window)
	Blood_UseTime_Slider_cover:SetPos(315, 153)
	Blood_UseTime_Slider_cover:SetSize(20, 20)
	Blood_UseTime_Slider_cover.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 235))
	end	

	local Blood_UseTime_Slider_txt_L = vgui.Create("DLabel", Blood_Window)
	Blood_UseTime_Slider_txt_L:SetPos(85, 155)
	Blood_UseTime_Slider_txt_L:SetFont("TargetIDSmall")
	Blood_UseTime_Slider_txt_L:SetText("Use Distance")
	Blood_UseTime_Slider_txt_L:SetColor(Color(100, 100, 100, 200))
	Blood_UseTime_Slider_txt_L:SizeToContents()

	local Blood_UseTime_Slider_txt2_L = vgui.Create("DLabel", Blood_Window)
	Blood_UseTime_Slider_txt2_L:SetPos(325, 155)
	Blood_UseTime_Slider_txt2_L:SetFont("TargetIDSmall")
	Blood_UseTime_Slider_txt2_L:SetText("Use Time")
	Blood_UseTime_Slider_txt2_L:SetColor(Color(100, 100, 100, 200))
	Blood_UseTime_Slider_txt2_L:SizeToContents()

	local Blood_UseTime_Slider_txt_S = vgui.Create("DLabel", Blood_Window)
	Blood_UseTime_Slider_txt_S:SetPos(85, 180)
	Blood_UseTime_Slider_txt_S:SetFont("DefaultSmall")
	Blood_UseTime_Slider_txt_S:SetText("Switch to Left: \nLeave a blood trace every certain distance the Ragdoll crawls" ..
										"\n\nSwitch to Right: \nLeave a blood trace every certain seconds during crawling")
	Blood_UseTime_Slider_txt_S:SetColor(Color(100, 100, 100, 150))
	Blood_UseTime_Slider_txt_S:SizeToContents()	


	---------------------------
	Blood_Dist_Slider_back:SetPos(50, 270)
	Blood_Dist_Slider_back:SetSize(455, 80)
	Blood_Dist_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Blood_Dist_Slider = vgui.Create("DNumSlider", Blood_Dist_Slider_back)
	Blood_Dist_Slider:SetPos(10, 3)
	Blood_Dist_Slider:SetSize(300, 20)
	Blood_Dist_Slider:SetDark(true)
	Blood_Dist_Slider:SetMin(0)
	Blood_Dist_Slider:SetMax(100)
	Blood_Dist_Slider:SetDecimals(0)
	Blood_Dist_Slider:SetConVar("ARag_blood_dist")

	local Blood_Dist_Slider_txt_L = vgui.Create("DLabel", Blood_Window)
	Blood_Dist_Slider_txt_L:SetPos(85, 275)
	Blood_Dist_Slider_txt_L:SetFont("TargetIDSmall")
	Blood_Dist_Slider_txt_L:SetText("Set Distance")
	Blood_Dist_Slider_txt_L:SetColor(Color(100, 100, 100, 200))
	Blood_Dist_Slider_txt_L:SizeToContents()

	local Blood_Dist_Slider_txt_S = vgui.Create("DLabel", Blood_Window)
	Blood_Dist_Slider_txt_S:SetPos(85, 300)
	Blood_Dist_Slider_txt_S:SetFont("DefaultSmall")
	Blood_Dist_Slider_txt_S:SetText("Every this far the Ragdoll crawls, a blood trace will be placed.")
	Blood_Dist_Slider_txt_S:SetColor(Color(100, 100, 100, 150))
	Blood_Dist_Slider_txt_S:SizeToContents()	


	---------------------------
	Blood_Time_Slider_back:SetPos(50, 350)
	Blood_Time_Slider_back:SetSize(455, 80)
	Blood_Time_Slider_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end

	local Blood_Time_Slider = vgui.Create("DNumSlider", Blood_Time_Slider_back)
	Blood_Time_Slider:SetPos(10, 3)
	Blood_Time_Slider:SetSize(300, 20)
	Blood_Time_Slider:SetDark(true)
	Blood_Time_Slider:SetMin(0)
	Blood_Time_Slider:SetMax(5)
	Blood_Time_Slider:SetDecimals(1)
	Blood_Time_Slider:SetConVar("ARag_blood_time")

	local Blood_Time_Slider_txt_L = vgui.Create("DLabel", Blood_Window)
	Blood_Time_Slider_txt_L:SetPos(85, 355)
	Blood_Time_Slider_txt_L:SetFont("TargetIDSmall")
	Blood_Time_Slider_txt_L:SetText("Set Time")
	Blood_Time_Slider_txt_L:SetColor(Color(100, 100, 100, 200))
	Blood_Time_Slider_txt_L:SizeToContents()

	local Blood_Time_Slider_txt_S = vgui.Create("DLabel", Blood_Window)
	Blood_Time_Slider_txt_S:SetPos(85, 380)
	Blood_Time_Slider_txt_S:SetFont("DefaultSmall")
	Blood_Time_Slider_txt_S:SetText("Every these seconds passed, a blood trace will be placed.")
	Blood_Time_Slider_txt_S:SetColor(Color(100, 100, 100, 150))
	Blood_Time_Slider_txt_S:SizeToContents()	


	---------------------------
	local Blood_Blank = vgui.Create("DPanel", Blood_Window)
	Blood_Blank:SetPos(50, 430)
	Blood_Blank:SetSize(455, 340)
	Blood_Blank.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
	end
end
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Functions


-- ↓ Panel itself
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
concommand.Add("ARag_panel", function()
	local Window = vgui.Create("DFrame")
	Window:SetSize(1200, 800)
	Window:Center()
	Window:SetTitle("")
	Window:SetDraggable(true)
	Window:ShowCloseButton(false)
	Window:MakePopup()
	Window.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end

	local Menu = vgui.Create("DImage", Window)
	Menu:SetPos(0,0)
	Menu:SetSize(1200, 800)		
	Menu:SetImage("Enhancing Death/menu_empty.png")
	surface.PlaySound("Enhancing Death/menu_button1.wav")

	local Button_Close = vgui.Create("DButton", Window)
	Button_Close:SetPos(1155, 15)
	Button_Close:SetSize(30, 30)
	Button_Close:SetText("")
	Button_Close:SetImage("Enhancing Death/button_closemenu.png")
	Button_Close.Paint = function(self, w, h) 
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	Button_Close.DoClick = function()
		Window:Close()
	end


	local Death_Enable_Death_Animation 	= Menu_Create_Button(Window, 82, "ARag_enab_d")
	local Death_Chance_Death_Animation 	= Menu_Create_Slider(Window, 183, "ARag_odds_d", 0, 1, 2, false)
	local Death_No_Crawl_After_Headshot = Menu_Create_Button(Window, 283, "ARag_headshot")
	local Death_More_Natural_Animation 	= Menu_Create_Slider(Window, 383, "ARag_natural", 1, 3, 2, true)
	local Death_Set_NPC_Blacklist 		= Menu_Create_Button_Big(Window, 471, "ARag_panel_npcblacklist")
	local Death_Open_Animation_Selector = Menu_Create_Button_Big(Window, 571, "ARag_panel_selector")


	local Crawl_Enable_Crawl_Animation 	= Menu_Create_Button(Window, 82, "ARag_enab_c")
	local Crawl_Chance_Crawl_Animation,  Crawl_Chance_Repeat_Animation	= Menu_Create_Slider_MinMax(Window, 158, "ARag_odds_c", "ARag_odds_c_repeat", 0, 1, 2, false)
	local Crawl_HP_Based_Crawl_Chance 	= Menu_Create_Button(Window, 233, "ARag_odds_c_hp")
	local Crawl_Delay_Min, Crawl_Delay_Max = Menu_Create_Slider_MinMax(Window, 383, "ARag_delay_min", "ARag_delay_max", 0, 20, 2, false)
	local Crawl_Crawl_Away_Settings 	= Menu_Create_Button_Big(Window, 471, NewPanel_Crawl_Away_Settings)
	local Crawl_Diverse_Crawl_Animation = Menu_Create_Button(Window, 583, "ARag_random")
	local Crawl_Ply_Ally_Always_Crawl 	= Menu_Create_Button(Window, 683, "ARag_ply_allycrawl")


	local Revive_Enable_Ally_Revive 	= Menu_Create_Button(Window, 82, "ARag_enab_ally_r")
	local Revive_Enable_Self_Revive 	= Menu_Create_Button(Window, 183, "ARag_enab_self_r")
	local Revive_NPC_Portion_HP_Button, Revive_NPC_Portion_HP_Slider = Menu_Create_Button_AND_Slider(Window, 283, "ARag_r_hp_portion", "ARag_r_hp_portion_v", 0, 1, 2, false)
	local Revive_NPC_Inherit_HP_Button 	= Menu_Create_Button(Window, 383, "ARag_r_hp_inherit")
	local Revive_NPC_No_Crawl 			= Menu_Create_Button(Window, 483, "ARag_no_2nd_crawl")
	local Revive_PLY_Portion, Revive_PLY_Inherit, Revive_PLY_NoCrawl = Menu_Create_Button_3PLY(Window, 583, "ARag_r_hp_portion_p", "ARag_r_hp_inherit_p", "ARag_no_2nd_crawl_p")
	local Revive_Player_Revive_Settings = Menu_Create_Button_Big(Window, 671, NewPanel_Player_Revive_Settings)
	DButton_Make_Exclusive(Revive_NPC_Portion_HP_Button, Revive_NPC_Inherit_HP_Button, "ARag_r_hp_portion", "ARag_r_hp_inherit", "Enhancing Death/button_on_s.png", "Enhancing Death/button_off_s.png", "Enhancing Death/button_on.png", "Enhancing Death/button_off.png")
	DButton_Make_Exclusive(Revive_PLY_Portion, Revive_PLY_Inherit, "ARag_r_hp_portion_p", "ARag_r_hp_inherit_p", "Enhancing Death/button_on_s.png", "Enhancing Death/button_off_s.png", "Enhancing Death/button_on_s.png", "Enhancing Death/button_off_s.png")


	local Overkill_Death_Animation 		= Menu_Create_Button_Big(Window, 71, NewPanel_Death_Animation_Overkill)
	local Overkill_Crawl_Animation 		= Menu_Create_Button_Big(Window, 171, NewPanel_Crawl_Animation_Overkill)
	local Overkill_Scale_Physics_Dmg 	= Menu_Create_Slider(Window, 283, "ARag_overkill_crush_damage", 0, 2, 2, false)


	local Player_Death_Animation_Multi 	= Menu_Create_Button(Window, 82, "ARag_player_1")
	local Player_Death_Animation_Singl 	= Menu_Create_Button(Window, 183, "ARag_player_2")
	local Player_Crawl_Animation, Player_Crawl_Animation_Chance	= Menu_Create_Button_Double(Window, 283, "ARag_player_crawl", "ARag_player_crawl_c")
	local Player_First_Person_DeathCam 	= Menu_Create_Button(Window, 383, "ARag_cam")
	local Player_Hide_Head_In_DeathCam 	= Menu_Create_Button(Window, 483, "ARag_hair")
	local Player_Adjust_DeathCam_Height = Menu_Create_Slider(Window, 583, "ARag_camz", 0, 200, 2, true)
	DButton_Make_Exclusive(Player_Death_Animation_Multi, Player_Death_Animation_Singl, "ARag_player_1", "ARag_player_2", "Enhancing Death/button_on.png", "Enhancing Death/button_off.png", "Enhancing Death/button_on.png", "Enhancing Death/button_off.png")


	local Others_Enable_Finger_Animation= Menu_Create_Button(Window, 82, "ARag_finger")
	local Others_Resize_Animation 		= Menu_Create_Button(Window, 183, "ARag_scalerag")
	local Others_Use_Female_Animation 	= Menu_Create_Button(Window, 283, "ARag_female")
	local Others_Zombie_Animation_Death, Others_Zombie_Animation_Crawl = Menu_Create_Button_Double(Window, 383, "ARag_zombie", "ARag_zombie_crawl")
	local Others_Corpse_Clean_Up, Others_Corpse_Clean_Up_Amount = Menu_Create_Button_AND_Slider(Window, 483, "ARag_clean_e", "ARag_clean", 0, 100, 2, true)
	local Others_Blood_Trace_Settings 	= Menu_Create_Button_Big(Window, 571, NewPanel_Blood_Trace_Settings)
	local Others_Show_Debug_Information = Menu_Create_Button(Window, 683, "ARag_healthbar")


	local ElementTb_Death = {
		Death_Enable_Death_Animation,
		Death_Chance_Death_Animation,
		Death_No_Crawl_After_Headshot,
		Death_More_Natural_Animation,
		Death_Set_NPC_Blacklist,
		Death_Open_Animation_Selector
	}

	local ElementTb_Crawl = {
		Crawl_Enable_Crawl_Animation,
		Crawl_Chance_Crawl_Animation,
		Crawl_Chance_Repeat_Animation,
		Crawl_HP_Based_Crawl_Chance,
		Crawl_Delay_Min,
		Crawl_Delay_Max,
		Crawl_Crawl_Away_Settings,
		Crawl_Diverse_Crawl_Animation,
		Crawl_Ply_Ally_Always_Crawl
	}

	local ElementTb_Revive = {
		Revive_Enable_Ally_Revive,
		Revive_Enable_Self_Revive,
		Revive_NPC_Portion_HP_Button,
		Revive_NPC_Portion_HP_Slider,
		Revive_NPC_Inherit_HP_Button,
		Revive_NPC_No_Crawl,
		Revive_PLY_Portion,
		Revive_PLY_Inherit,
		Revive_PLY_NoCrawl,
		Revive_Player_Revive_Settings
	}

	local ElementTb_Overkill = {
		Overkill_Death_Animation,
		Overkill_Crawl_Animation,
		Overkill_Scale_Physics_Dmg
	}

	local ElementTb_Player = {
		Player_Death_Animation_Multi,
		Player_Death_Animation_Singl,
		Player_Crawl_Animation,
		Player_Crawl_Animation_Chance,
		Player_First_Person_DeathCam,
		Player_Hide_Head_In_DeathCam,
		Player_Adjust_DeathCam_Height
	}

	local ElementTb_Others = {
		Others_Enable_Finger_Animation,
		Others_Resize_Animation,
		Others_Use_Female_Animation,
		Others_Zombie_Animation_Death,
		Others_Zombie_Animation_Crawl,
		Others_Corpse_Clean_Up,
		Others_Corpse_Clean_Up_Amount,
		Others_Blood_Trace_Settings,
		Others_Show_Debug_Information
	}


	local ElementTb_AllTb = {
		ElementTb_Death,
		ElementTb_Crawl,
		ElementTb_Revive,
		ElementTb_Overkill,
		ElementTb_Player,
		ElementTb_Others
	}

	for _, Table in pairs(ElementTb_AllTb) do
		for _, Element in pairs(Table) do
			Element:SetVisible(false)
		end
	end

	local Category_Death 	= Menu_Create_Button_Category(Window, Menu, 231, "menu_death", ElementTb_Death, ElementTb_AllTb)
	local Category_Crawl 	= Menu_Create_Button_Category(Window, Menu, 326, "menu_crawl", ElementTb_Crawl, ElementTb_AllTb)
	local Category_Revive 	= Menu_Create_Button_Category(Window, Menu, 421, "menu_revive", ElementTb_Revive, ElementTb_AllTb)
	local Category_Overkill = Menu_Create_Button_Category(Window, Menu, 516, "menu_overkill", ElementTb_Overkill, ElementTb_AllTb)
	local Category_Player 	= Menu_Create_Button_Category(Window, Menu, 611, "menu_player", ElementTb_Player, ElementTb_AllTb)
	local Category_Others 	= Menu_Create_Button_Category(Window, Menu, 706, "menu_others", ElementTb_Others, ElementTb_AllTb)

end)


hook.Add( "PopulateToolMenu", "Enhanced_Death_Animation", function()
	spawnmenu.AddToolMenuOption( "Utilities", "Enhanced Death Animations", "Enhanced Death Animations", "#Enhanced Death Animations", "", "", function( panel )
		panel:Button("Open Settings Menu", "ARag_panel")
		panel:Button("Open Animation Selector", "ARag_panel_selector")
	end)
end)
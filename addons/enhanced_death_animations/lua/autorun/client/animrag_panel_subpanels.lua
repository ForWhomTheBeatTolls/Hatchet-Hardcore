include("autorun/client/00_animrag_panel_preset_sum.lua")
include("autorun/server/animrag_allconvar.lua")

local AnimTb_file = file.Open("enhanced_death_animations/anim_table.txt", "r", "DATA")
local AnimTb = {}

if AnimTb_file then
	AnimTb = util.JSONToTable( file.Read("enhanced_death_animations/anim_table.txt", "DATA") )
else
	AnimTb = {
		["fire"]  = {
			"bd_death_fire1",
			"ex_engineer_burn",
			"ex_heavy_burn",
			"ex_movingonfire",
			"ex_runonfire1",
			"ex_runonfire2",
			"ex_scout_burn",
			"ex_sniper_burn",
			"ex_soldier_burn",
			"ex_spy_burn",
		},
		["exp"] = {
			"DeathRunning_09",
			"DeathRunning_10",
			"DeathRunning_11a",
			"DeathRunning_11b",
			"DeathRunning_11c",
			"DeathExplosion_01",
			"DeathExplosion_02",
			"DeathExplosion_03",
			"DeathExplosion_05",
			"DeathExplosion_06",
			"DeathExplosion_07",
			"DeathExplosion_08",
			"ex_mix_flying_back",
			"ex_mix_flying_forward_rightarm",
		},
		["club"] = {
			"club1",
			"club2",
			"club3",
			"club4",
			"bd_death_slasher_front",
			"bd_death_slasher_left",
			"bd_death_slasher_right",
			"bd_death_slasher_back",
		},
		["moving"] = {
			"DeathRunning_01",
			"DeathRunning_03",
			"DeathRunning_04",
			"DeathRunning_05",
			"DeathRunning_06",
			"DeathRunning_07",
			"DeathRunning_08",
			"DeathRunning_11d",
			"DeathRunning_11f",
			"DeathRunning_11g",
			"DeathRunning_12",
			"DeathRunning_13",
			"DeathRunning_14",
			"DeathRunning_15",
			"DeathRunning_16",
			"ex_mix_headshot_11",
			"ex_mix_running_faceplant",
			"ex_mix_running_roll_2",
			"ex_mix_running_roll_3",
			"ex_mix_running_roll",
			"ex_mix_running_trip",
		},
		["dying"] = {
			"Death_01",	
			"Death_02c",
			"Death_06",
			"Death_07",
			"Death_08",
			"Death_08b",
			"Death_09",
			"Death_10ab",
			"Death_10b",
			"Death_10c",
			"Death_11_01a",
			"Death_11_01b",
			"Death_11_02b",	
			"Death_11_02d",
			"Death_11_03b",
			"Death_11_03c",
			"dying2",
			"dying4",
			"dying5",
			"dying6",
			"bd_death_leg_05",
			"bd_death_leg_06",
			"bd_death_leg_07",
		},
		["bd_torso"] = {
			"dying3",
			"bd_death_torso_long_01",
			"bd_death_torso_long_02",
			"bd_death_torso_long_03",
			"bd_death_torso_short_01",
			"bd_death_torso_short_02",
			"bd_death_torso_short_03",
			"bd_death_torso_short_04",
			"bd_death_torso_short_05",
			"bd_death_torso_short_06",
			"bd_death_torso_short_07",
			"bd_death_torso_short_08",
			"bd_death_torso_short_09",
			"bd_death_torso_short_10",
			"bd_death_torso_short_11",
			"bd_death_torso_short_12",
			"bd_death_torso_short_13",
			"bd_death_torso_short_14",
			"bd_death_torso_short_15",
			"bd_death_torso_short_16",
			"bd_death_torso_short_17",
			"bd_death_torso_short_18",
			"bd_death_torso_short_19",
			"bd_death_torso_short_20",
			"bd_death_stomach_multi_01",
			"bd_death_stomach_single_01",
			"bd_death_stomach_single_02",
			"bd_death_stomach_short_01",
			"bd_death_stomach_short_02",
			"cod_1_torso_1",
			"cod_1_torso_2",
			"cod_1_torso_3",
			"cod_1_torso_4",
			"cod_1_torso_5",
			"cod_1_torso_6",
			"cod_1_torso_7",
			"ex_engineer_headshot",
			"ex_headshotback",
			"ex_medic_burn",
			"ex_mix_headshot_8",
			"ex_mix_headshot_9",
		},
		["bd_head"] = {
			"Death_11_03a",
			"dying7",
			"bd_death_head_01",
			"bd_death_head_02",
			"bd_death_head_03",
			"bd_death_head_04",
			"bd_death_head_05",
			"bd_death_head_07",
			"bd_death_head_08",
			"bd_death_head_multi_01",
			"bd_death_head_multi_02",
			"bd_death_head_multi_03",
			"bd_death_head_single_01",
			"bd_death_head_single_02",
			"bd_death_head_single_03",
			"bd_death_head_short_01",
			"bd_death_head_short_02",
			"bd_death_head_short_03",
			"ex_demo_headshot",
			"ex_headshotfront",
			"ex_heavy_backstab",
			"ex_heavy_headshot",
			"ex_medic_headshot",
			"ex_mix_falling_back_2_headshot",
			"ex_mix_headshot_10",
			"ex_mix_headshot_2",
			"ex_mix_headshot_3",
			"ex_mix_headshot_4",
			"ex_mix_headshot_5",
			"ex_mix_headshot_6",
			"ex_pyro_headshot",
			"ex_scout_headshot",
			"ex_sniper_headshot",
			"ex_soldier_headshot",
			"ex_spy_headshot",
		},
		["bd_neck"] = {
			"bd_death_neck_short_01",
			"bd_death_neck_short_02",
			"bd_death_neck_short_03",
			"bd_death_neck_short_04",
		},
		["bd_larm"] = {
			"bd_death_leftarm_multi_01",
			"bd_death_leftarm_multi_02",
			"bd_death_leftarm_multi_03",
			"bd_death_leftarm_multi_04",
			"bd_death_leftarm_single_01",
			"bd_death_leftarm_single_02",
			"bd_death_leftarm_single_03",
			"bd_death_leftarm_short_01",
			"bd_death_leftarm_short_02",
			"bd_death_leftarm_short_03",
			"ex_mix_hit_Left_shoulder",
			"ex_mix_hit_leftarm_2",
		},
		["bd_rarm"] = {
			"Death_02a",
			"Death_05",
			"bd_death_rightarm_01",
			"bd_death_rightarm_02",
			"bd_death_rightarm_multi_01",
			"bd_death_rightarm_multi_02",
			"bd_death_rightarm_single_01",
			"bd_death_rightarm_single_02",
			"bd_death_rightarm_single_03",
			"bd_death_rightarm_single_04",  
			"ex_mix_headshot_1",
			"ex_mix_right_arm_3",
			"ex_mix_right_arm",
			"ex_mix_rightarm_2",
		},
		["bd_lleg"] = {
			"bd_death_legs_01",
			"bd_death_leftleg_long_01",
			"bd_death_leftleg_long_02",
			"bd_death_leftleg_short_01",
			"bd_death_leftleg_short_02",
			"bd_death_leftleg_short_03",
			"bd_death_leftleg_short_04",
			"bd_death_leftleg_short_05",
			"bd_death_leftleg_short_06",
			"bd_death_leftleg_short_07",
			"bd_death_leftleg_short_08",
			"ex_mix_hit_left_leg",
		},
		["bd_rleg"] = {
			"bd_death_rightleg_multi_01",
			"bd_death_rightleg_multi_02",
			"bd_death_rightleg_multi_03",
			"bd_death_rightleg_short_01",
			"bd_death_rightleg_short_02",
			"bd_death_rightleg_single_01",
			"bd_death_rightleg_single_02",
			"bd_death_rightleg_single_03",
			"bd_death_rightleg_single_04",
			"bd_death_rightleg_single_05",
		},
		["bd_pelvis"] = {
			"bd_death_torso_short_21",
			"Death_03",
			"Death_11_02a",
			"dying1",
			"bd_death_leg_01",
			"bd_death_leg_02",
			"bd_death_leg_03",
			"bd_death_leg_04",
			"bd_death_leg_08",
			"ex_mix_groin_hit_left_leg",
			"ex_mix_groin_hit_right_leg",
			"ex_mix_hit_gut",
		},
		["bd_back"] = {
			"Death_11_02c",
			"ex_demo_backstab",
			"ex_engineer_backstab",
			"ex_medic_backstab",
			"ex_mix_shot_in_back_headshot",
			"ex_pyro_backstab",
			"ex_scout_backstab",
			"ex_sniper_backstab",
			"ex_soldier_backstab",
			"ex_spy_backstab",
		},
		["bd_shotgun"] = {
			"DeathRunning_11e",
			"DeathExplosion_04",
			"ex_shotgunback1",
			"ex_shotgunback2",
			"ex_shotgunback3",
			"ex_shotgunback4",
			"ex_shotgunback5",
			"ex_shotgunback6",
			"ex_shotgunback7",
		},
	}

	file.Write("enhanced_death_animations/anim_table.txt", util.TableToJSON(AnimTb) )
	file.Write("enhanced_death_animations/anim_table_default.txt", util.TableToJSON(AnimTb) )

end


----------------------------------------------------------------------------------------
--初始各参数
file.CreateDir("enhanced_death_animations")

local blacklist = {} 	--动画黑名单
local whitelist = {} 	--动画白名单
local everylist = {} 	--所有可用的动画，用于存储所有动画各自对应的end_position
local endpos_tb = {} 	--和everylist类似，只不过everylist是以"46/bd_death_fire1"的字符形式存储的，而该是以表格的形式存储的，这样能方便读取，减少卡顿
					 	--脱裤子放屁，本来完全可以只用这个而不用everylist。但是用表格形式写入文件的话人看不懂，不好排错，像everylist以字符形式写入文件的话能方便人类看
					 	--所以就是，everylist是给人看的，方便排错，endpos_tb是给程序看的，加快速度
  					   	--npc黑名单，本来放在这的，但因为上面代码的要用到这个表格，所以就给放上边去了
local weaponlist = {}  	--武器伤害类型自定义表
local npclist = {} 		--NPC黑名单

local lastlist = AnimTb["fire"] --上一次选择的tab
local lastlist_title = "Fire"
local lastlist_butID = 1
local lastlist_txtID = 1


----------------------------------------------------------------------------------------
--将 everylist 的某一行拆分成 百分比 和 动画名，用于得到 ARag_Addline 中所需添加的内容
local function ARag_Split_String(word_to_find)

	--判断输入的字符 word_to_find 到底存在于 everylist 的哪一行，并把那一行提取出来写进 word
	--如：输入"bd_death_fire1"，查找到该字符属于 everylist 里 "46/bd_death_fire1" 那一行，则将 "46/bd_death_fire1" 写进 word
	for _, mixName in pairs(everylist) do
		if string.EndsWith(mixName, word_to_find) then
			word = mixName
			break
		end
	end

	--接着将 word 拆分成 百分比 和 动画名 写入临时表格 store，如: "46" 和 "bd_death_fire1"
	local store = {}
	for v in string.gmatch(word, "[^/]+") do
		table.insert(store, v)
	end
	local anim_endpos = store[1]
	local anim_name = store[2]
	
	return anim_name, anim_endpos

end


----------------------------------------------------------------------------------------
--向 DListView 中 添加一行，用于建立与重建 DListView
local function ARag_Addline(Thelist, ent, word_to_find)

	local anim_name, anim_endpos = ARag_Split_String(word_to_find)
	local line = Thelist:AddLine(anim_name, anim_endpos)
	line.OnSelect = function ()
		X_Anim_Slider:SetValue(0)
		ent:SetSequence(ent:LookupSequence(anim_name))
		ent:SetPlaybackRate(1)
		ent:SetCycle(0)	
	end

end


----------------------------------------------------------------------------------------
--重建 DListView 列表，每次当 whitelist 或 blacklist 或 百分比 更新时，都会运行一次
local function ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

	--重建 C_List_black 的 DListView
	--先清空该列表
	for k, v in pairs(C_List_black:GetLines()) do
		C_List_black:RemoveLine(k)
	end

	--再从该列表对应的 AnimTb 中找到对应项，写入列表
	for k1, v1 in pairs(C_List_black.tb) do
		for k2, v2 in pairs(blacklist) do
			if v1 == v2 then
				ARag_Addline(C_List_black, ent, v1)
				break
			end
		end
	end


	--重建 C_List_white 的 DListView
	--先清空该列表
	for k, v in pairs(C_List_white:GetLines()) do
		C_List_white:RemoveLine(k)
	end

	--再从该列表对应的 AnimTb 中找到对应项，写入列表
	for k1, v1 in pairs(C_List_white.tb) do
		for k2, v2 in pairs(whitelist) do
			if v1 == v2 then
				ARag_Addline(C_List_white, ent, v1)
				break
			end
		end
	end

end


----------------------------------------------------------------------------------------
--当按下按钮时，设置每个动画的百分比，并重建列表
local function ARag_SetPercent(num, anim, ent, C_List_white, C_List_black)

	local replace = num .. "/" .. anim

	local word_to_find = anim

	--判断输入的字符 word_to_find 到底存在于 everylist 的哪一行，并把那一行换成 mix
	--如：输入"bd_death_fire1"，查找到该字符属于 everylist 里 "46/bd_death_fire1" 那一行，则将 "46/bd_death_fire1" 换成 mix 的 "67/bd_death_fire1"
	for k, orgn in pairs(everylist) do
		if string.match(orgn, word_to_find) then
			everylist[k] = replace
			break
		end
	end

	local everylist_insert = table.concat(everylist, ",\n")
	file.Write("enhanced_death_animations/everylist.txt", everylist_insert)

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--将 everylist 的每一行都拆分成 百分比 和 动画名，并将该 百分比 与 动画名 共同写入表格 endpos_tb，并将表格传给server端，该函数只在每次初始化以及通过菜单改变值时被调用
--脱裤子放屁，更好的选择是用json直接把 everylist 以表格形式写进文件里，而不是现在这样以txt格式写，写完还要想办法读取，麻烦。但我不高兴改写入的代码了，反正又不影响游戏性能
--例：转换前的 [everylist] 的某一行：46/bd_death_fire1, 转换后 [endpos_tb] 对应的行： {46, bd_death_fire1}
local function ARag_SetPercent_Make_Table()

	endpos_tb = {}
	for _, mixName in pairs(everylist) do
		--将 mixName 拆分成 百分比 和 动画名 写入临时表格 store，如: "46" 和 "bd_death_fire1"
		local store = {}
		for v in string.gmatch(mixName, "[^/]+") do
			table.insert(store, v)
		end

		--将 百分比 和 动画名 以表格的形式写入mix（这个函数的一切都是为了将 百分比 和 动画名 从txt形式转换成表格形式）
		local mix = {}
		mix.cent = store[1]
		mix.name = store[2]

		table.insert(endpos_tb, mix)
	end

	net.Start("ChangeEndposition_cTs")
	net.WriteTable(endpos_tb)
	net.SendToServer()

end


----------------------------------------------------------------------------------------
--当按下15个damagetype按钮的任意一个时，在窗口绘制DListView
local function DrawDListView( ColumName, Tb, ent, C_List_white, C_List_black, C_Button, C_Button_txt_L, Clist_but, Clist_txt )

	-------------------------------------
	C_List_white.col1:SetName(ColumName)
	C_List_white.tb = Tb

	for k, v in pairs(C_List_white:GetLines()) do
		C_List_white:RemoveLine(k)
	end

	--如果该类型的伤害里有元素和 whitelist 中的重合，则将该元素显示在表格上
	for k1, v1 in pairs(Tb) do
		for k2, v2 in pairs(whitelist) do
			if v1 == v2 then
				ARag_Addline(C_List_white, ent, v1)
				break
			end
		end
	end
	-------------------------------------
	C_List_black.col1:SetName(ColumName)
	C_List_black.tb = Tb

	for k, v in pairs(C_List_black:GetLines()) do
		C_List_black:RemoveLine(k)
	end

	--如果该类型的伤害里有元素和 whitelist 中的重合，则将该元素显示在表格上
	for k1, v1 in pairs(Tb) do
		for k2, v2 in pairs(blacklist) do
			if v1 == v2 then
				ARag_Addline(C_List_black, ent, v1)
				break
			end
		end
	end
	-------------------------------------

	--改变选中的按钮的颜色
	for k, v in pairs(Clist_but) do
		v.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
		end
	end

	for k, v in pairs(Clist_txt) do
		v:SetColor(Color(100, 100, 100, 200))
		v:SetFont("TargetIDSmall")
	end

	C_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(255, 51, 51, 235))
	end
	C_Button_txt_L:SetColor(Color(230, 230, 230, 235))
	C_Button_txt_L:SetFont("HudHintTextLarge")

	-------------------------------------

	--向lastlist中写入该list，该list_title，该button，该button_txt，从而下次打开面板时可以直接读取
	lastlist = Tb
	lastlist_title = ColumName
	for k, v in pairs(Clist_but) do
		if v == C_Button then
			lastlist_butID = k
		end
	end
	for k, v in pairs(Clist_txt) do
		if v == C_Button_txt_L then
			lastlist_txtID = k
		end
	end

end


----------------------------------------------------------------------------------------
--重置 blacklist, whitelist, everylist
local function ARag_Reset(ent, C_List_white, C_List_black)
	
	blacklist = {}
	whitelist = {}
	everylist = {}
	
	for k1, dmgType in pairs(AnimTb) do
		for k2, dmgName in pairs(dmgType) do
			table.insert(whitelist, dmgName)
			table.insert(everylist, "100/" .. dmgName)
		end
	end
	
	local blacklist_insert = {}
	local whitelist_insert = table.concat(whitelist, ",\n")
	local everylist_insert = table.concat(everylist, ",\n")
	
	file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
	file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)
	file.Write("enhanced_death_animations/everylist.txt", everylist_insert)

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--预设 blacklist, whitelist, everylist
local function ARag_Preset(ent, C_List_white, C_List_black)
	
	ARag_Make_Preset_File()
	
	blacklist = util.JSONToTable( file.Read("enhanced_death_animations/preset_blacklist.txt", "DATA") )
	whitelist = util.JSONToTable( file.Read("enhanced_death_animations/preset_whitelist.txt", "DATA") )
	everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )

	local blacklist_insert = table.concat(blacklist, ",\n")
	local whitelist_insert = table.concat(whitelist, ",\n")
	local everylist_insert = table.concat(everylist, ",\n")
	
	file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
	file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)
	file.Write("enhanced_death_animations/everylist.txt", everylist_insert)

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--从文件读取blacklist，whitelist，everylist，如果没有文件，则创建默认值
local function ARag_Initialize_List()

	local blacklist_file = file.Open("enhanced_death_animations/blacklist.txt", "r", "DATA")
	local whitelist_file = file.Open("enhanced_death_animations/whitelist.txt", "r", "DATA")
	local everylist_file = file.Open("enhanced_death_animations/everylist.txt", "r", "DATA")

	--如果文件存在，则将文件内容写入blacklist，whitelist，everylist
	if blacklist_file and whitelist_file and everylist_file then

		local blacklist_file_content = blacklist_file:Read()
		local whitelist_file_content = whitelist_file:Read()
		local everylist_file_content = everylist_file:Read()
		blacklist_file:Close()
		whitelist_file:Close()
		everylist_file:Close()

		--如果从文件里读到数据，则将数据拆分后写入blacklist
		if blacklist_file_content then
			for word in string.gmatch(blacklist_file_content, "[^,\n]+") do
				table.insert(blacklist, word)
			end
		else
			--其实这种情况不存在
			blacklist = {}
		end

		--如果从文件里读到数据，则将数据拆分后写入whitelist
		if whitelist_file_content then
			for word in string.gmatch(whitelist_file_content, "[^,\n]+") do
				table.insert(whitelist, word)
			end
		else
			--其实这种情况不存在
			whitelist = {}
			for k1, dmgType in pairs(AnimTb) do
				for k2, dmgName in pairs(dmgType) do
					table.insert(whitelist, dmgName)
				end
			end
		end

		--如果从文件里读到数据，则将数据拆分后写入everylist
		if everylist_file_content then
			for word in string.gmatch(everylist_file_content, "[^,\n]+") do
				table.insert(everylist, word)
			end
		else
			--其实这种情况不存在
			everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )
		end

	else --如果文件不存在，则以默认值创建文件，将默认值写入blacklist，whitelist，everylist

		--默认值是以json形式储存的（因为方便），而三个list是以txt形式储存的（因为人要看），所以需要转换一下
		blacklist = util.JSONToTable( file.Read("enhanced_death_animations/preset_blacklist.txt", "DATA") )
		whitelist = util.JSONToTable( file.Read("enhanced_death_animations/preset_whitelist.txt", "DATA") )
		everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )

		local blacklist_insert = table.concat(blacklist, ",\n")
		local whitelist_insert = table.concat(whitelist, ",\n")
		local everylist_insert = table.concat(everylist, ",\n")
		
		file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
		file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)
		file.Write("enhanced_death_animations/everylist.txt", everylist_insert)

	end

	--前面已经初始化了三个主要的list，这里再顺便初始化一下 npclist 和 weaponlist 这俩比较次要的list
	local npclist_file = file.Open("enhanced_death_animations/npclist.txt", "r", "DATA")
	if npclist_file then
		npclist = util.JSONToTable( file.Read("enhanced_death_animations/npclist.txt", "DATA") )
	else
		npclist = {}
		file.Write("enhanced_death_animations/npclist.txt", "")
	end

	local weapon_file = file.Open("enhanced_death_animations/weaponlist.txt", "r", "DATA")
	if weapon_file then
		weaponlist = util.JSONToTable( file.Read("enhanced_death_animations/weaponlist.txt", "DATA") )
	else
		weaponlist = {}
		file.Write("enhanced_death_animations/weaponlist.txt", "")
	end

	--另外一个主要的list:AnimTb已经在代码的最上边被初始化过了（从anim_table.txt读取的），所以pass
	--这样一来6个list就全部被初始化了
end

--每次进入游戏时初始化blacklist，whitelist，everylist
ARag_Initialize_List()
--每次进入游戏时根据上面刚刚得到的everylist，初始化endpos_tb（简而言之就是把给人看的 everylist 一比一转换为给代码看的 endpos_tb，详情见ARag_SetPercent_Make_Table()里的描述）
--为什么这个函数要跟着 ARag_Initialize_List()，而不是直接整合进去？因为在 Animation Selector 里 "Set This Frame As End Position!" 这个按钮还得要调用这个函数
ARag_SetPercent_Make_Table()


----------------------------------------------------------------------------------------
--动画文件更新了，把所有人的设置都换成我的新版本的预设！！！咋地
local function ARag_Replace_The_List_onUpdate()

	local shouldAdd_ex1 = file.Open("enhanced_death_animations/update_ex1.txt", "r", "DATA")

	if not shouldAdd_ex1 then

		blacklist = util.JSONToTable( file.Read("enhanced_death_animations/preset_blacklist.txt", "DATA") )
		whitelist = util.JSONToTable( file.Read("enhanced_death_animations/preset_whitelist.txt", "DATA") )
		everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )
	
		local blacklist_insert = table.concat(blacklist, ",\n")
		local whitelist_insert = table.concat(whitelist, ",\n")
		local everylist_insert = table.concat(everylist, ",\n")
		
		file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
		file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)
		file.Write("enhanced_death_animations/everylist.txt", everylist_insert)
		

		file.Write("enhanced_death_animations/update_ex1.txt", "0")

	end

end

ARag_Replace_The_List_onUpdate()


----------------------------------------------------------------------------------------
--新增的动画，在原有的基础上加上去（等以后真要再加动画时，再把这个函数启用吧）
//local function ARag_Initialize_List_ex1()
//
//	local shouldAdd_ex1 = file.Open("enhanced_death_animations/update_ex1.txt", "r", "DATA")
//
//	if not shouldAdd_ex1 then
//
//		blacklist_ex1 = ARag_AnimTb_Preset_Blacklist_ex1
//		whitelist_ex1 = ARag_AnimTb_Preset_Whitelist_ex1
//		everylist_ex1 = ARag_AnimTb_Preset_Everylist_ex1
//
//		for k, v in pairs(blacklist_ex1) do
//			table.insert(blacklist, v)
//		end
//
//		for k, v in pairs(whitelist_ex1) do
//			table.insert(whitelist, v)
//		end
//
//		for k, v in pairs(everylist_ex1) do
//			table.insert(everylist, v)
//		end
//
//		local blacklist_insert_ex1 = table.concat(blacklist, ",\n")
//		local whitelist_insert_ex1 = table.concat(whitelist, ",\n")
//		local everylist_insert_ex1 = table.concat(everylist, ",\n")
//
//		file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert_ex1)
//		file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert_ex1)
//		file.Write("enhanced_death_animations/everylist.txt", everylist_insert_ex1)
//
//		file.Write("enhanced_death_animations/update_ex1.txt", "0")
//
//	end
//
//end


----------------------------------------------------------------------------------------
--将玩家选定的动画加入blacklist，并写入文件，并重建DListView
local function ARag_SetList_blacklist(anim, ent, C_List_white, C_List_black)

	--判断当前的 anim 是否已经在blacklist中，如果不在，则写入 blacklist
	local black_AlreadyExists = false
	for k, black in pairs(blacklist) do
		if not black_AlreadyExists then
			if anim == black then
				black_AlreadyExists = true
			else
				black_AlreadyExists = false
			end
		end
	end

	if not black_AlreadyExists then
		table.insert(blacklist, anim)
	end


	--有了blacklist后，先将whitelist归零，再将所有不在 blacklist 中的 anim 写入 whitelist
	whitelist = {}
	for k1, dmgType in pairs(AnimTb) do
	--对于每种伤害类型：
		for k2, dmgName in pairs(dmgType) do
		--对于该伤害类型包含的每个动画：

			local black_AlreadyExists2 = false

			for k3, black in pairs(blacklist) do
				--判断该动画是否已经存在在blacklist里
				if not black_AlreadyExists2 then
					if dmgName == black then
						black_AlreadyExists2 = true
					else
						black_AlreadyExists2 = false
					end
				end
			end

			--如果blacklist里不存在，则将该动画写入whitelist
			if not black_AlreadyExists2 then
				table.insert(whitelist, dmgName)
			end

		end
	end


	--将计算好的 blacklist 和 whitelist 写入文件
	local blacklist_insert = table.concat(blacklist, ",\n")
	local whitelist_insert = table.concat(whitelist, ",\n")
	file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
	file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)

	--重建DListView
	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--将玩家选定的动画加入whitelist，并写入文件，并重建DListView
local function ARag_SetList_whitelist(anim, ent, C_List_white, C_List_black)

	--判断当前的 anim 是否已经在whitelist中，如果不在，则写入 whitelist
	local white_AlreadyExists = false
	for k, white in pairs(whitelist) do
		if not white_AlreadyExists then
			if anim == white then
				white_AlreadyExists = true
			else
				white_AlreadyExists = false
			end
		end
	end

	if not white_AlreadyExists then
		table.insert(whitelist, anim)
	end


	--有了whitelist后，先将blacklist归零，再将所有不在 whitelist 中的 anim 写入 blacklist
	blacklist = {}
	for k1, dmgType in pairs(AnimTb) do
	--对于每种伤害类型：
		
		for k2, dmgName in pairs(dmgType) do
		--对于该伤害类型包含的每个动画：

			local white_AlreadyExists2 = false

			for k3, white in pairs(whitelist) do
				--判断该动画是否已经存在在whitelist里
				if not white_AlreadyExists2 then
					if dmgName == white then
						white_AlreadyExists2 = true
					else
						white_AlreadyExists2 = false
					end
				end
			end

			--如果whitelist里不存在，则将该动画写入blacklist
			if not white_AlreadyExists2 then
				table.insert(blacklist, dmgName)
			end

		end
	end


	--将计算好的 blacklist 和 whitelist 写入文件
	local blacklist_insert = table.concat(blacklist, ",\n")
	local whitelist_insert = table.concat(whitelist, ",\n")
	file.Write("enhanced_death_animations/blacklist.txt", blacklist_insert)
	file.Write("enhanced_death_animations/whitelist.txt", whitelist_insert)

	--重建DListView
	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--将当前的动画复制到另一个damage type里
local function ARag_Damagetype_Copy_To(anim, typetb, ent, C_List_white, C_List_black)

	--得到当前 DListView 使用的是 AnimTb 里的哪一列（如"fire"/"club"...）
	local Current_index

	for k, v in pairs(AnimTb) do
		if v == C_List_white.tb then
			Current_index = k
		end
	end

	--将当前动画写入另一个damage type
	local Anim_AlreadyExists = false

	for k, v in pairs(typetb) do
		if v == anim then
			Anim_AlreadyExists = true
		end
	end

	if not Anim_AlreadyExists then
		table.insert(typetb, anim)
	end

	file.Write("enhanced_death_animations/anim_table.txt", util.TableToJSON(AnimTb) )
	
	--依据新的AnimTb来重写当前的DListView
	C_List_white.tb = AnimTb[Current_index]
	C_List_black.tb = AnimTb[Current_index]
	lastlist 		= AnimTb[Current_index]

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--将当前的动画从当前的damage type里移除
local function ARag_Damagetype_Remove_From(anim, typetb, ent, C_List_white, C_List_black)

	--得到当前 DListView 使用的是 AnimTb 里的哪一列（如"fire"/"club"...）
	local Current_index

	for k, v in pairs(AnimTb) do
		if v == C_List_white.tb then
			Current_index = k
		end
	end

	--将当前动画从当前的damage type里移除
	for k, name in pairs(typetb) do
		if name == anim then
			table.remove(typetb, k)
		end
	end

	file.Write("enhanced_death_animations/anim_table.txt", util.TableToJSON(AnimTb) )

	--依据新的AnimTb来重写当前的DListView
	C_List_white.tb = AnimTb[Current_index]
	C_List_black.tb = AnimTb[Current_index]
	lastlist 		= AnimTb[Current_index]

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end


----------------------------------------------------------------------------------------
--重置所有的damage type里的动画
local function ARag_Damagetype_Reset_All(ent, C_List_white, C_List_black)
	
	--得到当前 DListView 使用的是 AnimTb 里的哪一列（如"fire"/"club"...）
	local Current_index

	for k, v in pairs(AnimTb) do
		if v == C_List_white.tb then
			Current_index = k
		end
	end

	--从预制的文件内重置AnimTb
	AnimTb = util.JSONToTable( file.Read("enhanced_death_animations/anim_table_default.txt", "DATA") )
	file.Write("enhanced_death_animations/anim_table.txt", util.TableToJSON(AnimTb) )
	
	--依据新的AnimTb来重写当前的DListView
	C_List_white.tb = AnimTb[Current_index]
	C_List_black.tb = AnimTb[Current_index]
	lastlist 		= AnimTb[Current_index]

	ARag_Rebuild_DListView(ent, C_List_white, C_List_black)

end
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Functions


-- ↓ SubPanels
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--Set NPC Blacklist的菜单
concommand.Add("ARag_panel_npcblacklist", function()
	local NPCBlacklist_Window = vgui.Create("DFrame")
	NPCBlacklist_Window:SetSize(560, 800)
	NPCBlacklist_Window:Center()
	NPCBlacklist_Window:SetTitle("List of NPC Blacklist")
	NPCBlacklist_Window:SetDraggable(true)
	NPCBlacklist_Window:MakePopup()


	---------------------------
	local NPCBlacklist_Window_txt_back = vgui.Create("DPanel", NPCBlacklist_Window)
	NPCBlacklist_Window_txt_back:SetPos(50, 35)
	NPCBlacklist_Window_txt_back:SetSize(455, 100)
	NPCBlacklist_Window_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	local NPCBlacklist_Window_txt_L = vgui.Create("DLabel", NPCBlacklist_Window)
	NPCBlacklist_Window_txt_L:SetPos(240, 40)
	NPCBlacklist_Window_txt_L:SetFont("TargetIDSmall")
	NPCBlacklist_Window_txt_L:SetText("How To Use:")
	NPCBlacklist_Window_txt_L:SetColor(Color(100, 100, 100, 255))
	NPCBlacklist_Window_txt_L:SizeToContents()		

	local NPCBlacklist_Window_txt_S = vgui.Create("DLabel", NPCBlacklist_Window)
	NPCBlacklist_Window_txt_S:SetPos(70, 65)
	NPCBlacklist_Window_txt_S:SetFont("DefaultSmall")
	NPCBlacklist_Window_txt_S:SetText("Aim at a NPC or Corpse, then open console, type \"ARag_addNPC\"" .. 
									"\nThen All same NPCs will be added into blacklist" .. 
									"\nThus, be banned from playing Death & Crawl Animation" )
	NPCBlacklist_Window_txt_S:SetColor(Color(100, 100, 100, 235))
	NPCBlacklist_Window_txt_S:SizeToContents()



	---------------------------
	local NPCModel_Panel_back = vgui.Create("DPanel", NPCBlacklist_Window)
	NPCModel_Panel_back:SetPos(50, 515)
	NPCModel_Panel_back:SetSize(455, 220)
	NPCModel_Panel_back.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end
	
	local NPCModel_Panel = vgui.Create("DAdjustableModelPanel", NPCModel_Panel_back)
	NPCModel_Panel:SetPos(0, 0)
	NPCModel_Panel:SetSize(400, 220)
	NPCModel_Panel:SetModel("models/error.mdl")
	NPCModel_Panel:SetLookAng( Angle( 0, 180, 0 ) )
	NPCModel_Panel:SetCamPos( Vector( 150, 0, 35 ) )
	NPCModel_Panel:SetFOV(45)
	
	local npcModel = NPCModel_Panel:GetEntity()	


	---------------------------
	local NPCBlacklist_List = vgui.Create("DListView", NPCBlacklist_Window)
	NPCBlacklist_List:SetPos(50, 135)
	NPCBlacklist_List:SetSize(455, 350)
	NPCBlacklist_List:SetMultiSelect(false)
	local col_npc = NPCBlacklist_List:AddColumn("NPC Blacklist")
	col_npc.PaintOver = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
		draw.SimpleText("NPC Blacklist", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	NPCBlacklist_List.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	if npclist then
		for k, v in pairs(npclist) do
			local line = NPCBlacklist_List:AddLine(v)
			line.OnSelect = function()
				npcModel:SetModel(v)
			end
		end
	end


	---------------------------
	local NPCBlacklist_Button = vgui.Create("DButton", NPCBlacklist_Window)
	NPCBlacklist_Button:SetPos(50, 485)
	NPCBlacklist_Button:SetSize(455, 30)
	NPCBlacklist_Button:SetText( "" )
	NPCBlacklist_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
	end
	NPCBlacklist_Button.DoClick = function()
		
		if npclist then
			for k, v in pairs(npclist) do
				if v == npcModel:GetModel() then
					table.remove(npclist, k)
				end
			end
		end

		for k, v in pairs(NPCBlacklist_List:GetLines()) do
			NPCBlacklist_List:RemoveLine(k)
		end

		for k, v in pairs(npclist) do
			local line = NPCBlacklist_List:AddLine(v)
			line.OnSelect = function()
				npcModel:SetModel(v)
			end
		end

		file.Write("enhanced_death_animations/npclist.txt", util.TableToJSON(npclist) )
		net.Start("ChangeNPClist_cTs")
		net.WriteTable(npclist)
		net.SendToServer()
	end

	local NPCBlacklist_Button_txt_L = vgui.Create("DLabel", NPCBlacklist_Window)
	NPCBlacklist_Button_txt_L:SetPos(170, 490)
	NPCBlacklist_Button_txt_L:SetFont("TargetIDSmall")
	NPCBlacklist_Button_txt_L:SetText("Remove This NPC From Blacklist")
	NPCBlacklist_Button_txt_L:SetColor(Color(100, 100, 100, 255))
	NPCBlacklist_Button_txt_L:SizeToContents()
end)


----------------------------------------------------------------------------------------
--Animation Selector的菜单
concommand.Add("ARag_panel_selector", function()
	local window = vgui.Create("DFrame")
	window:SetSize(1050, 800)
	window:Center()
	window:SetTitle("")
	window:SetDraggable(true)
	window:MakePopup()

	window.Paint = function(self, w, h)
		draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 135))
		draw.RoundedBox(20, 15, 0, w-30, h, Color(225, 225, 225, 235))
		draw.SimpleText("Animation Selector", "DermaLarge", 500, 5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end


	------------------------------------------------------------------
	--Model_Panel
	local Model_Panel_back = vgui.Create("DPanel", window)
	Model_Panel_back:SetPos(50, 70)
	Model_Panel_back:SetSize(400, 1000)
	Model_Panel_back.Paint = function(self)
		draw.RoundedBox(20, 0, 0, 400, 400, Color(200, 200, 200, 235))
		draw.RoundedBox(20, 3, 3, 394, 394, Color(225, 225, 225, 235))
	end

	local Model_Panel = vgui.Create("DAdjustableModelPanel", Model_Panel_back)
	Model_Panel:SetPos(0, 0)
	Model_Panel:SetSize(400, 400)
	Model_Panel:SetModel("models/brutal_deaths/model_anim_modify.mdl")
	Model_Panel:SetLookAng( Angle( 0, 180, 0 ) )
	Model_Panel:SetCamPos( Vector( 150, 0, 35 ) )
	Model_Panel:SetFOV(45)

	local ent = Model_Panel:GetEntity()
	ent:SetBodygroup(ent:FindBodygroupByName("barney"), 1)
	
	function Model_Panel:LayoutEntity( ent ) 
		ent:FrameAdvance( FrameTime() ) 
		Model_Panel:RunAnimation()
	end

	local Model_Panel_Progress = vgui.Create("DNumSlider", Model_Panel_back)
	Model_Panel_Progress:SetPos(-295, 0)
	Model_Panel_Progress:SetSize(720, 20)
	Model_Panel_Progress:SetMin(0)
	Model_Panel_Progress:SetMax(100)
	Model_Panel_Progress:SetDark(true)
	Model_Panel_Progress:SetDecimals(0)
	function Model_Panel_Progress:Think()
		self:SetValue(ent:GetCycle()*100)
	end

	local Model_Panel_txt_S = vgui.Create("DLabel", Model_Panel_back)
	Model_Panel_txt_S:SetPos(15, 28)
	Model_Panel_txt_S:SetFont("DefaultSmall")
	Model_Panel_txt_S:SetText("When Right Mouse is held down,\nPress WASD/Space/Ctrl to Move View.")
	Model_Panel_txt_S:SetColor(Color(100, 100, 100, 200))
	Model_Panel_txt_S:SizeToContents()


	local Model_Panel_Button_ResetView = vgui.Create("DButton", Model_Panel_back)
	Model_Panel_Button_ResetView:SetPos(90, 370)
	Model_Panel_Button_ResetView:SetSize(100, 30)
	Model_Panel_Button_ResetView:SetText( "" )
	Model_Panel_Button_ResetView.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
	end
	Model_Panel_Button_ResetView.DoClick = function()
		Model_Panel:SetLookAng( Angle( 0, 180, 0 ) )
		Model_Panel:SetCamPos( Vector( 150, 0, 35 ) )
		Model_Panel:SetFOV(45)
	end

	local Model_Panel_Button_ResetView_txt_L = vgui.Create("DLabel", Model_Panel_back)
	Model_Panel_Button_ResetView_txt_L:SetPos(98, 380)
	Model_Panel_Button_ResetView_txt_L:SetFont("TargetIDSmall")
	Model_Panel_Button_ResetView_txt_L:SetText("ResetView")
	Model_Panel_Button_ResetView_txt_L:SetColor(Color(100, 100, 100, 150))
	Model_Panel_Button_ResetView_txt_L:SizeToContents()


	--------------------------
	local Model_Panel_Button_Pauses = vgui.Create("DButton", Model_Panel_back)
	local Model_Panel_Button_Pauses_txt_L = vgui.Create("DLabel", Model_Panel_back)
	local Model_Panel_Button_Resume = vgui.Create("DButton", Model_Panel_back)
	local Model_Panel_Button_Resume_txt_L = vgui.Create("DLabel", Model_Panel_back)


	Model_Panel_Button_Pauses:SetPos(0, 370)
	Model_Panel_Button_Pauses:SetSize(80, 30)
	Model_Panel_Button_Pauses:SetText( "" )
	Model_Panel_Button_Pauses.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
	end
	Model_Panel_Button_Pauses.DoClick = function()
		ent:SetPlaybackRate(0)
		Model_Panel_Button_Pauses:SetVisible(false)
		Model_Panel_Button_Pauses_txt_L:SetVisible(false)
		Model_Panel_Button_Resume:SetVisible(true)
		Model_Panel_Button_Resume_txt_L:SetVisible(true)
	end

	Model_Panel_Button_Pauses_txt_L:SetPos(8, 380)
	Model_Panel_Button_Pauses_txt_L:SetFont("TargetIDSmall")
	Model_Panel_Button_Pauses_txt_L:SetText("Pause")
	Model_Panel_Button_Pauses_txt_L:SetColor(Color(100, 100, 100, 150))
	Model_Panel_Button_Pauses_txt_L:SizeToContents()

	--------------------------

	Model_Panel_Button_Resume:SetVisible(false)
	Model_Panel_Button_Resume:SetPos(0, 370)
	Model_Panel_Button_Resume:SetSize(80, 30)
	Model_Panel_Button_Resume:SetText( "" )
	Model_Panel_Button_Resume.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 235))
	end
	Model_Panel_Button_Resume.DoClick = function()
		ent:SetPlaybackRate(1)
		Model_Panel_Button_Resume:SetVisible(false)
		Model_Panel_Button_Resume_txt_L:SetVisible(false)
		Model_Panel_Button_Pauses:SetVisible(true)
		Model_Panel_Button_Pauses_txt_L:SetVisible(true)
	end

	Model_Panel_Button_Resume_txt_L:SetVisible(false)
	Model_Panel_Button_Resume_txt_L:SetPos(8, 380)
	Model_Panel_Button_Resume_txt_L:SetFont("TargetIDSmall")
	Model_Panel_Button_Resume_txt_L:SetText("Resume")
	Model_Panel_Button_Resume_txt_L:SetColor(Color(100, 100, 100, 150))
	Model_Panel_Button_Resume_txt_L:SizeToContents()
	--Model_Panel
	------------------------------------------------------------------


	------------------------------------------------------------------
	--Make List
	local C_List_white = vgui.Create("DListView", window)
	local C_List_black = vgui.Create("DListView", window)

	-------------------------------------
	C_List_white:SetPos(480, 265)
	C_List_white:SetSize(250, 260)	
	C_List_white:SetMultiSelect(false)
	C_List_white.tb = lastlist
	local col1_white = C_List_white:AddColumn( lastlist_title )
	local col2_white = C_List_white:AddColumn( "End Position" )
	C_List_white.col1 = col1_white
	col2_white:SetMaxWidth(100)
	col1_white.PaintOver = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(0, 0, 0, w-4, h-4, Color(150, 150, 150, 235))
		draw.SimpleText(lastlist_title, "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	col2_white.PaintOver = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(0, 0, 0, w-4, h-4, Color(150, 150, 150, 235))
		draw.SimpleText("End Position", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	C_List_white.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-4, h-4, Color(230, 230, 230, 235))
	end
	--如果该类型的伤害里有元素和 whitelist 中的重合，则将该元素显示在表格上
	for k1, v1 in pairs(lastlist) do
		for k2, v2 in pairs(whitelist) do
			if v1 == v2 then
				ARag_Addline(C_List_white, ent, v1)
				break
			end
		end
	end
	-------------------------------------
	C_List_black:SetPos(750, 265)
	C_List_black:SetSize(250, 260)	
	C_List_black:SetMultiSelect(false)
	C_List_black.tb = lastlist
	local col1_black = C_List_black:AddColumn( lastlist_title )
	local col2_black = C_List_black:AddColumn( "End Position" )
	C_List_black.col1 = col1_black
	col2_black:SetMaxWidth(100)
	col1_black.PaintOver = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(0, 0, 0, w-4, h-4, Color(150, 150, 150, 235))
		draw.SimpleText(lastlist_title, "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	col2_black.PaintOver = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(0, 0, 0, w-4, h-4, Color(150, 150, 150, 235))
		draw.SimpleText("End Position", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	C_List_black.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(5, 0, 0, w-4, h-4, Color(230, 230, 230, 235))
	end
	--如果该类型的伤害里有元素和 whitelist 中的重合，则将该元素显示在表格上
	for k1, v1 in pairs(lastlist) do
		for k2, v2 in pairs(blacklist) do
			if v1 == v2 then
				ARag_Addline(C_List_black, ent, v1)
				break
			end
		end
	end		
	-------------------------------------

	--Make List
	------------------------------------------------------------------


	------------------------------------------------------------------
	--List Description
	local Whitelist_txt_back = vgui.Create("DPanel", window)
	Whitelist_txt_back:SetPos(480, 545)
	Whitelist_txt_back:SetSize(170, 60)
	Whitelist_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(100, 100, 100, 150))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
	end

	local Whitelist_txt_L = vgui.Create("DLabel", window)
	Whitelist_txt_L:SetPos(487, 543)
	Whitelist_txt_L:SetFont("TargetIDSmall")
	Whitelist_txt_L:SetText("▲ White List\n▲\n▲")
	Whitelist_txt_L:SetColor(Color(100, 100, 100, 200))
	Whitelist_txt_L:SizeToContents()

	local Whitelist_txt_S = vgui.Create("DLabel", window)
	Whitelist_txt_S:SetPos(505, 565)
	Whitelist_txt_S:SetFont("DefaultSmall")
	Whitelist_txt_S:SetText("These are enabled\nDeath Animation")
	Whitelist_txt_S:SetColor(Color(100, 100, 100, 200))
	Whitelist_txt_S:SizeToContents()


	local Blacklist_txt_back = vgui.Create("DPanel", window)
	Blacklist_txt_back:SetPos(830, 545)
	Blacklist_txt_back:SetSize(170, 60)
	Blacklist_txt_back.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(100, 100, 100, 150))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
	end

	local Blacklist_txt_L = vgui.Create("DLabel", window)
	Blacklist_txt_L:SetPos(837, 543)
	Blacklist_txt_L:SetFont("TargetIDSmall")
	Blacklist_txt_L:SetText("▲ Black List\n▲\n▲")
	Blacklist_txt_L:SetColor(Color(100, 100, 100, 200))
	Blacklist_txt_L:SizeToContents()

	local Blacklist_txt_S = vgui.Create("DLabel", window)
	Blacklist_txt_S:SetPos(855, 565)
	Blacklist_txt_S:SetFont("DefaultSmall")
	Blacklist_txt_S:SetText("These are disabled\nDeath Animation")
	Blacklist_txt_S:SetColor(Color(100, 100, 100, 200))
	Blacklist_txt_S:SizeToContents()
	--List Description
	------------------------------------------------------------------


	------------------------------------------------------------------
	--List Button
	local Preset_Button = vgui.Create("DButton", window)
	Preset_Button:SetPos(670, 565)
	Preset_Button:SetSize(140, 40)
	Preset_Button:SetText("")
	Preset_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(255, 51, 51, 235))
		draw.RoundedBox(10, 0, 0, w, h-8, Color(230, 230, 230, 255))
	end
	Preset_Button.DoClick = function()
		
		local Confirm_Window = vgui.Create("DFrame")
		Confirm_Window:SetSize(460, 210)
		Confirm_Window:Center()
		Confirm_Window:SetTitle("Reset / Use Preset")
		Confirm_Window:SetDraggable(true)
		Confirm_Window:MakePopup()
	
		local Reset_Button = vgui.Create("DButton", Confirm_Window)
		Reset_Button:SetPos(20, 50)
		Reset_Button:SetSize(200, 30)
		Reset_Button:SetText("")
		Reset_Button.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
		end
		Reset_Button.DoClick = function()
			Confirm_Window:Close()
			ARag_Reset(ent, C_List_white, C_List_black)
		end
	
		local Reset_Button_txt_L = vgui.Create("DLabel", Confirm_Window)
		Reset_Button_txt_L:SetPos(50, 55)
		Reset_Button_txt_L:SetFont("TargetIDSmall")
		Reset_Button_txt_L:SetText("Reset Everything")
		Reset_Button_txt_L:SetColor(Color(100, 100, 100, 200))
		Reset_Button_txt_L:SizeToContents()
	
		local Reset_Button_txt_S = vgui.Create("DLabel", Confirm_Window)
		Reset_Button_txt_S:SetPos(20, 85)
		Reset_Button_txt_S:SetFont("DefaultSmall")
		Reset_Button_txt_S:SetText("Clear all blacklists, and set all End Position back to 100.")
		Reset_Button_txt_S:SetColor(Color(230, 230, 230, 200))
		Reset_Button_txt_S:SizeToContents()
	
	
		local Preset_Button = vgui.Create("DButton", Confirm_Window)
		Preset_Button:SetPos(20, 110)
		Preset_Button:SetSize(200, 30)
		Preset_Button:SetText("")
		Preset_Button.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
		end
		Preset_Button.DoClick = function()
			Confirm_Window:Close()
			ARag_Preset(ent, C_List_white, C_List_black)
		end
	
		local Preset_Button_txt_L = vgui.Create("DLabel", Confirm_Window)
		Preset_Button_txt_L:SetPos(50, 115)
		Preset_Button_txt_L:SetFont("TargetIDSmall")
		Preset_Button_txt_L:SetText("Use A Preset")
		Preset_Button_txt_L:SetColor(Color(100, 100, 100, 200))
		Preset_Button_txt_L:SizeToContents()
	
		local Preset_Button_txt_S = vgui.Create("DLabel", Confirm_Window)
		Preset_Button_txt_S:SetPos(20, 145)
		Preset_Button_txt_S:SetFont("DefaultSmall")
		Preset_Button_txt_S:SetText("This is a rather comfortable preset I adjusted frame by frame." .. 
									"\nMost animaitons end in an appropriate and natural postion." ..
									"\nStill, you may want to make some adjustments.")
		Preset_Button_txt_S:SetColor(Color(230, 230, 230, 200))
		Preset_Button_txt_S:SizeToContents()
	end

	local Preset_Button_txt_L = vgui.Create("DLabel", window)
	Preset_Button_txt_L:SetPos(703, 573)
	Preset_Button_txt_L:SetFont("TargetIDSmall")
	Preset_Button_txt_L:SetText("Use Preset")
	Preset_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	Preset_Button_txt_L:SizeToContents()

	-------------------------------------
	-------------------------------------

	local Blacklist_Button = vgui.Create("DButton", window)
	Blacklist_Button:SetPos(480, 615)
	Blacklist_Button:SetSize(170, 40)
	Blacklist_Button:SetText("")
	Blacklist_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-4, h-4, Color(230, 230, 230, 235))
	end
	Blacklist_Button.DoClick = function()
		local anim = ent:GetSequenceName( ent:GetSequence() )
		ARag_SetList_blacklist(anim, ent, C_List_white, C_List_black)
	end
	
	local Blacklist_Button_txt_L = vgui.Create("DLabel", window)
	Blacklist_Button_txt_L:SetPos(488, 623)
	Blacklist_Button_txt_L:SetFont("TargetIDSmall")
	Blacklist_Button_txt_L:SetText("Move To Blacklist  >>")
	Blacklist_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	Blacklist_Button_txt_L:SizeToContents()


	local Blacklist_All_Button = vgui.Create("DButton", window)
	Blacklist_All_Button:SetPos(660, 615)
	Blacklist_All_Button:SetSize(70, 40)
	Blacklist_All_Button:SetText("")
	Blacklist_All_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
	end
	Blacklist_All_Button.DoClick = function()
		for k, anim in pairs(C_List_white.tb) do
			ARag_SetList_blacklist(anim, ent, C_List_white, C_List_black)
		end
	end
	
	local Blacklist_All_Button_txt_L = vgui.Create("DLabel", window)
	Blacklist_All_Button_txt_L:SetPos(668, 623)
	Blacklist_All_Button_txt_L:SetFont("TargetIDSmall")
	Blacklist_All_Button_txt_L:SetText("All  >>")
	Blacklist_All_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	Blacklist_All_Button_txt_L:SizeToContents()

	-------------------------------------
	-------------------------------------

	local Whitelist_Button = vgui.Create("DButton", window)
	Whitelist_Button:SetPos(830, 615)
	Whitelist_Button:SetSize(170, 40)
	Whitelist_Button:SetText("")
	Whitelist_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-4, h-4, Color(230, 230, 230, 235))
	end
	Whitelist_Button.DoClick = function()
		local anim = ent:GetSequenceName( ent:GetSequence() )
		ARag_SetList_whitelist(anim, ent, C_List_white, C_List_black)
	end

	local Whitelist_Button_txt_L = vgui.Create("DLabel", window)
	Whitelist_Button_txt_L:SetPos(838, 623)
	Whitelist_Button_txt_L:SetFont("TargetIDSmall")
	Whitelist_Button_txt_L:SetText("<<  Move To Whitelist")
	Whitelist_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	Whitelist_Button_txt_L:SizeToContents()


	local Whitelist_All_Button = vgui.Create("DButton", window)
	Whitelist_All_Button:SetPos(750, 615)
	Whitelist_All_Button:SetSize(70, 40)
	Whitelist_All_Button:SetText("")
	Whitelist_All_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
	end
	Whitelist_All_Button.DoClick = function()
		for k, anim in pairs(C_List_black.tb) do
			ARag_SetList_whitelist(anim, ent, C_List_white, C_List_black)
		end
	end
	
	local Whitelist_All_Button_txt_L = vgui.Create("DLabel", window)
	Whitelist_All_Button_txt_L:SetPos(758, 623)
	Whitelist_All_Button_txt_L:SetFont("TargetIDSmall")
	Whitelist_All_Button_txt_L:SetText("<<  All")
	Whitelist_All_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	Whitelist_All_Button_txt_L:SizeToContents()

	-------------------------------------
	-------------------------------------

	local CopyAnim_Button = vgui.Create("DButton", window)
	CopyAnim_Button:SetPos(480, 665)
	CopyAnim_Button:SetSize(340, 60)
	CopyAnim_Button:SetText("")
	CopyAnim_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w, h-4, Color(230, 230, 230, 235))
	end
	CopyAnim_Button.DoClick = function()

		local Copy_Window = vgui.Create("DFrame")
		Copy_Window:SetSize(560, 400)
		Copy_Window:Center()
		Copy_Window:SetTitle("Copy Animation To Another Damage Type / or Remove It")
		Copy_Window:SetDraggable(true)
		Copy_Window:MakePopup()

		local Copy_Window_txt_S = vgui.Create("DLabel", Copy_Window)
		Copy_Window_txt_S:SetPos(12, 35)
		Copy_Window_txt_S:SetFont("DefaultSmall")
		Copy_Window_txt_S:SetText("Choose a damage type to copy current animation to")
		Copy_Window_txt_S:SetColor(Color(230, 230, 230, 235))
		Copy_Window_txt_S:SizeToContents()


		local function Make_Button_Copy(x, y, name, typetb)
			
			local Target_Button = vgui.Create("DButton", Copy_Window)
			Target_Button:SetPos(x, y)
			Target_Button:SetSize(180, 35)
			Target_Button:SetText("")
			Target_Button.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
			end
			Target_Button.DoClick = function()
				Copy_Window:Close()
				local anim = ent:GetSequenceName( ent:GetSequence() )
				ARag_Damagetype_Copy_To(anim, typetb, ent, C_List_white, C_List_black)
			end

			local Target_Button_txt_L = vgui.Create("DLabel", Copy_Window)
			Target_Button_txt_L:SetPos(x+8, y+5)
			Target_Button_txt_L:SetFont("TargetIDSmall")
			Target_Button_txt_L:SetText(name)
			Target_Button_txt_L:SetColor(Color(100, 100, 100, 200))
			Target_Button_txt_L:SizeToContents()

			Target_Button.tb = typetb
			Target_Button.txt = Target_Button_txt_L

			return Target_Button

		end

		local X1_Target_Button = Make_Button_Copy(10, 60, "Fire", AnimTb["fire"])
		local X2_Target_Button = Make_Button_Copy(190, 60, "Explosion", AnimTb["exp"])
		local X3_Target_Button = Make_Button_Copy(370, 60, "Club", AnimTb["club"])

		local X4_Target_Button = Make_Button_Copy(10, 95, "Bullet - Head", AnimTb["bd_head"])
		local X5_Target_Button = Make_Button_Copy(190, 95, "Bullet - Neck", AnimTb["bd_neck"])
		local X6_Target_Button = Make_Button_Copy(370, 95, "Bullet - Torso", AnimTb["bd_torso"])

		local X7_Target_Button = Make_Button_Copy(10, 130, "Bullet - Left Arm", AnimTb["bd_larm"])
		local X8_Target_Button = Make_Button_Copy(190, 130, "Bullet - Right Arm", AnimTb["bd_rarm"])
		local X9_Target_Button = Make_Button_Copy(370, 130, "Bullet - Left Leg", AnimTb["bd_lleg"])

		local X10_Target_Button = Make_Button_Copy(10, 165, "Bullet - Right Leg", AnimTb["bd_rleg"])
		local X11_Target_Button = Make_Button_Copy(190, 165, "Bullet - Pelvis", AnimTb["bd_pelvis"])
		local X12_Target_Button = Make_Button_Copy(370, 165, "Bullet - Running", AnimTb["moving"])

		local X13_Target_Button = Make_Button_Copy(10, 200, "Bullet - Back", AnimTb["bd_back"])
		local X14_Target_Button = Make_Button_Copy(190, 200, "Bullet - Shotgun", AnimTb["bd_shotgun"])
		local X15_Target_Button = Make_Button_Copy(370, 200, "Other (Physics, etc)", AnimTb["dying"])

		local Xlist_but = {
			X1_Target_Button,
			X2_Target_Button,
			X3_Target_Button,
			X4_Target_Button,
			X5_Target_Button,
			X6_Target_Button,
			X7_Target_Button,
			X8_Target_Button,
			X9_Target_Button,
			X10_Target_Button,
			X11_Target_Button,
			X12_Target_Button,
			X13_Target_Button,
			X14_Target_Button,
			X15_Target_Button,
		}

		for k1, typetb in pairs(AnimTb) do
			for k2, anim in pairs(typetb) do
				if anim == ent:GetSequenceName( ent:GetSequence() ) then
					for k3, button in pairs(Xlist_but) do
						if button.tb == typetb then

							button.Paint = function(self, w, h)
								draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
								draw.RoundedBox(10, 0, 0, w-2, h-2, Color(255, 51, 51, 235))
							end

							button.txt:SetColor(Color(230, 230, 230, 235))
							button.txt:SetFont("HudHintTextLarge")
							
						end
					end
				end
			end
		end

		------------------------

		local RemoveAnim_Button_txt_S = vgui.Create("DLabel", Copy_Window)
		RemoveAnim_Button_txt_S:SetPos(12, 250)
		RemoveAnim_Button_txt_S:SetFont("DefaultSmall")
		RemoveAnim_Button_txt_S:SetText("Press this button to remove current animation from current damage type")
		RemoveAnim_Button_txt_S:SetColor(Color(230, 230, 230, 235))
		RemoveAnim_Button_txt_S:SizeToContents()

		local RemoveAnim_Button = vgui.Create("DButton", Copy_Window)
		RemoveAnim_Button:SetPos(10, 275)
		RemoveAnim_Button:SetSize(180, 30)
		RemoveAnim_Button:SetText("")
		RemoveAnim_Button.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
		end
		RemoveAnim_Button.DoClick = function()
			Copy_Window:Close()
			local anim = ent:GetSequenceName( ent:GetSequence() )
			ARag_Damagetype_Remove_From(anim, lastlist, ent, C_List_white, C_List_black)
		end

		local RemoveAnim_Button_txt_L = vgui.Create("DLabel", Copy_Window)
		RemoveAnim_Button_txt_L:SetPos(18, 280)
		RemoveAnim_Button_txt_L:SetFont("TargetIDSmall")
		RemoveAnim_Button_txt_L:SetText("Remove Animation")
		RemoveAnim_Button_txt_L:SetColor(Color(100, 100, 100, 200))
		RemoveAnim_Button_txt_L:SizeToContents()

		------------------------

		local ResetAnim_Button_txt_S = vgui.Create("DLabel", Copy_Window)
		ResetAnim_Button_txt_S:SetPos(12, 320)
		ResetAnim_Button_txt_S:SetFont("DefaultSmall")
		ResetAnim_Button_txt_S:SetText("If you deleted an animation by mistake, press this to reset all damage types to default")
		ResetAnim_Button_txt_S:SetColor(Color(230, 230, 230, 235))
		ResetAnim_Button_txt_S:SizeToContents()

		local ResetAnim_Button = vgui.Create("DButton", Copy_Window)
		ResetAnim_Button:SetPos(10, 345)
		ResetAnim_Button:SetSize(180, 30)
		ResetAnim_Button:SetText("")
		ResetAnim_Button.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
		end
		ResetAnim_Button.DoClick = function()
			Copy_Window:Close()
			ARag_Damagetype_Reset_All(ent, C_List_white, C_List_black)
		end

		local ResetAnim_Button_txt_L = vgui.Create("DLabel", Copy_Window)
		ResetAnim_Button_txt_L:SetPos(18, 350)
		ResetAnim_Button_txt_L:SetFont("TargetIDSmall")
		ResetAnim_Button_txt_L:SetText("Reset Damage Type")
		ResetAnim_Button_txt_L:SetColor(Color(100, 100, 100, 200))
		ResetAnim_Button_txt_L:SizeToContents()

	end
	
	local CopyAnim_Button_txt_L = vgui.Create("DLabel", window)
	CopyAnim_Button_txt_L:SetPos(488, 673)
	CopyAnim_Button_txt_L:SetFont("TargetIDSmall")
	CopyAnim_Button_txt_L:SetText("Copy To Another DamageType / or Remove It")
	CopyAnim_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	CopyAnim_Button_txt_L:SizeToContents()

	local CopyAnim_Button_txt_S = vgui.Create("DLabel", window)
	CopyAnim_Button_txt_S:SetPos(488, 690)
	CopyAnim_Button_txt_S:SetFont("DefaultSmall")
	CopyAnim_Button_txt_S:SetText("So other damge types can use this animation too")
	CopyAnim_Button_txt_S:SetColor(Color(100, 100, 100, 200))
	CopyAnim_Button_txt_S:SizeToContents()

	------------------------

	local SetWeapon_Button = vgui.Create("DButton", window)
	SetWeapon_Button:SetPos(830, 665)
	SetWeapon_Button:SetSize(170, 60)
	SetWeapon_Button:SetText("")
	SetWeapon_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-4, h-4, Color(230, 230, 230, 235))
	end
	SetWeapon_Button.DoClick = function()

		window:Close()

		local Weapon_Window = vgui.Create("DFrame")
		Weapon_Window:SetSize(560, 450)
		Weapon_Window:Center()
		Weapon_Window:SetTitle("Set your current weapon's damage type")
		Weapon_Window:SetDraggable(true)
		Weapon_Window:MakePopup()

		local Weapon_Window_txt_S = vgui.Create("DLabel", Weapon_Window)
		Weapon_Window_txt_S:SetPos(52, 35)
		Weapon_Window_txt_S:SetFont("DefaultSmall")
		Weapon_Window_txt_S:SetText("Choose a damage type to set your current weapon to" .. 
									"\n(e.g --- If you set a pistol to \"Fire\", then this pistol will trigger \"Fire\" Animation)" .. 
									"\n(e.g --- Set your sniper to \"Shotgun\" so your powerful sniper will set enemy fly)" )
		Weapon_Window_txt_S:SetColor(Color(230, 230, 230, 235))
		Weapon_Window_txt_S:SizeToContents()


		local function Make_Button_Weapon(x, y, name)
			
			local Target_Button = vgui.Create("DButton", Weapon_Window)
			Target_Button:SetPos(x, y)
			Target_Button:SetSize(455, 50)
			Target_Button:SetText("")
			Target_Button.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
				draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
			end
			Target_Button.DoClick = function()
				Weapon_Window:Close()

				local mix = {}
				mix.wep = LocalPlayer():GetActiveWeapon():GetPrintName()
				mix.typ = name

				local Weapon_AlreadyExists = false
				local Weapon_AlreadyExists_Index
				if weaponlist then --这里的判断是很有必要的，因为如果weaponlist={}，是空的的话，里面的循环会直接报错
					for k, v in pairs(weaponlist) do
						if v.wep == mix.wep then
							--表里已经有了这把武器，则记录下以下信息：1.已经有了 2.该武器在表里的位置，以便后面用新内容替换掉它
							Weapon_AlreadyExists = true
							Weapon_AlreadyExists_Index = k
						end
					end
				else
					weaponlist = {}
					Weapon_AlreadyExists = false
				end

				if not Weapon_AlreadyExists then
					--要是表里没有这把武器，则向表里添加 该武器 以及 该武器对应的伤害类型
					table.insert(weaponlist, mix)
				else
					--要是表里已经有了这把武器，则用新内容覆盖掉表里的内容
					weaponlist[Weapon_AlreadyExists_Index] = mix
				end

				file.Write("enhanced_death_animations/weaponlist.txt", util.TableToJSON(weaponlist) )
				net.Start("ChangeWeaponlist_cTs")
				net.WriteTable(weaponlist)
				net.SendToServer()
			end

			local Target_Button_txt_L = vgui.Create("DLabel", Weapon_Window)
			Target_Button_txt_L:SetPos(x+8, y+5)
			Target_Button_txt_L:SetFont("TargetIDSmall")
			Target_Button_txt_L:SetText(name)
			Target_Button_txt_L:SetColor(Color(100, 100, 100, 200))
			Target_Button_txt_L:SizeToContents()

			Target_Button.txt = Target_Button_txt_L

			return Target_Button

		end

		local Y1_Target_Button = Make_Button_Weapon(50, 90, "Fire")
		local Y2_Target_Button = Make_Button_Weapon(50, 140, "Explosion")
		local Y3_Target_Button = Make_Button_Weapon(50, 190, "Club")
		local Y4_Target_Button = Make_Button_Weapon(50, 240, "Bullet")
		local Y5_Target_Button = Make_Button_Weapon(50, 290, "Shotgun")

		------------------------

		local ResetWeapon_Button_txt_S = vgui.Create("DLabel", Weapon_Window)
		ResetWeapon_Button_txt_S:SetPos(52, 360)
		ResetWeapon_Button_txt_S:SetFont("DefaultSmall")
		ResetWeapon_Button_txt_S:SetText("Press this button to reset all weapons' damage type to default")
		ResetWeapon_Button_txt_S:SetColor(Color(230, 230, 230, 235))
		ResetWeapon_Button_txt_S:SizeToContents()

		local ResetWeapon_Button = vgui.Create("DButton", Weapon_Window)
		ResetWeapon_Button:SetPos(50, 385)
		ResetWeapon_Button:SetSize(455, 30)
		ResetWeapon_Button:SetText("")
		ResetWeapon_Button.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
			draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 235))
		end
		ResetWeapon_Button.DoClick = function()
			Weapon_Window:Close()
			weaponlist = {}
			file.Write("enhanced_death_animations/weaponlist.txt", "")
			net.Start("ChangeWeaponlist_cTs")
			net.WriteTable(weaponlist)
			net.SendToServer()
		end

		local ResetWeapon_Button_txt_L = vgui.Create("DLabel", Weapon_Window)
		ResetWeapon_Button_txt_L:SetPos(58, 390)
		ResetWeapon_Button_txt_L:SetFont("TargetIDSmall")
		ResetWeapon_Button_txt_L:SetText("Reset All Weapons")
		ResetWeapon_Button_txt_L:SetColor(Color(100, 100, 100, 200))
		ResetWeapon_Button_txt_L:SizeToContents()
	end

	local SetWeapon_Button_txt_L = vgui.Create("DLabel", window)
	SetWeapon_Button_txt_L:SetPos(838, 673)
	SetWeapon_Button_txt_L:SetFont("TargetIDSmall")
	SetWeapon_Button_txt_L:SetText("Set Weapon Type")
	SetWeapon_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	SetWeapon_Button_txt_L:SizeToContents()

	local SetWeapon_Button_txt_S = vgui.Create("DLabel", window)
	SetWeapon_Button_txt_S:SetPos(838, 690)
	SetWeapon_Button_txt_S:SetFont("DefaultSmall")
	SetWeapon_Button_txt_S:SetText("Set current weapon's type")
	SetWeapon_Button_txt_S:SetColor(Color(100, 100, 100, 200))
	SetWeapon_Button_txt_S:SizeToContents()

	-------------------------------------
	-------------------------------------

	local Backshot_Check = vgui.Create("DCheckBox", window)
	Backshot_Check:SetPos(480, 745)
	Backshot_Check:SetConVar("ARag_nobackshot")

	local Backshot_Check_txt_L = vgui.Create("DLabel", window)
	Backshot_Check_txt_L:SetPos(505, 745)
	Backshot_Check_txt_L:SetFont("TargetIDSmall")
	Backshot_Check_txt_L:SetText("Disable \"Bullet-Back\" Animation Type")
	Backshot_Check_txt_L:SetColor(Color(100, 100, 100, 200))
	Backshot_Check_txt_L:SizeToContents()

	local Backshot_Check_txt_S = vgui.Create("DLabel", window)
	Backshot_Check_txt_S:SetPos(505, 765)
	Backshot_Check_txt_S:SetFont("DefaultSmall")
	Backshot_Check_txt_S:SetText("Detection of \"Bullet-Back\" may go wrong due to penetration addons")
	Backshot_Check_txt_S:SetColor(Color(100, 100, 100, 200))
	Backshot_Check_txt_S:SizeToContents()
	--List Button
	------------------------------------------------------------------


	------------------------------------------------------------------
	--Slider
	local X_Anim_Slider_back = vgui.Create("DPanel", window)
	X_Anim_Slider_back:SetPos(50, 500)
	X_Anim_Slider_back:SetSize(400, 25)
	X_Anim_Slider_back:SetBackgroundColor(Color(100, 100, 100, 150))

	X_Anim_Slider = vgui.Create("DNumSlider", window)
	X_Anim_Slider:SetPos(-245, 500)
	X_Anim_Slider:SetSize(720, 20)
	X_Anim_Slider:SetMin(0)
	X_Anim_Slider:SetMax(100)
	X_Anim_Slider:SetDecimals(0)
	X_Anim_Slider.OnValueChanged = function(self, value)
		ent:SetPlaybackRate(0)
		ent:SetCycle(value/100)
	end

	local X_Anim_Slider_Button = vgui.Create("DButton", window)
	X_Anim_Slider_Button:SetPos(50, 540)
	X_Anim_Slider_Button:SetSize(400, 30)
	X_Anim_Slider_Button:SetText( "" )
	X_Anim_Slider_Button.DoClick = function()
		local num = math.Round(X_Anim_Slider:GetValue(), 0)
		local anim = ent:GetSequenceName( ent:GetSequence() )
		ARag_SetPercent(num, anim, ent, C_List_white, C_List_black)
		ARag_SetPercent_Make_Table()
	end

	local X_Anim_Slider_Button_txt_L = vgui.Create("DLabel", window)
	X_Anim_Slider_Button_txt_L:SetPos(58, 547)
	X_Anim_Slider_Button_txt_L:SetFont("TargetIDSmall")
	X_Anim_Slider_Button_txt_L:SetText("Set This Frame As End Position!")
	X_Anim_Slider_Button_txt_L:SetColor(Color(100, 100, 100, 150))
	X_Anim_Slider_Button_txt_L:SizeToContents()

	local X_Anim_Slider_Button_txt_S = vgui.Create("DLabel", window)
	X_Anim_Slider_Button_txt_S:SetPos(50, 590)
	X_Anim_Slider_Button_txt_S:SetFont("DefaultSmall")
	X_Anim_Slider_Button_txt_S:SetText("Drag slider above to choose an \"End Position\" for current animaiton" ..
									"\nThen press this button, then the \"End Position\" will be set" ..
									"\n\nIf an \"End Position\" is set, " ..
									"\nThen this death animation won't be played completely to the very end," ..
									"\nInstead, the Animation will stop at the \"End Position\", " .. 
									"\nAnd let the game's physics system do the rest." .. 
									"\nThis can shorten the death animation, make it not look that wired" ..
									"\n\nFor example," ..
									"\nIf you drag the slider to \"60\" and press the button," .. 
									"\nThen this animation will only play 60% and then it will end," .. 
									"\nAnd let the game's physics system do the rest.")
	X_Anim_Slider_Button_txt_S:SetColor(Color(100, 100, 100, 200))
	X_Anim_Slider_Button_txt_S:SizeToContents()
	--Slider
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	local C1_Button = vgui.Create("DButton", window)
	local C2_Button = vgui.Create("DButton", window)
	local C3_Button = vgui.Create("DButton", window)
	local C4_Button = vgui.Create("DButton", window)
	local C5_Button = vgui.Create("DButton", window)
	local C6_Button = vgui.Create("DButton", window)
	local C7_Button = vgui.Create("DButton", window)
	local C8_Button = vgui.Create("DButton", window)
	local C9_Button = vgui.Create("DButton", window)
	local C10_Button = vgui.Create("DButton", window)
	local C11_Button = vgui.Create("DButton", window)
	local C12_Button = vgui.Create("DButton", window)
	local C13_Button = vgui.Create("DButton", window)
	local C14_Button = vgui.Create("DButton", window)
	local C15_Button = vgui.Create("DButton", window)

	local C1_Button_txt_L = vgui.Create("DLabel", window)
	local C2_Button_txt_L = vgui.Create("DLabel", window)
	local C3_Button_txt_L = vgui.Create("DLabel", window)
	local C4_Button_txt_L = vgui.Create("DLabel", window)
	local C5_Button_txt_L = vgui.Create("DLabel", window)
	local C6_Button_txt_L = vgui.Create("DLabel", window)
	local C7_Button_txt_L = vgui.Create("DLabel", window)
	local C8_Button_txt_L = vgui.Create("DLabel", window)
	local C9_Button_txt_L = vgui.Create("DLabel", window)
	local C10_Button_txt_L = vgui.Create("DLabel", window)
	local C11_Button_txt_L = vgui.Create("DLabel", window)
	local C12_Button_txt_L = vgui.Create("DLabel", window)
	local C13_Button_txt_L = vgui.Create("DLabel", window)
	local C14_Button_txt_L = vgui.Create("DLabel", window)
	local C15_Button_txt_L = vgui.Create("DLabel", window)

	local Clist_but = {
		C1_Button,
		C2_Button,
		C3_Button,
		C4_Button,
		C5_Button,
		C6_Button,
		C7_Button,
		C8_Button,
		C9_Button,
		C10_Button,
		C11_Button,
		C12_Button,
		C13_Button,
		C14_Button,
		C15_Button,
	}

	local Clist_txt = {
		C1_Button_txt_L,
		C2_Button_txt_L,
		C3_Button_txt_L,
		C4_Button_txt_L,
		C5_Button_txt_L,
		C6_Button_txt_L,
		C7_Button_txt_L,
		C8_Button_txt_L,
		C9_Button_txt_L,
		C10_Button_txt_L,
		C11_Button_txt_L,
		C12_Button_txt_L,
		C13_Button_txt_L,
		C14_Button_txt_L,
		C15_Button_txt_L,
	}

	----------------------------------------------------------------
	----------------------------------------------------------------

	C1_Button:SetPos(480, 70)
	C1_Button:SetSize(160, 30)
	C1_Button:SetText("")
	C1_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C1_Button.DoClick = function()
		DrawDListView( "Fire", AnimTb["fire"], ent, C_List_white, C_List_black, C1_Button, C1_Button_txt_L, Clist_but, Clist_txt )
	end
	C1_Button_txt_L:SetPos(488, 75)
	C1_Button_txt_L:SetFont("TargetIDSmall")
	C1_Button_txt_L:SetText("Fire")
	C1_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C1_Button_txt_L:SizeToContents()

	--------------------------------

	C2_Button:SetPos(660, 70)
	C2_Button:SetSize(160, 30)
	C2_Button:SetText("")
	C2_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C2_Button.DoClick = function()
		DrawDListView( "Explosion", AnimTb["exp"], ent, C_List_white, C_List_black, C2_Button, C2_Button_txt_L, Clist_but, Clist_txt )
	end
	C2_Button_txt_L:SetPos(668, 75)
	C2_Button_txt_L:SetFont("TargetIDSmall")
	C2_Button_txt_L:SetText("Explosion")
	C2_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C2_Button_txt_L:SizeToContents()

	--------------------------------

	C3_Button:SetPos(840, 70)
	C3_Button:SetSize(160, 30)
	C3_Button:SetText("")
	C3_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C3_Button.DoClick = function()
		DrawDListView( "Club", AnimTb["club"], ent, C_List_white, C_List_black, C3_Button, C3_Button_txt_L, Clist_but, Clist_txt )
	end
	C3_Button_txt_L:SetPos(848, 75)
	C3_Button_txt_L:SetFont("TargetIDSmall")
	C3_Button_txt_L:SetText("Club")
	C3_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C3_Button_txt_L:SizeToContents()

	----------------------------------------------------------------
	----------------------------------------------------------------

	C4_Button:SetPos(480, 105)
	C4_Button:SetSize(160, 30)
	C4_Button:SetText("")
	C4_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C4_Button.DoClick = function()
		DrawDListView( "Bullet - Head", AnimTb["bd_head"], ent, C_List_white, C_List_black, C4_Button, C4_Button_txt_L, Clist_but, Clist_txt )
	end
	C4_Button_txt_L:SetPos(488, 110)
	C4_Button_txt_L:SetFont("TargetIDSmall")
	C4_Button_txt_L:SetText("Bullet - Head")
	C4_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C4_Button_txt_L:SizeToContents()

	--------------------------------

	C5_Button:SetPos(660, 105)
	C5_Button:SetSize(160, 30)
	C5_Button:SetText("")
	C5_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C5_Button.DoClick = function()
		DrawDListView( "Bullet - Neck", AnimTb["bd_neck"], ent, C_List_white, C_List_black, C5_Button, C5_Button_txt_L, Clist_but, Clist_txt )
	end
	C5_Button_txt_L:SetPos(668, 110)
	C5_Button_txt_L:SetFont("TargetIDSmall")
	C5_Button_txt_L:SetText("Bullet - Neck")
	C5_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C5_Button_txt_L:SizeToContents()

	--------------------------------

	C6_Button:SetPos(840, 105)
	C6_Button:SetSize(160, 30)
	C6_Button:SetText("")
	C6_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C6_Button.DoClick = function()
		DrawDListView( "Bullet - Torso", AnimTb["bd_torso"], ent, C_List_white, C_List_black, C6_Button, C6_Button_txt_L, Clist_but, Clist_txt )
	end
	C6_Button_txt_L:SetPos(848, 110)
	C6_Button_txt_L:SetFont("TargetIDSmall")
	C6_Button_txt_L:SetText("Bullet - Torso")
	C6_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C6_Button_txt_L:SizeToContents()

	----------------------------------------------------------------
	----------------------------------------------------------------

	C7_Button:SetPos(480, 140)
	C7_Button:SetSize(160, 30)
	C7_Button:SetText("")
	C7_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C7_Button.DoClick = function()
		DrawDListView( "Bullet - Left Arm", AnimTb["bd_larm"], ent, C_List_white, C_List_black, C7_Button, C7_Button_txt_L, Clist_but, Clist_txt )
	end
	C7_Button_txt_L:SetPos(488, 145)
	C7_Button_txt_L:SetFont("TargetIDSmall")
	C7_Button_txt_L:SetText("Bullet - Left Arm")
	C7_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C7_Button_txt_L:SizeToContents()

	--------------------------------

	C8_Button:SetPos(660, 140)
	C8_Button:SetSize(160, 30)
	C8_Button:SetText("")
	C8_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C8_Button.DoClick = function()
		DrawDListView( "Bullet - Right Arm", AnimTb["bd_rarm"], ent, C_List_white, C_List_black, C8_Button, C8_Button_txt_L, Clist_but, Clist_txt )
	end
	C8_Button_txt_L:SetPos(668, 145)
	C8_Button_txt_L:SetFont("TargetIDSmall")
	C8_Button_txt_L:SetText("Bullet - Right Arm")
	C8_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C8_Button_txt_L:SizeToContents()

	--------------------------------

	C9_Button:SetPos(840, 140)
	C9_Button:SetSize(160, 30)
	C9_Button:SetText("")
	C9_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C9_Button.DoClick = function()
		DrawDListView( "Bullet - Left Leg", AnimTb["bd_lleg"], ent, C_List_white, C_List_black, C9_Button, C9_Button_txt_L, Clist_but, Clist_txt )
	end
	C9_Button_txt_L:SetPos(848, 145)
	C9_Button_txt_L:SetFont("TargetIDSmall")
	C9_Button_txt_L:SetText("Bullet - Left Leg")
	C9_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C9_Button_txt_L:SizeToContents()

	----------------------------------------------------------------
	----------------------------------------------------------------

	C10_Button:SetPos(480, 175)
	C10_Button:SetSize(160, 30)
	C10_Button:SetText("")
	C10_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C10_Button.DoClick = function()
		DrawDListView( "Bullet - Right Leg", AnimTb["bd_rleg"], ent, C_List_white, C_List_black, C10_Button, C10_Button_txt_L, Clist_but, Clist_txt )
	end
	C10_Button_txt_L:SetPos(488, 180)
	C10_Button_txt_L:SetFont("TargetIDSmall")
	C10_Button_txt_L:SetText("Bullet - Right Leg")
	C10_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C10_Button_txt_L:SizeToContents()

	--------------------------------

	C11_Button:SetPos(660, 175)
	C11_Button:SetSize(160, 30)
	C11_Button:SetText("")
	C11_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C11_Button.DoClick = function()
		DrawDListView( "Bullet - Pelvis", AnimTb["bd_pelvis"], ent, C_List_white, C_List_black, C11_Button, C11_Button_txt_L, Clist_but, Clist_txt )
	end
	C11_Button_txt_L:SetPos(668, 180)
	C11_Button_txt_L:SetFont("TargetIDSmall")
	C11_Button_txt_L:SetText("Bullet - Pelvis")
	C11_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C11_Button_txt_L:SizeToContents()

	--------------------------------

	C12_Button:SetPos(840, 175)
	C12_Button:SetSize(160, 30)
	C12_Button:SetText("")
	C12_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C12_Button.DoClick = function()
		DrawDListView( "Bullet - Running", AnimTb["moving"], ent, C_List_white, C_List_black, C12_Button, C12_Button_txt_L, Clist_but, Clist_txt )
	end
	C12_Button_txt_L:SetPos(848, 180)
	C12_Button_txt_L:SetFont("TargetIDSmall")
	C12_Button_txt_L:SetText("Bullet - Running")
	C12_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C12_Button_txt_L:SizeToContents()

	----------------------------------------------------------------
	----------------------------------------------------------------

	C13_Button:SetPos(480, 210)
	C13_Button:SetSize(160, 30)
	C13_Button:SetText("")
	C13_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C13_Button.DoClick = function()
		DrawDListView( "Bullet - Back", AnimTb["bd_back"], ent, C_List_white, C_List_black, C13_Button, C13_Button_txt_L, Clist_but, Clist_txt )
	end
	C13_Button_txt_L:SetPos(488, 215)
	C13_Button_txt_L:SetFont("TargetIDSmall")
	C13_Button_txt_L:SetText("Bullet - Back")
	C13_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C13_Button_txt_L:SizeToContents()

	--------------------------------

	C14_Button:SetPos(660, 210)
	C14_Button:SetSize(160, 30)
	C14_Button:SetText("")
	C14_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C14_Button.DoClick = function()
		DrawDListView( "Bullet - Shotgun", AnimTb["bd_shotgun"], ent, C_List_white, C_List_black, C14_Button, C14_Button_txt_L, Clist_but, Clist_txt )
	end
	C14_Button_txt_L:SetPos(668, 215)
	C14_Button_txt_L:SetFont("TargetIDSmall")
	C14_Button_txt_L:SetText("Bullet - Shotgun")
	C14_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C14_Button_txt_L:SizeToContents()

	--------------------------------

	C15_Button:SetPos(840, 210)
	C15_Button:SetSize(160, 30)
	C15_Button:SetText("")
	C15_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(230, 230, 230, 235))
	end
	C15_Button.DoClick = function()
		DrawDListView( "Other (Physics, etc)", AnimTb["dying"], ent, C_List_white, C_List_black, C15_Button, C15_Button_txt_L, Clist_but, Clist_txt )
	end
	C15_Button_txt_L:SetPos(848, 215)
	C15_Button_txt_L:SetFont("TargetIDSmall")
	C15_Button_txt_L:SetText("Other (Physics, etc)")
	C15_Button_txt_L:SetColor(Color(100, 100, 100, 200))
	C15_Button_txt_L:SizeToContents()

	----------------------------------------------------------------
	----------------------------------------------------------------

	--按钮变红色
	Clist_but[lastlist_butID].Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 235))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(255, 51, 51, 235))
	end
	Clist_txt[lastlist_txtID]:SetColor(Color(230, 230, 230, 235))
	Clist_txt[lastlist_txtID]:SetFont("HudHintTextLarge")

	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------

end)


----------------------------------------------------------------------------------------
--将准心上的NPC或者Ragdoll加入NPC黑名单
concommand.Add("ARag_addNPC", function()
	local ent = LocalPlayer():GetEyeTrace().Entity
	if not IsValid(ent) or not ent:IsSolid() then return end
	local NPC_AlreadyExists = false

	if npclist then  --这里的判断是很有必要的，因为如果npclist={}，是空的的话，里面的循环会直接报错
		for k, v in pairs(npclist) do
			if v == ent:GetModel() then
				NPC_AlreadyExists = true
			end
		end
	else
		npclist = {}
		NPC_AlreadyExists = false
	end

	if not NPC_AlreadyExists then
		table.insert(npclist, ent:GetModel())
		print("Added model \"" .. ent:GetModel() .. "\" to NPC Blacklist!")
	else
		print("This model is already in NPC Blacklist!")
	end

	file.Write("enhanced_death_animations/npclist.txt", util.TableToJSON(npclist) )
	net.Start("ChangeNPClist_cTs")
	net.WriteTable(npclist)
	net.SendToServer()
end)
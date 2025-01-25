include("autorun/server/animrag_allconvar.lua")
include("autorun/server/animrag_allfunctions.lua")

util.AddNetworkString( "AnimRag_Death_T_Crawl_sTc" )					--用于 death 与 crawl 与 revive 动画之间传递消息，因为这三功能的文件是分开的
util.AddNetworkString( "AnimRag_Death_T_Crawl_cTs" )
util.AddNetworkString( "AnimRag_Crawl_T_Reviv_sTc" )
util.AddNetworkString( "AnimRag_Crawl_T_Reviv_cTs" )

util.AddNetworkString( "AnimRag_Reviv_T_Death_NPCRelation_sTc" )
util.AddNetworkString( "AnimRag_Reviv_T_Death_NPCRelation_cTs" )
util.AddNetworkString( "AnimRag_Reviv_T_Crawl_PausesCrawl_sTc" )
util.AddNetworkString( "AnimRag_Reviv_T_Crawl_PausesCrawl_cTs" )
util.AddNetworkString( "AnimRag_Reviv_T_Crawl_ResumeCrawl_sTc" )
util.AddNetworkString( "AnimRag_Reviv_T_Crawl_ResumeCrawl_cTs" )
util.AddNetworkString( "AnimRag_Death_T_Reviv_NPCIsPlyEnemy_sTc" )
util.AddNetworkString( "AnimRag_PoseFingerBone_sTc" )
util.AddNetworkString( "AnimRag_DrawHPDebugBar_sTc" )

util.AddNetworkString( "PlayerRag_StartDeathCam" )						--当玩家死亡时，告诉给client端的cam功能，开始DeathCam
util.AddNetworkString( "PlayerRag_PlayerSpawn" )						--当玩家重生时，告诉给client端的cam功能，让cam重置PRag
util.AddNetworkString( "PlayerRag_RotateHead" )							--当玩家死亡且开启了第一人称DeathCam时，根据视角方向改变Crawl时的头部方向，更拟真

util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_CreateRag_Death" )	--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_TransfRag_Death" )	--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_CreateRag_Crawl" )	--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_TransfRag_Crawl" )	--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_Crawl_Repeat" )		--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_Crawl_PosAng" )		--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_RemoveRag" )		--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_cTs" )				--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
util.AddNetworkString( "CreateAnimRag_KeepCorpseOff_sTc" )				--用于 关闭Keep Corpse后的 ClientSideRagdoll 的death与crawl动画
	
util.AddNetworkString( "ChangeWeaponlist_cTs" )							--在Settings Panel里改变该list时，将改变的结果传递到该server端
util.AddNetworkString( "ChangeEndposition_cTs" )						--在Settings Panel里改变该list时，将改变的结果传递到该server端
util.AddNetworkString( "ChangeNPClist_cTs" )							--在Settings Panel里改变该list时，将改变的结果传递到该server端
	

file.CreateDir("enhanced_death_animations")


Orgn_Rag_Tb_Death = {}		--包含了：所有正在播放死亡动画的Ragdoll，动画结束后会被清理
Anim_Rag_Tb_Death = {}		--包含了：所有正在播放死亡动画的Anim_Rag，动画结束后会被清理
local All_Rag_Tb = {} 		--包含了：地图上所有的Ragdoll，用于按量清理Ragdoll
local AnimTb = {} 			--包含了：根据所受伤害类型，而得到的所有该伤害类型的动画

local NrmTb = {
	["ValveBiped.Bip01_Pelvis"] 	= true,
	["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_D = {} 		--包含了：哪些肢体要跟随Anim_Rag运动

local MoveTb_1 = {
	["ValveBiped.Bip01_Pelvis"] 	= true,
	["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2 = {
	["ValveBiped.Bip01_Pelvis"] 	= true,
	//["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	//["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	//["ValveBiped.Bip01_L_Foot"] 	= true,
	//["ValveBiped.Bip01_R_Clavicle"] = true,
	//["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	//["ValveBiped.Bip01_L_Clavicle"] = true,
	//["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_3 = {
	//["ValveBiped.Bip01_Pelvis"] 	= true,
	//["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	//["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	//["ValveBiped.Bip01_L_Foot"] 	= true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	//["ValveBiped.Bip01_R_Forearm"] = true,
	//["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	//["ValveBiped.Bip01_L_Forearm"] = true,
	//["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local Zombie_Tb = {
	["npc_zombie"] = true,
	["npc_zombine"] = true,
	["npc_zombie_torso"] = true,
	["npc_poisonzombie"] = true,
	["npc_fastzombie_torso"] = true,
	["npc_fastzombie"] = true,
}


-- ↓ Initialize tables (They basicly only run once when game starts so no impact on performance)
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--决定使用哪个MoveTb，只有MoveTb里的骨骼会随着动画运动，其余骨骼都自由发挥。
if GetConVar("ARag_natural"):GetInt() == 1 then 
	MoveTb_D = MoveTb_1
elseif GetConVar("ARag_natural"):GetInt() == 2 then
	MoveTb_D = MoveTb_2
else
	MoveTb_D = MoveTb_3
end

cvars.AddChangeCallback("ARag_natural", function(convarName, oldValue, newValue)
	if tonumber(newValue) == 1 then 
		MoveTb_D = MoveTb_1
	elseif tonumber(newValue) == 2 then
		MoveTb_D = MoveTb_2
	else
		MoveTb_D = MoveTb_3
	end
end)


----------------------------------------------------------------------------------------
--决定使用哪种player的死亡方式
--防止 ARag_player_1 和 ARag_player_2 都为 1
function Animrag_Convar_Check(convar_name, Cvar1, Cvar2)
	if convar_name == Cvar1 and GetConVar(Cvar1):GetBool() then
		RunConsoleCommand(Cvar2, "0")
	end

	if convar_name == Cvar2 and GetConVar(Cvar2):GetBool() then
		RunConsoleCommand(Cvar1, "0")
	end
end

cvars.AddChangeCallback("ARag_player_1", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_player_1", "ARag_player_2")
end)
cvars.AddChangeCallback("ARag_player_2", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_player_1", "ARag_player_2")
end)


----------------------------------------------------------------------------------------
--决定使用哪种方式来作为Death Animation中的Ragdoll HP
--防止 ARag_overkill_fix_enable_d 和 ARag_overkill_max_enable_d 都为 1
cvars.AddChangeCallback("ARag_overkill_fix_enable_d", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_overkill_fix_enable_d", "ARag_overkill_max_enable_d")
end)
cvars.AddChangeCallback("ARag_overkill_max_enable_d", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_overkill_fix_enable_d", "ARag_overkill_max_enable_d")
end)


----------------------------------------------------------------------------------------
--决定使用哪种方式来作为Crawl Animation中的Ragdoll HP
--防止 ARag_overkill_fix_enable_c 和 ARag_overkill_max_enable_c 和 ARag_overkill_inherit_hp 都为 1
cvars.AddChangeCallback("ARag_overkill_fix_enable_c", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_overkill_fix_enable_c", "ARag_overkill_max_enable_c")
	Animrag_Convar_Check(convar_name, "ARag_overkill_fix_enable_c", "ARag_overkill_inherit_hp")
end)
cvars.AddChangeCallback("ARag_overkill_max_enable_c", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_overkill_max_enable_c", "ARag_overkill_fix_enable_c")
	Animrag_Convar_Check(convar_name, "ARag_overkill_max_enable_c", "ARag_overkill_inherit_hp")
end)
cvars.AddChangeCallback("ARag_overkill_inherit_hp", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_overkill_inherit_hp", "ARag_overkill_fix_enable_c")
	Animrag_Convar_Check(convar_name, "ARag_overkill_inherit_hp", "ARag_overkill_max_enable_c")
end)


----------------------------------------------------------------------------------------
--初始化weaponlist，并且当玩家在菜单里改变weaponlist时，更新该weaponlist
local weaponlist = {}

hook.Add("PlayerInitialSpawn", "Animrag_Getweaponlist_D", function()
	timer.Simple(0.5, function()
		local weapon_file = file.Open("enhanced_death_animations/weaponlist.txt", "r", "DATA")
		if weapon_file then
			weaponlist = util.JSONToTable( file.Read("enhanced_death_animations/weaponlist.txt", "DATA") )
		else
			weaponlist = {}
		end
	end)
end)

net.Receive("ChangeWeaponlist_cTs", function()
	weaponlist = net.ReadTable()
end)


----------------------------------------------------------------------------------------
--初始化npclist，并且当玩家在菜单里改变npclist时，更新该npclist
local npclist = {}

hook.Add("PlayerInitialSpawn", "Animrag_Getnpclist_D", function()
	timer.Simple(0.5, function()
		local npclist_file = file.Open("enhanced_death_animations/npclist.txt", "r", "DATA")
		if npclist_file then
			npclist = util.JSONToTable( file.Read("enhanced_death_animations/npclist.txt", "DATA") )
		else
			npclist = {}
		end
	end)
end)

net.Receive("ChangeNPClist_cTs", function()
	npclist = net.ReadTable()
end)


----------------------------------------------------------------------------------------
--初始化endpos_tb，并且当玩家在菜单里改变endpos_tb时，更新该endpos_tb
local everylist = {}
local endpos_tb = {}

hook.Add("PlayerInitialSpawn", "Animrag_Geteverylist_D", function()
	timer.Simple(0.5, function()
		
		--得到everylist，由于没有把endpos_tb写入文件（懒），所以就读取everylist，从everylist一比一转换得到endpos_tb，详情见animrag_panel.lua
		local everylist_file = file.Open("enhanced_death_animations/everylist.txt", "r", "DATA")
		if everylist_file then
			local everylist_file_content = everylist_file:Read()
			everylist_file:Close()
			--如果从文件里读到数据，则将数据拆分后写入everylist
			if everylist_file_content then
				for word in string.gmatch(everylist_file_content, "[^,\n]+") do
					table.insert(everylist, word)
				end
			else
				everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )
			end
		else
			everylist = util.JSONToTable( file.Read("enhanced_death_animations/preset_everylist.txt", "DATA") )
		end


		--从everylist得到endpos_tb
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

	end)
end)

--当菜单里的 百分比 更新时，更新endpos_tb
net.Receive("ChangeEndposition_cTs", function()
	endpos_tb = net.ReadTable()
end)
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Initialize tables (They basicly only run once when game starts so no impact on performance)


-- ↓ Functions
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--根据 动画名，从endpos_tb里揪出该 动画名 对应的 百分比
function Animrag_GetEndPos(anim)
	local percent = 100
	for k, v in pairs(endpos_tb) do
		if v.name == anim then
			percent = v.cent
		end
	end
	return percent
end


----------------------------------------------------------------------------------------
--从动画表格里剔除掉 blacklist 的部分
function Animrag_RemoveBlacklist(tb, blacklist)
	--例：tb = {"bd_death_fire1","bd_death_fire2",...}
	--要是tb里的某个元素存在在blacklist里，则从tb里移除这个元素
	for k, black in pairs(blacklist) do
		for i = #tb, 1, -1 do
			if tb[i] == black then
				table.remove(tb, i)
			end
		end
	end
	return tb
end


----------------------------------------------------------------------------------------
--选择播放哪个死亡动画
function Animrag_AnimChoose(ONPC)

	--从文件读取得到 blacklist
	--这个读取过程可以优化，可以用一个json表格直接代替txt文件，就省得再拆分txt了。但我懒得弄。
	local blacklist = {}
	local blacklist_file = file.Open("enhanced_death_animations/blacklist.txt", "r", "DATA")
	
	if blacklist_file then
		local blacklist_file_content = blacklist_file:Read()
		blacklist_file:Close()
		if blacklist_file_content then
			for word in string.gmatch(blacklist_file_content, "[^,\n]+") do
				table.insert(blacklist, word)
			end
		else
			blacklist = {}
		end
	else
		blacklist = {}
	end

	--选择死亡动画
	local anim
	local isHead = false
	local isFire = false
	local fixTb = {}

	--从文件读取动画表格
	AnimTb = util.JSONToTable( file.Read("enhanced_death_animations/anim_table.txt", "DATA") )

	if ONPC.Dmg == "Fire" then
		fixTb = Animrag_RemoveBlacklist(AnimTb["fire"], blacklist)
		anim = table.Random(fixTb)
		isFire = true
	elseif ONPC.Dmg == "Explosion" then
		fixTb = Animrag_RemoveBlacklist(AnimTb["exp"], blacklist)
		anim = table.Random(fixTb)
	elseif ONPC.Dmg == "Moving" then
		fixTb = Animrag_RemoveBlacklist(AnimTb["moving"], blacklist)
		anim = table.Random(fixTb)
	elseif ONPC.Dmg == "Club" then
		fixTb = Animrag_RemoveBlacklist(AnimTb["club"], blacklist)
		anim = table.Random(fixTb)
	else
		if ONPC.Hit == 1 then
			if ONPC.Neckshot then
				fixTb = Animrag_RemoveBlacklist(AnimTb["bd_neck"], blacklist)
				anim = table.Random(fixTb)
			else
				fixTb = Animrag_RemoveBlacklist(AnimTb["bd_head"], blacklist)
				anim = table.Random(fixTb) 
			end
			isHead = true
		elseif ONPC.Shotshot then
			fixTb = Animrag_RemoveBlacklist(AnimTb["bd_shotgun"], blacklist)
			anim = table.Random(fixTb)
		elseif ONPC.Hit == 2 or ONPC.Hit == 3 then
			if ONPC.Pelvshot then
				fixTb = Animrag_RemoveBlacklist(AnimTb["bd_pelvis"], blacklist)
				anim = table.Random(fixTb)
			elseif ONPC.Backshot then
				fixTb = Animrag_RemoveBlacklist(AnimTb["bd_back"], blacklist)
				anim = table.Random(fixTb)
			else
				fixTb = Animrag_RemoveBlacklist(AnimTb["bd_torso"], blacklist)
				anim = table.Random(fixTb)
			end
		elseif ONPC.Hit == 4 then
			fixTb = Animrag_RemoveBlacklist(AnimTb["bd_larm"], blacklist)
			anim = table.Random(fixTb) 
		elseif ONPC.Hit == 5 then
			fixTb = Animrag_RemoveBlacklist(AnimTb["bd_rarm"], blacklist)
			anim = table.Random(fixTb) 
		elseif ONPC.Hit == 6 then
			fixTb = Animrag_RemoveBlacklist(AnimTb["bd_lleg"], blacklist)
			anim = table.Random(fixTb) 
		elseif ONPC.Hit == 7 then
			fixTb = Animrag_RemoveBlacklist(AnimTb["bd_rleg"], blacklist)
			anim = table.Random(fixTb) 
		else
			fixTb = Animrag_RemoveBlacklist(AnimTb["dying"], blacklist)
			anim = table.Random(fixTb) 
		end
	end

	if CVAR_ARag_healthbar:GetBool() then
		print(anim)
	end

	return anim, isHead, isFire
end


----------------------------------------------------------------------------------------
--核心函数，当NPC死亡变成Ragdoll时，禁用它的骨骼碰撞，接着创建一个Anim_Rag来播放动画，将动画过程中Anim_Rag的各骨骼位置映射到Ragdoll身上
function Animrag_StartDeathAnimation(ONPC, Orgn_Rag)

	------------------------------------
	--下面的一坨虽然看起来长，但似乎对游戏的影响小于1fps
	if not IsValid(ONPC) or not IsValid(Orgn_Rag) then return end
	table.insert(All_Rag_Tb, Orgn_Rag) 										--不管播不播放动画，都把这个Ragdoll加入计数，用于按量清理

	------------------------------------
	--如果爆头了（我指的是连头都没了），那就不播放动画
	if Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1") then
		if Orgn_Rag:GetManipulateBoneScale(Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1")) == Vector(0, 0, 0) then return end
	end

	------------------------------------
	--得到Death与Crawl两者都要用到的各个参数，因此放在了这里，而不是放在下面的Death专用代码里
	local NPCHp = ONPC:GetMaxHealth()
	local Animation, isHead, isFire = Animrag_AnimChoose(ONPC) 				--得到NPC受伤时所传递的各个参数：是否爆头，是否着火，以及由此而判断出的动画名称

	------------------------------------
	--该NPC是否是zombie
	local isZombie = false
	if Zombie_Tb[ONPC:GetClass()] then
		isZombie = true
	end
	if isZombie and not CVAR_ARag_zombie:GetBool() then return end 			--是zombie时，如果禁用了zombie动画，就不播放

	------------------------------------
	--该NPC的身高，用于缩放AnimRag
	if ONPC:LookupAttachment('eyes') > 0 then
		local eye_height = ONPC:GetAttachment(ONPC:LookupAttachment('eyes')).Pos.z
		local npc_origin = ONPC:GetPos().z
		Orgn_Rag.BodyHeight = math.abs(eye_height-npc_origin)
	end

	------------------------------------
	--当死亡的是Player时，传递Ragdoll数据给cam
	if ONPC:IsPlayer() then
		ONPC:SetNWBool("PlayerIsDeadNow", true)								--用NW标记一下这个刚死掉的NPC是玩家，这样在Revive client端也能用，用于判断当前玩家按复活按键，到底是玩家在复活NPC，还是玩家在自活
		ONPC:SetNWInt("PlayerORagID", Orgn_Rag:EntIndex())					--用NW标记一下这个刚死掉的NPC（即玩家）的Ragdoll，用于玩家自活（于是当玩家按下复活按键时，复活的Ragdoll直接为这个Ragdoll）
		ONPC.Weapons = {}													--在PlayerDeath的Hook里得不到玩家的武器列表（用于Revive），因此只能在这里得到
		for k, wep in pairs(ONPC:GetWeapons()) do
			table.insert(ONPC.Weapons, wep:GetClass())
		end
		Orgn_Rag:SetNWBool("isPlayer", true)								--用NW标记一下该Ragdoll是Player的Ragdoll
		Orgn_Rag:SetNWString("isPlayer_SID", ONPC:SteamID())					--用NW标记一下该Player的NickName，用于复活该Player，防止复活错人

		net.Start("PlayerRag_StartDeathCam")
		net.WriteInt(Orgn_Rag:EntIndex(), 32)
		net.WriteEntity(Orgn_Rag)
		net.Send(player.GetBySteamID( Orgn_Rag:GetNWString("isPlayer_SID") ) )
		
		if IsValid(Orgn_Rag) and Orgn_Rag:GetNWBool("isPlayer") == true and ONPC:SteamID() == Orgn_Rag:GetNWString("isPlayer_SID") then
			net.Start("impulseRagdollLink")
			net.WriteEntity(Orgn_Rag)
			net.Send(ONPC)
		end
	end

	------------------------------------
	------------------------------------
	--Real stuff
	--Real stuff
	--Real stuff
	--Death专用
	--只有当有Animation，且该NPC是正常NPC而不是VJBase里奇奇怪怪的NPC时，才播放死亡动画
	if CVAR_ARag_enab_d:GetBool() and math.Rand(0, 1) <= CVAR_ARag_odds_d:GetFloat() and Animation then

		------------------------------------
		--创建一个Anim_Rag，设置其无碰撞、不可见，并让它播放死亡动画，从而能将这个动画映射到Ragdoll身上
		local Anim_Rag = ents.Create("prop_dynamic")
		Anim_Rag:SetModel("models/brutal_deaths/model_anim_modify.mdl")
		//Anim_Rag:SetBodygroup(Anim_Rag:FindBodygroupByName("barney"), 1) 	--If you don't understand how this addon works, enable this line and you may see.
		Anim_Rag:SetPos(ONPC:GetPos())
		Anim_Rag:SetAngles(ONPC:GetAngles())
		Anim_Rag:Spawn()
		Anim_Rag:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
		------------------------------------
		--缩放AnimRag以适应Ragdoll的尺寸
		Animrag_ScaleAnimRag(Orgn_Rag, Anim_Rag)		
		
		------------------------------------
		--得到播放动画所需的各种参数（动画名称、所需播放的时间、僵尸是否被爆头）
		local _, Animation_Tm = Anim_Rag:LookupSequence(Animation)
		local Animation_Endpos = Animrag_GetEndPos(Animation)
		Animation_Tm = Animation_Tm * (Animation_Endpos/100)
		Anim_Rag:Fire("SetAnimation", Animation)
		if isFire then Orgn_Rag:Ignite(Animation_Tm + math.Rand(5, 20)) end
		
		------------------------------------
		--每一个Ragdoll对应的各自的参数
		Anim_Rag.ORag = Orgn_Rag 											--该AnimRag对应的Ragdoll
		Orgn_Rag.ARag = Anim_Rag 											--该Ragdoll对应的AnimRag
		--播放动画所需的参数
		Orgn_Rag:SetNWInt("Animation_State", 1) 							--总之就是标记一下开始死亡了（用1标记），用于将 Alive(0), Death Animation(1), Crawl Animation(2), Revive Animation(3), Overkilled(0)区分开
		Orgn_Rag.Table = MoveTb_D 											--该Ragdoll对应的MoveTb，只有MoveTb里的骨骼会被移动，其它骨骼自由发挥
		Orgn_Rag.Bone = {}													--该Ragdoll每个骨骼各自的参数
		for bonename, _ in pairs(Orgn_Rag.Table) do
			local boneID = Orgn_Rag:LookupBone(bonename)
			if boneID then
				Orgn_Rag.Bone[bonename] = {}
				Orgn_Rag.Bone[bonename]["random"] = Angle(math.Rand(-15, 15), math.Rand(-15, 15), 0)--给动作一点随机性
				Orgn_Rag.Bone[bonename]["addpos"] = Vector(0, 0, 0)			--该骨骼当前帧的addpos
				Orgn_Rag.Bone[bonename]["lastAdd"] = Vector(0, 0, 0)		--该骨骼上一帧的addpos
				Orgn_Rag.Bone[bonename]["lastHit"] = Vector(0, 0, 0)		--该骨骼上一帧的HitPos
				Orgn_Rag.Bone[bonename]["Fall"] = false						--该骨骼这一帧是不是距离地面太高了，如果true（距地太高了），则不再让这个骨骼爬行了，而让它自由落体，计数+1
				Orgn_Rag.Bone[bonename]["HitWall"] = false					--该骨骼这一帧是不是撞墙上了，如果true（撞上了），则计数+1
			end
		end
		--结束动画所需的参数
		Orgn_Rag.Anim_Nm = Animation 										--动画的名称，用于Debug
		Orgn_Rag.Anim_Tm = Animation_Tm										--动画会播放多久，用于告诉crawl端
		Orgn_Rag.Anim_St = Animation_Tm + CurTime()							--动画何时会停止，用于判断何时动画结束
		Orgn_Rag.Head = Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1")  		--该Ragdoll的头部骨骼，方便判断是否被爆头
		Orgn_Rag.Isdead_d = false											--这是为了标记该Ragdoll已经被杀死了，防止继续打伤害会让它再死一次
		Orgn_Rag.StopAnim = false											--这是为了标记该Ragdoll已经结束动画了（不一定是被杀死的），防止AnimRag_ComputeShadowControl继续运算
		--环境交互所需的参数（也属于结束动画所需的参数）
		Orgn_Rag.Fall = 0													--该Ragdoll里有几个骨骼已经悬空了，用于当Ragdoll爬到地形边缘时，决定是让它结束动画还是让它继续顺着地形爬行
		Orgn_Rag.HitWall = 0												--该Ragdoll里有几个骨骼已经撞墙了，用于当Ragdoll撞到墙壁时，决定是让它结束动画还是让它继续怼墙
		--计算HP所需的参数（也属于结束动画所需的参数）
		if 			CVAR_OK_Fix_Enable_d:GetBool() and not 	CVAR_OK_Max_Enable_d:GetBool() then 		
			Orgn_Rag.Hp_d = CVAR_OK_Fix_Value_d:GetInt()					--使用固定值作为 Hp_d						
		elseif not 	CVAR_OK_Fix_Enable_d:GetBool() and 		CVAR_OK_Max_Enable_d:GetBool() then
			Orgn_Rag.Hp_d = CVAR_OK_Max_Value_d:GetFloat() * NPCHp 			--使用百分比作为 Hp_d	
		elseif 		CVAR_OK_Fix_Enable_d:GetBool() and 		CVAR_OK_Max_Enable_d:GetBool() then
			Orgn_Rag.Hp_d = CVAR_OK_Max_Value_d:GetFloat() * NPCHp 			--使用百分比作为 Hp_d（当固定值与百分比同时开启时，以百分比为准）
		else
			Orgn_Rag.Hp_d = false 											--禁用Overkill
		end
		Orgn_Rag.MaxHp = Orgn_Rag.Hp_d 										--这个是用来在Debug界面显示的
		
		------------------------------------
		--写入表格，开始播放死亡动画！
		table.insert(Orgn_Rag_Tb_Death, Orgn_Rag)
		table.insert(Anim_Rag_Tb_Death, Anim_Rag)
	
		------------------------------------
		--先禁用所有骨骼的任何运动，防止骨骼被子弹冲击力打歪到动画位置之外，接着再启用回来
		for bonename, _ in pairs(NrmTb) do
			local boneID = Orgn_Rag:LookupBone(bonename)
			if boneID then
				local phyid = Orgn_Rag:TranslateBoneToPhysBone(boneID)
				local phyobj = Orgn_Rag:GetPhysicsObjectNum(phyid)
				if phyobj then
					phyobj:EnableMotion(false)
				end
			end
		end
		
		timer.Simple(FrameTime(), function()
			if IsValid(Orgn_Rag) then
				for i=0, Orgn_Rag:GetPhysicsObjectCount()-1 do
					local phyobj = Orgn_Rag:GetPhysicsObjectNum(i)
					if phyobj then
						phyobj:EnableMotion(true)
					end
				end
			end
		end)

	end

	------------------------------------
	--Crawl专用

	------------------------------------
	--判断是否需要Crawl
	if not IsValid(Orgn_Rag) then return end
	if not isZombie and isHead and CVAR_ARag_headshot:GetBool() then return end			--不是zombie，受到了爆头，且开启了No Crawl After Headshot，则不再爬行
	if isZombie and not CVAR_ARag_zombie_crawl:GetBool() then return end 				--是zombie时，如果禁用了zombie_crawl，则不再爬行，
	if isFire then return end 															--被烧死时，则不再爬行，很合理吧
	if ONPC.Overflow then return end													--开启了伤害溢出时（比如50滴血却受到了整整5000点暴击！），则不再爬行
	if ONPC.IsRevivedNPC then return end 												--如果开启了“禁止复活NPC再次爬行”，且该NPC是个已经被复活过的NPC，则不再运行。
	if ONPC.IsRevivedPLY then ONPC.IsRevivedPLY = false return end 						--如果开启了“禁止复活PLY再次爬行”，且该PLY是个已经被复活过的PLY，则不再运行。这种情况下玩家只能手动复活，因此可以放心地把IsRevivedPLY重置为false

	------------------------------------
	--得到将要Crawl的Ragdoll的敌人信息，这样才能爬离敌人
	local Hostile1 = {}		--将所有敌人写入这个表格（可能会有重复的）（该NPC将试图爬离这些敌人）
	local Hostile2 = {}		--用于剔除重复的
	local Hostile  = {}		--无重复的最终的hostile表格
	local Friends  = {}		--将所有友军写入这个表格（这些友军将试图复活该NPC）

	--将hostile写入Hostile1
	--得到所有仇恨该NPC的entity与喜欢该NPC的entity，以下 other_npc 和 ONPC 两者间只要有一个是NPC就行，如果两个都是Player，则无法Disposition
	for _, other_npc in pairs(ents.GetAll()) do
		
		--如果other_npc是NPC，则将other_npc写入关系表（这个只能将NPC写入关系表，不能将Player写入关系表）
		if other_npc:IsNPC() then
			local D = other_npc:Disposition(ONPC)
			if D == D_HT or D == D_FR and CVAR_ARag_avoid_e:GetBool() then
				table.insert(Hostile1, other_npc)
			elseif D == D_LI then
				table.insert(Friends, other_npc)
			else
				--如果是中立，但是是同一个class，则也加入Friends
				if other_npc:GetClass() == ONPC:GetClass() then
					table.insert(Friends, other_npc)
				end
			end

		--如果能运行下面的，就说明other_npc是玩家（如果other_npc是NPC的话，那在上面就已经符合要求运行完了，不会运行这段，因此能运行这段，必然说明other_npc是玩家），且ONPC是NPC（这个弥补了上边的，让Player也能被写入关系表）
		elseif other_npc:IsPlayer() and ONPC:IsNPC() then
			local D = ONPC:Disposition(other_npc)
			if D == D_HT or D == D_FR then
				--告诉revive的client端该玩家与该Ragdoll是敌对关系，用于revive的client端判断玩家是否能复活敌对的NPC
				Orgn_Rag:SetNWBool("EnemyPlayer: " .. tostring(other_npc), true)
				table.insert(Hostile1, other_npc)
			elseif D == D_LI then
				table.insert(Friends, other_npc)
			else
				--如果是中立，但是是同一个class，则也加入Friends
				if other_npc:GetClass() == ONPC:GetClass() then
					table.insert(Friends, other_npc)
				end
			end
		end
	end

	--将player写入Hostile1
	if CVAR_ARag_avoid_p:GetBool() then
		for _, PLY in pairs(player.GetAll()) do
			table.insert(Hostile1, PLY)
		end
	end

	--用Hostile2给表格Hostile1去重，得到Hostile
	for _, v in pairs(Hostile1) do
		Hostile2[v] = true
	end

	for k, _ in pairs(Hostile2) do
		table.insert(Hostile, k)
	end
	
	------------------------------------
	--将Crawl与Revive所需的参数写入Ragdoll
	Orgn_Rag.NPCHp   = NPCHp
	Orgn_Rag.Hostile = Hostile
	Orgn_Rag.Friends = Friends
	Orgn_Rag.SpClass = ONPC:GetClass()
	Orgn_Rag.Weapons = ONPC.Weapons

	------------------------------------
	--无论death动画是否启用，如果挺过了以上条件，则将Orgn_Rag传递到Crawl动画端
	net.Start("AnimRag_Death_T_Crawl_sTc")
		net.WriteInt(Orgn_Rag:EntIndex(), 32)
		net.WriteFloat(Orgn_Rag.Anim_Tm or 0)
	net.Broadcast()
end
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Functions


-- ↓ Hooks/Nets
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--当在Revive端里，一个NPC前去Revive一个Ragdoll时，在Revive端得到该NPC的敌友信息，并传给Death端，用于当Death端中该NPC被杀时纠正其敌友关系（因为该NPC在Revive一个Ragdoll的过程中其敌友关系会被修改）
net.Receive("AnimRag_Reviv_T_Death_NPCRelation_cTs", function()
	local ONPC = Entity(net.ReadInt(32))
	ONPC.TB2 = {}
	ONPC.TB2.Relation_PLY = net.ReadTable()
	ONPC.TB2.Relation_NPC = net.ReadTable()
end)


----------------------------------------------------------------------------------------
--当NPC死亡变成Ragdoll时，执行核心功能，且将该Ragdoll与该NPC关联起来，因为下边的OnNPCKilled中是不包含Ragdoll信息的，而为了与VJBase兼容，又必须用OnNPCKilled再次判断一下应不应该播放死亡动画
hook.Add("CreateEntityRagdoll", "Animrag_CreateEntityRagdoll_D", function(ONPC, Orgn_Rag)

	--在npclist里的NPC不会播放死亡动画
	if npclist then
		for k, v in pairs(npclist) do
			if v == ONPC:GetModel() then return end
		end
	end

	--如果该NPC在Revive端有记录，则纠正其敌友关系（这段在以下情况里有用：一个NPC正在Revive一个Ragdoll，而这个NPC在Revive过程中被打死了），以在爬行时与复活时得到正确的敌友关系
	if ONPC.TB2 then
		for _, ply in pairs(player.GetAll()) do
			if ONPC.TB2.Relation_PLY[ply] then
				ONPC:AddEntityRelationship(ply, ONPC.TB2.Relation_PLY[ply], 99)
			end
		end
		for _, other_npc in ipairs(ents.GetAll()) do
			if other_npc:IsNPC() and ONPC.TB2.Relation_NPC[other_npc] then
				ONPC:AddEntityRelationship(other_npc, ONPC.TB2.Relation_NPC[other_npc], 99)
			end
		end
	end

	Animrag_StartDeathAnimation(ONPC, Orgn_Rag)
	Orgn_Rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end)


//----------------------------------------------------------------------------------------
//--等一帧后再运行，这样可以：如果是普通的NPC死亡，则一定是先CreateEntityRagdoll，再OnNPCKilled，于是ONPC.EntityRagdoll一定存在，ONPC.IsNormalNPC为真，可以正常运行死亡动画；
//--如果是VJBase里的一些玩意，则可能会是先OnNPCKilled，再CreateEntityRagdoll，于是ONPC.EntityRagdoll不存在，ONPC.IsNormalNPC为假，不播放死亡动画
//hook.Add("OnNPCKilled", "Animrag_StartMain_D", function(ONPC, attacker, inflictor)
//	timer.Simple(FrameTime(), function()
//		if ONPC.EntityRagdoll then
//			ONPC.IsNormalNPC = true
//		end
//		Animrag_StartDeathAnimation(ONPC, ONPC.EntityRagdoll)
//	end)
//end)


----------------------------------------------------------------------------------------
--主功能，得到 AnimRag 各骨骼应有的位置与角度信息，并应用在 Ragdoll 身上。
hook.Add("Tick", "Animrag_MainTick_D", function()
	if not Orgn_Rag_Tb_Death then return end
	for k, ORag in pairs(Orgn_Rag_Tb_Death) do
		if IsValid(ORag) and IsValid(ORag.ARag) then

			------------------------------------------------------
			--当Ragdoll超过5个肢体有坠落的趋势，或者所有运动肢体被墙壁阻挡时，结束动画
			if ORag.Fall >= 5 or ORag.HitWall >= table.Count(ORag.Table) then 
				Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
			end

			--当Ragdoll被爆头时，结束动画
			if ORag.Head then
				if ORag:GetManipulateBoneScale(ORag.Head) == Vector(0, 0, 0) then
					Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
				end
			end

			------------------------------------------------------
			--主循环
			Animrag_ComputeShadowControl(ORag)

			------------------------------------------------------
			--当动画播放完毕后
			if CurTime() >= ORag.Anim_St then
				Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
			end

		end
	end
end)
----------------------------------------------------------------------------------------
--主要功能



--辅助功能
----------------------------------------------------------------------------------------
--得到NPC收到的伤害类型（只能用在NPC身上，而不能用在Ragdoll身上，因此才有下边的EntityTakeDamage来判断Ragdoll所受伤害）
hook.Add("ScaleNPCDamage", "Animrag_NPCHit_D", function(ONPC, hitgrp, dmg)

	ONPC.Hit = hitgrp

	--判断伤害类型
	if dmg:GetDamageType() == DMG_BURN or ONPC:IsOnFire() then
		ONPC.Dmg = "Fire"
	elseif dmg:IsExplosionDamage() or dmg:GetDamageType() == DMG_BLAST then
		ONPC.Dmg = "Explosion"
	elseif ONPC:IsOnGround() and (ONPC:IsPlayer() and ONPC:GetVelocity():LengthSqr() > math.pow(ONPC:GetWalkSpeed(), 2) or ONPC:IsNPC() and ONPC:GetIdealMoveSpeed() > 150) then
		ONPC.Dmg = "Moving"
	elseif (dmg:GetDamageType() == DMG_CLUB or dmg:GetDamageType() == DMG_CRUSH) then
		ONPC.Dmg = "Club"
	else
		ONPC.Dmg = "Bullet"
	end

	--超越控制，用玩家所持武器对应的damagetype超越控制伤害类型
	local attacker = dmg:GetAttacker()
	if attacker:IsNPC() or attacker:IsPlayer() then 
		local awep = attacker:GetActiveWeapon()
		if weaponlist and awep != NULL then
			for k, v in pairs(weaponlist) do
				if v.wep == awep:GetPrintName() then
					ONPC.Dmg = v.typ
				end
			end
		end
	end

	--判断特殊射击位置
	local dmgpos = dmg:GetDamagePosition()

	--每次受伤时都重置一下这些
	ONPC.Neckshot = false
	ONPC.Shotshot = false
	ONPC.Backshot = false
	ONPC.Pelvshot = false

	--超越控制里有点小错误，纠正一下
	if ONPC.Dmg == "Shotgun" then
		ONPC.Dmg = "Bullet"
		ONPC.Shotshot = true
	return end

	if ONPC:LookupBone("ValveBiped.Bip01_Head1") then
		ONPC.Neckshot = (ONPC.Hit == 1 and dmgpos.z < ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Head1")).z)
		if ONPC.Neckshot then return end
	end
	
	if (dmg:IsDamageType(DMG_BUCKSHOT) or dmg:GetAmmoType() == 7) then
		ONPC.Shotshot = true
	return end

	if not CVAR_ARag_nobackshot:GetBool() and ONPC:GetForward():Dot((dmgpos - ONPC:GetPos()):GetNormalized()) < 0 then
		ONPC.Backshot = true
	return end

	if ONPC:LookupBone("ValveBiped.Bip01_Pelvis") then
		ONPC.Pelvshot = dmgpos.z < (ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis")).z + 2)
	end

end)


----------------------------------------------------------------------------------------
--当Ragdoll收到一定量的伤害时，执行这个Ragdoll的结束函数，结束动画
hook.Add("EntityTakeDamage", "Animrag_Damage_D", function(ORag, dmg)

	--针对vFire，vFire的只能在这里得到NPC是否着火
	if ORag:IsNPC() and ORag:IsOnFire() then
		ORag.Dmg = "Fire"
	end

	--（NPC死亡前，这时的 ORag 是 NPC ）如果开启伤害过量，则在伤害过量时禁止crawl动画
	if not ORag:IsRagdoll() then
		if CVAR_OK_Overflow_enable:GetBool() then
			local NPC_MaxHp = ORag:GetMaxHealth()
			if (dmg:GetDamage() - NPC_MaxHp) >= (CVAR_OK_Overflow_value:GetFloat() * NPC_MaxHp) then
				ORag.Overflow = true
			end
		end
	end

	--（NPC死亡后，这时的 ORag 是 Ragdoll ）计算Hp_d，并判断是否要Overkill
	if ORag:IsRagdoll() and ORag.Hp_d then
		if dmg:GetDamageType() == DMG_CRUSH then
			dmg:ScaleDamage(CVAR_OK_CrushDmg_Scale:GetFloat())
		end

		ORag.Hp_d = ORag.Hp_d - math.Round(dmg:GetDamage())
		if ORag.Hp_d <= 0 and not ORag.Isdead_d then
			Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
		end
	end
end)


----------------------------------------------------------------------------------------
--得到被杀的NPC所持武器的名称，用于Revive（因为前面的CreateEntityRagdoll的Hook没法得到武器名称）
hook.Add("OnNPCKilled", "Animrag_OnNPCKilled", function(ONPC, attacker, inflictor)
	if ONPC:IsNPC() then
		if ONPC:GetWeapons() then
			ONPC.Weapons = {}
			for k, wep in pairs(ONPC:GetWeapons()) do
				table.insert(ONPC.Weapons, wep:GetClass())
			end
		end
	end
end)


----------------------------------------------------------------------------------------
--允许Player死亡时生成实体，并播放动画
hook.Add("DoPlayerDeath", "Animrag_PlayerDeath_D", function(ply)
	if CVAR_ARag_player_1:GetBool() then 

		timer.Simple(FrameTime(), function()
			if IsValid(ply:GetRagdollEntity()) then
				ply:GetRagdollEntity():Remove()
			end
		end)

		local NewRag = ents.Create("prop_ragdoll")
		NewRag:SetModel(ply:GetModel())
		NewRag:SetColor(ply:GetColor())
		NewRag:SetSkin(ply:GetSkin())
		for k, v in pairs(ply:GetBodyGroups()) do
			NewRag:SetBodygroup(v.id, ply:GetBodygroup(v.id))
		end
		NewRag:SetPos(ply:GetPos())
		NewRag:SetAngles(ply:GetAngles())
		NewRag:Spawn()
		NewRag:Activate()
		NewRag:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		for i = 0, NewRag:GetPhysicsObjectCount() - 1 do
			local NewPhyBone = NewRag:GetPhysicsObjectNum( i )
			if IsValid(NewPhyBone) then
				local bonename = NewRag:GetBoneName(NewRag:TranslatePhysBoneToBone(i))
				local pos, ang = ply:GetBonePosition(ply:LookupBone(bonename))
				if pos then NewPhyBone:SetPos( pos ) end
				if ang then NewPhyBone:SetAngles( ang ) end
			end
		end

		Animrag_StartDeathAnimation(ply, NewRag)
		
		local ragCount = #ents.FindByClass("prop_ragdoll")
		
		NewRag:Fire("FadeAndRemove", nil, impulse.Config.BodyDeSpawnTime)

	if ragCount > 24 then
		print("[impulse] Avoiding ragdoll body spawn for performance reasons... (rag count: "..ragCount..")")
		NewRag:Remove()
	end
		
	end
end)

--允许Player死亡时生成实体，并播放动画（方案B）
hook.Add("PlayerDeath", "Animrag_PlayerDeath2_D", function(ply)
	if CVAR_ARag_player_2:GetBool() then 
		ply:SetShouldServerRagdoll(true)
	end
end)
hook.Add("PostPlayerDeath","Animrag_PlayerDeath22_D", function(ply)
	if CVAR_ARag_player_2:GetBool() then  
		local PRag = ply:GetRagdollEntity()
		if PRag and IsValid(PRag) then 
			PRag:Remove() 
		end
	end
end)


----------------------------------------------------------------------------------------
--当重生时，告诉client端重设PRag，同时重设玩家的NW
-- hook.Add("PlayerSpawn", "Animrag_PlayerSpawn_D", function(ply)
	-- //--当玩家复活后，让玩家的Ragdoll不再属于玩家Ragdoll，就变成普通的可以Revive的Ragdoll（有问题，会TPose，不用）
	-- //local PRag = Entity(ply:GetNWInt("PlayerORagID"))
	-- //PRag:SetNWBool("isPlayer", false)

	-- --清空玩家的NW
	-- ply:SetNWBool("PlayerIsDeadNow", false)
	-- ply:SetNWInt("PlayerORagID", nil)

	-- --告诉client端重设PRag，从而重设死亡视角
	-- net.Start("PlayerRag_PlayerSpawn")
	-- net.WriteBool(true)
	-- net.Send(
-- end)


----------------------------------------------------------------------------------------
--得到Player收到的伤害类型
hook.Add("ScalePlayerDamage", "Animrag_PlayerHit_D", function(PLY, hitgrp, dmg)

	PLY.Hit = hitgrp

	--判断伤害类型
	if dmg:GetDamageType() == DMG_BURN or PLY:IsOnFire() then
		PLY.Dmg = "Fire"
	elseif dmg:IsExplosionDamage() or dmg:GetDamageType() == DMG_BLAST then
		PLY.Dmg = "Explosion"
	elseif PLY:IsOnGround() and PLY:GetVelocity():LengthSqr() >= math.pow(PLY:GetWalkSpeed(), 2) then
		PLY.Dmg = "Moving"
	elseif (dmg:GetDamageType() == DMG_CLUB or dmg:GetDamageType() == DMG_CRUSH) then
		PLY.Dmg = "Club"
	else
		PLY.Dmg = "Bullet"
	end

	--超越控制，用玩家所持武器对应的damagetype超越控制伤害类型
	local attacker = dmg:GetAttacker()
	if attacker:IsNPC() or attacker:IsPlayer() then 
		local awep = attacker:GetActiveWeapon()
		if weaponlist and awep != NULL then
			for k, v in pairs(weaponlist) do
				if v.wep == awep:GetPrintName() then
					PLY.Dmg = v.typ
				end
			end
		end
	end

	--判断特殊射击位置
	local dmgpos = dmg:GetDamagePosition()
	
	--每次受伤时都重置一下这些
	PLY.Neckshot = false
	PLY.Shotshot = false
	PLY.Pelvshot = false

	--超越控制里有点小错误，纠正一下
	if PLY.Dmg == "Shotgun" then
		PLY.Dmg = "Bullet"
		PLY.Shotshot = true
	return end

	if PLY:LookupBone("ValveBiped.Bip01_Head1") then
		PLY.Neckshot = (PLY.Hit == 1 and dmgpos.z < PLY:GetBonePosition(PLY:LookupBone("ValveBiped.Bip01_Head1")).z)
		if PLY.Neckshot then return end
	end

	if (dmg:IsDamageType(DMG_BUCKSHOT) or dmg:GetAmmoType() == 7) then
		PLY.Shotshot = true
	return end

	if PLY:LookupBone("ValveBiped.Bip01_Pelvis") then
		PLY.Pelvshot = dmgpos.z < (PLY:GetBonePosition(PLY:LookupBone("ValveBiped.Bip01_Pelvis")).z + 2)
	end
end)


----------------------------------------------------------------------------------------
--当用撤销键移除一个Ragdoll时，执行这个Ragdoll的结束函数
hook.Add("EntityRemoved", "Animrag_RagRemoved_D", function(ent, fullUpdate)
	
	--[Arc9 Base]会莫名其妙地删除AnimRag，所以需要这段
	if ent:GetClass() == "prop_dynamic" then
		for k, ARag in pairs(Anim_Rag_Tb_Death) do
			if ARag == ent then

				for k2, v in pairs(Orgn_Rag_Tb_Death) do
					if v == ARag.ORag then
						table.remove(Orgn_Rag_Tb_Death, k2)
					end
				end

				table.remove(Anim_Rag_Tb_Death, k)

			end
		end
	end

	if ent:IsRagdoll() then
		for k, ORag in pairs(Orgn_Rag_Tb_Death) do
			if ORag == ent then
				Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
			end
		end

		for k, ORag in pairs(All_Rag_Tb) do
			if ORag == ent then
				table.remove(All_Rag_Tb, k)
			end
		end
	end
end)


----------------------------------------------------------------------------------------
--当清空服务器时，重置一切参数
hook.Add("PostCleanupMap" , "Animrag_ResetAll_D" , function(ply)
	Orgn_Rag_Tb_Death = {}
	Anim_Rag_Tb_Death = {}
	All_Rag_Tb = {}
end)


----------------------------------------------------------------------------------------
--Ragdoll Clean
timer.Create("Animrag_CleanupRag_D", 1, 0, function()
	if not CVAR_ARag_clean_e:GetBool() then return end
	if table.Count(All_Rag_Tb) > CVAR_ARag_clean:GetInt() then
		Animrag_EndAnimation(All_Rag_Tb[1], Orgn_Rag_Tb_Death, Anim_Rag_Tb_Death, "Death")
		All_Rag_Tb[1]:Remove()
		table.remove(All_Rag_Tb, 1)
	end
end)


----------------------------------------------------------------------------------------
--在NPC或Ragdoll头顶画生命值条，用来Debug
hook.Add("Think", "Animrag_DrawHealthBar", function()
	if not CVAR_ARag_healthbar:GetBool() then return end
		
	for k, ORag in pairs(ents.GetAll()) do
		--对于还活着的NPC
		if ORag:IsNPC() then
			net.Start("AnimRag_DrawHPDebugBar_sTc")
				net.WriteInt(ORag:EntIndex(), 32)
				net.WriteString(tostring(ORag:Health()))
				net.WriteString(tostring(ORag:GetMaxHealth()))
				net.WriteString(ORag:GetSequenceName(ORag:GetSequence()))
			net.Broadcast()		
		--对于播放Death动画的Ragdoll
		elseif ORag:IsRagdoll() and ORag:GetNWInt("Animation_State") == 1 then
			net.Start("AnimRag_DrawHPDebugBar_sTc")
				net.WriteInt(ORag:EntIndex(), 32)
				if ORag.Hp_d then
					net.WriteString(tostring(ORag.Hp_d))
					net.WriteString(tostring(ORag.MaxHp))
				else
					net.WriteString("HP Disabled")
					net.WriteString("HP Disabled")
				end
				if IsValid(ORag.ARag) then
					net.WriteString(ORag.ARag:GetSequenceName(ORag.ARag:GetSequence()))
				else
					net.WriteString("")
				end
			net.Broadcast()
		--对于播放Crawl/Revive动画的Ragdoll，没错这个Crawl得放Death前边，因为有Hp_c则必有Hp_d，有Hp_d却不一定有Hp_c
		elseif ORag:IsRagdoll() and ORag:GetNWInt("Animation_State") >= 2 then
			net.Start("AnimRag_DrawHPDebugBar_sTc")
				net.WriteInt(ORag:EntIndex(), 32)
				if ORag.Hp_c then
					net.WriteString(tostring(ORag.Hp_c))
					net.WriteString(tostring(ORag.MaxHp))
				else
					net.WriteString("HP Disabled")
					net.WriteString("HP Disabled")
				end
				if IsValid(ORag.ARag) then
					net.WriteString(ORag.ARag:GetSequenceName(ORag.ARag:GetSequence()))
				else
					net.WriteString("")
				end
			net.Broadcast()
		end
	end
end)


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- ↑ Hooks/Nets


-- ↓ KeepCorpse OFF Stuff
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


--KeepCorpse OFF
----------------------------------------------------------------------------------------
--当Ragdoll是在client端生成的时，由于client端无法创造AnimRag，因此需要该server端协助创建，再传递过去，这是Death动画的AnimRag
net.Receive("CreateAnimRag_KeepCorpseOff_CreateRag_Death", function()
	local ONPC = net.ReadEntity()
	util.PrecacheModel(ONPC:GetModel())

	------------------------------------
	--得到要用到的各个参数，放在这里是因为可以提前判断Animation是否存在，提前判断究竟需不需要播放Death动画
	local Animation, isHead, isFire = Animrag_AnimChoose(ONPC)
	if not Animation then return end

	------------------------------------
	--创建一个Anim_Rag，设置其无碰撞、不可见，并让它播放死亡动画，从而能将这个动画映射到Ragdoll身上
	local Anim_Rag = ents.Create("prop_dynamic")
	Anim_Rag:SetModel("models/brutal_deaths/model_anim_modify.mdl")
	//Anim_Rag:SetBodygroup(Anim_Rag:FindBodygroupByName("barney"), 1) --If you don't understand how this addon works, enable this line and you may see.
	Anim_Rag:SetPos(ONPC:GetPos())
	Anim_Rag:SetAngles(ONPC:GetAngles())
	Anim_Rag:Spawn()
	Anim_Rag:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
	------------------------------------
	--得到播放动画所需的各种参数（动画名称、所需播放的时间、僵尸是否被爆头）
	local _, Animation_Tm = Anim_Rag:LookupSequence(Animation)
	local Animation_Endpos = Animrag_GetEndPos(Animation)
	Animation_Tm = Animation_Tm * (Animation_Endpos/100)
	Anim_Rag:Fire("SetAnimation", Animation)

	------------------------------------
	--得到将要Crawl的Ragdoll的敌人信息，这样才能爬离敌人
	local Hostile1 = {}		--将所有hostile写入这个表格（可能会有重复的）
	local Hostile2 = {}		--用于剔除重复的
	local Hostile  = {}		--无重复的最终的hostile表格

	--将hostile写入Hostile1
	if CVAR_ARag_avoid_e:GetBool() then
		if ONPC:IsNPC() then
			--得到所有仇恨该NPC的entity（Player除外，因为Disposition只能用在NPC身上）
			for k, v in pairs(ents.GetAll()) do
				local D = ONPC:Disposition(v)
				if D == D_HT or D == D_FR then
					table.insert(Hostile1, v)
				end
			end
		end
	end

	--将player写入Hostile1
	if CVAR_ARag_avoid_p:GetBool() then
		for k, v in pairs(player.GetAll()) do
			table.insert(Hostile1, v)
		end
	end

	--用Hostile2给表格Hostile1去重，得到Hostile
	for _, v in pairs(Hostile1) do
		Hostile2[v] = true
	end
	
	for k, _ in pairs(Hostile2) do
		table.insert(Hostile, k)
	end

	------------------------------------
	--最有意思的一步！生成一个HelpEnt，传递到client端，然后在client端将这个HelpEnt贴到Ragdoll的上方，并垂直向下每隔一秒发射一颗子弹，击中ragdoll，将其从休眠中唤醒，继续爬行（这似乎是唯一的唤醒办法？）
	local HelpEnt = ents.Create("prop_dynamic")
	HelpEnt:SetModel("models/hunter/plates/plate.mdl")			
	HelpEnt:Spawn()
	HelpEnt:SetModelScale(0)
	HelpEnt:SetCollisionGroup(COLLISION_GROUP_WORLD)
	HelpEnt:SetNotSolid(true)
	HelpEnt:DrawShadow(false)

	net.Start("CreateAnimRag_KeepCorpseOff_TransfRag_Death")
	net.WriteEntity(ONPC)
	net.WriteEntity(Anim_Rag)
	net.WriteFloat(Animation_Tm)
	net.WriteTable(Hostile)
	net.WriteBool(isHead)
	net.WriteBool(isFire)
	net.WriteBool(ONPC.Overflow)
	net.WriteEntity(HelpEnt)
	net.Broadcast()
end)


----------------------------------------------------------------------------------------
--当Ragdoll是在client端生成的时，由于client端无法创造AnimRag，因此需要该server端协助创建，再传递过去，这是Crawl动画的AnimRag
net.Receive("CreateAnimRag_KeepCorpseOff_CreateRag_Crawl", function()
	local ID = net.ReadInt(32)
	local pos = net.ReadVector()
	local ang = net.ReadAngle()
	local Animation = net.ReadString()

	------------------------------------
	--创建一个Anim_Rag，设置其无碰撞、不可见，并让它播放死亡动画，从而能将这个动画映射到Ragdoll身上
	local Anim_Rag = ents.Create("prop_dynamic")
	Anim_Rag:SetModel("models/brutal_deaths/model_anim_modify.mdl")
	//Anim_Rag:SetBodygroup(Anim_Rag:FindBodygroupByName("barney"), 1) --If you don't understand how this addon works, enable this line and you may see.
	Anim_Rag:SetPos(pos)
	Anim_Rag:SetAngles(ang)
	Anim_Rag:Spawn()
	Anim_Rag:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
	------------------------------------
	--得到播放动画所需的各种参数（动画名称、所需播放的时间、僵尸是否被爆头）
	local _, Animation_Tm = Anim_Rag:LookupSequence(Animation)
	Anim_Rag:Fire("SetAnimation", Animation)

	------------------------------------
	--最有意思的一步！生成一个HelpEnt，传递到client端，然后在client端将这个HelpEnt贴到Ragdoll的上方，并垂直向下每隔一秒发射一颗子弹，击中ragdoll，将其从休眠中唤醒，继续爬行（这似乎是唯一的唤醒办法？）
	local HelpEnt = ents.Create("prop_dynamic")
	HelpEnt:SetModel("models/hunter/plates/plate.mdl")			
	HelpEnt:Spawn()
	HelpEnt:SetModelScale(0)
	HelpEnt:SetCollisionGroup(COLLISION_GROUP_WORLD)
	HelpEnt:SetNotSolid(true)
	HelpEnt:DrawShadow(false)

	net.Start("CreateAnimRag_KeepCorpseOff_TransfRag_Crawl")
	net.WriteInt(ID, 32)
	net.WriteEntity(Anim_Rag)
	net.WriteFloat(Animation_Tm)
	net.WriteEntity(HelpEnt)
	net.Broadcast()
end)


----------------------------------------------------------------------------------------
--当client端的crawl动画需要改变AnimRag的位置和角度以爬离hostile时，帮它一下
net.Receive("CreateAnimRag_KeepCorpseOff_Crawl_PosAng", function()
	local Anim_Rag = net.ReadEntity()
	local NewPos = net.ReadVector()
	local NewAng = net.ReadAngle()
	
	Anim_Rag:SetPos(NewPos)
	Anim_Rag:SetAngles(NewAng)
end)


----------------------------------------------------------------------------------------
--当client端的crawl动画播放结束，需要重复时，帮它一下
net.Receive("CreateAnimRag_KeepCorpseOff_Crawl_Repeat", function()
	local Anim_Rag = net.ReadEntity()
	local Animation = net.ReadString()
	local pos = net.ReadVector()
	
	Anim_Rag:Fire("SetAnimation", Animation, 0)
	Anim_Rag:SetPos(pos)
end)


----------------------------------------------------------------------------------------
--帮助client端移除已经播放完动画的AnimRag
net.Receive("CreateAnimRag_KeepCorpseOff_RemoveRag", function()
	net.ReadEntity():Remove()
end)

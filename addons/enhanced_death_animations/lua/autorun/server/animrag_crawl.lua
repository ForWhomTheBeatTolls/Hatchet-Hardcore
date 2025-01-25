include("autorun/server/animrag_allconvar.lua")
include("autorun/server/animrag_allfunctions.lua")

Orgn_Rag_Tb_Crawl = {}
Anim_Rag_Tb_Crawl = {}
local MoveTb_C = {}

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


local MoveTb_1 = {
	["ValveBiped.Bip01_Pelvis"] 	= true,
	//["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	//["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	//["ValveBiped.Bip01_R_Foot"] 	= true,
	//["ValveBiped.Bip01_L_Thigh"] 	= true,
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


local MoveTb_2_1 = { --不瘫
	//["ValveBiped.Bip01_Pelvis"] 	= true,
	//["ValveBiped.Bip01_Spine1"] 	= true,
	//["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,
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

local MoveTb_2_2 = { --瘫双腿

	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2_3 = { --瘫右腿

	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,

	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2_4 = { --瘫左腿

	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,

	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2_5 = { --瘫左腿右手

	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,

	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2_6 = { --瘫右腿左手

	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,

	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_2 = {
	MoveTb_2_1,
	MoveTb_2_2,
	MoveTb_2_3,
	MoveTb_2_4,
	MoveTb_2_5,
	MoveTb_2_6
}



local MoveTb_3_1 = { --不瘫
	//["ValveBiped.Bip01_Pelvis"] 	= true,
	//["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	//["ValveBiped.Bip01_R_Thigh"] 	= true,
	//["ValveBiped.Bip01_R_Calf"] 	= true,
	//["ValveBiped.Bip01_R_Foot"] 	= true,
	//["ValveBiped.Bip01_L_Thigh"] 	= true,
	//["ValveBiped.Bip01_L_Calf"] 	= true,
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

local MoveTb_3_2 = { --瘫右手

	["ValveBiped.Bip01_Spine4"] 	= true,

	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_3_3 = { --瘫左手

	["ValveBiped.Bip01_Spine4"] 	= true,

	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,

	["ValveBiped.Bip01_Head1"] 		= true
}

local MoveTb_3 = {
	MoveTb_3_1,
	MoveTb_3_2,
	MoveTb_3_3
}


----------------------------------------------------------------------------------------
--核心函数，当得到Ragdoll时，禁用它的骨骼碰撞，接着创建一个Anim_Rag来播放动画，将动画过程中Anim_Rag的各骨骼位置映射到Ragdoll身上
function Animrag_StartCrawlAnimation(Orgn_Rag, DeathTime)

	------------------------------------
	--这一段计算 Ragdoll 的 Hp 的代码被放在了最开始，这样才能在开始crawl前就开始通过受到的伤害来计算 Hp, 来判断是否应该由于Overkill而放弃crawl。开始crawl后，该Hp会被继承。
	--而在Death动画的文件里，这段计算 Hp 的代码被放在了中间，因为好看，而且放中间放前面都一样
	--比如：开启了“crawl前Overkill”，Hp的初始值被设定为了[75]。如果 Ragdoll 在crawl前受到了[35]点的伤害，那么开始crawl后其Hp则还剩75-35=40
	if not CVAR_OK_Inherit_Hp:GetBool() then --如果开启了继承Death Ragdoll的HP，直接将Death端的Orgn_Rag.Hp_d拿来作为Hp_c
		if 			CVAR_OK_Fix_Enable_c:GetBool() and not 	CVAR_OK_Max_Enable_c:GetBool() then 		
		Orgn_Rag.Hp_c = CVAR_OK_Fix_Value_c:GetInt()					--使用固定值作为 Hp_c						
		elseif not 	CVAR_OK_Fix_Enable_c:GetBool() and 		CVAR_OK_Max_Enable_c:GetBool() then
		Orgn_Rag.Hp_c = CVAR_OK_Max_Value_c:GetFloat() * Orgn_Rag.NPCHp --使用百分比作为 Hp_c
		elseif 		CVAR_OK_Fix_Enable_c:GetBool() and 		CVAR_OK_Max_Enable_c:GetBool() then
		Orgn_Rag.Hp_c = CVAR_OK_Max_Value_c:GetFloat() * Orgn_Rag.NPCHp --使用百分比作为 Hp_c（当固定值与百分比同时开启时，以百分比为准）
		else
		Orgn_Rag.Hp_c = false 											--禁用Overkill
		end
	else
		Orgn_Rag.Hp_c = Orgn_Rag.Hp_d
	end
	Orgn_Rag.PreStop = false 											--该Ragdoll是否应该由于启用了“crawl前Overkill”而直接不播放crawl动画，该值默认为false，一旦受够伤害变成true，Timer结束后下面的函数就不再运行


	------------------------------------
	------------------------------------
	--Real stuff
	--Real stuff
	--Real stuff
	--Crawl专用
	timer.Simple(DeathTime + math.Rand(CVAR_ARag_delay_min:GetFloat(), CVAR_ARag_delay_max:GetFloat()), function()

		------------------------------------
		--防止在等待crawl开始的中途ragdoll消失了
		if not IsValid(Orgn_Rag) then return end
		if Orgn_Rag.PreStop then return end

		------------------------------------
		--如果被爆头了则不播放动画
		if Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1") then
			if Orgn_Rag:GetManipulateBoneScale(Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1")) == Vector(0, 0, 0) then return end
		end

		------------------------------------
		--得到Orgn_Rag胸部朝向的角度，从而决定动画播放的角度
		local body_index = Orgn_Rag:LookupBone("ValveBiped.Bip01_Spine4") or Orgn_Rag:LookupBone("ValveBiped.Bip01_Spine2") or Orgn_Rag:LookupBone("ValveBiped.Bip01_Spine1") or Orgn_Rag:LookupBone("ValveBiped.Bip01_Spine")
		local body_ang = Angle(0, 0, 0)
		local Animation_startAng = Angle(0, 0, 0)
		
		if body_index then
			body_ang = Orgn_Rag:GetBoneMatrix(body_index):GetAngles():Forward():Angle()
			Animation_startAng = Angle(0, body_ang.y, 0)
		else
			Animation_startAng = Angle(0, math.Rand(0, 360), 0)
		end

		------------------------------------
		--判断Orgn_Rag胸部是否朝上，从而判断应该用哪个动画，Facing>0是朝上，反之朝下
		local Atta_chest = Orgn_Rag:LookupAttachment("chest")
		local Atta_eyes  = Orgn_Rag:LookupAttachment("eyes")
		local Facing
		if Atta_chest > 0 then
			Facing = Orgn_Rag:GetAttachment(Atta_chest).Ang:Forward().z
		elseif Atta_eyes > 0 then
			Facing = Orgn_Rag:GetAttachment(Atta_eyes).Ang:Forward().z
		else
			Facing = -1
		end

		--根据上面得到的朝上或朝下来决定播放哪个动画，并随机化一下动画，最终得到的是一个 Animation 和一个 MoveTb_C
		math.randomseed(CurTime())
		local Animation
		if Facing >= 0 then
			if CVAR_ARag_female:GetBool() then
				Animation = "crawling" .. 1 .. "_f"
			else
				Animation = "crawling" .. 1
			end

			MoveTb_C = MoveTb_1
		else
			local rand = math.random(5,6)

			if CVAR_ARag_female:GetBool() then
				Animation = "crawling" .. rand .. "_f"
			else
				Animation = "crawling" .. rand
			end

			if rand == 5 then
				if CVAR_ARag_random:GetBool() then
					MoveTb_C = MoveTb_2[math.random(1, 6)]
				else
					MoveTb_C = MoveTb_2[1]
				end
			else
				if CVAR_ARag_random:GetBool() then
					MoveTb_C = MoveTb_3[math.random(1, 3)]
				else
					MoveTb_C = MoveTb_3[1]
				end
			end
		end

		------------------------------------
		--如果死亡的是玩家，则将MoveTb_C换为NrmTb，且不对head进行控制，而交由玩家的视角进行控制
		local ARag_cam = false
		if GetConVar("ARag_cam") then
			ARag_cam = GetConVar("ARag_cam"):GetBool()
		end
		if Orgn_Rag:GetNWBool("isPlayer") and ARag_cam then
			MoveTb_C = NrmTb
			table.RemoveByValue(MoveTb_C, "ValveBiped.Bip01_Head1")
			table.RemoveByValue(MoveTb_C, "ValveBiped.Bip01_Spine4")
		end

		------------------------------------
		--得到动画播放的位置
		local Apos = util.TraceLine( {
			start = Orgn_Rag:GetPos(),
			endpos = Orgn_Rag:GetPos()-Vector(0,0,100),
			mask = MASK_SOLID,
			filter = Orgn_Rag
		})

		------------------------------------
		--创建一个Anim_Rag，设置其无碰撞、不可见，并让它播放死亡动画，从而能将这个动画映射到Ragdoll身上
		local Anim_Rag = ents.Create("prop_dynamic")
		Anim_Rag:SetModel("models/brutal_deaths/model_anim_modify.mdl")
		//Anim_Rag:SetBodygroup(Anim_Rag:FindBodygroupByName("barney"), 1)
		Anim_Rag:SetPos(Apos.HitPos)
		Anim_Rag:SetAngles(Animation_startAng)
		Anim_Rag:Spawn()
		Anim_Rag:SetCollisionGroup(COLLISION_GROUP_WORLD)

		------------------------------------
		--缩放AnimRag以适应Ragdoll的尺寸
		Animrag_ScaleAnimRag(Orgn_Rag, Anim_Rag)

		------------------------------------
		--播放动画，这次不需要什么参数，一个Animation_Tm就够了
		local _, Animation_Tm = Anim_Rag:LookupSequence(Animation)
		Anim_Rag:Fire("SetAnimation", Animation)

		------------------------------------
		--每一个Ragdoll对应的各自的参数
		Anim_Rag.ORag = Orgn_Rag 										--该AnimRag对应的Ragdoll
		Orgn_Rag.ARag = Anim_Rag										--该Ragdoll对应的AnimRag
		--播放动画所需的参数
		Orgn_Rag:SetNWInt("Animation_State", 2) 						--总之就是标记一下开始爬行了（用2标记），有些地方能用到，比如 “提前计算Overkill”，“没爬行时无法Revive”等，之所以用NW是因为client端也要用到
		Orgn_Rag.Table = MoveTb_C 										--该Ragdoll对应的MoveTb，只有MoveTb里的骨骼会被移动，其它骨骼自由发挥
		Orgn_Rag.Bone = {}												--该Ragdoll每个骨骼各自的参数
		for bonename, _ in pairs(Orgn_Rag.Table) do
			local boneID = Orgn_Rag:LookupBone(bonename)
			if boneID then
				Orgn_Rag.Bone[bonename] = {}
				Orgn_Rag.Bone[bonename]["random"] = Angle(math.Rand(-15, 15), math.Rand(-15, 15), 0)--给动作一点随机性
				Orgn_Rag.Bone[bonename]["addpos"] = Vector(0, 0, 0)		--该骨骼当前帧的addpos
				Orgn_Rag.Bone[bonename]["lastAdd"] = Vector(0, 0, 0)	--该骨骼上一帧的addpos
				Orgn_Rag.Bone[bonename]["lastHit"] = Vector(0, 0, 0)	--该骨骼上一帧的HitPos
				Orgn_Rag.Bone[bonename]["Fall"] = false					--该骨骼这一帧是不是距离地面太高了，如果true（距地太高了），则不再让这个骨骼爬行了，而让它自由落体，计数+1
				Orgn_Rag.Bone[bonename]["HitWall"] = false				--该骨骼这一帧是不是撞墙上了，如果true（撞上了），则计数+1
			end
		end
		Orgn_Rag.FacingUp = Facing>=0 									--该Ragdoll是面朝上的还是面朝下的，用于决定使用哪个Revive动画（面朝上则为true）
		--循环播放所需的参数
		Orgn_Rag.Repeat = true											--超越控制，是否应该循环播放动画
		Orgn_Rag.Anim_Nm = Animation									--动画的参考名称，用于重复播放
		Orgn_Rag.Anim_Tm = Animation_Tm									--动画会播放多久，用于重复播放
		Orgn_Rag.Anim_St = Animation_Tm + CurTime()						--动画何时会停止，用于判断何时动画结束

		--结束动画所需的参数
		Orgn_Rag.Head = Orgn_Rag:LookupBone("ValveBiped.Bip01_Head1")  	--该Ragdoll的头部骨骼，方便判断是否被爆头
		Orgn_Rag.Isdead_c = false										--这是为了标记该Ragdoll已经被杀死了，防止继续打伤害会让它再死一次
		Orgn_Rag.StopAnim = false										--这是为了标记该Ragdoll已经结束动画了（不一定是被杀死的），防止AnimRag_ComputeShadowControl继续运算
		--环境交互所需的参数（也属于结束动画所需的参数）
		Orgn_Rag.Fall = 0												--该Ragdoll里有几个骨骼已经悬空了，用于当Ragdoll爬到地形边缘时，决定是让它结束动画还是让它继续顺着地形爬行
		Orgn_Rag.HitWall = 0											--该Ragdoll里有几个骨骼已经撞墙了，用于当Ragdoll撞到墙壁时，决定是让它结束动画还是让它继续怼墙
		Orgn_Rag.Delay = 0												--当坠落或撞墙时，延迟几秒后结束动画
		Orgn_Rag.Delay2 = false											--帮忙判断刚刚所说的延迟
		--爬离敌人所需的参数
		Orgn_Rag.StartCrawlAway = CurTime() + 1 						--AnimRag生成后，延迟1秒后才开始让Ragdoll向着远离玩家的方向爬行
		--血迹所需的参数
		Orgn_Rag.LastPos = Orgn_Rag:GetBonePosition(0)					--上一次判定时该Ragdoll的位置，用于按距离来放置血液的decal
		Orgn_Rag.Blood = CVAR_ARag_blood:GetBool()						--是否要开启血迹
		Orgn_Rag.Blood_UseTime = CVAR_ARag_blood_usetime:GetBool()		--是让血迹随时间还是随距离
		Orgn_Rag.Blood_Time = CVAR_ARag_blood_time:GetFloat()			--每隔多久留一个血迹
		Orgn_Rag.Blood_Dist = CVAR_ARag_blood_dist:GetInt()				--每隔多远留一个血迹

		------------------------------------
		--写入表格，开始播放Crawl动画！（得延时0.1秒，不然Ragdoll会莫名其妙蹦起来）
		timer.Simple(0.1, function()
			------------------------------------
			--开始crawl!			
			table.insert(Orgn_Rag_Tb_Crawl, Orgn_Rag)
			table.insert(Anim_Rag_Tb_Crawl, Anim_Rag)

			------------------------------------
			--既然开始crawl了，那就开始revive!
			net.Start("AnimRag_Crawl_T_Reviv_sTc")
				net.WriteInt(Orgn_Rag:EntIndex(), 32)
				net.WriteInt(Anim_Rag:EntIndex(), 32)
			net.Broadcast()
		end)

	end)
end


----------------------------------------------------------------------------------------
--当接受到Death发送过来的Ragdoll时（也就是有NPC被杀死时），开始代码
net.Receive("AnimRag_Death_T_Crawl_cTs", function()
	
	local Orgn_Rag = Entity(net.ReadInt(32))
	local DeathTime = net.ReadFloat()
	local Orgn_Rag_Is_Player_Ally = false

	--如果开启了“让玩家的友军爬行的概率为1”，则判断该Ragdoll是否是玩家的友军，如果是，则直接绕过概率，让Ragdoll开始爬行
	if CVAR_ARag_ply_allycrawl:GetBool() then
		for k1, ply in pairs(player.GetAll()) do
			for k2, ally in pairs(Orgn_Rag.Friends) do
				if ally == ply then
					Orgn_Rag_Is_Player_Ally = true
					break
				end
			end
		end
	end
	
	if Orgn_Rag:GetNWBool("isPlayer") then
		--如果该Ragdoll是PLY，则以下情况爬行：开启了玩家爬行（如果还开启了玩家爬行概率的话，还需要概率符合）
		if not CVAR_ARag_player_crawl:GetBool() then return end
		if math.Rand(0, 1) > CVAR_ARag_odds_c:GetFloat() and CVAR_ARag_player_crawl_c:GetBool() then return end
		Animrag_StartCrawlAnimation(Orgn_Rag, DeathTime)
	else
		--如果该Ragdoll是NPC，则以下情况爬行：开启了NPC爬行，且概率符合；或者该开启了“让玩家的友军爬行的概率为1”，且该NPC是友军
		if not CVAR_ARag_enab_c:GetBool() then return end
		if math.Rand(0, 1) > CVAR_ARag_odds_c:GetFloat() and not Orgn_Rag_Is_Player_Ally then return end
		Animrag_StartCrawlAnimation(Orgn_Rag, DeathTime)
	end
end)


----------------------------------------------------------------------------------------
--当接受到Revive发送过来的Ragdoll时（也就是有NPC被复活时），不再爬行
net.Receive("AnimRag_Reviv_T_Crawl_PausesCrawl_cTs", function()
	local ORag = Entity(net.ReadInt(32))
	ORag.PausesCrawl = true
end)


----------------------------------------------------------------------------------------
--当接受到Revive发送过来的Ragdoll时（也就是复活被中断时），继续爬行
net.Receive("AnimRag_Reviv_T_Crawl_ResumeCrawl_cTs", function()
	local ORag = Entity(net.ReadInt(32))
	ORag.PausesCrawl = false
	ORag.Anim_St = CurTime() --立马开始一个新的crawl循环
	ORag:SetNWInt("Animation_State", 2) --更新一下标记，把它从Revive的3改回Crawl的2
end)


----------------------------------------------------------------------------------------
--主功能，得到 AnimRag 各骨骼应有的位置与角度信息，并应用在 Ragdoll 身上。
hook.Add("Tick", "Animrag_MainTick_C", function()
	if not Orgn_Rag_Tb_Crawl then return end
	for k, ORag in pairs(Orgn_Rag_Tb_Crawl) do
		if IsValid(ORag) and IsValid(ORag.ARag) and not ORag.PausesCrawl then

			--当Ragdoll超过5个肢体有坠落的趋势，或者所有运动肢体被墙壁阻挡时，延迟4-8秒后结束动画
			if ORag.Fall >= 5 or ORag.HitWall >= table.Count(ORag.Table) then 
				if not ORag.Delay2 then
					ORag.Delay = CurTime() + math.random(6, 8)
					ORag.Delay2 = true
					ORag.Repeat = false --超越控制，不再重复动画，防止当前动画在这4-8秒里的某一刻结束，接着重复播放，从而重置AnimRag的位置，导致乱七八糟的东西
				end
				
				if CurTime() >= ORag.Delay then
					Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
				end
			end
			
			--当Ragdoll被爆头时，结束动画
			if ORag.Head then
				if ORag:GetManipulateBoneScale(ORag.Head) == Vector(0, 0, 0) then
					Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
				end
			end

			------------------------------------------------------
			--主循环
			--Animrag_ComputeShadowControl(ORag)

			------------------------------------------------------
			--血迹效果
			if ORag.Blood then
				if ORag.Blood_UseTime then
					if not ORag.NextBlood or ORag.NextBlood < CurTime() then
						ORag.NextBlood = CurTime()+ORag.Blood_Time
						util.Decal("Blood", ORag:GetBonePosition(0), ORag:GetBonePosition(0)-Vector(0,0,32), {ORag, ORag.ARag})
					end
				else
					local CurPos = ORag:GetBonePosition(0)
					local MoveDist = CurPos:DistToSqr(ORag.LastPos)											
					if MoveDist >= math.pow(ORag.Blood_Dist, 2) then
						ORag.LastPos = CurPos
						util.Decal("Blood", ORag:GetBonePosition(0), ORag:GetBonePosition(0)-Vector(0,0,32), {ORag, ORag.ARag})
					end
				end
			end

			------------------------------------------------------
			--通过改变AnimRag的位置和角度，让Ragdoll向远离玩家的方向爬行
			if CurTime() > ORag.StartCrawlAway then

				local MixPos = Vector(0, 0, 0)								--MixPos为：得到所有该NPC的敌人位置，根据这些位置，混合出一个中心位置
				local ARagPos = ORag.ARag:GetPos() 							--AnimRag当前的位置
				local ARagAng = ORag.ARag:GetAngles() 						--AnimRag当前的角度
				local ORagPos = ORag.ARag:GetPos()				--以AnimRag的Pelvis的位置来近似得到ORag的位置
				--AnimRag的位置(ARagPos) 与 AnimRag的Pelvis的位置(ORagPos) 并不相同
				--在播放动画时，AnimRag的中心点一直留在原地，只是模型的网格随着动画在移动而已。
				--因此ARagPos是不会变的，因为它得到的是AnimRag的中心点的位置，而ORagPos会随着动画的位置而变化，因为它得到的是AnimRag的模型网格的位置
				ORagPos.z = ARagPos.z										--因为ORagPos求的是Pelvis的位置，距离地面有高度，会干扰爬行方向，因此要将这个高度归零。
				
				--得到所有敌人与该Ragdoll的位置差E_O_Pos，以及相距距离E_O_Dist，如果某一个敌人距离过近，则在MixPos(0,0,0)里加上这个位置差，有几个敌人就加上几次，最终得到总位置差，再加回ORagPos后就得到了这几个敌人的中心位置
				--如：Ragdoll的位置是(100,100,0)，敌人A的位置是(80,120,0)，敌人B的位置是(150,70,0)，则与A的位置差是(-20,20,0)，与B的位置差是(50,-30,0)，组合的位置差就是(30,-10,0)，加回ORagPos就是该Ragdoll应该逃离的点，MixPos(130,90,0)
				--这一整个的意义，就是拿A的位置加上B的位置，再除以2，得到敌人A与敌人B之间的中心点，ORagPos(Ragdoll当前的位置) 与 MixPos(Ragdoll需逃离的位置) 以该点为中心，中心对称。挺傻逼的，肯定有更好的数学办法。
				for _, enemy in pairs(ORag.Hostile) do
					if IsValid(enemy) then
						local EnemPos = enemy:GetPos()
						local E_O_Pos = EnemPos - ORagPos
						local E_O_Dist = E_O_Pos:LengthSqr()

						if E_O_Dist < 10000 then
							MixPos = MixPos + E_O_Pos
						end
					end
				end

				MixPos = MixPos + ORagPos

				--Enemy相对Ragdoll的位置、角度
				local N_O_Pos = MixPos - ORagPos
				local N_O_Ang = N_O_Pos:Angle()
				
				--AnimRag相对Ragdoll的位置、角度
				local A_O_Pos = ARagPos - ORagPos
				local A_O_Ang = A_O_Pos:Angle()
				
				--理论上AnimRag的新位置与新角度
				local NewPos = ORagPos + N_O_Ang:Forward() * A_O_Pos:Length()
				local NewAng = Angle(0, (ORagPos - MixPos):Angle().yaw, 0) 

				if N_O_Pos:LengthSqr() < math.pow(CVAR_ARag_avoid_dist:GetInt(), 2) and N_O_Pos:LengthSqr() > 0 then
					ORag.ARag:SetPos(NewPos)
					ORag.ARag:SetAngles(NewAng)
				end
			end

			------------------------------------------------------
			--当动画播放完毕后，要么重复，要么结束
			if CurTime() >= ORag.Anim_St and ORag.Repeat then
				math.randomseed(os.time())
				if ORag:GetNWBool("isPlayer") then
					--当Ragdoll是PLY时，则以下情况重复：开启了玩家爬行概率且概率符合；或者没有开启玩家爬行概率
					if ( CVAR_ARag_player_crawl_c:GetBool() and math.Rand(0, 1) <= (CVAR_ARag_odds_c_repeat:GetFloat()) ) or not CVAR_ARag_player_crawl_c:GetBool() then
						local tr_pos = util.TraceLine( {
							start = ORag:GetPos(),
							endpos = ORag:GetPos()-Vector(0,0,100),
							mask = MASK_SOLID,
							filter = ORag, ORag.ARag
						})
						
						ORag.ARag:Fire("SetAnimation", ORag.Anim_Nm, 0)
						ORag.ARag:SetPos(tr_pos.HitPos)
						ORag.Anim_St = CurTime() + ORag.Anim_Tm
		
						ORag.StartCrawlAway = CurTime() + 1
					else
						Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
					end
				else
					--当Ragdoll是NPC时，则以下情况重复：爬行概率符合
					if math.Rand(0, 1) <= (CVAR_ARag_odds_c_repeat:GetFloat()) then
						local tr_pos = util.TraceLine( {
							start = ORag:GetPos(),
							endpos = ORag:GetPos()-Vector(0,0,100),
							mask = MASK_SOLID,
							filter = ORag, ORag.ARag
						})
						
						ORag.ARag:Fire("SetAnimation", ORag.Anim_Nm, 0)
						ORag.ARag:SetPos(tr_pos.HitPos)
						ORag.Anim_St = CurTime() + ORag.Anim_Tm
	
						ORag.StartCrawlAway = CurTime() + 1
					else
						Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
					end
				end
			end

		end
	end
end)
----------------------------------------------------------------------------------------
--主要功能



--辅助功能
----------------------------------------------------------------------------------------
--当Ragdoll收到一定量的伤害时，执行这个Ragdoll的结束函数，结束动画
hook.Add("EntityTakeDamage", "Animrag_Damage_C", function(ORag, dmg)

	if not ORag:IsRagdoll() then return end

	if ORag:GetNWInt("Animation_State") != 0 then
		dmg:SetDamage(math.Round(dmg:GetDamage()))
		if dmg:GetDamageType() == DMG_CRUSH then
			dmg:ScaleDamage(CVAR_OK_CrushDmg_Scale:GetFloat())
		end
	end

	--当还没开始爬行，且允许Hp时，提前计算Hp_c，要是在爬行开始前就被Overkill的话，就用ORag.PreStop阻止后续代码的运行
	if ORag:GetNWInt("Animation_State") < 2 and ORag.Hp_c then
		ORag.Hp_c = ORag.Hp_c - dmg:GetDamage()
		if ORag.Hp_c <= 0 and not ORag.PreStop then
			ORag.PreStop = true
		end
	end

	--当开始爬行时，且允许Hp时，正常计算Hp_c
	if ORag:GetNWInt("Animation_State") >= 2 and ORag.Hp_c then
		ORag.Hp_c = ORag.Hp_c - dmg:GetDamage()
		if ORag.Hp_c <= 0 and not ORag.Isdead_c then
			Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
		end
	end

end)


----------------------------------------------------------------------------------------
--当移除一个Ragdoll时，执行这个Ragdoll的结束函数
hook.Add("EntityRemoved", "Animrag_RagRemoved_C", function(ent, fullUpdate)
	
	--[Arc9 Base]会莫名其妙地删除AnimRag，所以需要这段
	if ent:GetClass() == "prop_dynamic" then
		for k, ARag in pairs(Anim_Rag_Tb_Crawl) do
			if ARag == ent then

				for k2, v in pairs(Orgn_Rag_Tb_Crawl) do
					if v == ARag.ORag then
						table.remove(Orgn_Rag_Tb_Crawl, k2)
					end
				end

				table.remove(Anim_Rag_Tb_Crawl, k)

			end
		end
	end

	if ent:IsRagdoll() then
		for k, ORag in pairs(Orgn_Rag_Tb_Crawl) do
			if ORag == ent then
				Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
			end
		end
	end
	
end)


----------------------------------------------------------------------------------------
--当清空服务器时，重置一切参数
hook.Add( "PostCleanupMap" , "Animrag_ResetAll_C" , function( ply )
	Orgn_Rag_Tb_Crawl = {}
	Anim_Rag_Tb_Crawl = {}
end)


----------------------------------------------------------------------------------------
--当死亡的是玩家且开启了第一人称DeathCam时，根据视角方向改变Crawl时的头部方向，更拟真
net.Receive("PlayerRag_RotateHead", function()
	local eye_ang = net.ReadAngle()
	local PRag = Entity(net.ReadInt(32))

	if not PRag.StartCrawlAway then return end
	if CurTime() > PRag.StartCrawlAway then

		--传递过来的eye_ang用的是EyeAngles()的坐标系，要把它转换成骨骼ValveBiped.Bip01_Head1的坐标系
		eye_ang:RotateAroundAxis(eye_ang:Right(), 90)
		eye_ang:RotateAroundAxis(eye_ang:Forward(), 90)
	
		local head_phyobj = PRag:GetPhysicsObjectNum(PRag:TranslateBoneToPhysBone(PRag:LookupBone("ValveBiped.Bip01_Head1")))
		local body_phyobj = PRag:GetPhysicsObjectNum(PRag:TranslateBoneToPhysBone(PRag:LookupBone("ValveBiped.Bip01_Spine4")))
	
		local p_head = {}
		p_head.secondstoarrive = 0.01
		p_head.pos = head_phyobj:GetPos()
		p_head.angle = eye_ang
		p_head.maxangular = 400
		p_head.maxangulardamp = 200
		p_head.maxspeed = 400
		p_head.maxspeeddamp = 300
		p_head.teleportdistance = 0
		
		head_phyobj:Wake()
		head_phyobj:ComputeShadowControl(p_head)
	
		local p_body = {}
		p_body.secondstoarrive = 0.01
		p_body.pos = head_phyobj:GetPos()
		p_body.angle = eye_ang
		p_body.maxangular = 20
		p_body.maxangulardamp = 10
		p_body.maxspeed = 0
		p_body.maxspeeddamp = 0
		p_body.teleportdistance = 0
	
		body_phyobj:Wake()
		body_phyobj:ComputeShadowControl(p_body)
	end
end)

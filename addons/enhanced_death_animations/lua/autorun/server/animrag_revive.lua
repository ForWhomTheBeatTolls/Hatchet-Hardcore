include("autorun/server/animrag_allconvar.lua")
include("autorun/server/animrag_allfunctions.lua")

util.AddNetworkString( "AnimRag_Reviv_StartsPressing_cTs" )
util.AddNetworkString( "AnimRag_Reviv_FinishPressing_cTs" )
util.AddNetworkString( "AnimRag_Reviv_FinishPressing_PlySelfRevive_cTs" )
util.AddNetworkString( "AnimRag_Reviv_RleasePressing_cTs" )


local Ally_NPC_Tb = {}
local MoveTb_Idles_Up = {	
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

local MoveTb_Idles_Down = {	
	["ValveBiped.Bip01_Pelvis"] 	= true,
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

local MoveTb_Getup = {	
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

local MoveTb_DoCollision = {	
	["ValveBiped.Bip01_R_Foot"]		= true,
	["ValveBiped.Bip01_L_Foot"]		= true,
	["ValveBiped.Bip01_R_Hand"]		= true,
	["ValveBiped.Bip01_L_Hand"]		= true,
}

local Dismember_Tb = {	
	["ValveBiped.Bip01_Pelvis"] 	= true,
	["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	//["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	//["ValveBiped.Bip01_L_Foot"] 	= true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	//["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	//["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local D_enum = {
	[0] = "D_ER",
	[1] = "D_HT",
	[2] = "D_FR",
	[3] = "D_LI",
	[4] = "D_NU"
}


----------------------------------------------------------------------------------------
--决定使用哪种方式来设置复活NPC的HP，防止 ARag_r_hp_portion 和 ARag_r_hp_inherit 都为 1
cvars.AddChangeCallback("ARag_r_hp_portion", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_r_hp_portion", "ARag_r_hp_inherit")
end)
cvars.AddChangeCallback("ARag_r_hp_inherit", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_r_hp_portion", "ARag_r_hp_inherit")
end)


----------------------------------------------------------------------------------------
--决定使用哪种方式来设置复活PLY的HP，防止 ARag_r_hp_portion_p 和 ARag_r_hp_inherit_p 都为 1
cvars.AddChangeCallback("ARag_r_hp_portion_p", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_r_hp_portion_p", "ARag_r_hp_inherit_p")
end)
cvars.AddChangeCallback("ARag_r_hp_inherit_p", function(convar_name, value_old, value_new)
	Animrag_Convar_Check(convar_name, "ARag_r_hp_portion_p", "ARag_r_hp_inherit_p")
end)



----------------------------------------------------------------------------------------
--呼叫附近的最近的友军前来Revive
function Animrag_CallingNearbyAllys(ORag)
	if not ORag or not ORag.Friends or ORag.SomebodyIsComing then return end
	--如果是玩家Ragdoll，且玩家已经手动复活了，则禁止友军复活
	if ORag:GetNWBool("isPlayer") then
		for k, PLY in pairs(player.GetAll()) do
			if PLY:Nick() == ORag:GetNWString("isPlayer_Name") and PLY:Alive() then
			return end
		end
	end

	local MinDist = math.huge
	local MinDist2 = math.huge
	local MinDist_NPC = nil
	local NPC = nil

	for k, Ally in pairs(ORag.Friends) do
		--给所有友军NPC初始化一下TB
		if not Ally.TB then Ally.TB = {} end
		--当该友军NPC没有在复活谁时，则让他可以参加MinDist_NPC的筛选
		if IsValid(Ally) then
			if not Ally:IsPlayer() and not Ally.TB.IsRunningToRagdoll then
				Ally.TB.Dist = Ally:GetPos():DistToSqr(ORag:GetPos())
				if Ally.TB.Dist < 250000 and Ally.TB.Dist < MinDist then
					MinDist = Ally.TB.Dist
					MinDist_NPC = Ally
				end
			end
		end
	end

	--如果500半径内没能找到一个MinDist_NPC，则开始寻找任何500半径外能直接看见该Ragdoll的NPC
	if not MinDist_NPC then
		for k, Ally in pairs(ORag.Friends) do
			if IsValid(Ally) then
				if not Ally:IsPlayer() and not Ally.TB.IsRunningToRagdoll then
					local tr = util.TraceLine({
						start = Ally:EyePos(),
						endpos = ORag:GetPos(),
						mask = MASK_SOLID,
						filter = function(ent)
							if ent:IsNPC() or ent:IsPlayer() or ent:IsRagdoll() then
								return false
							else
								return true
							end
						end
					})
					
					if not tr.Hit then
						local Ally_Dir_Nrm = (ORag:GetPos() - Ally:GetPos()):GetNormalized()
						
						local Ally_Dir_Horizons = Ally:EyeAngles():Forward()
						local Ally_Dir_Vertical = Ally:EyeAngles():Up()
						
						local Ally_Dot_Horizons = Ally_Dir_Nrm:Dot(Ally_Dir_Horizons)
						local Ally_Dot_Vertical = Ally_Dir_Nrm:Dot(Ally_Dir_Vertical)
					
						if Ally_Dot_Horizons > 0 and math.abs(Ally_Dot_Vertical) < 0.6 and Ally.TB.Dist < MinDist2 then
							MinDist2 = Ally.TB.Dist
							MinDist_NPC = Ally
						end
					end
				end
			end
		end
	end

	if MinDist_NPC then
		if MinDist_NPC.TB.IsRunningToRagdoll then return end
		
		--之所以用了一个MinDist_NPC.TB，是为了把所有自定义的属性写进一个表格里，这样当该NPC救完一个Ragdoll后，可以很方便地直接重置该NPC的所有属性，从而能顺利进行下一个Ragdoll的Revive
		
		--设置NPC为中立，防止移动过程被AI打断
		MinDist_NPC.TB.Relation_PLY = {}
		MinDist_NPC.TB.Relation_NPC = {}

		for _, ply in pairs(player.GetAll()) do
			MinDist_NPC.TB.Relation_PLY[ply] = MinDist_NPC:Disposition(ply)
		end
		MinDist_NPC:AddRelationship("player D_NU 99")
		
		for _, other_npc in pairs(ents.GetAll()) do
			if other_npc:IsNPC() then
				MinDist_NPC.TB.Relation_NPC[other_npc] = MinDist_NPC:Disposition(other_npc)
				MinDist_NPC:AddEntityRelationship(other_npc, D_NU, 99)
			end
		end

		MinDist_NPC:SetLastPosition(ORag:GetPos())
		MinDist_NPC:SetSchedule( SCHED_FORCED_GO_RUN )

		MinDist_NPC.TB.ORag = ORag
		
		MinDist_NPC.TB.CollisionORag = ORag
		MinDist_NPC.TB.CheckTargetPos_Time = CurTime() + 3
		MinDist_NPC.TB.IsRunningToRagdoll = true
		MinDist_NPC.TB.isRunning = true
		net.Start("AnimRag_Reviv_T_Death_NPCRelation_sTc")
			net.WriteInt(MinDist_NPC:EntIndex(), 32)
			net.WriteTable(MinDist_NPC.TB.Relation_PLY)
			net.WriteTable(MinDist_NPC.TB.Relation_NPC)
		net.Broadcast()

		MinDist_NPC:SetCustomCollisionCheck(true)
		ORag:SetCustomCollisionCheck(true)
		ORag.SomebodyIsComing = true

		table.insert(Ally_NPC_Tb, MinDist_NPC)
	end
end


----------------------------------------------------------------------------------------
--下面的Animrag_CallingSelfRevive要用到的判断函数
function Animrag_CallingSelfRevive_IsInSight(ORag)
	if not ORag or not ORag.Hostile then return end

	local BeInEnemySight = false
	for k, Enemy in pairs(ORag.Hostile) do
		if IsValid(Enemy) then
			local tr = util.TraceLine({
				start = ORag:GetPos()+Vector(0,0,20),
				endpos = Enemy:GetPos(),
				mask = MASK_SOLID,
				filter = function(ent)
					if ent:IsNPC() or ent:IsPlayer() or ent:IsRagdoll() then
						return false
					else
						return true
					end
				end
			})

			if not tr.Hit then
				local Enemy_Dir_Nrm = (ORag:GetPos() - Enemy:GetPos()):GetNormalized()
				
				local Enemy_Dir_Horizons = Enemy:EyeAngles():Forward()
				local Enemy_Dir_Vertical = Enemy:EyeAngles():Up()
				
				local Enemy_Dot_Horizons = Enemy_Dir_Nrm:Dot(Enemy_Dir_Horizons)
				local Enemy_Dot_Vertical = Enemy_Dir_Nrm:Dot(Enemy_Dir_Vertical)
				
				if Enemy_Dot_Horizons > 0 and (Enemy:IsPlayer() or math.abs(Enemy_Dot_Vertical) < 0.6) then
					BeInEnemySight = true
				end
			end
		end
	end
	return BeInEnemySight --如果有敌人在视野内，则返回true，否则返回false
end


----------------------------------------------------------------------------------------
--判断该Ragdoll是否能SelfRevive，条件为：自己不在任何敌人的视野范围内
function Animrag_CallingSelfRevive(ORag)
	if not ORag or not ORag.Hostile then return end

	--如果Ragdoll一个敌人都看不到的话，开始SelfRevive
	if not Animrag_CallingSelfRevive_IsInSight(ORag) then
		--用这个值来停下Animrag_CallingSelfRevive的Timer，防止重复运行Animrag_StartReviveAnimation
		ORag.WantToSelfRevive = true
		--延迟2-4秒再判断一次，如果两次都为false，则说明Ragdoll有连续2-4秒没有看见敌人，这时可以SelfRevive
		timer.Simple(math.Rand(2,4), function()
			if not IsValid(ORag) then return end
			if not Animrag_CallingSelfRevive_IsInSight(ORag) and not ORag:GetNWBool("IsBeingRevived_ByPLY") and not ORag:GetNWBool("IsBeingRevived_ByNPC") then
				Animrag_StartReviveAnimation(ORag, true)
				--让这两个都为true，能让无论NPC还是PLY都无法Revive这个Ragdoll
				ORag:SetNWBool("IsBeingRevived_ByPLY", true)
				ORag:SetNWBool("IsBeingRevived_ByNPC", true)
			else
				--被看见了！不SelfRevive了，继续Animrag_CallingSelfRevive的Timer
				ORag.WantToSelfRevive = false
			end
		end)
	end
end


----------------------------------------------------------------------------------------
--核心函数，当被Revive后，删除该Ragdoll，并在原位生成该Ragdoll对应的NPC
function Animrag_Create_Revived_NPC(ORag)
	if not IsValid(ORag) then return end

	------------------------------------
	--得到创建NPC所需的各种数据（把ORag里的数据写进新的Local里，防止这些数据因为ORag的Remove而丢失）
	local ORag_spClass 			= ORag.SpClass
	local ORag_npcHp			= ORag.NPCHp
	local ORag_isPlayer 		= ORag:GetNWBool("isPlayer")
	local ORag_isPlayer_Name 	= ORag:GetNWString("isPlayer_Name")
	local ORag_weapons 			= ORag.Weapons
	local ORag_savior 			= ORag.Savior
	local ORag_pos = util.TraceLine( {
		start = ORag:GetPos()+Vector(0,0,10),
		endpos = ORag:GetPos()-Vector(0,0,100),
		mask = MASK_SOLID,
		filter = ORag
	}).HitPos + Vector(0, 0, 10)

	local ORag_ang
	if ORag:LookupAttachment('eyes') > 0 then 
		ORag_ang = Angle(0, ORag:GetAttachment(ORag:LookupAttachment('eyes')).Ang.yaw, 0)
	else
		ORag_ang = ORag.Ang
	end
	local ORag_mdl 				= ORag:GetModel()
	local ORag_skin	 			= ORag:GetSkin()
	local ORag_group 			= ORag:GetBodyGroups()
	local ORag_group_value 		= {}
	--设置复活NPC的HP
	if ORag_isPlayer then
		if CVAR_ARag_r_hp_inherit_p:GetBool() and ORag.Hp_c then
			ORag_npcHp = ORag.Hp_c
		elseif CVAR_ARag_r_hp_portion_p:GetBool() then
			ORag_npcHp = ORag.NPCHp * CVAR_ARag_r_hp_portion_v:GetFloat()
		else
			ORag_npcHp = ORag.NPCHp
		end
	else
		if CVAR_ARag_r_hp_inherit:GetBool() and ORag.Hp_c then
			ORag_npcHp = ORag.Hp_c
		elseif CVAR_ARag_r_hp_portion:GetBool() then
			ORag_npcHp = ORag.NPCHp * CVAR_ARag_r_hp_portion_v:GetFloat()
		else
			ORag_npcHp = ORag.NPCHp
		end
	end
	--让复活后NPC的生命值不超过原来的最大生命值
	if ORag_npcHp > ORag.NPCHp then
		ORag_npcHp = ORag.NPCHp
	end
	for k, group in pairs(ORag_group) do
		table.insert(ORag_group_value, group.id, ORag:GetBodygroup(group.id))
	end
	
	------------------------------------
	--运行该Ragdoll的结束函数，再删除该Ragdoll，这里用了"Death"而不是"Crawl"是因为不管怎么样已经无所谓了，反正ORag马上被删除，用"Death"能节约性能
	Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Death")
	ORag:Remove()

	------------------------------------
	--创建相应的NPC
	if ORag_isPlayer then
		--如果这个Ragdoll是玩家的Ragdoll的话，直接让玩家在原地复活
		for k, PLY in pairs(player.GetAll()) do
			if PLY:Nick() == ORag_isPlayer_Name then
				PLY:Spawn()
				PLY:SetPos(ORag_pos)
				PLY:SetEyeAngles(ORag_ang)
				for _, wep in pairs(ORag_weapons) do
					PLY:Give(wep)
				end
				if CVAR_ARag_no_2nd_crawl_p:GetBool() then
					PLY.IsRevivedPLY = true	--标记这个新生成的PLY是个被复活过的PLY，用于判断是否需要让被复活过的PLY无法再爬行，继而被再次复活。但是！但玩家通过点鼠标主动重生时，要重置IsRevivedPLY为false!
				end
			end
		end
	else
		--如果这个Ragdoll是玩家的Ragdoll，而玩家又没有SelfRevive而是选择了直接复活，让该Ragdoll变成了普通的Ragdoll，那么该Ragdoll复活出来的NPC就从player改为npc_citizen
		if ORag_spClass == "player" then 
			ORag_spClass = "npc_citizen" 
			ORag_weapons = {}
		end

		local RevivedNPC = ents.Create(ORag_spClass)
		RevivedNPC:Spawn()
		RevivedNPC:SetPos(ORag_pos)
		RevivedNPC:SetAngles(ORag_ang)
		RevivedNPC:SetModel(ORag_mdl)
		RevivedNPC:SetSkin(ORag_skin)
		RevivedNPC:SetHealth(ORag_npcHp)
		RevivedNPC.RelationTb = {}			--这个新生成的NPC原本的关系表，如果是玩家复活了敌对NPC，使敌对NPC变为友好，但后来又打了他一枪，则将该NPC的关系恢复为敌对
		if CVAR_ARag_no_2nd_crawl:GetBool() then
			RevivedNPC.IsRevivedNPC = true	--标记这个新生成的NPC是个被复活过的NPC，用于判断是否需要让被复活过的NPC无法再爬行，继而被再次复活
		end
		if ORag_weapons then
			for k, wep in pairs(ORag_weapons) do
				RevivedNPC:Give(wep)
			end
		end
		if ORag_group_value then
			for k, v in pairs(ORag_group_value) do
				RevivedNPC:SetBodygroup(k, v)
			end
		end
		timer.Simple(FrameTime()*2, function()
			RevivedNPC:SetPos(ORag_pos)
		end)
		
		--将被复活的NPC设为与玩家同一阵营
		if ORag_savior then
			timer.Simple(0.5, function()
				RevivedNPC.RelationTb[ORag_savior] = RevivedNPC:Disposition(ORag_savior)				
				for k, other_npc in pairs(ents.GetAll()) do
					if other_npc:IsNPC() and other_npc != RevivedNPC then
						local D = other_npc:Disposition(ORag_savior)
						--将复活NPC对其他NPC的态度设置为：其他NPC对玩家什么态度（如友好），该复活NPC就对其他NPC什么态度（如友好）
						RevivedNPC:AddRelationship( tostring(other_npc:GetClass() .. " " .. D_enum[D] .. " " .. "99") )
						--将其他NPC对复活NPC的态度设置为：他们对玩家什么态度，就对该复活NPC什么态度
						other_npc:AddEntityRelationship(RevivedNPC, D, 99)
					end
				end
				RevivedNPC:AddEntityRelationship(ORag_savior, D_LI, 99)
			end)
			timer.Create("RevivedNPC_FollowPLY", 2, -1, function()
				if IsValid(RevivedNPC) then
					RevivedNPC:SetLastPosition(ORag_savior:GetPos())
					RevivedNPC:SetSchedule( SCHED_FORCED_GO_RUN )
				end
			end)
		else
			timer.Simple(1, function()
				if IsValid(RevivedNPC) then
					RevivedNPC:SetLastPosition(RevivedNPC:GetPos()+Vector(0, 10, 0))
					RevivedNPC:SetSchedule( SCHED_FORCED_GO_RUN )
				end
			end)
			timer.Simple(3, function()
				if IsValid(RevivedNPC) then
					RevivedNPC:ClearSchedule()
				end
			end)
		end
	end
end


----------------------------------------------------------------------------------------
--核心函数，当被Revive时，将AnimRag的动画从crawl动画变为revive动画
function Animrag_StartReviveAnimation(Orgn_Rag, IsSelfRevive)
	local Anim_Rag = Orgn_Rag.ARag
	if not IsValid(Orgn_Rag) or not IsValid(Anim_Rag) then return end

	------------------------------------
	--得到动画播放的位置
	local Apos = util.TraceLine( {
		start = Orgn_Rag:GetPos(),
		endpos = Orgn_Rag:GetPos()-Vector(0,0,100),
		mask = MASK_SOLID,
		filter = Orgn_Rag
	})

	------------------------------------
	--根据Ragdoll朝上还是朝下，得到播放哪个动画，以及该动画对应的持续时间
	--同时，如果是 IsSelfRevive 的话，播放 SelfRevive + Getup 动画，而不是 Idle + Getup 动画
	local Animation_Nm_Idles, Animation_Nm_Getup, MoveTb_Idles
	if     not IsSelfRevive and Orgn_Rag.FacingUp then
		Animation_Nm_Idles = "crawling_up_idle"
		Animation_Nm_Getup = "crawling_up_getup" .. math.random(1,2)
		Animation_startAng = -Anim_Rag:GetAngles()
		MoveTb_Idles = MoveTb_Idles_Up
	elseif not IsSelfRevive and not Orgn_Rag.FacingUp then
		Animation_Nm_Idles = "crawling_down_idle"
		Animation_Nm_Getup = "crawling_down_getup" .. math.random(1,2)
		Animation_startAng = Anim_Rag:GetAngles()
		MoveTb_Idles = MoveTb_Idles_Down
	else
		Animation_Nm_Idles = "crawling_self_revive" .. math.random(1,2)
		Animation_Nm_Getup = "crawling_up_getup" .. math.random(1,2)
		Animation_startAng = -Anim_Rag:GetAngles()
		MoveTb_Idles = MoveTb_Idles_Up
	end
	local _, Animation_Tm_Idles = Anim_Rag:LookupSequence(Animation_Nm_Idles)
	local _, Animation_Tm_Getup = Anim_Rag:LookupSequence(Animation_Nm_Getup)

	------------------------------------
	--将AnimRag从Crawl动画变为Revive动画，要先告诉crawl端不要再crawl了
	net.Start("AnimRag_Reviv_T_Crawl_PausesCrawl_sTc")
		net.WriteInt(Orgn_Rag:EntIndex(), 32)
	net.Broadcast()
	Anim_Rag:SetPos(Apos.HitPos)
	Anim_Rag:Fire("SetAnimation", Animation_Nm_Idles)

	------------------------------------
	--每一个Ragdoll对应的各自的参数	
	--播放动画所需的参数
	Orgn_Rag:SetNWInt("Animation_State", 3) 							--标记为3，为了在DeathCam里区分Crawl和Revive
	Orgn_Rag.Table 	= MoveTb_Idles 										--该Ragdoll对应的MoveTb，只有MoveTb里的骨骼会被移动，其它骨骼自由发挥
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
	Orgn_Rag.Isdead = false												--这是为了标记该Ragdoll已经被杀死了，防止继续打伤害会让它再死一次
	Orgn_Rag.StopAnim = false											--这是为了标记该Ragdoll已经结束动画了（不一定是被杀死的），防止AnimRag_ComputeShadowControl继续运算
	--环境交互所需的参数（也属于结束动画所需的参数）
	Orgn_Rag.Fall = 0													--该Ragdoll里有几个骨骼已经悬空了，用于当Ragdoll爬到地形边缘时，决定是让它结束动画还是让它继续顺着地形爬行
	Orgn_Rag.HitWall = 0												--该Ragdoll里有几个骨骼已经撞墙了，用于当Ragdoll撞到墙壁时，决定是让它结束动画还是让它继续怼墙
	--转换动作（从Idle到Getup）所需的参数
	Orgn_Rag.IsBeingRevived = true			--由于Orgn_Rag已经提前被写进Orgn_Rag_Tb_Crawl了（为了方便创建Animrag_CallingNearbyAllys的Timer），因此需要这个参数来阻止Tick的hook的运行，这个最一开始为false，当这里变成true后，Tick就能开始播放动画了
	Orgn_Rag.StartIdle = true				--如果条件满足，开始播放Idle动画（默认为true也就是说现在立刻开始播放Idle动画。不仅要true，还需要CurTime处在应该播放Idle动画的时间段内（这是为了实现循环播放），这两个条件共同决定是否应该Idle）
	Orgn_Rag.StartGetup = false				--如果条件满足，开始播放Getup动画（只有当玩家按完revive按键，或NPC成功revive时，值才为true。它不需要判断CurTime是否处在正确的时间段内（因为不需要循环播放），任何时刻只要是true，就播放Getup）
	Orgn_Rag.FinishGetup = false			--如果条件满足，延迟0.25秒后创建被复活的NPC（只有当StartGetup为true时它才为true。不仅要true，还需要CurTime大于Anim_Tm_Getup_FullStop（因为StartGetup为true的一瞬间，FinishGetup也被设为true，需要延时一会等动画播放完才行））
	Orgn_Rag.FailGetup = false				--如果CurTime已经过了正常复活时间，但还没有收到StartGetup的命令，则说明Revive被打断了，则告诉crawl端继续爬行（默认为true，只有当StartGetup（也就是成功revive时）才为false，也就是说只要没成功revive，一律当失败处理）
	Orgn_Rag.FailGetup_X = true				--因为FailGetup需要一直为true，来阻止Idle动画的播放，因此FailGetup的值不能改，只能加一个FailGetup_X来做辅助（以上的参数如StartGetup，FinishGetup之类的，都只要运行一次就行，完全可以true完就改false，因此不需要这类参数）
	Orgn_Rag.IsSelfRevive = IsSelfRevive 	--用于判断动画是否需要循环（Idle动画需要循环，SelfRevive动画不需要，播放一遍后立刻接StartGetup）

	Orgn_Rag.Anim_Nm_Idles = Animation_Nm_Idles
	Orgn_Rag.Anim_Nm_Getup = Animation_Nm_Getup
	Orgn_Rag.Anim_Tm_Idles = Animation_Tm_Idles					
	Orgn_Rag.Anim_Tm_Getup = Animation_Tm_Getup
	Orgn_Rag.Anim_Tm_Idles_ThisStop = CurTime() + Animation_Tm_Idles	--这一次的循环会在什么时候结束，用于循环idle动画
	Orgn_Rag.Anim_Tm_Idles_IdeaStop = CurTime() + 4 + 0.5				--如果成功Revive的话，理应在什么时候结束，如果在这段时间后还没有得到 Orgn_Rag.StartGetup，则说明Revive失败，继续crawl
	--复活所需的参数（其它的在net事件里已经被定义过了）
	Orgn_Rag.Ang = Animation_startAng

	------------------------------------
	--在被revive的时候禁用手部和腿部的碰撞，因为这俩真的很Bug
	for bonename, _ in pairs(MoveTb_DoCollision) do
		local boneID = Orgn_Rag:LookupBone(bonename)
		if boneID then
			local phyid = Orgn_Rag:TranslateBoneToPhysBone(boneID)
			local phyobj = Orgn_Rag:GetPhysicsObjectNum(phyid)
			if phyobj then
				phyobj:EnableCollisions(false)
			end
		end
	end

end


----------------------------------------------------------------------------------------
--当Ragdoll在Crawl端开始crawl时，接受到命令，记录下刚刚开始crawl的ragdoll，并召唤附近的友军。
net.Receive("AnimRag_Crawl_T_Reviv_cTs", function()
	local Orgn_Rag = Entity(net.ReadInt(32))
	local Anim_Rag = Entity(net.ReadInt(32))
	if not Orgn_Rag or not Anim_Rag then return end

	--zombie滚蛋
	if string.match(Orgn_Rag:GetModel(), "zombie") or string.match(Orgn_Rag:GetModel(), "zombine") then return end

	Anim_Rag.ORag = Orgn_Rag
	Orgn_Rag.ARag = Anim_Rag

	if CVAR_ARag_enab_ally_r:GetBool() then
		timer.Simple(math.Rand(0, 2), function()
			Animrag_CallingNearbyAllys(Orgn_Rag)	--0-2秒后召唤附近的友军（如果有的话）前来Revive
		end)
	end
end)


----------------------------------------------------------------------------------------
--当玩家复活按键按下时，初始化Ragdoll，执行Idle动画
net.Receive("AnimRag_Reviv_StartsPressing_cTs", function()
	local Orgn_Rag = Entity(net.ReadInt(32))
	Orgn_Rag:SetNWBool("IsBeingRevived_ByPLY", true)
	Animrag_StartReviveAnimation(Orgn_Rag, false) --这个不是SelfRevive，而是由玩家进行的Revive，因此false，从而使用Idle动画
end)


----------------------------------------------------------------------------------------
--当玩家复活按键按完时，结束Idle动画，开始Getup动画
net.Receive("AnimRag_Reviv_FinishPressing_cTs", function()
	local Orgn_Rag = Entity(net.ReadInt(32))
	Orgn_Rag.Savior = net.ReadEntity()
	Orgn_Rag.StartGetup = true
end)


----------------------------------------------------------------------------------------
--当玩家复活按键按完，且复活的是玩家自活时，结束Idle动画，开始SelfRevive动画，然后再Getup动画
net.Receive("AnimRag_Reviv_FinishPressing_PlySelfRevive_cTs", function()
	local Orgn_Rag = Entity(net.ReadInt(32))
	Animrag_StartReviveAnimation(Orgn_Rag, true) --这个是SelfRevive，因此true，从而使用SelfRevive动画
end)


----------------------------------------------------------------------------------------
--当玩家复活按键松开时，标记一下玩家已经停止revive该Ragdoll，这时NPC可以过来revive了
net.Receive("AnimRag_Reviv_RleasePressing_cTs", function()
	local Orgn_Rag = Entity(net.ReadInt(32))
	Orgn_Rag:SetNWBool("IsBeingRevived_ByPLY", false)
end)


----------------------------------------------------------------------------------------
--对于所有没在被Revive的Ragdoll，每隔2秒召唤一次友军来进行revive
timer.Create("Animrag_CallingNearbyAllys_Timer", 2, 0, function()
	if not CVAR_ARag_enab_ally_r:GetBool() then return end
	if not Orgn_Rag_Tb_Crawl then return end

	for k, ORag in pairs(Orgn_Rag_Tb_Crawl) do
		--当该Ragdoll在 播放Idle动画 或 播放Getup动画 或 正被玩家救 时，说明已经有人在救他了，于是不再喊人来救他
		if IsValid(ORag) and IsValid(ORag.ARag) and not ORag.StartIdle and not ORag.StartGetup and not ORag:GetNWBool("IsBeingRevived_ByPLY") then
			Animrag_CallingNearbyAllys(ORag)
		end
	end
end)


----------------------------------------------------------------------------------------
--对于所有没在被Revive的Ragdoll，每隔2秒尝试进行一次SelfRevive，如果此时有友军正在赶来，则让友军停止
timer.Create("Animrag_CallingSelfRevive_Timer", 2, 0, function()
	if not CVAR_ARag_enab_self_r:GetBool() then return end
	if not Orgn_Rag_Tb_Crawl then return end

	for k, ORag in pairs(Orgn_Rag_Tb_Crawl) do
		--当该Ragdoll在 播放Idle动画 或 播放Getup动画 或 正被玩家救 或 正被NPC救 时，说明已经有人在救他了，于是不再自救；同时Ragdoll是玩家时也不自动自救，让玩家自己按按键
		if IsValid(ORag) and IsValid(ORag.ARag) and not ORag.StartIdle and not ORag.StartGetup and not ORag.WantToSelfRevive and not ORag:GetNWBool("isPlayer") and not ORag:GetNWBool("IsBeingRevived_ByPLY") and not ORag:GetNWBool("IsBeingRevived_ByNPC") then
			Animrag_CallingSelfRevive(ORag)
		end
	end
end)


----------------------------------------------------------------------------------------
--主功能，得到 AnimRag 各骨骼应有的位置与角度信息，并应用在 Ragdoll 身上。
hook.Add("Tick", "Animrag_MainTick_R", function()
	if not Orgn_Rag_Tb_Crawl then return end
	for k, ORag in pairs(Orgn_Rag_Tb_Crawl) do
		--FailGetup是为了当revive失败时防止和crawl端冲突；IsBeingRevived是为了当Orgn_Rag被写入Orgn_Rag_Tb_Crawl，但还没有NPC前来revive时，阻止Ragdoll播放revive动画
		if IsValid(ORag) and IsValid(ORag.ARag) and not ORag.FailGetup and ORag.IsBeingRevived then

			------------------------------------------------------
			--主循环
			Animrag_ComputeShadowControl(ORag)

			------------------------------------------------------
			--在Idle动画中：如果不是SelfRevive，每此Idel动画结束时就再循环一遍，直到到达FullStop的时间点；如果是SelfRevive，第一次动画结束后立马StartGetup
			if CurTime() >= ORag.Anim_Tm_Idles_ThisStop and ORag.StartIdle then	
				if not ORag.IsSelfRevive then
					ORag.ARag:Fire("SetAnimation", ORag.Anim_Nm_Idles)
					ORag.Anim_Tm_Idles_ThisStop = CurTime() + ORag.Anim_Tm_Idles
				else
					ORag.StartGetup = true
				end
			end

			------------------------------------------------------
			--Revive如果中途被打断（即：当时间已经过了正常复活时间，但还没有收到StartGetup的命令），则继续crawl，同时重置该ORag的大部分参数
			if CurTime() >= ORag.Anim_Tm_Idles_IdeaStop and ORag.FailGetup_X then
				ORag.FailGetup_X = false
				
				ORag.FailGetup = true
				ORag.StartIdle = false
				ORag.StartGetup = false
				ORag.FinishGetup = false

				ORag.SomebodyIsComing = false
				ORag.IsBeingRevived = false
				ORag:SetNWBool("IsBeingRevived_ByPLY", false)
				ORag:SetNWBool("IsBeingRevived_ByNPC", false)
				net.Start("AnimRag_Reviv_T_Crawl_ResumeCrawl_sTc")
					net.WriteInt(ORag:EntIndex(), 32)
				net.Broadcast()
			end

			------------------------------------------------------
			--Revive成功后，播放Getup动画
			if ORag.StartGetup then
				ORag.StartGetup = false
				
				ORag.StartIdle = false
				ORag.FinishGetup = true
				ORag.FailGetup = false
				ORag.FailGetup_X = false

				--如果有哪个部分被肢解了，则在Revive结束后不播放Getup动画，而是直接结束动画，防止复活后发生奇奇怪怪的东西
				for bonename, _ in pairs(Dismember_Tb) do
					local boneID = ORag:LookupBone(bonename)
					if boneID then
						if ORag:GetManipulateBoneScale(boneID) != Vector(1, 1, 1) then
							Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
						return end
					end
				end

				ORag.ARag:Fire("SetAnimation", ORag.Anim_Nm_Getup)
				ORag.Anim_Tm_Getup_FullStop = CurTime() + ORag.Anim_Tm_Getup
				
				--因为改变了Animation，因此MoveTb也需改变，因此Bone中的各种参数也需重置
				ORag.Table = MoveTb_Getup
				ORag.Bone = {}
				for bonename, _ in pairs(ORag.Table) do
					local boneID = ORag:LookupBone(bonename)
					if boneID then
						local phyobj = ORag:GetPhysicsObjectNum(ORag:TranslateBoneToPhysBone(boneID))
						--恢复手部和腿部的碰撞
						if phyobj and MoveTb_DoCollision[bonename] then
							phyobj:EnableCollisions(true)
						end
						ORag.Bone[bonename] = {}
						ORag.Bone[bonename]["random"] = Angle(math.Rand(-15, 15), math.Rand(-15, 15), 0)
						ORag.Bone[bonename]["addpos"] = Vector(0, 0, 0)
						ORag.Bone[bonename]["lastAdd"] = Vector(0, 0, 0)
						ORag.Bone[bonename]["lastHit"] = Vector(0, 0, 0)
						ORag.Bone[bonename]["Fall"] = false
						ORag.Bone[bonename]["HitWall"] = false
					end
				end
			end

			------------------------------------------------------
			--Getup动画结束后：等0.25秒后开始复活！（反正Ragdoll马上就要被Remove了，所以就不像上面一样重置各种乱七八糟的参数了）
			if ORag.Anim_Tm_Getup_FullStop then
				if CurTime() >= ORag.Anim_Tm_Getup_FullStop and ORag.FinishGetup then
					ORag.FinishGetup = false
					
					timer.Simple(0.25, function()
						if IsValid(ORag) then
							Animrag_EndAnimation(ORag, Orgn_Rag_Tb_Crawl, Anim_Rag_Tb_Crawl, "Crawl")
							Animrag_Create_Revived_NPC(ORag)
						end
					end)
				end
			end		

		end
	end
end)


----------------------------------------------------------------------------------------
--让友军跑向各自的Ragdoll并尝试进行Revive
hook.Add("Think", "Animrag_AllyReviving", function()
	if not Ally_NPC_Tb then return end
	for k, NPC in pairs(Ally_NPC_Tb) do

		--这一段不需要ORag也可以判断
		if IsValid(NPC) then
			--如果该NPC没有对应的Ragdoll了（说明Ragdoll死亡了，或者复活成NPC了），则重置该NPC并从表里移除该NPC
			if not NPC.TB or not NPC.TB.ORag then
				NPC:ClearSchedule()
				NPC.TB = {}
				table.remove(Ally_NPC_Tb, k)
			end
		end

		--这一段必须要ORag
		if IsValid(NPC) and IsValid(NPC.TB.ORag) then	
			local ORag = NPC.TB.ORag
			local Dist = NPC:GetPos():DistToSqr(ORag:GetPos())

			--如果在跑向Ragdoll的途中Ragdoll被玩家救了，则重置该NPC
			if ORag:GetNWBool("IsBeingRevived_ByPLY") then
				--重设该NPC与其他物体的敌友关系
				for _, other_npc in pairs(ents.GetAll()) do
					if other_npc:IsNPC() and NPC.TB.Relation_NPC[other_npc] then
						NPC:AddEntityRelationship(other_npc, NPC.TB.Relation_NPC[other_npc], 99)
					end
				end
				for _, ply in pairs(player.GetAll()) do
					if NPC.TB.Relation_PLY[ply] then
						NPC:AddEntityRelationship(ply, NPC.TB.Relation_PLY[ply], 99)
					end
				end
				--重置该NPC
				NPC:ClearSchedule()
				NPC.TB = {}
				table.remove(Ally_NPC_Tb, k)
			return end

			--如果是玩家Ragdoll，且玩家已经手动复活了，则重置该NPC
			if ORag:GetNWBool("isPlayer") then
				for k, PLY in pairs(player.GetAll()) do
					if PLY:Nick() == ORag:GetNWString("isPlayer_Name") and PLY:Alive() then
						NPC:ClearSchedule()
						NPC.TB = {}
						table.remove(Ally_NPC_Tb, k)
					return end
				end
			end

			--当NPC与Ragdoll的距离在60以内时，让NPC蹲下救Ragdoll，否则让NPC持续跑向Ragdoll
			if Dist <= 3600 and NPC.TB.isRunning then
				NPC.TB.isRunning = false
				NPC:ClearSchedule()
				NPC.TB.Duck_Start_Time = CurTime() + 1
				NPC.TB.Duck_Loop_Time 	= NPC.TB.Duck_Start_Time + 3
				NPC.TB.Duck_End_Time 	= NPC.TB.Duck_Loop_Time + 1
				ORag:SetNWBool("IsBeingRevived_ByNPC", true)	--这里用了NW命令，这样在其它端（如crawl端、client端）也能读写这个Ragdoll是否正在被Revive，从而防止玩家的revive和NPC的revive打架
			elseif Dist > 3600 and CurTime() >= NPC.TB.CheckTargetPos_Time then
				NPC.TB.CheckTargetPos_Time = CurTime() + 3
				NPC:SetLastPosition(ORag:GetPos())
				NPC:SetSchedule( SCHED_FORCED_GO_RUN )
			else end
			
			if not NPC.TB.Duck_Start_Time then return end
			
			--当NPC成功接近Ragdoll时，NPC.TB.Duck_Start_Time被写入，开始播放蹲下动作
			if		CurTime() <  NPC.TB.Duck_Start_Time and not NPC.TB.Duck_Start then
				NPC.TB.Duck_Start = true
				NPC:PlayScene("scenes/Animrag_duck.vcd")
				Animrag_StartReviveAnimation(ORag, false)
			
			--播放蹲下动作时，禁用NPC的动作，防止蹲下动作被AI打断
			elseif	CurTime() <  NPC.TB.Duck_Start_Time and NPC.TB.Duck_Start then
				NPC:StopMoving()
			
			--蹲下动作完成后，播放循环动作
			elseif	CurTime() >= NPC.TB.Duck_Start_Time and CurTime() < NPC.TB.Duck_Loop_Time then
				NPC:PlayScene("scenes/Animrag_duck_loop.vcd")
			
			--循环动作完成后，播放站起动作，同时：标记该Ragdoll需要开始播放Getup动画
			elseif	CurTime() >= NPC.TB.Duck_Loop_Time  and not NPC.TB.Duck_End then
				NPC.TB.Duck_End = true
				NPC:PlayScene("scenes/Animrag_duck_to_stand")
				ORag.StartGetup = true
			
			--站起动作完成后，重置该NPC
			elseif	CurTime() >= NPC.TB.Duck_End_Time then
				
				------------------------------------
				--重设该NPC与其他物体的敌友关系
				for _, other_npc in pairs(ents.GetAll()) do
					if other_npc:IsNPC() and NPC.TB.Relation_NPC[other_npc] then
						NPC:AddEntityRelationship(other_npc, NPC.TB.Relation_NPC[other_npc], 99)
					end
				end
				for _, ply in pairs(player.GetAll()) do
					if NPC.TB.Relation_PLY[ply] then
						NPC:AddEntityRelationship(ply, NPC.TB.Relation_PLY[ply], 99)
					end
				end
				------------------------------------
				--重设该NPC的一切参数，让该NPC能无缝衔接到下一个救援中
				NPC:ClearSchedule()
				NPC.TB = {}
				table.remove(Ally_NPC_Tb, k)
			else 
			end
		end
	end	
end)


----------------------------------------------------------------------------------------
--禁用Ragdoll与前来救援的NPC之间的碰撞
hook.Add("ShouldCollide", "Animrag_AllyAndRagdoll_Collision", function(ent1, ent2)
	if ent1.TB then
		if ent1.TB.CollisionORag == ent2 then
			return false
		end
	elseif ent2.TB then
		if ent2.TB.CollisionORag == ent1 then
			return false
		end
	else end
end)


----------------------------------------------------------------------------------------
--当清空服务器时，重置一切参数
hook.Add( "PostCleanupMap" , "Animrag_ResetAll_C" , function( ply )
	Orgn_Rag_Tb_Crawl = {}
	Anim_Rag_Tb_Crawl = {}
	Ally_NPC_Tb = {}
end)
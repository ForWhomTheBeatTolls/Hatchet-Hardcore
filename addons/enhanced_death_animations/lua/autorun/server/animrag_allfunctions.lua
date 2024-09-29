
--以下为在 Death, Crawl, Revive 中的共有函数

----------------------------------------------------------------------------------------
--结束函数，用于停止当前播放的动画（动画播放结束时、被Overkill时等）
function Animrag_EndAnimation(ORag, Orgn_Rag_Tb, Anim_Rag_Tb, Type)
	if Type == "Death" then
		ORag.Isdead_d = true					--这是为了标记该Ragdoll已经被杀死了，防止继续打伤害会让它再死一次
	else
		ORag.Isdead_c = true					--这是为了标记该Ragdoll已经被杀死了，防止继续打伤害会让它再死一次
		timer.Simple(FrameTime(), function()	--稍微延时一帧，给Debug界面一点时间反应
			if IsValid(ORag) then
				ORag:SetNWInt("Animation_State", 0)	--标记Ragdoll已经彻底死亡了，之所以Death没有这一段，是因为Death时被Overkill可能并没有真的死，过会还是会Crawl
			end
		end)
	end

	ORag.StopAnim = true						--这是为了标记该Ragdoll已经结束动画了（不一定是被杀死的），防止AnimRag_ComputeShadowControl继续运算

	for k, v in pairs(Orgn_Rag_Tb) do
		if v == ORag then
			table.remove(Orgn_Rag_Tb, k)
		end
	end

	for k, v in pairs(Anim_Rag_Tb) do
		if v == ORag.ARag then
			table.remove(Anim_Rag_Tb, k)
			v:Remove()
		end
	end
end


----------------------------------------------------------------------------------------
--主要函数，让Ragdoll的肢体跟着AnimRag的肢体运动
function Animrag_ComputeShadowControl(ORag)

	//for _, bonename in pairs(ORag.Table) do
	//	local boneID = ORag:LookupBone(bonename)
	//	if boneID and not ORag.StopAnim then
	//		local phyobj = ORag:GetPhysicsObjectNum(ORag:TranslateBoneToPhysBone(boneID))

	for i=0, ORag:GetPhysicsObjectCount()-1 do
		local bonename = ORag:GetBoneName(ORag:TranslatePhysBoneToBone(i))
		if ORag.Table[bonename] then
			local phyobj = ORag:GetPhysicsObjectNum(i)
	
			--当某个骨骼被肢解时，或者该骨骼被标记为fall时，不再移动这个骨骼
			if phyobj and ORag:GetManipulateBoneScale(ORag:TranslatePhysBoneToBone(i)) != Vector(0, 0, 0) and not ORag.Bone[bonename]["Fall"] then			
	
				local pos0, bone_ang = ORag.ARag:GetBonePosition(ORag.ARag:LookupBone(bonename)) 	--得到原始的目标位置和目标角度
				bone_ang = bone_ang + ORag.Bone[bonename]["random"]									--给角度一点随机性
				
				local refer = Vector(pos0.x, pos0.y, ORag.ARag:GetPos().z) 	--refer：它的x,y位置与骨骼的目标位置一致，但z位置保持与AnimRag的本体平齐
				
				--“目标位置”：为该骨骼理应到达的位置。
				--在平地时，目标位置是我希望骨骼到达的位置；
				--而当坠落、或者碰到障碍物时，如果还继续向着原本的“目标位置”运动，该骨骼就会浮空、穿墙。
				--因此需要根据地形变化来实时修正目标位置。
	
				----------------------------------------------------------------------修正目标位置
				--这一帧的 目标位置距地面距离
				local tr1 = util.TraceLine( {
					start = refer + Vector(0,0,10),--目标位置
					endpos = refer - Vector(0,0,100),
					mask = MASK_SOLID,
					filter = {ORag, ORag.ARag}
				})
		
				--计算addpos
								--这一帧的 目标距地面距离 		--上一帧的 目标距地面距离		
				local Diff = (refer.z - tr1.HitPos.z) - ORag.Bone[bonename]["lastHit"].z 	--Diff：上下两帧的目标位置距地距离的差值
			
				--与地面距离<20时，适应地形；与地面>20时，说明高度差太大，适应不了，直接结束动画自由落体
				if Diff < 20  then
					ORag.Bone[bonename]["addpos"] = Vector(0, 0, Diff + ORag.Bone[bonename]["lastAdd"].z)
				else
					ORag.Bone[bonename]["addpos"] = Vector(0, 0, Diff + ORag.Bone[bonename]["lastAdd"].z)
					ORag.Bone[bonename]["Fall"] = true
					ORag.Fall = ORag.Fall + 1 --标记该骨骼已经悬空并准备自由落体，每个骨骼只标记一次，总计5个骨骼悬空后，直接结束动画，自由落体
				end
		
				ORag.Bone[bonename]["lastAdd"] = ORag.Bone[bonename]["addpos"] 	--上一帧的 addpos，用来计算下一帧的addpos
				ORag.Bone[bonename]["lastHit"] = refer - tr1.HitPos		--上一帧的 目标距地面的距离，用来计算下一帧的Diff
		
				--bone_pos:经过修正后的目标位置，当Ragdoll从高15落下到高0时，如果不修正，目标位置将会是浮空的高15，修正后目标位置变成正确的高0。
				local bone_pos = pos0 - ORag.Bone[bonename]["addpos"]
				----------------------------------------------------------------------修正目标位置
	
				--计算 当前骨骼位置 与 目标位置 之间是否有障碍物，比如Ragdoll被一面墙挡住时，没有碰撞模型的AnimRag穿墙穿过去了，但Ragdoll不能，那么这堵墙就是障碍物。
				local tr2 = util.TraceLine( {
					start = phyobj:GetPos(),
					endpos = bone_pos,
					mask = MASK_ALL, --包括了水面，这样当NPC在水下时，tr2就能hit了
					filter = {ORag, ORag.ARag}
				})
			
				--如果撞墙，则标记该骨骼已经撞墙，同时使ORag.HitWall的值+1，每个骨骼只能加一次，总计10个骨骼撞墙后，直接结束动画。
				if tr2.Hit then
					if not ORag.Bone[bonename]["HitWall"] then
						ORag.HitWall = ORag.HitWall + 1
						ORag.Bone[bonename]["HitWall"] = true
					end
				end
	
				--该骨骼路径上没有障碍物，且没有从高处坠落时，才让该骨骼开始运动
				if !tr2.Hit and not ORag.Bone[bonename]["Fall"] then
					local p = {}
					p.secondstoarrive = 0.01
					p.pos = bone_pos
					p.angle = bone_ang
					p.maxangular = 400
					p.maxangulardamp = 200
					p.maxspeed = 400
					p.maxspeeddamp = 300
					p.teleportdistance = 0
					
					phyobj:Wake()
					phyobj:ComputeShadowControl(p)
				end
	
			end
		end
	end

	--前面是改变有物理的身体骨骼，现在是改变没有物理的手指骨骼（手指骨骼必须在Client端改）
		net.Start("AnimRag_PoseFingerBone_sTc")
			net.WriteInt(ORag:EntIndex(), 32)
			net.WriteInt(ORag.ARag:EntIndex(), 32)
		net.Broadcast()
end


----------------------------------------------------------------------------------------
--根据Ragdoll的尺寸来缩放AnimRag，让动画更自然
function Animrag_ScaleAnimRag(ORag, ARag)
	if not CVAR_ARag_scalerag:GetBool() or not ORag.BodyHeight then return end

	local scale = math.sqrt(ORag.BodyHeight/67.01953125)
	ARag:SetModelScale(scale, 0)
end
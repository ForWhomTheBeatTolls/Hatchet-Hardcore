
--玩家复活相关
local CVAR_ARag_ply_key 		= CreateClientConVar("ARag_ply_key", "17")				--（KEY）玩家按哪个键来复活NPC
local CVAR_ARag_ply_r_ally 		= CreateClientConVar("ARag_ply_r_ally", "1", 0, 1)		--（0/1）是否允许玩家复活NPC
local CVAR_ARag_ply_r_enemy 	= CreateClientConVar("ARag_ply_r_enemy", "1", 0, 1)		--（0/1）是否允许玩家复活敌对NPC
local CVAR_ARag_ply_r_self 		= CreateClientConVar("ARag_ply_r_self", "1", 0, 1)		--（0/1）是否允许玩家自活
--玩家复活HUD相关
local CVAR_ARag_ply_hud_cir 	= CreateClientConVar("ARag_ply_hud_cir", "0", 0, 1)		--（0/1）玩家复活HUD的种类，是圆形HUD还是多边形HUD，0为多边形，1为圆形
local CVAR_ARag_ply_hud_r 		= CreateClientConVar("ARag_ply_hud_r", "80", 0, 255)	--（NUM）玩家复活HUD的R
local CVAR_ARag_ply_hud_g 		= CreateClientConVar("ARag_ply_hud_g", "180", 0, 255)	--（NUM）玩家复活HUD的G
local CVAR_ARag_ply_hud_b 		= CreateClientConVar("ARag_ply_hud_b", "152", 0, 255)	--（NUM）玩家复活HUD的B
local CVAR_ARag_ply_hud_a 		= CreateClientConVar("ARag_ply_hud_a", "152", 0, 255)	--（NUM）玩家复活HUD的Alpha
local CVAR_ARag_ply_hud_rad 	= CreateClientConVar("ARag_ply_hud_rad", "70")			--（NUM）玩家复活HUD的尺寸
local CVAR_ARag_ply_hud_seg 	= CreateClientConVar("ARag_ply_hud_seg", "6")			--（NUM）玩家复活HUD（种类为多边形时）的多边形边数


local KeyDown_Start 	= false
local KeyDown_StartTime = 0
local KeyDown_Finish 	= false
local KeyUpup_Start 	= false
local ORag = nil


----------------------------------------------------------------------------------------
--不知道，AI写的，画进度条
function Animrag_DrawProgressCircle(ORag, KeyDown_StartTime, Rad, Segment, RGB1, RGB2, Alpha)
	if not IsValid(ORag) then return end
	if not ORag.CanDrawCircle or ORag.TooFar then return end

	--x,y为画进度条的位置。如果复活的是NPC，则在NPC的正上方画进度条；如果复活的是玩家自活，则在玩家屏幕正中央画进度条
	local x, y
	if not LocalPlayer():GetNWBool("PlayerIsDeadNow") then
		local DrawPos = (ORag:GetPos() + Vector(0, 0, 20)):ToScreen()
		x = DrawPos.x
		y = DrawPos.y
	else
		x = ScrW()/2
		y = ScrH()/2
	end

	--进度
	local Progress = math.min((CurTime() - KeyDown_StartTime)/4, 1)

	if CVAR_ARag_ply_hud_cir:GetBool() then
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

		--如：Progress为0.75，Seg为5时，每个Segment间的Interval就为0.2，通过判断i-1与i分别乘以Interval的值，就得到了当前正在绘制哪一段Segment
		--在这里，0.75属于0.6~0.8，即正在绘制 i=4 的那一段Segment，因为只有当 i=4 时，(i-1)*Interval为0.6，i*Interval为0.8
		--接着，在 i=4 这一段Segment里，还需判断这一段Segment自己的进度。通过用Progress(0.75)除以Interval(0.2)，得到了一个数3.75，即：正在绘制第3~4的那一段Segment，已经绘制了0.75
		for i = 1, Segment do
			if Progress >= (i-1)*Interval and Progress < i*Interval then
				local Progress_sub = Progress/Interval - (i-1)
				ORag.DrawCircle_Tb_Alpha[i] = Progress_sub*Alpha
				ORag.DrawCircle_Tb_RGB[i] = LerpVector(Progress_sub, RGB1, RGB2)
			elseif Progress >= i*Interval then
				ORag.DrawCircle_Tb_Alpha[i] = Alpha
				ORag.DrawCircle_Tb_RGB[i] = RGB2
			end
		end
		
		--根据上边得到的每一片 RGB 和 Alpha，开画
		local Angle_Cur = math.rad(270)
		for i = 1, Segment do
			local Angle_Next = Angle_Cur + math.rad(360/Segment)
			local V1 = {x = x+math.cos(Angle_Cur)*Rad, y = y+math.sin(Angle_Cur)*Rad}
			local V2 = {x = x+math.cos(Angle_Next)*Rad, y = y+math.sin(Angle_Next)*Rad}
			local V3 = {x = x, y = y}
			local RGB = ORag.DrawCircle_Tb_RGB[i]
			local Alpha = ORag.DrawCircle_Tb_Alpha[i]
			Angle_Cur = Angle_Next
			
			draw.NoTexture()
			surface.SetDrawColor(RGB.x, RGB.y, RGB.z, Alpha)
			surface.DrawPoly({V1, V2, V3})
		end
	end
end


----------------------------------------------------------------------------------------
--核心功能，当按键按下与松开时，画进度条，改变视角等，同时在满足条件时与server端通信，使ragdoll播放Idle动画/使ragdoll复活/使ragdoll恢复爬行
hook.Add("HUDPaint", "Animrag_DrawReviveBar", function()

	if input.IsKeyDown(CVAR_ARag_ply_key:GetInt()) then
		------------------------------------
		--按下键时，记录ORag为鼠标指向的这个Ragdoll（如果此时玩家还活着的话，因为当玩家死亡时，按键一定是复活自己；当玩家活着时，按键一定是复活NPC）
		local EyeEnt = LocalPlayer():GetEyeTrace().Entity
		--该Ent必须是Ragdoll，必须要么处在Crawl阶段要么处在Revive阶段，必须是玩家活着时
		if EyeEnt:IsRagdoll() and EyeEnt:GetNWInt("Animation_State") >= 2 and not LocalPlayer():GetNWBool("PlayerIsDeadNow") then
			--如果该Ragdoll是玩家的敌人
			if EyeEnt:GetNWBool("EnemyPlayer: " .. tostring(LocalPlayer())) then
				if CVAR_ARag_ply_r_enemy:GetBool() then
					ORag = EyeEnt
				end
			--如果该Ragdoll不是玩家的敌人
			else
				if CVAR_ARag_ply_r_ally:GetBool() then
					ORag = EyeEnt
				end
			end
		end

		------------------------------------
		--如果按下按键时，玩家处于死亡状态，则此时的ORag即为玩家自己的Ragdoll，而不是准心指向的Ragdoll。当进度条读完后，告诉server端，玩家想自活，让server端播放自活动画
		--这种情况下，玩家将经过 Crawl - Idle - SelfRevive - Getup 四个阶段，而不是普通NPC自活时将经过的 Crawl - SelfRevive - Getup 三个阶段，或者是普通NPC被救时将经过的 Crawl - Idle - Getup 三个阶段
		if LocalPlayer():GetNWBool("PlayerIsDeadNow") then
			if CVAR_ARag_ply_r_self:GetBool() then
				ORag = Entity(LocalPlayer():GetNWInt("PlayerORagID"))
			end
		end

		------------------------------------
		--各种各样的判断，来辨别这个ORag是否应该能被救
		if IsValid(ORag) then
			------------------------------------
			--如果该Ragdoll没在Crawl阶段；或者正在被一个NPC救起；或者是个zombie；或者是玩家Ragdoll，但玩家已经手动复活了。则玩家不能救，该Ragdoll从一开始不能进入被Revive的阶段。
			--ORag.DontStartView是给CalcView用的，因为它不像Animrag_DrawProgressCircle一样能直接简单地用ORag.CanDrawCircle和ORag.TooFar进行判定
			if ORag:GetNWInt("Animation_State") < 2 then ORag.DontStartView = true return end
			if ORag:GetNWBool("IsBeingRevived_ByNPC") then ORag.DontStartView = true return end
			if string.match(ORag:GetModel(), "zombie") or string.match(ORag:GetModel(), "zombine") then ORag.DontStartView = true return end
			if ORag:GetNWBool("isPlayer") then
				for k, PLY in pairs(player.GetAll()) do
					if PLY:Nick() == ORag:GetNWString("isPlayer_Name") and PLY:Alive() then
						ORag.DontStartView = true
					return end
				end
			end

			------------------------------------
			--如果该Ragdoll已经进入了被Revive的阶段，当它已经被救完了，正在播放Getup动画；或者距离玩家过远时，停止Revive过程
			if ORag.ReviveSuccess then return end --这里没设置各种参数是因为在下边按键按完将ORag.ReviveSuccess设置为true时，已经把参数都设置完了
			if not LocalPlayer():GetNWBool("PlayerIsDeadNow") then
				ORag.TooFar = LocalPlayer():GetPos():DistToSqr(ORag:GetPos()) >= 5000 
				------------------------------------
				--如果该Ragdoll与玩家距离过远，则不能救（如果该Ragdoll就是属于玩家的话，就别判断了，因为玩家的Ragdoll和LocalPlayer虽然看似是一体的，但其实玩家死后LocalPlayer的位置就固定在了死亡的原位，与Ragdoll分开了）
				--当下面这段运行的时候ORag可能已经在Revive过程中了，因此出了正常的return end之外，还需要重置一些参数来停止Revive过程
				if ORag.TooFar and not ORag.TooFar_Start then
					ORag.TooFar_Start = true 						--让下面的代码只运行一次，不然ChangeView_Out_StartTime会一直是CurTime
					ORag.CanDrawCircle = false
					ORag.ChangeView_IIn_Start = false
					ORag.ChangeView_Out_Start = true				--既然已经松开键了，那就将视角慢慢移回去
					ORag.ChangeView_Out_StartTime = CurTime()	--视角从这一时刻开始慢慢移回去
				return end
			else
				ORag.TooFar = false
			end
		end

		------------------------------------------------------
		--刚按下键时，告诉revive端，开始revive了（只在按下键的一瞬间运行一次）
		if not KeyDown_Start then
			KeyDown_Start = true

			------------------------------------
			--这些参数是后续判断是否按完键、是否松开键所要用到的，这里把它们初始化一下
			KeyDown_StartTime = CurTime()							--何时按下的键，用于判断总共按了多久，是不是已经按完了
			KeyDown_Finish = false									--让按完键时的函数只运行一次
			KeyUpup_Start = false									--让松开键时的函数只运行一次

			if IsValid(ORag) then
				------------------------------------
				--初始化一下[进度条]和[视角]所需的参数
				ORag.CanDrawCircle = true
				ORag.DrawCircle_Tb_Alpha = {}
				ORag.DrawCircle_Tb_RGB = {}
				for i=1, CVAR_ARag_ply_hud_seg:GetInt() do
					ORag.DrawCircle_Tb_Alpha[i] = 0
					ORag.DrawCircle_Tb_RGB[i] = Vector(0, 0, 0)
				end
				ORag.TooFar_Start = false
				ORag.ChangeView_IIn_Start = true
				ORag.ChangeView_IIn_Finish = false
				ORag.ChangeView_IIn_StartTime = CurTime()
				ORag.ChangeView_Out_Start = false
				
				------------------------------------
				--告诉server端，开始播放Idel动画
				net.Start("AnimRag_Reviv_StartsPressing_cTs")
					net.WriteInt(ORag:EntIndex(), 32)
				net.SendToServer()
			end
		end

		------------------------------------------------------
		--画进度条
		if IsValid(ORag) then
			local R = CVAR_ARag_ply_hud_r:GetInt()
			local G = CVAR_ARag_ply_hud_g:GetInt()
			local B = CVAR_ARag_ply_hud_b:GetInt()
			local Alpha = CVAR_ARag_ply_hud_a:GetInt()
			local Rad = CVAR_ARag_ply_hud_rad:GetInt()
			local Segment = CVAR_ARag_ply_hud_seg:GetInt()
			Animrag_DrawProgressCircle(ORag, KeyDown_StartTime, Rad, Segment, Vector(255, 51, 51), Vector(R, G, B), Alpha)
		end

		------------------------------------------------------
		--按完键时，告诉revive端，救好了，同时删掉[进度条]，重置[视角]
		if not KeyDown_Finish and CurTime()-KeyDown_StartTime > 4 then
			KeyDown_Finish = true

			------------------------------------
			--重置一下按键相关参数，以便下次按按键
			KeyDown_Start = false
			KeyDown_StartTime = 0
			KeyUpup_Start = false

			if IsValid(ORag) then
				ORag.ReviveSuccess = true							--标志已经成功按完了，这样当松开键时就不会触发不想要的函数了（也就是还没按完就松开键时，所将触发的函数），同时再按键也不会发生任何事了
				ORag.CanDrawCircle = false							--成功按完时，不再绘制进度条
				ORag.ChangeView_IIn_Start = false				--成功按完时，开始让视角变回去
				ORag.ChangeView_Out_Start = true					--成功按完时，开始让视角变回去
				ORag.ChangeView_Out_StartTime = CurTime()		--成功按完时，开始让视角变回去

				------------------------------------
				--如果复活的是NPC，则告诉server端让Ragdoll播放Getup动画；如果复活的是玩家自活，则告诉server端让Ragdoll先播放SelfRevive动画，再播放Getup动画
				if not LocalPlayer():GetNWBool("PlayerIsDeadNow") then
					net.Start("AnimRag_Reviv_FinishPressing_cTs")	--成功按完时，告诉revive端按完了，应该播放Getup动画了
						net.WriteInt(ORag:EntIndex(), 32)
						net.WriteEntity(LocalPlayer())				--告诉revive端是谁把这个NPC给复活了，这样能把该NPC添加为该PLY的友军
					net.SendToServer()
				else
					net.Start("AnimRag_Reviv_FinishPressing_PlySelfRevive_cTs")
						net.WriteInt(ORag:EntIndex(), 32)
					net.SendToServer()
				end
			end
		end 
	else
		------------------------------------------------------
		--松开键时
		if not KeyUpup_Start then
			KeyUpup_Start = true

			------------------------------------
			--重置一下按键相关参数，以便下次按按键
			KeyDown_Start = false									--重置下KeyDown所需的参数
			KeyDown_StartTime = 0									--重置下KeyDown所需的参数
			KeyDown_Finish = false									--重置下KeyDown所需的参数

			------------------------------------
			--如果没救完就松开按键了，那就删掉[进度条]，重置[视角]，不需要告诉server端，因为server端自己能判断有没有救成功（如果时间到了还没收到“已救完”的net事件，则就说明没救成功）
			if IsValid(ORag) then
				if not ORag.ReviveSuccess then					--还没按完就松开键时，将触发以下函数
					ORag.CanDrawCircle = false						--松开键时，不再绘制进度条
					ORag.ChangeView_IIn_Start = false			--松开键时，开始让视角变回去
					ORag.ChangeView_Out_Start = true				--松开键时，开始让视角变回去
					ORag.ChangeView_Out_StartTime = CurTime()	--松开键时，开始让视角变回去
					
					net.Start("AnimRag_Reviv_RleasePressing_cTs")
						net.WriteInt(ORag:EntIndex(), 32)
					net.SendToServer()
				end
			end
		end
	end
end)




----------------------------------------------------------------------------------------
--改变视角
hook.Add("CalcView", "Animrag_LockViewInRevive", function(ply, pos, ang, fov)
	if not IsValid(ORag) then return end
	if ORag.DontStartView or LocalPlayer():GetNWBool("PlayerIsDeadNow") then return end

	local TargetAngle = LerpAngle(0.5, ang, ( (ORag:GetPos()+Vector(0, 0, 15))-LocalPlayer():EyePos() ):Angle() )
	local view = {}

	------------------------------------
	--当按下按键时，淡入视角
	if ORag.ChangeView_IIn_Start and not ORag.ChangeView_IIn_Finish then

		local ChangeView_IIn_ElapsedTime = CurTime() - ORag.ChangeView_IIn_StartTime
		local ChangeView_IIn_Progress = math.ease.InOutQuad(math.Clamp(ChangeView_IIn_ElapsedTime/1, 0, 1))
		if ChangeView_IIn_Progress >= 1 then 
			ORag.ChangeView_IIn_Finish = true
		end
		--改变视角所需的参数
		view.angles = LerpAngle(ChangeView_IIn_Progress, ang, TargetAngle)
		view.fov = Lerp(ChangeView_IIn_Progress, fov, fov*1.2)
		--如果中途松开按键等，这一段可以记录下当前视角变到了哪里，于是从当前视角位置开始淡出，而不是从过程视角位置开始淡出，让淡出更流畅
		ORag.Cur_view_angles = view.angles
		ORag.Cur_view_fov = view.fov

	------------------------------------
	--当松开按键时/复活完成/复活失败，淡出视角
	elseif ORag.ChangeView_Out_Start then

		local ChangeView_Out_ElapsedTime = CurTime() - ORag.ChangeView_Out_StartTime
		local ChangeView_Out_Progress = math.ease.InOutQuad(math.Clamp(ChangeView_Out_ElapsedTime/1, 0, 1))
		if ChangeView_Out_Progress >= 1 then 
			KeyDown_Start 	= false
			KeyDown_StartTime = 0
			KeyDown_Finish 	= false
			KeyUpup_Start 	= false
			ORag = nil
		return end
		--这里就用到了上面的 ORag.Cur_view_angles 和 ORag.Cur_view_fov
		if ORag.Cur_view_angles and ORag.Cur_view_fov then
			view.angles = LerpAngle(ChangeView_Out_Progress, ORag.Cur_view_angles, ang)
			view.fov = Lerp(ChangeView_Out_Progress, ORag.Cur_view_fov, fov)
		end

	------------------------------------
	--淡入完成后，淡出开始前（也就是复活过程中），过程视角
	else
		view.angles = TargetAngle
		view.fov = fov*1.2
		ORag.Cur_view_angles = view.angles
		ORag.Cur_view_fov = view.fov
	end

	return view
end)


--移除死亡红屏
hook.Add("HUDShouldDraw", "Animrag_RemoveDeathScreen", function( name ) 
    if (name == "CHudDamageIndicator") then 
       return false 
    end
end)
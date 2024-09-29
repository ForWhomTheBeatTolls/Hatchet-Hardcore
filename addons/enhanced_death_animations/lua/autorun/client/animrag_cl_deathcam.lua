
--玩家死亡视角相关
local CVAR_ARag_cam_enable		= CreateClientConVar("ARag_cam", "0", 0, 1)				--（0/1）是否启用第一人称死亡视角
local CVAR_ARag_cam_hair		= CreateClientConVar("ARag_hair", "0", 0, 1)			--（0/1）是否在第一人称死亡时隐藏头部
local CVAR_ARag_cam_z_axis		= CreateClientConVar("ARag_camz", "75", 0, 200)			--（NUM）第三人称死亡视角的高度


local PRag = nil
local set0 = 0 	--这俩存在的意义是为了让ScaleBone只需运行一次，而不是每时每刻都运行
local set1 = 0 	--这俩存在的意义是为了让ScaleBone只需运行一次，而不是每时每刻都运行


----------------------------------------------------------------------------------------
--玩家死亡时，开始改变摄像机位置
net.Receive("PlayerRag_StartDeathCam", function()
	local id = net.ReadInt(32)
	set0 = 0
	set1 = 0

	timer.Simple(FrameTime(), function()
		PRag = Entity(id)
		if not PRag or not IsValid(PRag) then return end
		if PRag:LookupAttachment('eyes') > 0 then
			PRag.att 		= PRag:GetAttachment(PRag:LookupAttachment('eyes'))
			PRag.ang_smooth_last 	= PRag.att.Ang
			PRag.ang_mix_last = 1
		end
	end)
end)


----------------------------------------------------------------------------------------
--玩家重生时，重置PRag
net.Receive("PlayerRag_PlayerSpawn", function()
	if net.ReadBool() then
		PRag = nil
	end
end)


----------------------------------------------------------------------------------------
--将头部以及其所有子骨骼缩放为0（用于隐藏头部模型）
local function ScaleBone_0(parent)	
	PRag:ManipulateBoneScale(parent, Vector(0,0,0))
	for _, child in pairs(PRag:GetChildBones(parent)) do
		ScaleBone_0(child)
	end
end


----------------------------------------------------------------------------------------
--将头部以及其所有子骨骼缩放为1
local function ScaleBone_1(parent)
	PRag:ManipulateBoneScale(parent, Vector(1,1,1))
	for _, child in pairs(PRag:GetChildBones(parent)) do
		ScaleBone_1(child)
	end
end


----------------------------------------------------------------------------------------
--改变DeathCam
hook.Add("CalcView", "Animrag_Cam", function(ply, pos_ply, ang_ply)

	if not IsValid(PRag) or GetViewEntity() != LocalPlayer() then return end
	if CVAR_ARag_cam_z_axis:GetInt() == 0 then return end

	------------------------------------
	--复活时显示头发
	if CVAR_ARag_cam_hair:GetBool() then
		if LocalPlayer():Alive() and not gui.IsConsoleVisible() then
			if set1 <= 120 and PRag:LookupBone("ValveBiped.Bip01_Head1") then
				ScaleBone_1(PRag:LookupBone("ValveBiped.Bip01_Head1"))
				set1 = set1 + 1
			end
		end
	end

	if LocalPlayer():Alive() then return end

	local view = {}

	if CVAR_ARag_cam_enable:GetBool() then

		------------------------------------
		--开关死亡时隐藏头发
		if CVAR_ARag_cam_hair:GetBool() then
			if set0 == 0 and PRag:LookupBone("ValveBiped.Bip01_Head1") then
				ScaleBone_0(PRag:LookupBone("ValveBiped.Bip01_Head1"))
				set0 = 1
			end
		end

		------------------------------------
		--将DeathCam放到头上
		if PRag:LookupAttachment('eyes') > 0 and PRag.ang_smooth_last then
			local pos_rag = PRag:GetAttachment(PRag:LookupAttachment('eyes')).Pos
			local ang_rag = PRag:GetAttachment(PRag:LookupAttachment('eyes')).Ang
			local ang_mix
			--当Crawl时，头能转动，当不是Crawl时，头不能转
			if PRag:GetNWInt("Animation_State") == 2 then
				ang_mix = LerpAngle(0.5, ang_rag, ang_ply)
				------------------------------------
				--让头和胸的物理骨骼跟着视角转，这样更拟真
				net.Start("PlayerRag_RotateHead")
					net.WriteAngle(ang_mix)
					net.WriteInt(PRag:EntIndex(), 32)
				net.SendToServer()
			else
				ang_mix = ang_rag
			end

			view.origin = pos_rag
			view.angles = ang_mix
		else
			------------------------------------
			--正常的第三人称死亡视角
			local rd = util.TraceLine(
				{start=PRag:GetPos(),
				endpos=PRag:GetPos()-ang_ply:Forward()*106,
				filter={PRag,LocalPlayer()}
			})
			view.origin = PRag:GetPos()-ang_ply:Forward()*(CVAR_ARag_cam_z_axis:GetInt()*rd.Fraction)
			view.angles = ang_ply
		end

	else
		------------------------------------
		--正常的第三人称死亡视角
		local rd = util.TraceLine(
			{start=PRag:GetPos(),
			endpos=PRag:GetPos()-ang_ply:Forward()*106,
			filter={PRag,LocalPlayer()}
		})
		view.origin = PRag:GetPos()-ang_ply:Forward()*(CVAR_ARag_cam_z_axis:GetInt()*rd.Fraction)
		view.angles = ang_ply
	end

	return view
end)
include("autorun/server/animrag_allconvar.lua")


local FingerTb = {
	//"ValveBiped.Bip01_L_Finger0",
	"ValveBiped.Bip01_L_Finger01",
	"ValveBiped.Bip01_L_Finger02",
	"ValveBiped.Bip01_L_Finger4",
	"ValveBiped.Bip01_L_Finger41",
	"ValveBiped.Bip01_L_Finger42",
	"ValveBiped.Bip01_L_Finger3",
	"ValveBiped.Bip01_L_Finger31",
	"ValveBiped.Bip01_L_Finger32",
	"ValveBiped.Bip01_L_Finger2",
	"ValveBiped.Bip01_L_Finger21",
	"ValveBiped.Bip01_L_Finger22",
	"ValveBiped.Bip01_L_Finger1",
	"ValveBiped.Bip01_L_Finger11",
	"ValveBiped.Bip01_L_Finger12",
	//"ValveBiped.Bip01_R_Finger0",
	"ValveBiped.Bip01_R_Finger01",
	"ValveBiped.Bip01_R_Finger02",
	"ValveBiped.Bip01_R_Finger4",
	"ValveBiped.Bip01_R_Finger41",
	"ValveBiped.Bip01_R_Finger42",
	"ValveBiped.Bip01_R_Finger3",
	"ValveBiped.Bip01_R_Finger31",
	"ValveBiped.Bip01_R_Finger32",
	"ValveBiped.Bip01_R_Finger2",
	"ValveBiped.Bip01_R_Finger21",
	"ValveBiped.Bip01_R_Finger22",
	"ValveBiped.Bip01_R_Finger1",
	"ValveBiped.Bip01_R_Finger11",
	"ValveBiped.Bip01_R_Finger12"
}


net.Receive("AnimRag_PoseFingerBone_sTc", function()
	local ORag = Entity(net.ReadInt(32))
	local ARag = Entity(net.ReadInt(32))

	if not IsValid(ORag) or not IsValid(ARag) then return end
	
	ORag:InvalidateBoneCache()
	ARag:InvalidateBoneCache()

	for _, bonename in pairs(FingerTb) do
		local boneID_ORag = ORag:LookupBone(bonename)
		local boneID_ARag = ARag:LookupBone(bonename)
		local boneID_ARag_P = ARag:GetBoneParent(boneID_ARag)

		if boneID_ORag and boneID_ARag then
			--得到该Bone与其父级Bone的Matrix
			local matrix = ARag:GetBoneMatrix(boneID_ARag)
			local matrix_P = ARag:GetBoneMatrix(boneID_ARag_P) 
			--得到该Bone相较于其父级Bone的相对Matrix
			if matrix and matrix_P then
				local matrix_Relative = matrix_P:GetInverseTR()*matrix
				--用该相对Matrix的角度来改变手指角度
				local ang_Relative = matrix_Relative:GetAngles()
				ORag:ManipulateBoneAngles(boneID_ORag, ang_Relative)
			end
		end
	end
end)
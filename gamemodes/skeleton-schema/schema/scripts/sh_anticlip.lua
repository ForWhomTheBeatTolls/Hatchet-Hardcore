local ret = "other"
function meta:GetPlayerGunHoldType()
	if self:GetActiveWeapon().HoldType == nil then
		return "other"
	else
		return self:GetActiveWeapon().HoldType
	end
end

local holdtypes = {
		["pistol"] = Vector(0,0,30),
		["smg"] = Vector(5,-8,15),
		["shotgun"] = Vector(0,0,20),
		["revolver"] = Vector(0,0,10),
		["fists"] = Vector(0,0,0),
		["other"] = Vector(0,0,0),
		["normal"] = Vector(0,0,20),
		["ar2"] = Vector(5,-8,15)
	}
	
local holdtypes_alt = {
		["pistol"] = Vector(0,0,30),
		["smg"] = Vector(-12,-6,25),
		["shotgun"] = Vector(0,0,0),
		["revolver"] = Vector(0,0,0),
		["fists"] = Vector(0,0,0),
		["other"] = Vector(0,0,0),
		["normal"] = Vector(0,0,0),
		["ar2"] = Vector(5,-8,15)
	}

local holdtypes_cor = {
	["pistol"] = 50,
	["smg"] = 80,
	["shotgun"] = 50,
	["revolver"] = 50,
	["fists"] = 50,
	["other"] = 50,
	["normal"] = 50,
	["ar2"] = 80
	}
	
local holdtypes_easenum = {
	["pistol"] = 2,
	["smg"] = 2.5,
	["shotgun"] = 3,
	["revolver"] = 6,
	["fists"] = 10,
	["other"] = 10,
	["normal"] = 10,
	["ar2"] = 10
	}
	

hook.Add("Think", "HatchetAvoidArmClipping", function()
	
	for _,ply in pairs(player.GetAll()) do
		
		lclavm = ply:LookupBone("ValveBiped.Bip01_L_Clavicle")
		rclavm = ply:LookupBone("ValveBiped.Bip01_R_Clavicle")
		
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil then continue end
		
		if !IsValid(ply:GetActiveWeapon()) or (ply:GetPlayerGunHoldType() == "normal") then 
			continue
		end
		
		chbone = ply:LookupBone("ValveBiped.Bip01_Pelvis")
		chmatrix = ply:GetBoneMatrix(chbone)
		chpos = chmatrix:GetTranslation()
		
		gunmodifstart = 10
		gunmodifend = holdtypes_cor[ply:GetPlayerGunHoldType()]
		
		gunmodifang_x = holdtypes[ply:GetPlayerGunHoldType()].x
		gunmodifang_y = holdtypes[ply:GetPlayerGunHoldType()].y
		gunmodifang_z = holdtypes[ply:GetPlayerGunHoldType()].z
		
		gunmodifang_alt_x = holdtypes_alt[ply:GetPlayerGunHoldType()].x
		gunmodifang_alt_y = holdtypes_alt[ply:GetPlayerGunHoldType()].y
		gunmodifang_alt_z = holdtypes_alt[ply:GetPlayerGunHoldType()].z
		
		plyloceyeang = ply:LocalEyeAngles()
		plyeyeang = ply:EyeAngles()
		
		plyposandbounds = Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z + 50)
		plyposandbounds2 = plyposandbounds + (Angle(0, ply:LocalEyeAngles().y, 0):Forward() * gunmodifend)
		
		tr3_start = plyposandbounds
		tr3_endpos = plyposandbounds2
		--tr3_endpos = plyposandbounds + ply:LocalEyeAngles():Forward() * gunmodifend
		
		local tr3 = util.TraceLine( {
		start = tr3_start,
		endpos =  tr3_endpos,
		filter = ply
		} )
		
		local modifangr = Angle(gunmodifang_x, gunmodifang_y, gunmodifang_z) - (Angle(gunmodifang_x, gunmodifang_y, gunmodifang_z) * (1 / tr3.Fraction))
		local modifangl = Angle(-gunmodifang_alt_x,-gunmodifang_alt_y,-gunmodifang_alt_z) - (Angle(-gunmodifang_alt_x,-gunmodifang_alt_y,-gunmodifang_alt_z) * (1 / tr3.Fraction))
		local az = Angle(0,0,0)
		
		-- if SERVER then
		--print(modifangr)
		--print(modifangl)
		-- end
		
		if tr3.Hit and ply:IsWeaponRaised() == true then
			coltr3 = Color(200, 0, 0, 122)
			
			if 	(math.abs(modifangr.x) + math.abs(modifangr.y) + math.abs(modifangr.z)) > 300 then
				return
			end
			
			ply:ManipulateBoneAngles(rclavm, modifangr, false)
			ply:ManipulateBoneAngles(lclavm, modifangl, false)
			-- if SERVER then
			-- --print(modifangr)
			-- --print(modifangl)
			-- print(math.abs(modifangr.x) + math.abs(modifangr.y) + math.abs(modifangr.z))
			-- end
			
		else
			coltr3 = Color(0, 200, 0, 122)
			
			ply:ManipulateBoneAngles(rclavm, Angle(math.Approach(ply:GetManipulateBoneAngles(rclavm).x, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()]), math.Approach(ply:GetManipulateBoneAngles(rclavm).y, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()]),math.Approach(ply:GetManipulateBoneAngles(rclavm).z, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()])), false)	
			ply:ManipulateBoneAngles(lclavm, Angle(math.Approach(ply:GetManipulateBoneAngles(lclavm).x, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()]), math.Approach(ply:GetManipulateBoneAngles(lclavm).y, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()]),math.Approach(ply:GetManipulateBoneAngles(lclavm).z, 0, holdtypes_easenum[ply:GetPlayerGunHoldType()])), false)
			
		end
		
		tr3_hitpos = tr3.HitPos
		
	end
	
end)	

-- if CLIENT then
-- hook.Add("HUDPaint", "HatchetAvoidArmClippingHUD", function()
	
	-- cam.Start3D()
		-- render.SetColorMaterial()
		-- render.DrawLine( tr3_start, tr3_hitpos, coltr3, true )
	-- cam.End3D()
	
-- end)
-- end

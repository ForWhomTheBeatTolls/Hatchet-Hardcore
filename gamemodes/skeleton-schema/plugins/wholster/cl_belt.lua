local nextbeltthink = CurTime()
local beltData = {
	["m_usp"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_pistol.mdl",
			pos = Vector(1.6, 2, -7.2),
			ang = Angle(88, 102, -8),
			scale = 1
		}
	},
	["m_rev"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_357.mdl",
			pos = Vector(-4, -7, 0),
			ang = Angle(-90, -90, 90),
			scale = 1
		}
	},
	["m_smg"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/weapons/w_smg1.mdl",
			pos = Vector(2.5, 10, 1),
			ang = Angle(195, 0, 150),
			scale = 0.88
		}
	},
	["m_ar2"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/weapons/w_irifle.mdl",
			pos = Vector(4.8, 12, -6),
			ang = Angle(195, -5, 150),
			scale = 0.88
		}
	},
	["m_ak47"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/weapons/w_rif_ak47.mdl",
			pos = Vector(5, 6, -2.5),
			ang = Angle(195, 0, 150),
			scale = 0.88
		}
	},
	["ls_axe"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/props_forest/axe.mdl",
			pos = Vector(4, 5, 0),
			ang = Angle(90, 0, 60),
			scale = 0.88
		}
	},
	["ls_crowbar"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/weapons/w_crowbar.mdl",
			pos = Vector(4, 5, 0),
			ang = Angle(0, 0, 25),
			scale = 0.88
		}
	},
	["ls_cleaver"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/props_lab/cleaver.mdl",
			pos = Vector(4, 10, 0),
			ang = Angle(0, 5, -25),
			scale = 0.88
		}
	},
	["ls_pipe"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/props_canal/mattpipe.mdl",
			pos = Vector(4, 0, 0),
			ang = Angle(0, 0, 75),
			scale = 0.88
		}
	},
	["ls_pickaxe"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/props_mining/pickaxe01.mdl",
			pos = Vector(3.5, 25, -10),
			ang = Angle(0, 10, 60),
			scale = 0.88
		}
	},
	["m_shotgun"] = {
		Bone = "ValveBiped.Bip01_Spine1",
		Data = {
			model = "models/weapons/w_shotgun.mdl",
			pos = Vector(3.5, 5, 0),
			ang = Angle(0, 10, -390),
			scale = 0.88
		}
	}
}

local LocalPlayer = LocalPlayer
local pairs = pairs
local IsValid = IsValid
local function beltCheck(ent, isPanel)
	local ply = isPanel and LocalPlayer() or ent
	local weps = ply.GetWeapons(ply)
	local active = ply.GetActiveWeapon(ply)
	local activeClass = IsValid(active) and active:GetClass() or nil

	ply.BeltCos = ply.BeltCos or {}

	for v,k in pairs(ply.BeltCos) do
		if not ply:HasWeapon(v) then
			RemoveCosmetic(ply, ply, "belt_"..v)
			ply.BeltCos[v] = nil
		end
	end

	for v,k in pairs(weps) do
		local class = k.GetClass(k)
		local beltId = "belt_"..class

		if not beltData[class] then
			continue
		end

		if activeClass and activeClass == class then
			if ply.Cosmetics and ply.Cosmetics[beltId] then
				RemoveCosmetic(ply, ply, beltId)
				ply.BeltCos[class] = nil
			end

			continue
		end

		--if not ply.Cosmetics or not ply.Cosmetics[beltId] then
			MakeCosmetic(ply, nil, beltData[class].Bone, beltData[class].Data, beltId)
			ply.BeltCos[class] = true
		--end
	end
end

function PLUGIN:PostPlayerDraw(ply)
if nextbeltthink < CurTime() then
	if not ply.Alive(ply) or ply == LocalPlayer() then 
		if ply.BeltCos then
			for v,k in pairs(ply.BeltCos) do
				RemoveCosmetic(ply, ply, "belt_"..v)
			end

			ply.BeltCos = nil
		end

		return 
	end

	beltCheck(ply)
	nextbeltthink = CurTime() + 1
end
end

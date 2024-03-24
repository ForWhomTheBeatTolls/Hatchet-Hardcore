local VENDOR = {}

VENDOR.UniqueID = "cpreq"
VENDOR.Name = "Requisition Supply Officer"
VENDOR.Desc = "Can supply Civil Protection officers with equipment."

VENDOR.Model = "models/props_c17/Lockers001a.mdl"
VENDOR.Skin = 0
--VENDOR.Bodygroups = "01" -- manhack
VENDOR.Gender = "cp" -- male, female, cp
VENDOR.Talk = false

VENDOR.Sell = {
	["ammo_pistol"] = {
		Restricted = true,
		Max = 6,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_I3 and ply:HasInventoryItem("wep_pistol")
		end
	},
	["ammo_smg"] = {
		Restricted = true,
		Max = 6,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_GUNNER
		end
	},
	["util_ziptie"] = {
		Restricted = true,
		Max = 4
	},
	["item_healthkit"] = {
		Desc = "i2+ only.",
		Restricted = true,
		Max = 1,
		Cooldown = 10,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_I1 and !ply:HasInventoryItem("item_healthvial")
		end
	},
	["item_healthvial"] = {
		Desc = "I3+ only.",
		Restricted = true,
		Max = 1,
		CanBuy = function(ply)
			if ply:GetTeamRank() >= RANK_I2 and !ply:HasInventoryItem("item_healthkit") then
				return true
			end

			return false
		end
	},
	["wep_smg"] = {
		Desc = "Gunner only",
		Restricted = true,
		Max = 1,
		Cooldown = 10,
		CanBuy = function(ply)
			if ply:GetTeamRank() >= RANK_I1 then
				return true
			end

			return false
		end
	},
		["wep_pistol"] = {
		Desc = "i3+ only",
		Restricted = true,
		Max = 1,
		Cooldown = 10,
		CanBuy = function(ply)
			if (ply:GetTeamRank() >= RANK_I3 and ply:GetTeamClass() == CLASS_UNION) then
				return true
			end
			
			return false
		end
	},
}


VENDOR.Buy = {}

function VENDOR:CanUse(ply)
	return ply:Team() == TEAM_CP and ply:GetTeamClass() != nil
end

-- function VENDOR:OnItemPurchased(class, ply)
	-- if class == "med_kit" and ply:HasInventoryItem("med_vial") then
		-- ply:TakeInventoryItemClass("med_vial")
	-- end
	-- if class == "med_vial" and ply:HasInventoryItem("med_kit") then
		-- ply:TakeInventoryItemClass("med_kit")
	-- end
-- end

impulse.RegisterVendor(VENDOR)
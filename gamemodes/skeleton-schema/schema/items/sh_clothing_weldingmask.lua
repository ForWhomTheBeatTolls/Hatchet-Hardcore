local ITEM = {}

ITEM.UniqueID = "clothing_weldmask"
ITEM.Name = "Welding Mask"
ITEM.Desc =  "A heavy metal mask used by welders to prevent sparks from entering their eyes."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 21.796561604585
ITEM.CamPos = Vector(-39.426933288574, -2.7507164478302, -75.64469909668)
ITEM.NoCenter = true
ITEM.Weight = 5


ITEM.Droppable = true
ITEM.DropOnDeath = true
ITEM.Illegal = true

ITEM.Equipable = true

ITEM.EquipGroup = "head"

ITEM.CanStack = false



ITEM.CosmeticData = {
    model = Model("models/props_silo/welding_helmet.mdl"),
    pos = Vector(0, -1, 0),
    ang = Angle(90, 180, 270),
    scale = 1.1,
    femalePos = Vector(2.75, -1.1, 0),
    femaleScale = 1
}




impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse

impulse.Cosmetics[8] = ITEM.CosmeticData



function ITEM:CanEquip(ply)

	return not ply:IsCP()

end



function ITEM:OnEquip(ply)
    ply.WeldingMask = true
	ply:SetSyncVar(SYNC_COS_HEAD, 8, true)
	ply.HasFaceCover = true
end



function ITEM:UnEquip(ply)
    ply.WeldingMask = true
	ply:SetSyncVar(SYNC_COS_HEAD, nil, true)
	ply.HasFaceCover = false
end
-- hook.Add("EntityTakeDamage", "WeldingMaskDamageReduction", function(target, dmginfo)
      -- if target:IsPlayer() and target:GetNWBool("equipped_weldingmask") and if (target:IsPlayer() and dmginfo:IsBulletDamage()) and ( hitgroup == HITGROUP_HEAD ) then 
      -- dmginfo:SetDamage(dmg * 0.5) -- Reduce damage by 50%, hopefully.
    -- end
-- end) 


impulse.RegisterItem(ITEM)
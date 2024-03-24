function util.PaintDown(start, effname, ignore)
	local btr = util.TraceLine({start=start, endpos=(start + Vector(0,0,-256)), mask=CONTENTS_SOLID})

	util.Decal(effname, btr.HitPos+btr.HitNormal, btr.HitPos-btr.HitNormal)
end

function corpsebleedttt(ent)
   if not IsValid(ent) then
      return
   end

   local jitter = VectorRand() * 30
   jitter.z = 20

   
   if ent:GetBoneSurfaceProp(0) == "flesh" then
   util.PaintDown(ent:GetPos() + jitter, "Blood", ent)
   elseif ent:GetBoneSurfaceProp(0) == "zombieflesh" then
   util.PaintDown(ent:GetPos() + jitter, "YellowBlood", ent)
   elseif ent:GetBoneSurfaceProp(0) == "alienflesh" then
   util.PaintDown(ent:GetPos() + jitter, "YellowBlood", ent)
   end
end

  
hook.Add("OnEntityCreated", "corpsestartbleedttt", function(ent)
--	local times = math.Clamp(math.Round(dmg / 15), 1, 20)
--	local delay = math.Clamp(t / times , 0.1, 2)
   
	if ( ent:GetClass() == "prop_ragdoll" ) then
	timer.Create("bleed" .. ent:EntIndex(), 4, 12,
    function() corpsebleedttt(ent) end)
	end
end)
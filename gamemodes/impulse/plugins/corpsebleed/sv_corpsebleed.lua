function util.PaintDown(start, effname, ignore)

	local btr = util.TraceLine({
	
	start=start, 
	endpos=(start + Vector(0,0,-456)),
	filter = Entity(0)
	--mask=CONTENTS_SOLID
	})

	util.Decal(effname, start, btr.HitPos)
	
end

function util.BleedDecal(start, ply, isbleed)
	local trace = util.TraceLine({
                        start = start + Vector(math.random(-10,12),math.random(-10,12),2),
                        endpos = start - Vector(0, 0, 500),
                        filter = ply
                    })

        if trace.HitWorld or trace.Hit then
			local rtd = math.random(1,2)
			if rtd == 1 then
				util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, ply)
			else
				util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
			end
			if isbleed then
				EmitSound("ambient/water/rain_drip"..math.random(1,4)..".wav", trace.HitPos + trace.HitNormal, 0, CHAN_AUTO, 0.7, 65, 0, math.random(45,80))
			end
        end
end

function util.GetPaintDownPos(start, effname, ignore)

	local btr = util.TraceLine({start=start, endpos=(start + Vector(0,0,-256)), mask=CONTENTS_SOLID})
	
	return btr.HitPos-btr.HitNormal
	
end

function corpsebleedttt(ent)
   if not IsValid(ent) then
      return
   end

   -- local jitter = VectorRand() * 30
   -- jitter.z = 20

   
   -- if ent:GetBoneSurfaceProp(0) == "flesh" then
   -- util.PaintDown(ent:GetPos() + jitter, "Blood", ent)
   -- elseif ent:GetBoneSurfaceProp(0) == "zombieflesh" then
   -- util.PaintDown(ent:GetPos() + jitter, "YellowBlood", ent)
   -- elseif ent:GetBoneSurfaceProp(0) == "alienflesh" then
   -- util.PaintDown(ent:GetPos() + jitter, "YellowBlood", ent)
   -- end
   
	util.BleedDecal(ent:GetPos() + Vector(0,0,5), ent, false)
end

  
hook.Add("OnEntityCreated", "corpsestartbleedttt", function(ent)
--	local times = math.Clamp(math.Round(dmg / 15), 1, 20)
--	local delay = math.Clamp(t / times , 0.1, 2)
   
	if ( ent:GetClass() == "prop_ragdoll" ) then
	timer.Create("bleed" .. ent:EntIndex(), 4, 12,
    function() corpsebleedttt(ent) end)
	end
end)

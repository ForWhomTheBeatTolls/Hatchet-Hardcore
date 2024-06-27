	local NPCRelations = {
		npc_citizen = {citizen = D_NU,
					   combine = D_HT,
					   antlion = D_HT,
					   zombies = D_HT},
		npc_metropolice = {citizen = D_HT,
						   combine = D_NU,
						   antlion = D_HT,
						   zombies = D_HT},
		npc_antlion = {citizen = D_HT,
					   combine = D_HT,
					   antlion = D_NU,
					   zombies = D_HT},
		npc_zombie = {citizen = D_HT,
					  combine = D_HT,
					  antlion = D_HT,
					  zombies = D_NU}
	}
	local RecognizedEnts = setmetatable({},{__mode = 'k'})
	
	local NPCTypes = {citizen = "npc_citizen", combine = "npc_metropolice", antlion = "npc_antlion", zombies = "npc_zombie"}
	
	
	
	local function NPCSpawned(ent)
		local r = NPCRelations[ent:GetClass()]
		if not r then
			r = {}
			for k,v in pairs(NPCTypes) do
				local e = ents.Create(v)
				e:Spawn()
				local n = ent:Disposition(e)
				e:Remove()
				r[k]=n
			end
			NPCRelations[ent:GetClass()] = r
		end
			
		--if r then for k,v in pairs(r) do print(k,v) end end
	end
	
	
	local function OnTick()
		for k,v in pairs(ents.FindByClass("npc_*")) do
			if v:IsNPC() then
				if not RecognizedEnts[v] then
					NPCSpawned(v)
					RecognizedEnts[v] = true
				end

				for k,ply in pairs(player.GetAll()) do
					if ply:IsValid() then
						local inf = GetPlayerFaction(ply)
						local r
						if inf == "nobody" then
							r = D_HT
						elseif inf == "zombies" then
							r = D_HT
						elseif inf == "citizen" and ply.IsInCombat == true then
							r = D_HT
						elseif inf == "citizen" and v:GetClass() == "npc_metropolice" or v:GetClass() == "npc_combine_s" then
							r = D_NU
						else
							r = NPCRelations[v:GetClass()][inf] or D_NU
						end
						v:AddEntityRelationship(ply,r,0)
					end
				end
			end
		end
	end
	
	function GetPlayerFaction(ply)
		if (ply:Team() == TEAM_CITIZEN) or (ply:Team() == TEAM_WORKFORCE) then	
			return "citizen"
		elseif ply:IsCP() then
			return "combine"
		else
			return "zombies"
		end
	end

	hook.Add("Tick","NPCRelation",OnTick)

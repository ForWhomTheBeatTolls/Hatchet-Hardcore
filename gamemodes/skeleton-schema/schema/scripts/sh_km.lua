local plymeta = FindMetaTable("Player")
if not plymeta then return end

local entmeta = FindMetaTable("Entity")
if not entmeta then return end

local plymeta = FindMetaTable("Player")
if not plymeta then return end

if SERVER then	
	--util.AddNetworkString("showhint")
	util.AddNetworkString("setkillmovable")
	util.AddNetworkString("removedecals")
	util.AddNetworkString("debugbsmodcalcview")
	
	--A list that a player/npc must have to be killmovable (highlighted blue)
	if !killMovableBones then killMovableBones = {"ValveBiped.Bip01_Spine", "MiniStrider.body_joint"} end
	if !killMovableEnts then killMovableEnts = {} end
	
	local setters = {}
	local setterCount = 0
	
	function entmeta:SetKillMovable(value)
		if value then
			if self.killMovable then return end
			
			--Hunters are called MiniStriders internally for some reason
		else
			if !self.killMovable then return end
			
			if self.IsVJBaseSNPC then
				self:SetState(VJ_STATE_NONE)
			elseif self:IsNPC() then
				self:SetCondition(68)
				self:SetNPCState(NPC_STATE_IDLE)
			end
		end
		
		self.killMovable = value
		
		--[[setters[self] = value
		setterCount = setterCount + 1]]
		
		--self:Say("I am set to killMovable")
		
		net.Start("setkillmovable")
		net.WriteEntity(self)
		net.WriteBool(value)
		net.Broadcast()
	end
	
	hook.Add( "CreateEntityRagdoll", "BSModCreateEntityRagdoll", function(entity, ragdoll)
		if !IsValid(entity.kmModel) or !IsValid(entity) or !IsValid(ragdoll) then return end
		
		for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
			local bone = ragdoll:GetPhysicsObjectNum(i)
			
			if bone and bone:IsValid() then
				local bonepos, boneang = entity.kmModel:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
				
				bone:SetPos(bonepos, true)
				bone:SetAngles(boneang)
				bone:SetVelocity(vector_origin)
			end
		end
		
		hook.Run("KMRagdoll", entity, ragdoll, entity.kmAnim:GetSequenceName(entity.kmAnim:GetSequence()))
	end)
	
	
	function PlayRandomSound(ent, min, max, snd)
		local rand = math.random(min, max)
		
		ent:EmitSound("" .. snd .. rand .. ".wav", 100, 100, 0.5, CHAN_AUTO )
	end
	
	function entmeta:GetHeadBone()
		return self:LookupBone("ValveBiped.Bip01_Head1") or self:LookupBone("ValveBiped.HC_Body_Bone") or self:LookupBone("ValveBiped.HC_BodyCube") or self:LookupBone("ValveBiped.Headcrab_Cube1")
	end
	
	function plymeta:DoKMEffects(animName, plyModel, targetModel)
		
		local headBone = nil
		
		if IsValid (targetModel) then headBone = targetModel:GetHeadBone() end
		
		if animName == "killmove_front_1" then
			timer.Simple(0.3, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 5, "player/killmove/km_hit")
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
			
			timer.Simple(0.8, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 1, "player/killmove/km_punch")
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
		elseif animName == "killmove_front_2" then
			timer.Simple(0.25, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 5, "player/killmove/km_hit")
			end)
			
			timer.Simple(0.45, function()
				if !IsValid(targetModel) then return end
				
				if plyModel:LookupBone("ValveBiped.Bip01_R_Foot") then
					local effectdata = EffectData()
					effectdata:SetOrigin(plyModel:GetBonePosition(plyModel:LookupBone("ValveBiped.Bip01_R_Foot")))
					util.Effect("BloodImpact", effectdata)
				end
			end)
			
			timer.Simple(1, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 2, "player/killmove/km_gorehit")
			end)
			
			timer.Simple(1.1, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
		elseif animName == "killmove_hunter_front_1" then
			
			timer.Simple(0.5, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 1, "player/killmove/km_grapple")
			end)
			
			timer.Simple(1.3, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 3, "player/killmove/km_stabin")
				PlayRandomSound(self, 1, 2, "player/killmove/km_gorehit")
				PlayRandomSound(self, 1, 2, "npc/ministrider/hunter_foundenemy")
			end)
			
			timer.Simple(2, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 2, "player/killmove/km_stabout")
			end)
		elseif animName == "killmove_front_air_1" then
			timer.Simple(0.25, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 5, "player/killmove/km_hit")
			end)
			
			timer.Simple(1, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 2, "player/killmove/km_gorehit")
			end)
			
			timer.Simple(1.25, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
		elseif animName == "killmove_left_1" then
			timer.Simple(0.3, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 1, "player/killmove/km_punch")
			end)
			
			timer.Simple(0.325, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(plyModel:GetBonePosition(plyModel:LookupBone("ValveBiped.Bip01_R_Foot")))
					util.Effect("BloodImpact", effectdata)
				end
			end)
			
			timer.Simple(1, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 2, "player/killmove/km_gorehit")
			end)
			
			timer.Simple(1.15, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
		elseif animName == "killmove_right_1" then
			timer.Simple(0.2, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 5, "player/killmove/km_hit")
			end)
			
			timer.Simple(0.35, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
			
			timer.Simple(0.8, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 1, "player/killmove/km_punch")
			end)
			
			timer.Simple(1.0, function()
				if !IsValid(targetModel) then return end
				
				if headBone != nil then
					local effectdata = EffectData()
					effectdata:SetOrigin(targetModel:GetBonePosition(headBone))
					util.Effect("BloodImpact", effectdata)
				end
			end)
			
		elseif animName == "killmove_back_1" then
			timer.Simple(0.5, function()
				if !IsValid(targetModel) then return end
				
				PlayRandomSound(self, 1, 3, "player/killmove/km_bonebreak")
			end)
		end
		
		hook.Run("CustomKMEffects", self, animName, targetModel)
	end
	
	function KMCheck(ply)
		if ply.inKillMove then return false end
		
		local tr = util.TraceLine( {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:EyeAngles():Forward() * 100,
			filter = ply
		} )
		
		if !IsValid(tr.Entity) then
			tr = util.TraceHull( {
				start = ply:EyePos(),
				endpos = ply:EyePos() + ply:EyeAngles():Forward() * 100,
				filter = ply,
				mins = Vector( -1, -1, -1 ),
				maxs = Vector( 1, 1, 1 ),
			} )
		end
		
		if !IsValid(tr.Entity) then return false end
		
		local target = tr.Entity
		
		if !target:IsPlayer() and !target:IsNPC() and !target:IsNextBot() then return false end
		
		if ply.inKillMove or ply:Health() <= 0 or target.inKillMove or target == ply then return false end
		
		if target:IsPlayer() then
			-- if GetConVar( "bsmod_killmove_enable_players" ):GetInt() == 0 or target:HasGodMode() then return false end 
			-- if engine.ActiveGamemode() != "sandbox" and GetConVar( "bsmod_killmove_enable_teammates" ):GetInt() == 0 then if target:Team() == ply:Team() then return false end end
		end
		
		
		local vec = ( ply:GetPos() - target:GetPos() ):GetNormal():Angle().y
		local targetAngle = target:EyeAngles().y
		
		if targetAngle > 360 then
			targetAngle = targetAngle - 360
		end
		if targetAngle < 0 then
			targetAngle = targetAngle + 360
		end
		
		local angleAround = vec - targetAngle
		
		if angleAround > 360 then
			angleAround = angleAround - 360
		end
		if angleAround < 0 then
			angleAround = angleAround + 360
		end
		
		-- if GetConVar( "bsmod_killmove_anytime" ):GetInt() == 0 then
			-- if GetConVar( "bsmod_killmove_anytime_behind" ):GetInt() == 0 then 
				-- if !target.killMovable then
					-- return false 
				-- end
			-- elseif !target.killMovable and !(angleAround > 135 and angleAround <= 225) then
				-- return false
			-- end
		-- end
		
		--print ("target eye angles", targetAngle, "angle to target", vec, "the sum thing", angleAround)
		
		--Setup killmove values
		
		local plyKMModel = ""
		local targetKMModel = ""
		local animName = ""
		local plyKMPosition = nil
		local plyKMAngle = nil
		local plyKMTime = nil
		local targetKMTime = nil
		local moveTarget = false
		
		--Custom killmove hook
		local customKMData = hook.Run("CustomKillMoves", ply, target, angleAround)
		
		if customKMData then
			if customKMData[1] != nil then plyKMModel = customKMData[1] end
			if customKMData[2] != nil then targetKMModel = customKMData[2] end
			if customKMData[3] != nil then animName = customKMData[3] end
			if customKMData[4] != nil then plyKMPosition = customKMData[4] end
			if customKMData[5] != nil then plyKMAngle = customKMData[5] end
			if customKMData[6] != nil then plyKMTime = customKMData[6] end
			if customKMData[7] != nil then targetKMTime = customKMData[7] end
			if customKMData[8] != nil then moveTarget = customKMData[8] end
		end
		
		--Default killmoves
		-- if animName == "" then
			-- plyKMModel = "models/weapons/c_limbs.mdl"
			
			-- if target:LookupBone("ValveBiped.Bip01_Spine") then
				-- targetKMModel = "models/bsmodimations_human.mdl"
				
				-- if angleAround <= 45 or angleAround > 315 then
					-- if ply:OnGround() then
						-- --if ply:EyeAngles().x <= 30 then]]
							-- animName = "killmove_front_" .. math.random(1, 2)
						-- --end
						
						-- if animName == "killmove_front_1" then targetKMTime = 1.15 end
					-- else
						-- animName = "killmove_front_air_1"
					-- end
				-- end
				
				-- if angleAround > 45 and angleAround <= 135 then
					-- animName = "killmove_left_1"
				-- end
				
				-- if angleAround > 135 and angleAround <= 225 then
					-- animName = "killmove_back_1"
				-- end
				
				-- if angleAround > 225 and angleAround <= 315 then
					-- animName = "killmove_right_1"
				-- end
			-- elseif target:LookupBone("MiniStrider.body_joint") then
				-- targetKMModel = "models/bsmodimations_hunter.mdl"
				
				-- animName = "killmove_hunter_front_1"
			-- end
			
			-- if animName == "killmove_left_1" then
				-- plyKMPosition = target:GetPos() + (-target:GetRight() * 31.5 )
			-- elseif animName == "killmove_right_1" then
				-- plyKMPosition = target:GetPos() + (target:GetRight() * 95) + (target:GetForward() * 10)
				-- plyKMAngle = (-target:GetRight()):Angle()
			-- elseif animName == "killmove_back_1" then
				-- plyKMPosition = target:GetPos() + (-target:GetForward() * 30 )
			-- elseif animName == "killmove_front_1" then
				-- plyKMPosition = target:GetPos() + (target:GetForward() * 31.5 )
			-- elseif animName == "killmove_front_2" then
				-- plyKMPosition = target:GetPos() + (target:GetForward() * 29 )
			-- elseif animName == "killmove_front_air_1" then
				-- plyKMPosition = target:GetPos() + (target:GetForward() * 39 )
			-- elseif animName == "killmove_hunter_front_1" then
				-- plyKMPosition = target:GetPos() + (target:GetForward() * 31.5 )
			-- end
		-- end
		
		ply:KillMove(target, animName, plyKMModel, targetKMModel, plyKMPosition, plyKMAngle, plyKMTime, targetKMTime, moveTarget)
		
		return true
	end
	
	concommand.Add("bsmod_killmove", KMCheck)
	
	--Now this function has a lot of arguments but that's cuz custom killmoves will use them, nothing else I can do :P
	function plymeta:KillMove(target, animName, plyKMModel, targetKMModel, plyKMPosition, plyKMAngle, plyKMTime, targetKMTime, moveTarget)
		if plyKMModel == "" or targetKMModel == "" or animName == "" then return end
		
		if self.inKillMove or self:Health() <= 0 or !IsValid(target) or target.inKillMove or target == self then return end
		
		--End of return checks
		
		-- net.Start("debugbsmodcalcview")
		-- net.Broadcast()
		
		self.inKillMove = true
		
		local tempSelf
		local tempTarget
		
		--Reverse player and target identifiers if target is set to move instead
		if moveTarget then 
			tempSelf = target
			tempTarget = self
		else
			tempSelf = self
			tempTarget = target
		end
		
		
		tempSelf:SetPos(tempTarget:GetPos() + (tempTarget:GetForward() * 40 ))
		
		if plyKMPosition != nil then
			tempSelf:SetPos(plyKMPosition)
		end
		
		--Set the player to look at the tempTarget by default
		tempSelf:SetAngles((Vector (tempTarget:GetPos().x, tempTarget:GetPos().y, 0) - Vector (tempSelf:GetPos().x, tempSelf:GetPos().y, 0)):Angle())
		if tempSelf:IsPlayer() then tempSelf:SetEyeAngles((Vector (tempTarget:GetPos().x, tempTarget:GetPos().y, 0) - Vector (tempSelf:GetPos().x, tempSelf:GetPos().y, 0)):Angle()) end
		
		--Override the default angle if a custom one is set
		if plyKMAngle != nil then
			tempSelf:SetAngles(plyKMAngle)
			if tempSelf:IsPlayer() then tempSelf:SetEyeAngles(plyKMAngle) end
		end
		
		local prevWeapon = nil
		local prevGodMode = self:HasGodMode()
		local prevMaterial = self:GetMaterial()
		
		if IsValid(self:GetActiveWeapon()) then
			prevWeapon = self:GetActiveWeapon()
		end
		
		if self.killMovable then self:SetKillMovable(false) end
		
		self:Lock()
		self:SetVelocity(-self:GetVelocity())
		self:SetMaterial("null")
		self:DrawShadow( false )
		
		self:RemoveAllDecals()			
		
		--Spawn the players animation model
		
		if IsValid(self.kmAnim) then self.kmAnim:Remove() end
		
		self.kmAnim = ents.Create("m_km")
		self.kmAnim:SetPos(self:GetPos())
		self.kmAnim:SetAngles(self:GetAngles())
		self.kmAnim:SetModel(plyKMModel)
		self.kmAnim:SetOwner(self)
		
		for i = 0, self:GetBoneCount() - 1 do 
			 local bone = self.kmAnim:LookupBone(self:GetBoneName(i))
			if bone then
				self.kmAnim:ManipulateBonePosition(bone, self:GetManipulateBonePosition(i))
				self.kmAnim:ManipulateBoneAngles(bone, self:GetManipulateBoneAngles(i))
				self.kmAnim:ManipulateBoneScale(bone, self:GetManipulateBoneScale(i))
			end
		end
		
		self.kmAnim:SetModelScale(self:GetModelScale())
		
		self.kmAnim:Spawn()
		
		--Spawn the players model and bonemerge it to the animation model
		
		if IsValid(self.kmModel) then self.kmModel:Remove() end
		
		self.kmModel = ents.Create("m_km")
		self.kmModel:SetPos(self:GetPos())
		self.kmModel:SetAngles(self:GetAngles())
		self.kmModel:SetModel(self:GetModel())
		self.kmModel:SetSkin(self:GetSkin())
		self.kmModel:SetColor(self:GetColor())
		self.kmModel:SetMaterial(prevMaterial)
		self.kmModel:SetRenderMode(self:GetRenderMode())
		self.kmModel:SetOwner(self)
		
		if IsValid(self:GetActiveWeapon()) then self.kmModel.Weapon = self:GetActiveWeapon() end
		
		for i, bodygroup in pairs(self:GetBodyGroups()) do
			self.kmModel:SetBodygroup(bodygroup.id, self:GetBodygroup(bodygroup.id))
		end
		
		for i, ent in ipairs(self:GetChildren()) do 
			ent:SetParent(self, ent:GetParentAttachment()) 
			ent:SetLocalPos(vector_origin)
			ent:SetLocalAngles(angle_zero)
		end 
		
		self.kmModel.maxKMTime = plyKMTime
		self.kmModel:Spawn()
		
		self.kmModel:AddEffects(EF_BONEMERGE)
		self.kmModel:SetParent(self.kmAnim)
		
		self:Give("ls_km")
		
		if IsValid(self:GetActiveWeapon()) then
			if self:GetActiveWeapon():GetClass() != "ls_unarmed" then
				self:SelectWeapon("ls_km")
			end
		end
		
		------------------------------------------------------------------------------------------
		
		local prevTMaterial = target:GetMaterial()
		
		target:SetKillMovable(false)
		target.inKillMove = true
		
		if target:IsPlayer() then
			target:SetMaterial("null")
		else
			target:SetNoDraw(true)
		end
		
		target:DrawShadow( false )
		
		target:RemoveAllDecals()
		
		if target:IsNPC() then
			target:SetCondition(67)
			target:SetNPCState(NPC_STATE_NONE)
		elseif target:IsPlayer() then
			--target:DrawWorldModel(false)
			--target:StripWeapons()
			target:Lock()
			self:SetVelocity(-self:GetVelocity())
		end
		
		--Now for the targets animation model
		
		if IsValid(target.kmAnim) then target.kmAnim:Remove() end
		
		target.kmAnim = ents.Create("m_km")
		target.kmAnim:SetPos(target:GetPos())
		target.kmAnim:SetAngles(target:GetAngles())
		target.kmAnim:SetModel(targetKMModel)
		target.kmAnim:SetOwner(target)
		
		for i = 0, target:GetBoneCount() - 1 do 
			 local bone = target.kmAnim:LookupBone(target:GetBoneName(i))
			if bone then
				target.kmAnim:ManipulateBonePosition(bone, target:GetManipulateBonePosition(i))
				target.kmAnim:ManipulateBoneAngles(bone, target:GetManipulateBoneAngles(i))
				target.kmAnim:ManipulateBoneScale(bone, target:GetManipulateBoneScale(i))
			end
		end
		
		target.kmAnim:SetModelScale(target:GetModelScale())
		
		target.kmAnim:Spawn()
		
		--And the targets model
		
		if IsValid(target.kmModel) then target.kmModel:Remove() end
		
		target.kmModel = ents.Create("m_km")
		target.kmModel:SetPos(target:GetPos())
		target.kmModel:SetAngles(target:GetAngles())
		target.kmModel:SetModel(target:GetModel())
		target.kmModel:SetSkin(target:GetSkin())
		target.kmModel:SetColor(target:GetColor())
		target.kmModel:SetMaterial(prevTMaterial)
		target.kmModel:SetRenderMode(target:GetRenderMode())
		target.kmModel:SetOwner(target)
		
		if !target:IsNextBot() then if IsValid(target:GetActiveWeapon()) then target.kmModel.Weapon = target:GetActiveWeapon() end end
		
		for i, bodygroup in ipairs(target:GetBodyGroups()) do
			target.kmModel:SetBodygroup(bodygroup.id, target:GetBodygroup(bodygroup.id))
		end
		
		for i, ent in ipairs(target:GetChildren()) do 
			ent:SetParent(target.kmModel, ent:GetParentAttachment()) 
			ent:SetLocalPos(vector_origin)
			ent:SetLocalAngles(angle_zero)
		end 
		
		target.kmModel:Spawn()
		
		target.kmModel:AddEffects(EF_BONEMERGE)
		target.kmModel:SetParent(target.kmAnim)
		
		--Play the KillMove animations 1 frame later to fix them not playing properly

		timer.Simple(5, function()
			if target:Health() < 1 then
				target.KillMoved = true
			else
				target.KillMoved = false
			end
		end)
		
		timer.Simple(0, function()
		
			self.kmAnim:ResetSequence( animName )
			self.kmAnim:ResetSequenceInfo()
			self.kmAnim:SetCycle(0)
			
			------------------------------------------------------------------------------------------
			
			target.kmAnim:ResetSequence( animName )
			target.kmAnim:ResetSequenceInfo()
			target.kmAnim:SetCycle(0)
			
			if plyKMTime == nil then plyKMTime = self.kmAnim:SequenceDuration() end
			if targetKMTime == nil then targetKMTime = target.kmAnim:SequenceDuration() end
			
			self:DoKMEffects(animName, self.kmModel, target.kmModel)
			
			--Now for the timers
			
			timer.Simple(targetKMTime, function()
				if IsValid(target) then
					
					target.kmAnim.AutomaticFrameAdvance = false
					
					timer.Simple(0.075, function()
						if IsValid(target) then
							if IsValid(target.kmModel) then target.kmModel:SetNoDraw(true) end
							
							if IsValid(target.kmModel) then
								local bonePos, boneAng = nil
								
								bonePos, boneAng = target.kmModel:GetBonePosition(0)
								
								target:SetPos(Vector(bonePos.x, bonePos.y, target:GetPos().z))
								--target:SetAngles(Angle(0, boneAng.y, 0))
							end
							
							--target:SetHealth(1)
							
							target:DrawShadow( true )
							
							if target:IsPlayer() then
								target:SetMaterial(prevTMaterial)
							else
								target:SetNoDraw(false)
							end
							
							target.inKillMove = false
							
							if target:IsPlayer() then
								--target:DrawWorldModel(true)
								target:UnLock()
								
								if target:Health() > 0 then
									local dmginfo = DamageInfo()
									
									dmginfo:SetAttacker( self )
									dmginfo:SetDamageType( DMG_DIRECT )
									dmginfo:SetDamage( 40 )
									
									target:TakeDamageInfo( dmginfo )
									
									--timer.Simple(0, function() if target:Health() > 0 then target:Kill() end end)
								else

									target.KillMoved = true
									
								end
							elseif target:IsNPC() or target:IsNextBot() then

								--target:SetHealth(0)
								
								local dmginfo = DamageInfo()
								
								dmginfo:SetAttacker( self )
								dmginfo:SetDamageType( DMG_SLASH )
								dmginfo:SetDamage( 1 )
								
								target:TakeDamageInfo( dmginfo )
							end
							
							if IsValid(target.kmModel) then 
								for i, ent in ipairs(target.kmModel:GetChildren()) do 
									ent:SetParent(target, ent:GetParentAttachment()) 
									ent:SetLocalPos(vector_origin)
									ent:SetLocalAngles(angle_zero)
								end 
								
								target.kmModel:RemoveDelay(2)
							end
							if IsValid(target.kmAnim) then target.kmAnim:RemoveDelay(2) end
						end
					end )
				end
			end )
			
			timer.Simple(plyKMTime, function()
				if IsValid(self) then
					
					self.kmAnim.AutomaticFrameAdvance = false
					
					timer.Simple(0.075, function()
						if IsValid(self) then
							if IsValid(self.kmAnim) then
								local headBone = self.kmAnim:GetAttachment(self.kmAnim:LookupAttachment( "eyes" ))
								self:SetPos(Vector(headBone.Pos.x, headBone.Pos.y, headBone.Pos.z + (self:GetPos().z - self:EyePos().z)))
								self:SetEyeAngles(Angle(headBone.Ang.x, headBone.Ang.y, 0))
							end
							
							self:DrawShadow( true )
							
							if self:IsPlayer() then
								self:SetMaterial(prevMaterial)
							else
								self:SetNoDraw(false)
							end
							
							self:DrawWorldModel(true)
							
							if IsValid(prevWeapon) then
								if prevWeapon:GetClass() != "ls_unarmed" then
									self:StripWeapon("ls_km")
								end
								
								self:SelectWeapon(prevWeapon)
							end
							
							self:SetMoveType(MOVETYPE_WALK)
							self:UnLock()
							
							if IsValid(self.kmModel) then 
								for i, ent in ipairs(self.kmModel:GetChildren()) do 
									ent:SetParent(self, ent:GetParentAttachment()) 
									ent:SetLocalPos(vector_origin)
									ent:SetLocalAngles(angle_zero)
								end 
								
								self.kmModel:Remove() 
							end
							if IsValid(self.kmAnim) then self.kmAnim:Remove() end
							
							self.inKillMove = false
							
							if self:IsInWorld() == false then
								local pos = self:GetPos()
								self:SetPos(Vector(pos.x, pos.y, pos.z + 9))
							end
							
							local healthToSpawn = 0
							
						end
					end )
				end
			end	)
		end)
	end
end

if CLIENT then
	
	-- net.Receive("debugbsmodcalcview", function()
		-- if GetConVar( "bsmod_debug_calcview" ):GetInt() != 0 then
			-- PrintTable(hook.GetTable()["CalcView"])
		-- end
	-- end)
	
	--Hide weapon pickup hud for the killmove weapon
	hook.Add("HUDWeaponPickedUp", "HideKMWeaponNotify", function(weapon)
		if weapon:GetClass() == "ls_km" then return false end
	end)
	
	hook.Add( "CalcView", "BSModCalcView", function(ply, pos, angles, fov)
		if IsValid(ply.kmviewentity) and !ply.kmviewentity:GetNoDraw() and ply:GetViewEntity() == ply then
			local KMOrigin = pos
			local KMAngles = angles
			
			-- if GetConVar( "bsmod_killmove_thirdperson" ):GetInt() != 0 then
				
				-- if ply.randTPYaw == nil and GetConVar( "bsmod_killmove_thirdperson_randomyaw" ):GetInt() != 0 then LocalPlayer().randTPYaw = math.Rand(-180, 180) end
				
				-- local TPAng = angles + Angle(20), (GetConVar( "bsmod_killmove_thirdperson_randomyaw" ):GetInt() == 0) and GetConVar( "bsmod_killmove_thirdperson_yaw" ):GetFloat() or ply.randTPYaw, 0)
				
				KMOrigin = ply.kmviewentity:GetAttachment(ply.kmviewentity:LookupAttachment( "eyes" )).Pos - (angles:Forward() * 90) + (angles:Up() * 30) + (angles:Right() * 1)
				KMAngles = angles
			-- else
				--KMOrigin = ply.kmviewentity:GetAttachment(ply.kmviewentity:LookupAttachment( "eyes" )).Pos
				--KMAngles = ply.kmviewentity:GetAttachment(ply.kmviewentity:LookupAttachment( "eyes" )).Ang
			-- end
			
			local view = {
				origin = KMOrigin,
				angles = KMAngles,
				drawviewer = true
			}
			
			return view
		end
		
		-- if GetConVar( "bsmod_killmove_thirdperson" ):GetInt() != 0 and (!IsValid(ply.kmviewentity) or ply.kmviewentity:GetNoDraw() or ply:GetViewEntity() != ply) then
			-- ply.randTPYaw = nil
		-- end
	end)
	
	hook.Add( "OnEntityCreated", "BSModOnEntityCreated", function( ent )
		if ( ent:GetClass() == "m_km" ) then
			--This was originally in the killmove entity's Initialize function but it was setting the viewtarget too late causing some visual issues for a few frames
			--Putting it here fixes this problem
			if IsValid(ent:GetOwner()) then
				if ent:GetOwner():GetModel() == ent:GetModel() then
					ent:GetOwner().kmviewentity = ent
				else
					ent:GetOwner().kmviewanim = ent
				end
				
				if ent:GetOwner().GetPlayerColor != nil then
					local playerColor = nil
					playerColor = ent:GetOwner():GetPlayerColor()
					
					if playerColor != nil then
						ent.GetPlayerColor = function() return Vector( playerColor.r, playerColor.g, playerColor.b ) end
					end
				end
			end
		end
	end)
end

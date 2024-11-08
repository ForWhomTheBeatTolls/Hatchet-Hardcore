local PANEL = {}



function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	-- self:SetSize(ScrW() * .2, ScrH())
	self:Center()
	--self:CenterHorizontal(.9)
 	self:MoveToFront()
	self:SetAlpha(0)
	self:AlphaTo(255, .1, 0)
	self.once = false

 	local w, h = self:GetSize()

	surface.PlaySound("hatchet/buttonclickrelease.wav")

 	local className = LocalPlayer():GetTeamClassName()
 	local rankName = LocalPlayer():GetTeamRankName()

	local model = LocalPlayer():GetModel()
 	local skin = LocalPlayer():GetSkin()

 	self.modelPreview = vgui.Create("impulseModelPanel", self)
	self.modelPreview:SetPos(80, 0)
	self.modelPreview:SetSize(w/6, h)
	self.modelPreview:SetModel(model, skin)
	self.modelPreview:MoveToBack()
	self.modelPreview:SetCursor("arrow")
	self.modelPreview:SetFOV(20)

	function self.modelPreview:LayoutEntity(ent)
		ent:SetAngles(Angle(-1, 60, 0))
		ent:SetEyeTarget(Vector(0, 0, 70))
		ent:SetPos(Vector(0, 0, 2.5))
		self:RunAnimation()

		if not self.setup then
			for v,k in pairs(LocalPlayer():GetBodyGroups()) do
				ent:SetBodygroup(k.id, LocalPlayer():GetBodygroup(k.id))
			end

			for v,k in pairs(LocalPlayer():GetMaterials()) do
				local mat = LocalPlayer():GetSubMaterial(v - 1)

				if mat != k then
					ent:SetSubMaterial(v - 1, mat)
				end
			end

			hook.Run("SetupInventoryModel", self, ent)

			self.setup = true
		end
	end

 	self:SetupItems(w, h)
end

function PANEL:PaintOver(w, h)
	draw.SimpleText(self.invWeight.."kg/"..impulse.Config.InventoryMaxWeight.."kg", "Impulse-Elements27-Shadow", w / 1.035, 14, grey, TEXT_ALIGN_CENTER)
	draw.SimpleText("My inventory & Skills", "Impulse-Elements27-Shadow", 120, 2, grey, TEXT_ALIGN_CENTER)
end

function PANEL:SetupItems()

	local w, h = ScrW(), ScrH()
	
	local itempanel = vgui.Create( "DPanel", self )
	itempanel:SetSize(w / 1.8, h)
	itempanel:SetPos(w / 2.2, 0)


	function itempanel:Paint(w, h)
		local bodyCol = Color(0, 0, 0, 255)
		local lpTeam = LocalPlayer():Team()
		local TeamCol = Color(team.GetColor(lpTeam).r, team.GetColor(lpTeam).g, team.GetColor(lpTeam).b, 8)
		local gradient = Material("gui/gradient_up")
		local orange = Color(255, 123, 0)


	
		surface.SetDrawColor(bodyCol)
		surface.SetMaterial(gradient)
		surface.DrawRect(w / 1.55, 0, w / .2, h)
		surface.SetDrawColor(TeamCol)
		surface.DrawTexturedRect(w / 1.55, 0, w / .2, h)

		surface.SetDrawColor(orange)
		surface.DrawRect(w / 1.55, 0, w / .2, 3)
	end

	local Scroll = vgui.Create( "DScrollPanel", itempanel ) -- Create the Scroll panel
	Scroll:SetSize(w / 1.83, h)
	Scroll:SetPos(0, 0)
	
	local List = vgui.Create( "DIconLayout", Scroll )
	List:SetSize(w / 6, h)
	List:SetPos(w / 2.7, h / 15)
	List:SetSpaceY( 5 ) -- Sets the space in between the panels on the Y Axis by 5
	List:SetSpaceX( 5 ) -- Sets the space in between the panels on the X Axis by 5

	self.items = {}
	self.itemsPanels = {}
 	local weight = 0
 	local realInv = impulse.Inventory.Data[0][1]
 	local localInv = table.Copy(impulse.Inventory.Data[0][1]) or {}
 	local reccurTemp = {}
 	local equipTemp = {}

 	local shouldSortEq = impulse.GetSetting("inv_sortequippablesattop", true)
 	local sortMethod = impulse.GetSetting("inv_sortweight", "Inventory only")
 	local invertSort = true

	for v,k in pairs(localInv) do -- fix for fucking table.sort desyncing client/server itemids!!!!!!!
		k.realKey = v

		if sortMethod == "Always" or sortMethod == "Inventory only" then
			reccurTemp[k.id] = (reccurTemp[k.id] or 0) + (impulse.Inventory.Items[k.id].Weight or 0)
			k.sortWeight = reccurTemp[k.id]
		else
			k.sortWeight = impulse.Inventory.Items[k.id].Name
			invertSort = false
		end
	end

	if localInv and table.Count(localInv) > 0 then
		if shouldSortEq then
			for v,k in SortedPairsByMemberValue(localInv, "sortWeight", invertSort) do
				if not k.equipped then continue end
				local itemX = impulse.Inventory.Items[k.id]

				local item = List:Add("impulseInventoryItem")
			   	item:SetItem(k, w)
				item:Dock( TOP )
				item:DockMargin( 0, 0, 0, 2 )
			   	item.InvID = k.realKey
			   	item.InvPanel = self
			   	self.items[k.id] = item
			   	self.itemsPanels[k.realKey] = item

				weight =  weight + (itemX.Weight or 0)
			end
		end
		
		for v,k in SortedPairsByMemberValue(localInv, "sortWeight", invertSort) do -- 01 is player 0 (localplayer) and storage 1 (local inv)
			if shouldSortEq and k.equipped then continue end
			local otherItem = self.items[k.id]
			local itemX = impulse.Inventory.Items[k.id]

			if itemX.CanStack and otherItem then
				otherItem.Count = (otherItem.Count or 1) + 1
			else
				local item = List:Add("impulseInventoryItem")
			   	item:SetItem(k, w)
				item:Dock( TOP )
				item:DockMargin( 0, 0, 0, 2 )
			   	item.InvID = k.realKey
			   	item.InvPanel = self
			   	self.items[k.id] = item
			   	self.itemsPanels[k.realKey] = item
		   end

		   weight =  weight + (itemX.Weight or 0)
	   end
   else
	   self.empty = List:Add("DLabel", self)
	   self.empty:SetContentAlignment(5)
	   self.empty:Dock(TOP)
	   self.empty:SetText("Empty")
	   self.empty:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements22-Shadow"))
   end

	self.invWeight = weight
	self:SetupSkills(w, h)
end



local bodyCol = Color(50, 50, 50, 210)
function PANEL:SetupSkills(w, h)
	local skillpanel = vgui.Create( "DPanel", self )
	skillpanel:SetSize(w / 2.8, h)
	skillpanel:SetPos(w / 2.17, h / 1.68)

	function skillpanel:Paint()
	end
	
 	for v,k in pairs(impulse.Skills.Skills) do
 		local skillBg = skillpanel:Add("DPanel")
 		skillBg:SetTall(80)
 		skillBg:Dock(TOP)
 		skillBg:DockMargin(0, 0, 15, 5)
 		skillBg.Skill = v

 		local level = LocalPlayer():GetSkillLevel(v)
 		local xp = LocalPlayer():GetSkillXP(v)

 		function skillBg:Paint(w, h)
 			surface.SetDrawColor(bodyCol)
			surface.DrawRect(0, 0, w, h)

			local skill = self.Skill
			local skillName = impulse.Skills.GetNiceName(skill)

			draw.DrawText(skillName.." - Level "..level, "Impulse-Elements22-Shadow", 5, 3, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText("Total skill: "..xp.."XP", "Impulse-Elements16-Shadow", w - 5, 7, color_white, TEXT_ALIGN_RIGHT)

 			return true
 		end

 		local lastXp = impulse.Skills.GetLevelXPRequirement(level - 1)
 		local nextXp = impulse.Skills.GetLevelXPRequirement(level)
 		local perc = (xp - lastXp) / (nextXp - lastXp)

 		local bar = vgui.Create("DProgress", skillBg)
 		bar:SetPos(20, 30)
 		bar:SetSize(self:GetWide() / 3.05, 40)

 		if level == 10 then
 			bar:SetFraction(1)
 			bar.BarCol = Color(218, 165, 32)
 		else
 			bar:SetFraction(perc)
 		end

 		function bar:PaintOver(w, h)
 			if level != 10 then
 				draw.DrawText(math.Round(perc * 100, 1).."% to next level", "Impulse-Elements18-Shadow", w / 2, 10, color_white, TEXT_ALIGN_CENTER)
 			else
 				draw.DrawText("Mastered", "Impulse-Elements18-Shadow", w / 2, 10, color_white, TEXT_ALIGN_CENTER)
 			end

 			draw.DrawText(lastXp.."XP", "Impulse-Elements16-Shadow", 10, 10, color_white)
 			draw.DrawText(nextXp.."XP", "Impulse-Elements16-Shadow", w - 10, 10, color_white, TEXT_ALIGN_RIGHT)
 		end
 	end
end

function PANEL:FindItemPanelByID(id)
	return self.itemsPanels[id]
end

function PANEL:OnRemove()
	surface.PlaySound("ui/buttonrollover.wav")
end


function PANEL:Paint(w, h)
	local grey = Color(209, 209, 209)
	local lpTeam = LocalPlayer():Team()
	local TeamCol = Color(team.GetColor(lpTeam).r, team.GetColor(lpTeam).g, team.GetColor(lpTeam).b, 10)
	local orange = Color(255, 123, 0)
	local bodycol = Color(39, 39, 39)
	local blk = Color(0, 0, 0)
	local d = Color(0, 0, 0, 240)
	local gradient = Material("vgui/gradient_up")
	local background = Material("hatchet/overlays/vignette.png")



	surface.SetDrawColor(blk)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0, 0, w,  h)
	surface.SetMaterial(background)
	surface.DrawTexturedRect(0, 0, w,  h)

	surface.SetDrawColor(d)
	surface.DrawRect(0, 0, w, h)

	-- if impulse.GetSetting("perf_blur") == true then
	-- 	impulse.blur(self, 4, 8, 255)
	-- else
		
	-- end

	local figure_col = Color(255, 255, 255, 40)
	local injured_figure_col = Color(170, 41, 41)
	local body = Material("hatchet/limbs/body.png")

	local figure_larm = Material("hatchet/limbs/larm.png")
	local figure_rarm = Material("hatchet/limbs/rarm.png")
	local figure_lleg = Material("hatchet/limbs/lleg.png")
	local figure_rleg = Material("hatchet/limbs/rleg.png")
	local figure_head = Material("hatchet/limbs/head.png")
	local figure_chest = Material("hatchet/limbs/chest.png")

	surface.SetDrawColor(figure_col)
	surface.SetMaterial(body)
	surface.DrawTexturedRect(500, h / 1.7, 210, 400)

	if LocalPlayer():GetNWBool("RLegCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_rleg)
		surface.DrawTexturedRect(500, h / 1.7, 210, 400)
	end

	if LocalPlayer():GetNWBool("LLegCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_lleg)
		surface.DrawTexturedRect(500, h / 1.7, 210, 400)
	end

	if LocalPlayer():GetNWBool("RArmCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_rarm)
		surface.DrawTexturedRect(500, h / 1.7, 210, 400)
	end

	if LocalPlayer():GetNWBool("LArmCrippled") == true then
		surface.SetDrawColor(injured_figure_col)
		surface.SetMaterial(figure_larm)
		surface.DrawTexturedRect(500, h / 1.7, 210, 400)
	end
	
	surface.SetFont("HatchetFont20")
	surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("LLeg"), 155 + LocalPlayer():GetNWInt("LLeg")))
	surface.SetTextPos(430, h/ 1.17)
	surface.DrawText("L-LEG: "..math.Round(LocalPlayer():GetNWInt("LLeg"), 1).."/100")
	
	surface.SetFont("HatchetFont20")
	surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("RLeg"), 155 + LocalPlayer():GetNWInt("RLeg")))
	surface.SetTextPos(660, h/ 1.17)
	surface.DrawText("R-LEG: "..math.Round(LocalPlayer():GetNWInt("RLeg"), 1).."/100")
	
	surface.SetFont("HatchetFont20")
	surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("LArm"), 155 + LocalPlayer():GetNWInt("LArm")))
	surface.SetTextPos(410, h/ 1.45)
	surface.DrawText("L-ARM: "..math.Round(LocalPlayer():GetNWInt("LArm"), 1).."/100")
	
	surface.SetFont("HatchetFont20")
	surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("RArm"), 155 + LocalPlayer():GetNWInt("RArm")))
	surface.SetTextPos(680, h/ 1.45)
	surface.DrawText("R-ARM: "..math.Round(LocalPlayer():GetNWInt("RArm"), 1).."/100")
	

	-- surface.SetDrawColor(injured_figure_col)
	-- surface.SetMaterial(figure_head)
	-- surface.DrawTexturedRect(500, h / 1.7, 210, 400)

	if LocalPlayer():Team() != TEAM_DISPATCH then
		local curhp = ""
		local curhunger = ""
	
		surface.SetMaterial(gradient)
		surface.SetDrawColor(bodycol)
		surface.DrawRect(w / 1.74, 0, w / 1, h / 6)
		surface.SetDrawColor(TeamCol)
		surface.DrawTexturedRect(w / 1.74, 0, w / 2, h / 6)
		surface.SetDrawColor(orange)
		surface.DrawRect(w / 1.74, h / 6.1, w / 2, 3)
		--surface.DrawRect(w / 1.74, 0, 3, h / 6)
	
	
		surface.SetFont("HatchetFont34")
		surface.SetTextColor(Color(255, 255, 255))
		surface.SetTextPos(w / 1.72, 14)
		surface.DrawText(LocalPlayer():Name())
		surface.SetTextPos(w / 1.72, 46)
		surface.DrawText(team.GetName(lpTeam))
		surface.SetFont("HatchetFont20")
		surface.SetTextPos(w / 1.72, 90)
		surface.DrawText("I have "..LocalPlayer():GetSyncVar(SYNC_MONEY, 100).."T In my wallet right now.")
		surface.SetTextPos(w / 1.72, 110)
	
		if LocalPlayer():Health() < 10 then
			curhp = "I'm extremely injured."
		elseif LocalPlayer():Health() < 25 then
			curhp = "I'm seriously injured."
		elseif LocalPlayer():Health() < 45 then
			curhp = "I'm injured."
		elseif LocalPlayer():Health() < 60 then
			curhp = "I'm hurt."
		elseif LocalPlayer():Health() < 80 then
			curhp = "I'm bruised."
		elseif LocalPlayer():Health() <= 100 then
			curhp = "I'm healthy."
		end
	
		surface.DrawText(curhp)
	
		surface.SetTextPos(w / 1.72, 128)
	
		if LocalPlayer():Health() < 10 then
			curhunger = "I'm going to die from starvation soon!"
		elseif LocalPlayer():Health() < 25 then
			curhunger = "I'm seriously starving!"
		elseif LocalPlayer():Health() < 45 then
			curhunger = "i'm starving!"
		elseif LocalPlayer():Health() < 60 then
			curhunger = "I'm hungry!"
		elseif LocalPlayer():Health() < 80 then
			curhunger = "I'm somewhat hungry."
		elseif LocalPlayer():Health() < 101 then
			curhunger = "I'm satisfied."
		end
	
		surface.DrawText(curhunger)
	end
end


vgui.Register("impulseInventory", PANEL, "DPanel")

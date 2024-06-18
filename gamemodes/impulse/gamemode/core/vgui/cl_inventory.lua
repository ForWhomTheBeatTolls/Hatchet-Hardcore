local PANEL = {}



function PANEL:Init()
	self:SetSize(ScrW() * .2, ScrH())
	self:Center()
	self:CenterHorizontal(.9)
	self:SetTitle("Inventory & Skills")
	self:ShowCloseButton(false)
	self:SetDraggable(false)
	--self:MakePopup()
 	self:MoveToFront()
	

	-- (ScrW() * .2, ScrH())


 	local w, h = self:GetSize()

 	-- self.infoName = vgui.Create("DLabel", self)
 	-- self.infoName:SetPos(15, 40)
 	-- self.infoName:SetText(LocalPlayer():Nick())
 	-- self.infoName:SetFont(HIGH_RES("Impulse-Elements24-Shadow", "Impulse-Elements27-Shadow"))
 	-- self.infoName:SizeToContents()

	hook.Add("CalcView", "PlayerPreview", function(client, origin, angles, fov)
		local newOrigin, newAngles, newFOV, bDrawPlayer = GetOverviewInfo(origin, angles, fov)
	
		local view = {
			drawviewer = bDrawPlayer,
			fov = newFOV,
			origin = newOrigin,
			angles = newAngles
		}
		
		return view
	end)

	hook.Add( "Think", "InventoryLight", function()
		local dlight = DynamicLight( LocalPlayer():EntIndex() )
		local lpTeam = LocalPlayer():Team()
		if ( dlight ) then
			dlight.pos = LocalPlayer():GetPos() + Vector(0, 0, 50)
			dlight.r = team.GetColor(lpTeam).r
			dlight.g = team.GetColor(lpTeam).g
			dlight.b = team.GetColor(lpTeam).b
			dlight.brightness = 2
			dlight.decay = 1000
			dlight.size = 60
			dlight.dietime = CurTime() + 1
		end
	end )

	surface.PlaySound("hatchet/buttonclickrelease.wav")

	hook.Add("HUDPaint", "CharacterStats", function()
		local w, h = ScrW(), ScrH()
		local lpTeam = LocalPlayer():Team()
		local TeamCol = Color(team.GetColor(lpTeam).r, team.GetColor(lpTeam).g, team.GetColor(lpTeam).b, 14)
		local gradient = Material("gui/gradient_up")
		draw.RoundedBox(0, w * .497, h * .065, w * .246, h * .810, Color(team.GetColor(lpTeam).r + 100, team.GetColor(lpTeam).g + 100, team.GetColor(lpTeam).b + 100, 255))
		draw.RoundedBox(0, w * .5, h * .07, w * .24, h * .8, Color(24, 24, 24))
		surface.SetDrawColor(TeamCol)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(w * .5, h * .07, w * .24, h * .8)

		draw.SimpleTextOutlined(LocalPlayer():Name(), "Impulse-Elements22-Shadow", w * .62, h * .085, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		draw.RoundedBox(45,  w * .52, h * .12, w * .2, h * .002, Color(255, 255, 255))
		draw.SimpleTextOutlined(team.GetName(lpTeam), "Impulse-Elements22-Shadow", w * .62, h * .14, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		draw.SimpleTextOutlined(LocalPlayer():GetTeamRankName(), "Impulse-Elements22-Shadow", w * .62, h * .17, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		draw.SimpleTextOutlined(LocalPlayer():GetTeamClassName(), "Impulse-Elements22-Shadow", w * .62, h * .2, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		draw.RoundedBox(45,  w * .52, h * .24, w * .2, h * .002, Color(255, 255, 255))


		if LocalPlayer():Health() < 10 then
			draw.SimpleTextOutlined("Im Extremely injured!", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():Health() < 25 then
			draw.SimpleTextOutlined("Im Seriously injured!", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():Health() < 45 then
			draw.SimpleTextOutlined("im injured!", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():Health() < 60 then
			draw.SimpleTextOutlined("Im Hurt!", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():Health() < 80 then
			draw.SimpleTextOutlined("Im Bruised.", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():Health() < 101 then
			draw.SimpleTextOutlined("Im Healthy.", "Impulse-Elements22-Shadow", w * .62, h * .25, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		end

		if LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 10 then
			draw.SimpleTextOutlined("Im Extremely starving!", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 25 then
			draw.SimpleTextOutlined("Im Seriously Starving!", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 45 then
			draw.SimpleTextOutlined("im Starving!", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 60 then
			draw.SimpleTextOutlined("Im Hungry..", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 80 then
			draw.SimpleTextOutlined("Im kind of Satisfied.", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		elseif LocalPlayer():GetSyncVar(SYNC_HUNGER, 100) < 101 then
			draw.SimpleTextOutlined("Im Satisfied.", "Impulse-Elements22-Shadow", w * .62, h * .28, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))
		end

		draw.SimpleTextOutlined("I have "..LocalPlayer():GetSyncVar(SYNC_MONEY, 100).."T In my wallet right now.", "Impulse-Elements22-Shadow", w * .62, h * .31, Color(255, 255, 255), TEXT_ALIGN_CENTER, nil, 1, Color(team.GetColor(lpTeam).r - 100, team.GetColor(lpTeam).g - 100, team.GetColor(lpTeam).b - 100))

		draw.RoundedBox(45,  w * .52, h * .35, w * .2, h * .002, Color(255, 255, 255))

	end)

 	-- if self.infoName:GetWide() > 245 then
 	-- 	self.infoName:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements24-Shadow"))
 	-- end

 	-- local lpTeam = LocalPlayer():Team()
  	-- self.infoTeam = vgui.Create("DLabel", self)
 	-- self.infoTeam:SetPos(15, 64)
 	-- self.infoTeam:SetText(team.GetName(lpTeam))
 	-- self.infoTeam:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements22-Shadow"))
 	-- self.infoTeam:SetColor(team.GetColor(lpTeam))
 	-- self.infoTeam:SizeToContents()

 	local className = LocalPlayer():GetTeamClassName()
 	local rankName = LocalPlayer():GetTeamRankName()

 	-- if className != "Default" then
	--  	self.infoClassRank = vgui.Create("DLabel", self)
	--  	self.infoClassRank:SetPos(15, 80)
	--  	self.infoClassRank:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements22-Shadow"))
	--  	self.infoClassRank:SetText(className)
	--  	self.infoClassRank:SetColor(team.GetColor(lpTeam))
	--  	self.infoClassRank:SizeToContents()
	-- end

 	--self.invName = vgui.Create("DLabel", self)
 	--self.invName:SetPos(270, 35)
 	--self.invName:SetText("Inventory")
 	--self.invName:SetFont("Impulse-Elements24-Shadow")
 	--self.invName:SizeToContents()

 	self:SetupItems(w, h)
end

function PANEL:SetupItems()
	local w, h = self:GetSize()

	if self.tabs and IsValid(self.tabs) then
		self.tabs:Remove()
	end

	local s = HIGH_RES(0, 0) // having them set to 0 fixed it lmao
	
 	self.tabs = vgui.Create("DPropertySheet", self)
 	self.tabs:SetPos(s, 40)
 	self.tabs:SetSize(w - s, h - 0)
 	self.tabs.tabScroller:DockMargin(0, 0, 0, 0)
 	self.tabs.tabScroller:SetOverlap(0)

 	function self.tabs:Paint()
 		return true
 	end
	
	if self.invScroll and IsValid(self.invScroll) then
		self.invScroll:Remove()
	end

	self.invScroll = vgui.Create("DScrollPanel", self.tabs)
 	self.invScroll:SetPos(0, 0)
 	self.invScroll:SetSize(w - math.Clamp(s, 100, 270), h - 42)

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

	 			local item = self.invScroll:Add("impulseInventoryItem")
				item:Dock(TOP)
				item:DockMargin(0, 0, 0, 0)
				item:SetItem(k, w)
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
	 			local item = self.invScroll:Add("impulseInventoryItem")
				item:Dock(TOP)
				item:DockMargin(0, 0, 0, 0)
				item:SetItem(k, w)
				item.InvID = k.realKey
				item.InvPanel = self
				self.items[k.id] = item
				self.itemsPanels[k.realKey] = item
			end

			weight =  weight + (itemX.Weight or 0)
		end
	else
		self.empty = self.invScroll:Add("DLabel", self)
		self.empty:SetContentAlignment(5)
		self.empty:Dock(TOP)
		self.empty:SetText("Empty")
		self.empty:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements22-Shadow"))
	end

	self.invWeight = weight

	self.tabs:AddSheet("Inventory", self.invScroll)

	self:SetupSkills(w, h)
end



local bodyCol = Color(50, 50, 50, 210)
function PANEL:SetupSkills(w, h)
	self.skillScroll = vgui.Create("DScrollPanel", self.tabs)
 	self.skillScroll:SetPos(0, 0)
 	self.skillScroll:SetSize(w - 270, h - 42)

 	for v,k in pairs(impulse.Skills.Skills) do
 		local skillBg = self.skillScroll:Add("DPanel")
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
 		bar:SetSize(self.skillScroll:GetWide() + 200, 40)

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

 	self.tabs:AddSheet("Skills", self.skillScroll)
end

function PANEL:FindItemPanelByID(id)
	return self.itemsPanels[id]
end

function PANEL:OnRemove()
	hook.Remove("CalcView", "PlayerPreview")
	hook.Remove("HUDPaint", "CharacterStats")
	hook.Remove( "Think", "InventoryLight")
	surface.PlaySound("ui/buttonrollover.wav")
end

local grey = Color(209, 209, 209)
function PANEL:PaintOver(w, h)
	draw.SimpleText(self.invWeight.."kg/"..impulse.Config.InventoryMaxWeight.."kg", HIGH_RES("Impulse-Elements18-Shadow", "Impulse-Elements22-Shadow"), w - 18, 40, grey, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
end

vgui.Register("impulseInventory", PANEL, "DFrame")

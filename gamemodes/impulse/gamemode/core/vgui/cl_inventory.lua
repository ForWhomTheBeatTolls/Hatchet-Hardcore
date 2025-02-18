local PANEL = {}

function PANEL:Init()
	local w, h = ScrW(), ScrH()


	local backgr = Material("gui/gradient")
	local colhp = Color(136, 33, 33)
	local colhung = Color(134, 97, 49)
	local moneyicon = Material("hatchet/money.png")
	local hpicon = Material("hatchet/plus.png")
	local hungicon = Material("hatchet/food.png")
	local col1, col2, col3 = Color(77, 77, 77), Color(32, 32, 32), Color(255, 255, 255)

	self:SetSize(w * .4, h * .7)
	self:Center()
	self:CenterHorizontal()
 	self:MoveToFront()
	self:SetTitle("Inventory")

	self.scroll = vgui.Create( "DScrollPanel", self )
	local ww, wh = self:GetSize()
	self.scroll:SetSize(ww, wh)
	self.scroll:SetPos(ww / 2 * 0.1, wh / 2 * 0.4)

	self.lay = vgui.Create("DTileLayout", self.scroll)
	self.lay:SetBaseSize(12) -- Tile size
	self.lay:Dock( FILL )

 	self:SetupItems(w, h)
end



function PANEL:SetupItems()
	if (itemhover) then
		itemhover:Remove()
	end

	local w, h = self:GetSize()
	if (self.itemsPanels and self.itemsPanels != {}) then
		for _, q in pairs(self.itemsPanels) do
			q:Remove()
		end
	end

 	local weight = 0
 	local realInv = impulse.Inventory.Data[0][1]
 	local localInv = table.Copy(impulse.Inventory.Data[0][1]) or {}
 	local reccurTemp = {}
 	local equipTemp = {}

	self.items = {}
	self.itemsPanels = {}
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

	 			local item = self:Add("impulseInventoryItem", self)
				item:SetItem(k, w)
				item.Item = itemX
				self.lay:Add(item)
				item.InvID = k.realKey
				item.InvPanel = self
				self.items[k.id] = item
				self.itemsPanels[k.realKey] = item
				
				function item.model:OnCursorEntered()
					itemhover = vgui.Create("impulseInventoryHover")
					itemhover:SetItem(item)
					itemhover:MakePopup()
					itemhover:MoveToFront()
				end

				function item.model:OnCursorExited()
					itemhover:Remove()
				end
	
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
	 			local item = self:Add("impulseInventoryItem", self)
				item:SetItem(k, w)
				item.Item = itemX
				self.lay:Add(item)
				item.InvID = k.realKey
				item.InvPanel = self
				self.items[k.id] = item
				self.itemsPanels[k.realKey] = item
				
				function item.model:OnCursorEntered()
					if (IsValid(itemhover)) then
						itemhover:Remove()
					end
					itemhover = vgui.Create("impulseInventoryHover")
					itemhover:SetItem(item)
					itemhover:MakePopup()
					itemhover:MoveToFront()
				end

				function item.model:OnCursorExited()
					itemhover:Remove()
				end
			end

			weight =  weight + (itemX.Weight or 0)
		end
	else
		self.empty = self:Add("DLabel", self)
		self.empty:SetContentAlignment(5)
		self.empty:Dock(TOP)
		self.empty:SetText("Empty")
		self.empty:SetFont(HIGH_RES("Impulse-Elements19-Shadow", "Impulse-Elements22-Shadow"))
	end

	self.invWeight = weight
end

function PANEL:OnRemove()
	if (IsValid(itemhover)) then
		itemhover:Remove()
	end
end



function PANEL:FindItemPanelByID(id)
	return self.itemsPanels[id]
end
local bodycol = Color(12, 12, 12, 243)
-- function PANEL:Paint(w, h)
-- 	draw.RoundedBox(16, 0, 0, w, h, bodycol)
-- end

local grey = Color(209, 209, 209)
local textcol
function PANEL:PaintOver(w, h)
	textcol = self.invWeight .. "kg/" .. impulse.Config.InventoryMaxWeight .. "kg"
	-- draw.SimpleText(textcol, "Impulse-Elements22-Shadow",  surface.GetTextSize(textcol), 40, grey, TEXT_ALIGN_LEFT)
	draw.SimpleText(textcol, "Impulse-Elements22-Shadow", w / 2, 36, grey, TEXT_ALIGN_CENTER)
end

vgui.Register("impulseInventory", PANEL, "DFrame")

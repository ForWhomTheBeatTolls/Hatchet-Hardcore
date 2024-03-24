local PANEL = {}

impulse.RankMenu = impulse.RankMenu or nil

function PANEL:Init()

	if impulse.RankMenu and IsValid(impulse.RankMenu) then
		impulse.RankMenu:Remove()
	end

	impulse.RankMenu = self
	impulse.hudEnabled = false

	self:SetSize(ScrW(), ScrH())
	self:Center()
	self:MakePopup()

	self.characterPreview = vgui.Create("impulseModelPanel", self)
	self.characterPreview:SetSize(ScrW() * 0.4, ScrH())
	self.characterPreview:SetPos(ScrW() * 0.6, 0)
	self.characterPreview:SetFOV(54)
	self.characterPreview:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
	self.characterPreview:MoveToBack()
	self.characterPreview:SetCursor("arrow")

	function self.characterPreview:LayoutEntity(ent) 
		ent:SetAngles(Angle(0, 40, 0))
	end

	self.divisionLbl = vgui.Create("DLabel", self)
	self.divisionLbl:SetColor(color_white)
 	self.divisionLbl:SetFont("BudgetLabel")
	self.divisionLbl:SetText("Divison")
	self.divisionLbl:SizeToContents()
	self.divisionLbl:SetTall(54)
	self.divisionLbl:SetPos(96, ScrH() * 0.6)

	self.divisionSelect = vgui.Create("DComboBox", self)
	self.divisionSelect:SetPos(112 + self.divisionLbl:GetWide(), ScrH() * 0.6)
	self.divisionSelect:SetSize(500, 54)
	self.divisionSelect:SetSortItems(false)
	self.divisionSelect:SetValue("Select a divison")
	self.divisionSelect:SetFont("BudgetLabel")

	local xp = LocalPlayer():GetXP()

	for v,k in pairs(impulse.Teams.Data[LocalPlayer():Team()].classes) do
		local add = (k.whitelistLevel and " and whitelist") or ""
		if k.xp <= xp then
			self.divisionSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false)
		else
			self.divisionSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false, "icon16/lock.png")
		end
	end

	local panel =  self

	function self.divisionSelect:OnSelect(index, value, data)
		local div = impulse.Teams.Data[LocalPlayer():Team()].classes[data]
		panel.descLblT:SetText(div.description)
		panel.descLblT:SetWrap(true)

		if div.model then
			panel.characterPreview:SetModel(div.model)
		end

		if div.skin then
			panel.characterPreview.Entity:SetSkin(div.skin)
		end

		if div.noSubMats then
			panel.characterPreview.Entity:SetSubMaterial(0, nil)
		else
			if panel.characterPreview.subMats then
				for v,k in pairs(panel.characterPreview.subMats) do
					panel.characterPreview.Entity:SetSubMaterial(v - 1, k)
				end
			elseif LocalPlayer():Team() == TEAM_CP then
				--panel.characterPreview.Entity:SetSubMaterial(0, "models/impulse/cp/rank_i4")
			end
		end

		if div.xp > LocalPlayer():GetXP() then
			panel.doneBtn.DivisionName = nil
			return
		end

		if div.bodygroups then
			--panel.characterPreview.subMats = {}
			for v,k in pairs(div.bodygroups) do
				panel.characterPreview.Entity:SetBodygroup(k[1], k[2])
				--panel.characterPreview.subMats[v] = k
			end
		end

		panel.doneBtn.DivisionName = div.name
		panel.doneBtn.Division = data
	end

	self.rankLbl = vgui.Create("DLabel", self)
 	self.rankLbl:SetFont("BudgetLabel")
	self.rankLbl:SetText("Rank")
	self.rankLbl:SizeToContents()
	self.rankLbl:SetTall(54)
	self.rankLbl:SetPos(96, ScrH() * 0.6 + 72)
	self.rankLbl:SetColor(color_white)

	self.rankSelect = vgui.Create("DComboBox", self)
	self.rankSelect:SetFont("BudgetLabel")
	self.rankSelect:SetPos(112 + self.divisionLbl:GetWide(), ScrH() * 0.6 + 72)
	self.rankSelect:SetSize(500, 54)
	self.rankSelect:SetSortItems(false)
	self.rankSelect:SetValue("Select a rank")

	for v,k in pairs(impulse.Teams.Data[LocalPlayer():Team()].ranks) do
		local add = (k.whitelistLevel and " + whitelist") or ""
		if k.xp <= xp then
			self.rankSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false)
		else
			self.rankSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false, "icon16/lock.png")
		end
	end

	function self.rankSelect:OnSelect(index, value, data)
		local rank = impulse.Teams.Data[LocalPlayer():Team()].ranks[data]
		local div = impulse.Teams.Data[LocalPlayer():Team()].classes[panel.doneBtn.Division]

		if rank.model then
			panel.characterPreview:SetModel(rank.model)
		end

		if rank.subMaterial then
			panel.characterPreview.subMats = {}
			for v,k in pairs(rank.subMaterial) do
				panel.characterPreview.Entity:SetSubMaterial(v - 1, k)
				panel.characterPreview.subMats[v] = k
			end
		end

		if rank.bodygroups then
			--panel.characterPreview.subMats = {}
			for v,k in pairs(rank.bodygroups) do
				panel.characterPreview.Entity:SetBodygroup(k[1], k[2])
				--panel.characterPreview.subMats[v] = k
			end
		end

		if div and div.noSubMats then
			panel.characterPreview.Entity:SetSubMaterial(0, nil)
		end

		if rank.xp > LocalPlayer():GetXP() then
			panel.doneBtn.RankName = nil
			return
		end

		panel.doneBtn.RankName = rank.name
		panel.doneBtn.Rank = data
	end

	self.descLbl = vgui.Create("DLabel", self)
 	self.descLbl:SetFont("BudgetLabel")
	self.descLbl:SetText("Description:")
	self.descLbl:SizeToContents()
	self.descLbl:SetPos(800, ScrH() * 0.6)

	self.descLblT = vgui.Create("DLabel", self)
 	self.descLblT:SetText("")
 	self.descLblT:SetFont("BudgetLabel")
 	self.descLblT:SetPos(800, ScrH() * 0.6 + 32)
 	self.descLblT:SetContentAlignment(7)
  	self.descLblT:SetSize(ScrW() * 0.3, 400)

  	self.doneBtn = vgui.Create("DButton", self)
	self.doneBtn:SetFont("BudgetLabel")
  	self.doneBtn:SetPos(96, ScrH() * 0.8)
  	self.doneBtn:SetSize(658, 72)
  	self.doneBtn:SetText("No divison or rank selected")
  	self.doneBtn:SetDisabled(true)

  	function self.doneBtn:Think()
  		if self.DivisionName and self.RankName then
  			self:SetText("Become a "..self.DivisionName.." "..self.RankName)
  			self:SetDisabled(false)
  			return
  		end

  		self:SetDisabled(true)
  		self:SetText("No valid division and/or rank selected")
  	end

  	function self.doneBtn:DoClick()
  		if self.Division and self.Rank then
	  		net.Start("impulseHL2RPRankBecome")
	  		net.WriteUInt(self.Division, 8)
	  		net.WriteUInt(self.Rank, 8)
	  		net.SendToServer()

	  		panel:Remove()
	  	end
  	end
end

function PANEL:OnRemove()
	impulse.hudEnabled = true
end

local textIO = {
	[TEAM_CP] = {
		["header:title"] = "Civil Protection Enlistment",
		["header:subtitle"] = "Request your rank and division."
	},
	[TEAM_OTA] = {
		["header:title"] = "Overwatch Transhuman Arm",
		["header:subtitle"] = "Submit request to Overwatch for your rank and division."
	}
}

local guadient = Material("vgui/gradient-d")

function PANEL:Paint(w, h)

	Derma_DrawBackgroundBlur(self, 0)

	surface.SetMaterial(guadient)
	surface.SetDrawColor(0, 0, 0, 120)
	surface.DrawTexturedRect(0, h-(h/3), w, h/3)

	local myTeam = LocalPlayer():Team()
	local myLang = textIO[myTeam]
	local myColor = team.GetColor(myTeam)

	-- local _, h0 = impulse.Surface.DrawText(
		-- myLang["header:title"],
		-- "BudgetLabel",
		-- 64,
		-- 64,
		-- myColor,
		-- TEXT_ALIGN_LEFT,
		-- TEXT_ALIGN_TOP
	-- )

	-- impulse.Surface.DrawText(
		-- myLang["header:subtitle"],
		-- "BudgetLabel",
		-- 64,
		-- 70 + h0,
		-- color_white,
		-- TEXT_ALIGN_LEFT,
		-- TEXT_ALIGN_TOP
	-- )
end

vgui.Register("impulseRankMenu", PANEL, "DPanel")
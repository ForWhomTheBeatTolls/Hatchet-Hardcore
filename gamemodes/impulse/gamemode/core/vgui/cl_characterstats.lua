local PANEL = {}
local w, h = ScrW(), ScrH()
local BackgroundCol = Color(0, 0, 0, 200)

function PANEL:Init()
	surface.PlaySound("hatchet/buttonrollover.wav")

	self:SetSize(w, h)
	self.alphavalue = 0

	local Anim = "lineidle0" .. math.random(1, 3)

	self.model = vgui.Create("impulseModelPanel", self)
	self.model:SetPos(ScrW() / 2 - (w * .15 / 2), 0)
	self.model:SetSize(w * .15, h * .55)
	self.model:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
	self.model:MoveToBack()
	self.model:SetCursor("arrow")
	self.model:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	self.model:SetDirectionalLight(BOX_FRONT, team.GetColor(LocalPlayer():Team()))

	self.model:SetFOV((324 / ScrH()) * 100) -- a incredible equation that makes the model fit onto the ui, patent by professor vin
	local frameTime = FrameTime()
	local approach = math.Approach

	function self.model:LayoutEntity(ent)
		local goal = true and 255 or 0
		local alpha = approach(self.alphavalue or 0, goal, frameTime * 300)
		ent:SetSequence( Anim )
		ent:SetAngles(Angle(-6, 45, 0))
		ent:SetPos(Vector(0, 0, 2.5))
		ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(ColorAlpha(Color(255, 255, 255), alpha))
		self:RunAnimation()


		self.alphavalue = alpha


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
	local BodyCol = Color(20, 20, 20)
	local BodyCol2 = Color(218, 56, 28)

	self.skillScroll = vgui.Create("DScrollPanel", self)
	self.skillScroll:SetSize(w * .4, h * .2)
	self.skillScroll:SetPos(20, h * .6)

	function self.skillScroll:Paint(w, h)
		HatchetDrawRect(0, 0, w, h)
	end

	for v,k in pairs(impulse.Skills.Skills) do
		local skillBg = self.skillScroll:Add("DPanel")
		skillBg:SetTall(37)
		skillBg:Dock(TOP)
		skillBg:DockMargin(0, 5, 15, 5)
		skillBg.Skill = v

		local level = LocalPlayer():GetSkillLevel(v)
		local xp = LocalPlayer():GetSkillXP(v)
		local lastXp = impulse.Skills.GetLevelXPRequirement(level - 1)
		local nextXp = impulse.Skills.GetLevelXPRequirement(level)
		function skillBg:Paint(w, h)

		   local skill = self.Skill
		   local skillName = impulse.Skills.GetNiceName(skill)

		   draw.DrawText(skillName.." || Level "..level.." || Total skill: "..xp.."XP || "..lastXp.."XP || "..nextXp.."XP", "Impulse-Elements22-Shadow", 5, 0, color_white, TEXT_ALIGN_LEFT)

			return true
		end


		local perc = (xp - lastXp) / (nextXp - lastXp)
		local bar = vgui.Create("DProgress", skillBg)
		bar:SetPos(8, 30)
		bar:SetSize(self.skillScroll:GetWide(),10)

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

	self.StatsScroll = vgui.Create("DScrollPanel", self)
	self.StatsScroll:SetSize(w * .4, h * .2)
	self.StatsScroll:SetPos(w * .59, h * .6)

	function self.StatsScroll:Paint(w, h)
		HatchetDrawRect(0, 0, w, h)
	end

	self.HpStat = vgui.Create("DPanel", self.StatsScroll)
	self.HpStat:SetHeight(50)
	self.HpStat:Dock(TOP)
	local hpstat = self.HpStat
	local hpicon = Material("hatchet/icon_characters.png")
	local hpcolor = Color(141, 39, 39)
	function self.HpStat:Paint()
		surface.SetDrawColor(BackgroundCol)
		surface.DrawRect(80, 21, hpstat:GetWide() - 121, 10)
		surface.SetMaterial(hpicon)
		surface.SetDrawColor(hpcolor)
		surface.DrawTexturedRect(14, 4, 46, 46)
		surface.DrawRect(80, 21, ( hpstat:GetWide() - 121 ) * math.Clamp(LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0, 1), 10)
	end

	self.HgStat = vgui.Create("DPanel", self.StatsScroll)
	self.HgStat:SetHeight(50)
	self.HgStat:Dock(TOP)
	local hgstat = self.HgStat
	local hgicon = Material("hatchet/food.png")
	local hgcolor = Color(189, 94, 31)
	function self.HgStat:Paint()
		surface.SetDrawColor(BackgroundCol)
		surface.DrawRect(80, 21, hgstat:GetWide() - 121, 10)
		surface.SetMaterial(hgicon)
		surface.SetDrawColor(hgcolor)
		surface.DrawTexturedRect(14, 4, 46, 46)
		surface.DrawRect(80, 21, ( hgstat:GetWide() - 121 ) * math.Clamp(LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0, 1), 10)
	end

	self.MoneyStat = vgui.Create("DPanel", self.StatsScroll)
	self.MoneyStat:SetHeight(50)
	self.MoneyStat:Dock(TOP)
	local MnyStat = self.MoneyStat
	local mnicon = Material("hatchet/icon_wallet.png")
	local mncolor = Color(53, 90, 38)
	function self.MoneyStat:Paint()
		surface.SetMaterial(mnicon)
		surface.SetDrawColor(mncolor)
		surface.DrawTexturedRect(14, 4, 46, 46)

		draw.SimpleText(impulse.Config.CurrencyName .. ": " .. LocalPlayer():GetMoney() .. impulse.Config.CurrencyPrefix, "Impulse-Elements22-Shadow", 80, 16, color_white, TEXT_ALIGN_LEFT)
	end

	self.BodyStats = vgui.Create("DScrollPanel", self)
	self.BodyStats:SetSize(w * .15, h * .5)
	self.BodyStats:SetPos(w * .59, h * .08)

	local figure_col = Color(255, 255, 255, 40)
	local injured_figure_col = Color(170, 41, 41)
	local body = Material("hatchet/limbs/body.png")
	local figure_larm = Material("hatchet/limbs/larm.png")
	local figure_rarm = Material("hatchet/limbs/rarm.png")
	local figure_lleg = Material("hatchet/limbs/lleg.png")
	local figure_rleg = Material("hatchet/limbs/rleg.png")
	local figure_head = Material("hatchet/limbs/head.png")
	local figure_chest = Material("hatchet/limbs/chest.png")

	function self.BodyStats:Paint(w, h)
		HatchetDrawRect(0, 0, w, h)

		surface.SetDrawColor(figure_col)
		surface.SetMaterial(body)
		surface.DrawTexturedRect(w * .04, h * 0.04, w * .9, h * .9)

		if LocalPlayer():GetNWBool("RLegCrippled") == true then
			surface.SetDrawColor(injured_figure_col)
			surface.SetMaterial(figure_rleg)
			surface.DrawTexturedRect(w * .04, h * 0.04, w * .9, h * .9)
		end

		if LocalPlayer():GetNWBool("LLegCrippled") == true then
			surface.SetDrawColor(injured_figure_col)
			surface.SetMaterial(figure_lleg)
			surface.DrawTexturedRect(w * .04, h * 0.04, w * .9, h * .9)
		end

		if LocalPlayer():GetNWBool("RArmCrippled") == true then
			surface.SetDrawColor(injured_figure_col)
			surface.SetMaterial(figure_rarm)
			surface.DrawTexturedRect(w * .04, h * 0.04, w * .9, h * .9)
		end

		if LocalPlayer():GetNWBool("LArmCrippled") == true then
			surface.SetDrawColor(injured_figure_col)
			surface.SetMaterial(figure_larm)
			surface.DrawTexturedRect(w * .04, h * 0.04, w * .9, h * .9)
		end

		surface.SetFont("HatchetFont-BodyParts")
		surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("LLeg"), 155 + LocalPlayer():GetNWInt("LLeg")))
		surface.SetTextPos(w * .06, h * .8)
		surface.DrawText("L-LEG: "..math.Round(LocalPlayer():GetNWInt("LLeg"), 1).."/100")

		surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("RLeg"), 155 + LocalPlayer():GetNWInt("RLeg")))
		surface.SetTextPos(w * .66, h * .8)
		surface.DrawText("R-LEG: "..math.Round(LocalPlayer():GetNWInt("RLeg"), 1).."/100")

		surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("LArm"), 155 + LocalPlayer():GetNWInt("LArm")))
		surface.SetTextPos(w * .02, h * .55)
		surface.DrawText("L-ARM: "..math.Round(LocalPlayer():GetNWInt("LArm"), 1).."/100")

		surface.SetTextColor(Color(255, 155 + LocalPlayer():GetNWInt("RArm"), 155 + LocalPlayer():GetNWInt("RArm")))
		surface.SetTextPos(w * .68, h * .55)
		surface.DrawText("R-ARM: "..math.Round(LocalPlayer():GetNWInt("RArm"), 1).."/100")
	end

end

function PANEL:Paint(w, h)
	impulse.blur(self, 6, 8, 255)

	surface.SetDrawColor(BackgroundCol)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("Hatchet_CharacterStats", PANEL, "DPanel")

local PANEL = {}

function PANEL:Init()
    local w, h = ScrW(), ScrH()
    if !LocalPlayer():IsCP() then
        self:Remove()
        return
    end
    self:SetSize(320, 700)
    self:MakePopup()
    self:Center()
    self:SetTitle("Combine Civil Terminal")

	LocalPlayer():EmitSound("buttons/combine_button7.wav", 100, 100, 0.33)


    local scroll = vgui.Create( "DScrollPanel", self )
    scroll:Dock( FILL )

    local background = Color(53, 53, 53, 196)
    for k, v in pairs(player.GetAll()) do
        if v:Team() == TEAM_RESISTANCE then continue end
        local butt = scroll:Add( "DPanel" )
        butt:SetTall(50)
        butt:Dock( TOP )
        butt:DockMargin( 0, 0, 0, 2 )
        local TeamCol = team.GetColor(v:Team())
        local class = team.GetClass(v:Team()) or "None"

        function butt:Paint(w, h)


            surface.SetDrawColor(background)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(TeamCol)
            surface.DrawOutlinedRect(0, 0, w, h, 1)

            draw.SimpleText(v:KnownName(), "BudgetLabel", 4, 0, color_white)
            draw.SimpleText(v:GetSyncVar(SYNC_BANKMONEY), "BudgetLabel", 4, 24, color_white)
            draw.SimpleText(team.GetName(v:Team()), "BudgetLabel", 4, 12, color_white)
            draw.SimpleText("CLASS: " .. class, "BudgetLabel", 4, 36, color_white)

        end

         	self.modelIcon = vgui.Create("impulseSpawnIcon", butt)
             self.modelIcon:SetPos(250,4)
             self.modelIcon:SetSize(43,43)
             self.modelIcon:SetModel(v:GetModel(), v:GetSkin())
             self.modelIcon:SetTooltip(false)
             self.modelIcon:SetDisabled(true)

             timer.Simple(0, function()
                 if not IsValid(self) then
                     return
                 end

                 local ent = self.modelIcon.Entity

                 if IsValid(ent) and IsValid(v) then
                     for w,k in pairs(v:GetBodyGroups()) do
                         ent:SetBodygroup(k.id, v:GetBodygroup(k.id))
                     end
                 end
             end)

             function self.modelIcon:PaintOver() -- remove that mouse hover effect
                 return false
             end
    end
end

function PANEL:OnRemove()
	LocalPlayer():EmitSound("buttons/combine_button7.wav", 100, 100, 0.33)
end

vgui.Register("CombineCivilTerminal_Screen", PANEL, "DFrame")
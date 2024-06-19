-- local PANEL = {}

-- if CLIENT then
--     function PANEL:Init()
--         self:SetSize(300,400)
--         self:SetTitle("Animation Menu")
--         self:Center()
--         self:MakePopup()

--         local AnimList = {
--             "plazastand1",
--             "plazastand2",
--             "plazastand3",
--             "plazastand4"
--         }

--         for k,v in ipairs(AnimList) do
--             self.DermaButton = vgui.Create( "DButton", self )
--             self.DermaButton:SetText( v )
--             self.DermaButton:SetFont("HatchetFont18")
--             self.DermaButton:Dock(TOP)
--             self.DermaButton:DockMargin(0, 0, 0, 5)
--             self.DermaButton:SetSize( 260, 20 )
--             self.DermaButton.DoClick = function()
--                 net.Start("HatchetAnimationCall")
--                 net.WriteString(v)
--                 net.SendToServer()
--             end
--         end
--     end

--     vgui.Register("HatchetAnimationMenu", PANEL, "DFrame")
-- end
local PANEL = {}

function PANEL:Init()
	self:SetSize(400, ScrH())
	self:Center()
	self:SetPos(ScrW(), 0)
	self:MoveTo(ScrW() - 400, 0, .5, 0, .5)
	self:SetTitle("Scoreboard")
	self:ShowCloseButton(false)
	self:SetDraggable(false)
	self:MakePopup()
 	self:MoveToFront()

 	self.scrollPanel = vgui.Create("DScrollPanel", self)
	self.scrollPanel:Dock(FILL)

	local playerList = player.GetAll()
	table.sort(playerList, function(a,b)
		return a:Team() > b:Team()
	end)
	
	for v,k in pairs(playerList) do
		if k:IsAdmin() and k:GetSyncVar(SYNC_INCOGNITO, false) then
			continue
		end

		local playerCard = self.scrollPanel:Add("impulseScoreboardCard")
		playerCard:SetPlayer(k)
		playerCard:SetHeight(60)
		playerCard:Dock(TOP)
		playerCard:DockMargin(0,0,0,0)
	end

end


vgui.Register("impulseScoreboard", PANEL, "DFrame")

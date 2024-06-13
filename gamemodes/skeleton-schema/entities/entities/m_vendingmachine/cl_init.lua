include("shared.lua")
ENT.AutomaticFrameAdvance = true

local redCol = Color(255, 50, 50)
local greenCol = Color(50, 255, 50)
local glowMat = Material("sprites/glow04_noz")
local gradLeft = Material("vgui/gradient-l")
function ENT:Draw()
	self:DrawModel()
	self:CreateShadow()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 900 then return end

	local position = self:GetPos()
	local angles = self:GetAngles()
	local position = self:GetPos()
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

	self.buttonLocation = self.buttonLocation or {}

	self.buttonLocation[1] = position + f*18 + r*-24.4 + u*4.9

	angles:RotateAroundAxis(angles:Up(), 90)
	angles:RotateAroundAxis(angles:Forward(), 90)

	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
	
	render.SetMaterial(glowMat)
	
	if self:GetStock() == false then
		render.DrawSprite(self.buttonLocation[1], 4, 4, redCol)
	else
		render.DrawSprite(self.buttonLocation[1], 4, 4, greenCol)
	end


end

-- if (CLIENT) then
-- 	index = index or 1
-- 	deltaIndex = deltaIndex or index
-- 	infoAlpha = infoAlpha or 0
-- 	alpha = alpha or 0
-- 	alphaDelta = alphaDelta or alpha
-- 	fadeTime = fadeTime or 0

-- 	local matrixScale = Vector(1, 1, 0)

-- 	function PLUGIN:LoadFonts(font, genericFont)
-- 		surface.CreateFont("Trebuchet18", {
-- 			font = font,
-- 			size = ScreenScale(16),
-- 			extended = true,
-- 			weight = 1000
-- 		})
-- 	end

-- 	function PLUGIN:HUDShouldDraw(name)
-- 		if (name == "CHudWeaponSelection") then
-- 			return false
-- 		end
-- 	end	

-- 	function PLUGIN:HUDPaint()
-- 		local frameTime = FrameTime()

-- 		alphaDelta = Lerp(frameTime * 10, alphaDelta, alpha)

-- 		local fraction = alphaDelta

-- 		if (fraction > 0.01) then
-- 			local x, y = ScrW() * 0.5, ScrH() * 0.5
-- 			local spacing = math.pi * 0.85
-- 			local radius = 240 * alphaDelta
-- 			local shiftX = ScrW() * .02

-- 			deltaIndex = Lerp(frameTime * 12, deltaIndex, index)

-- 			local weapons = LocalPlayer():GetWeapons()
-- 			local index = deltaIndex

-- 			if (!weapons[index]) then
-- 				index = #weapons
-- 			end

-- 			for i = 1, #weapons do
-- 				local theta = (i - index) * 0.1

-- 				local lastY = 0

-- 				if (markup and (i < index or i == 1)) then
-- 					if (index != 1) then
-- 						local _, h = markup:Size()
-- 						lastY = h * fraction
-- 					end

-- 					if (i == 1 or i == index - 1) then
-- 						infoAlpha = Lerp(frameTime * 3, infoAlpha, 255)
-- 						markup:Draw(x + 6 + shiftX, y + 30, 0, 0, infoAlpha * fraction)
-- 					end
-- 				end

-- 				surface.SetFont("Trebuchet18")
-- 				local weaponName = weapons[i]:GetPrintName()
-- 				local _, ty = surface.GetTextSize(weaponName)
-- 				local scale = 1 - math.abs(theta * 2)

-- 				local matrix = Matrix()
-- 				matrix:Translate(Vector(
-- 					shiftX + x + math.cos(theta * spacing + math.pi) * radius + radius,
-- 					y + lastY + math.sin(theta * spacing + math.pi) * radius - ty / 2 ,
-- 					1))
-- 				matrix:Scale(matrixScale * scale)

-- 				cam.PushModelMatrix(matrix)
-- 					draw.SimpleTextOutlined(weaponName, "Trebuchet18", 2, y / 4, Color(255, 255, 255), 0, 1, 1, Color(0,0,0))
-- 				cam.PopModelMatrix()
-- 			end

-- 			if (fadeTime < CurTime() and alpha > 0) then
-- 				alpha = 0
-- 			end
-- 		end
-- 	end

-- 	function OnIndexChanged(weapon)
-- 		alpha = 1
-- 		fadeTime = CurTime() + 5
-- 		markup = nil

-- 		if (IsValid(weapon)) then
-- 			local instructions = weapon.Instructions
-- 			local text = ""

-- 			if (instructions != nil and instructions:find("%S")) then
-- 				local color = Color(255, 255, 255)
-- 				text = text .. string.format(
-- 					"<font=ixItemBoldFont><color=%d,%d,%d>%s</font></color>\n%s\n",
-- 					color.r, color.g, color.b, L("Instructions"), instructions
-- 				)
-- 			end

-- 			if (text != "") then
-- 				markup = markup.Parse("<font=ixItemDescFont>"..text, ScrW() * 0.3)
-- 				infoAlpha = 0
-- 			end

-- 			local source, pitch = hook.Run("WeaponCycleSound")
-- 			LocalPlayer():EmitSound(source or "common/talk.wav", 50, pitch or 180)
-- 		end
-- 	end

-- 	function PLUGIN:PlayerBindPress(client, bind, pressed)
-- 		bind = bind:lower()

-- 		if (!pressed or !bind:find("invprev") and !bind:find("invnext")
-- 		and !bind:find("slot") and !bind:find("attack")) then
-- 			return
-- 		end

-- 		local currentWeapon = client:GetActiveWeapon()
-- 		local bValid = IsValid(currentWeapon)
-- 		local bTool

-- 		if (client:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and client:KeyDown(IN_ATTACK))) then
-- 			return
-- 		end

-- 		if (bValid and currentWeapon:GetClass() == "gmod_tool") then
-- 			local tool = client:GetTool()
-- 			bTool = tool and (tool.Scroll != nil)
-- 		end

-- 		local weapons = client:GetWeapons()

-- 		if (bind:find("invprev") and !bTool) then
-- 			local oldIndex = index
-- 			index = math.min(index + 1, #weapons)

-- 			if (alpha == 0 or oldIndex != index) then
-- 				OnIndexChanged(weapons[index])
-- 			end

-- 			return true
-- 		elseif (bind:find("invnext") and !bTool) then
-- 			local oldIndex = index
-- 			index = math.max(index - 1, 1)

-- 			if (alpha == 0 or oldIndex != index) then
-- 				OnIndexChanged(weapons[index])
-- 			end

-- 			return true
-- 		elseif (bind:find("slot")) then
-- 			index = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, #weapons)
-- 			OnIndexChanged(weapons[index])

-- 			return true
-- 		elseif (bind:find("attack") and alpha > 0) then
-- 			local weapon = weapons[index]

-- 			if (IsValid(weapon)) then
-- 				LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", weapon) or "HL2Player.Use")

-- 				input.SelectWeapon(weapon)
-- 				alpha = 0
-- 			end

-- 			return true
-- 		end
-- 	end

-- 	function PLUGIN:Think()
-- 		local client = LocalPlayer()
-- 		if (!IsValid(client) or !client:Alive()) then
-- 			alpha = 0
-- 		end
-- 	end

-- 	function PLUGIN:ScoreboardShow()
-- 		alpha = 0
-- 	end

-- 	function PLUGIN:ShouldPopulateEntityInfo(entity)
-- 		if (alpha > 0) then
-- 			return false
-- 		end
-- 	end
-- end
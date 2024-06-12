-- Works pretty much like the noclip flashlight.
local lightOn = false
local prevFState = false -- Track the previous state of F key press

local function GetNightVisionColor(ply)
    local col

    if ply:Team() == TEAM_OTA then
        local class = ply:GetTeamClass()
        if class == 1 then
            col = Color(22, 78, 94) 
        elseif class == 2 then
            col = Color(80, 1, 0) 
        elseif class == 3 then
            col = Color(255, 0, 0) 
        else
            col = Color(0, 0, 0) 
        end
    else
        col = Color(0, 0, 0)
    end

    return col
end

local function ToggleNightVision()
    local ply = LocalPlayer()
    if not IsValid(ply) then
        return
    end

    if ply:Team() ~= TEAM_OTA then
        return
    end

    if not ply:GetTeamClass() then
        return
    end
	
	if ply:IsTyping() then
		return
	end

    lightOn = not lightOn

    if lightOn then
        surface.PlaySound("buttons/button18.wav")
    else
        surface.PlaySound("buttons/button18.wav")
    end
end

hook.Add("Think", "ToggleNightVision", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then
        lightOn = true
        prevFState = false -- Reset previous F key state
        return
    end

    local button = KEY_F
    local currentFState = input.IsKeyDown(button)

    if (ply:Team() == TEAM_OTA) and (!ply:IsTyping() and ply:GetMoveType() != MOVETYPE_NOCLIP) and currentFState and not prevFState then
        ToggleNightVision()
    end

    prevFState = currentFState -- Update previous F key state

    if lightOn and ply:GetTeamClass() then
        local dLight = DynamicLight(ply:EntIndex())
        if dLight then
            dLight.pos = ply:EyePos()

            local col = GetNightVisionColor(ply)
            dLight.r = col.r
            dLight.g = col.g
            dLight.b = col.b
            dLight.brightness = 0.5
            local size = 30000
            dLight.Size = size
            dLight.Decay = size
            dLight.DieTime = CurTime() + 0.8
        end
    end
end)

-- Turn off night vision light when player dies
hook.Add("PlayerDeath", "TurnOffNightVisionOnDeath", function(ply)
    if ply:Team() == TEAM_OTA then
        lightOn = false
        prevFState = false -- Reset previous F key state
    end
end)


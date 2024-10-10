local larm = 0
local rarm = 0

local RandomPitchValue = 0
local RandomTiltValue = 0
local RandomRotationValue = 0

local RotMax = 100
local PitchMax = 20
local TiltMax = 15

local function GetDamagedArmsCount()
	if LocalPlayer():GetNWBool("LArmCrippled") == true then larm = 1 end
	if LocalPlayer():GetNWBool("RArmCrippled") == true then rarm = 1 end
	return larm + rarm
end

hook.Add("PlayerTick", "HatchetDamagedArmsView", function(ply, cmd)
	if GetDamagedArmsCount() == 0 then return end
	if not IsValid(LocalPlayer():GetActiveWeapon()) then return end
	if LocalPlayer():GetActiveWeapon().Base != "m_base" then return end

	local curRotation =  LocalPlayer():EyeAngles().y
	local curPitch =  LocalPlayer():EyeAngles().x
	local curTilt =  LocalPlayer():EyeAngles().z

	local RotMod = 1
	local PitchMod = 1
	local TiltMod = 1
	local ratio = (PitchMax/RotMax)

	local LMod = 1

	RandomRotationValue = math.Clamp(RandomRotationValue + math.Rand(-1*RotMax*0.05, RotMax*0.05), -1*RotMax,RotMax)
	RandomPitchValue = math.Clamp(RandomPitchValue + math.Rand(-1*PitchMax*0.2, PitchMax*0.2), -1*PitchMax,PitchMax)
	RandomTiltValue = math.Clamp(RandomTiltValue + math.Rand(-1*TiltMax*0.2, TiltMax*0.2), -1*TiltMax,TiltMax)

	if curPitch > 45 or curPitch < -45 then RandomPitchValue = 0 end

	local lookDownMod = 1

	if curPitch > 35 then
		lookDownMod = 0.2
	end

	
		if GetDamagedArmsCount() == 1 then
			LMod = 10
		elseif GetDamagedArmsCount() == 2 then
			LMod = 5
		end

		if RandomRotationValue <= LMod*-1 then
			RotMod = -1
		elseif RandomRotationValue < LMod then
			RotMod = 0
		end

		if RandomPitchValue <= LMod*-1*ratio  then
			PitchMod = -1
		elseif RandomPitchValue < LMod*ratio  then
			PitchMod = 0
		end

		LocalPlayer():SetEyeAngles(Angle(curPitch+(lookDownMod*0.2*PitchMod*0.2*(math.abs(RandomPitchValue)-(LMod*ratio))*FrameTime()),curRotation+(lookDownMod*0.2*RotMod*0.2*(math.abs(RandomRotationValue)-LMod)*FrameTime()),0))
end)

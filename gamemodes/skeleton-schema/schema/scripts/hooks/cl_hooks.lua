// Yeah.. thats the uhh... stuff.. i think.. i dont know

function GetOverviewInfo(origin, angles, fov)
	local originAngles = Angle(0, angles.yaw, angles.roll)
	local target = LocalPlayer():GetObserverTarget()
	local fraction = 1
	local bDrawPlayer = true
	local forward = originAngles:Forward() * 58 - originAngles:Right() * 24
	forward.z = 0

	local newOrigin

	if (IsValid(target)) then
		newOrigin = target:GetPos() + forward
	else
		newOrigin = origin - LocalPlayer():OBBCenter() * 0.6 + forward
	end

	local newAngles = originAngles + Angle(0,180,0)
	newAngles.pitch = 5
	newAngles.roll = 0

	return LerpVector(fraction, origin, newOrigin), LerpAngle(fraction, angles, newAngles), Lerp(fraction, fov, 90), bDrawPlayer
end

hook.Remove("CalcView", "PlayerPreview")

-- RunConsoleCommand("disconnect")

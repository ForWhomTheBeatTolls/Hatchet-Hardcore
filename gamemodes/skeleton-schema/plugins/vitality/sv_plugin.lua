local v = Entity(1)

function VitalitySystem()
    if v:GetSkillXP("vital") <= 299 then
        --v:Say("Under 300")
        v:SetRunSpeed(impulse.Config.JogSpeed)
    elseif v:GetSkillXP("vital") <= 300 then
        v:SetRunSpeed(impulse.Config.JogSpeed  * 1.02)
        --v:Say("300")
    elseif v:GetSkillXP("vital") <= 600 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.04)
        --v:Say("600")
    elseif v:GetSkillXP("vital") <= 1499 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.04)
        --v:Say("600")
    elseif v:GetSkillXP("vital") <= 1500 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.05)
        --v:Say("1500")
    elseif v:GetSkillXP("vital") <= 2799 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.05)
        --v:Say("1500")
    elseif v:GetSkillXP("vital") <= 2800 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
        --v:Say("2800")
    elseif v:GetSkillXP("vital") <= 4499 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
        --v:Say("2800")
    elseif v:GetSkillXP("vital") <= 4500 then
        v:SetRunSpeed(impulse.Config.JogSpeed * 1.08)
        --v:Say("4500")
    end
end

local delay = 0
hook.Add( "Think", "THE_CUM_LAGNATOR", function()
	if CurTime() < delay then return end	
	VitalitySystem()
	delay = CurTime() + 4
    v:AddSkillXP("vital", -2)
    --print(v:GetSkillXP("vital"))
end)

print("sv_plugin for vitality ran")
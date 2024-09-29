local LocalRagdollID = 0
local LastRagdollEntity = nil

net.Receive("BD.DeathCam", function()
    local id = net.ReadInt(32)
    LocalRagdollID = id
end)

hook.Add("CalcView","RagDeath_Cam",function(ply, pos, angles, fov, znear)
    --if !GetConVar("bd_customcamdisable"):GetBool() then
        local LocalRagdoll = Entity(LocalRagdollID)
        if LocalPlayer():Alive() then
            if IsValid(LocalRagdoll) and LocalRagdoll:LookupBone("ValveBiped.Bip01_Head1") != nil and LocalRagdoll:LookupBone("ValveBiped.Bip01_Head1") > 0 then
                LocalRagdoll:ManipulateBoneScale(LocalRagdoll:LookupBone("ValveBiped.Bip01_Head1"), Vector(1,1,1))
            end
            return 
        end
        if not IsValid(LocalRagdoll) then return end
        local ent = GetViewEntity()
        if ent != LocalPlayer() then return end

            --LocalRagdoll:ManipulateBoneScale(LocalRagdoll:LookupBone("ValveBiped.Bip01_Head1"), Vector(0,0,0))
            
            local att = LocalRagdoll:GetAttachment(LocalRagdoll:LookupAttachment('eyes'))
            local pos = att.Pos
            local ang = att.Ang
            return {
                origin=pos,
                angles=ang,
                fov=fov,
                znear=4.8
            }
    --end
end)
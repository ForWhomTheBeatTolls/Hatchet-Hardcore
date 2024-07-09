function AddIntroduction(greeter, visitor)
    local theframe = util.JSONToTable(visitor:GetSyncVar(SYNC_RECOGNIZES))

    theframe[greeter:SteamID()] = true

    local query = mysql:Update("impulse_players")
    query:Where("steamid", visitor:SteamID())
    query:Update("recognizedata", util.TableToJSON(theframe))
    query:Execute()
    Entity(visitor:EntIndex()):SetSyncVar(SYNC_RECOGNIZES, util.TableToJSON(theframe), true)
end

local RecognitionCore = {
    description = "Introduce yourself to the person infront of you.",
    adminOnly = false,
    onRun = function(ply, arg, rawText)
        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 150,
            filter = ply
        })
        local hitplayer = trace.Entity
        if trace.Hit and IsValid(trace.Entity) then
            AddIntroduction(ply, hitplayer)
        end

        local tabl = util.JSONToTable(ply:GetSyncVar(SYNC_RECOGNIZES))
        if tabl[hitplayer:SteamID()] then
            ply:Notify( "You introduced yourself to " .. hitplayer:Name() .. "." )
            hitplayer:Notify(ply:Name() .. " Introduced himself to you.")
        else
            ply:Notify( "You introduced yourself to an unknown person." )
            hitplayer:Notify(ply:Name() .. " Introduced himself to you.")
        end
    end
}

impulse.RegisterChatCommand("/introduceinfront", RecognitionCore)

local TalkRecognitionCore = {
    description = "Introduce yourself to the people around you in a talk radius.",
    adminOnly = false,
    onRun = function(ply, arg, rawText)
        for v,k in pairs(player.GetAll()) do
            if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then
                local tabl = util.JSONToTable(k:GetSyncVar(SYNC_RECOGNIZES))

                if k:SteamID() == ply:SteamID() then continue end

                if k:IsCP() then return end

                if tabl[ply:SteamID()] then
                    return
                else

                    AddIntroduction(ply, k)

                    if tabl[k:SteamID()] then
                        ply:Notify( "You introduced yourself to " .. k:Name() .. "." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    else
                        ply:Notify( "You introduced yourself to an unknown person." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    end
                end


            end
        end
    end
}

impulse.RegisterChatCommand("/introducetalk", TalkRecognitionCore)

local YellRecognitionCore = {
    description = "Introduce yourself to the people around you in a yell radius.",
    adminOnly = false,
    onRun = function(ply, arg, rawText)
        for v,k in pairs(player.GetAll()) do
            if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.YellDistance ^ 2) then
                local tabl = util.JSONToTable(k:GetSyncVar(SYNC_RECOGNIZES))

                if k:SteamID() == ply:SteamID() then continue end

                if k:IsCP() then return end

                if tabl[ply:SteamID()] then
                    return
                else

                    AddIntroduction(ply, k)

                    if tabl[k:SteamID()] then
                        ply:Notify( "You introduced yourself to " .. k:Name() .. "." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    else
                        ply:Notify( "You introduced yourself to an unknown person." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    end
                end


            end
        end
    end
}

impulse.RegisterChatCommand("/introduceyell", YellRecognitionCore)

local WhisperRecognitionCore = {
    description = "Introduce yourself to the people around you in a whisper radius.",
    adminOnly = false,
    onRun = function(ply, arg, rawText)
        for v,k in pairs(player.GetAll()) do
            if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.WhisperDistance ^ 2) then
                local tabl = util.JSONToTable(k:GetSyncVar(SYNC_RECOGNIZES))

                if k:SteamID() == ply:SteamID() then continue end

                if k:IsCP() then return end

                if tabl[ply:SteamID()] then
                    return
                else

                    AddIntroduction(ply, k)

                    if tabl[k:SteamID()] then
                        ply:Notify( "You introduced yourself to " .. k:Name() .. "." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    else
                        ply:Notify( "You introduced yourself to an unknown person." )
                        k:Notify(ply:Name() .. " Introduced himself to you.")
                    end
                end


            end
        end
    end
}

impulse.RegisterChatCommand("/introducewhisper", WhisperRecognitionCore)

local dwad = {
    description = " resets ur introduction (temp com for testing)",
    adminOnly = false,
    onRun = function(ply, arg, rawText)
        local selfintroduce = {
            [ply:SteamID()] = true,
        }

        local query = mysql:Update("impulse_players")
        query:Where("steamid", ply:SteamID())
        query:Update("recognizedata", util.TableToJSON(selfintroduce))
        query:Execute()

        ply:SetSyncVar(SYNC_RECOGNIZES, util.TableToJSON(selfintroduce), true)
        print(table.ToString(util.JSONToTable(ply:GetSyncVar(SYNC_RECOGNIZES))))
    end
}

impulse.RegisterChatCommand("/introducereset", dwad)


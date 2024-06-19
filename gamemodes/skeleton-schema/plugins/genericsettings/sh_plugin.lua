if CLIENT then
impulse.DefineSetting("hud_jim", {name="Movement Indicator", category="HUD", type="tickbox", default=false})
impulse.DefineSetting("hud_hunger", {name="Hunger Bar", category="HUD", type="tickbox", default=true})
impulse.DefineSetting("hud_ambience", {name="Ambience Color", category="HUD", type="tickbox", default=true})
impulse.DefineSetting("admin_dispatch", {name="Dispatch", category="ops", type="tickbox", default=false})
impulse.DefineSetting("ambience_sounds", {name="Ambience Sounds (WIP)", category="Misc", type="tickbox", default=true})
impulse.DefineSetting("hud_ambienceindoors", {name="Automatically disable Ambience Color while indoors (WIP)", category="HUD", type="tickbox", default=false})
end

-- local StopAnims = {
--     description = "Gives the player the item specified",
--     requiredArg = false,
--     adminOnly = true,
--     onRun = function(ply, arg)
--         ply:ForceSequence("plazastand2", nil, 0.001, true)
--     end
-- }


-- impulse.RegisterChatCommand("/actstop", StopAnims)

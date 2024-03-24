-- impulse.NPCDrops = {
    -- ["npc_metropolice"] = {
        -- max = 2,
        -- items = {
            -- "wep_smg",
            -- "util_biolink",
            -- "util_metalplate",
            -- "item_healthvial",
            -- "wep_pistol",
            -- "ammo_pistol",
            -- "ammo_smg"
        -- }
    -- },
    -- ["npc_cscanner"] = {
        -- max = 4,
        -- items = {
            -- "util_biolink",
            -- "util_metalplate"
        -- }
    -- },
    -- ["npc_manhack"] = {
        -- max = 2,
        -- items = {
            -- "util_biolink",
            -- "util_metalplate"
        -- }
    -- },
    -- ["npc_zombine"] = {
        -- max = 1,
        -- items = {
            -- "util_ruinedotavest",
            -- "util_biolink",
            -- "util_metalplate"
        -- }
    -- },
    -- ["npc_combine_s"] = {
        -- max = 4,
        -- items = {
            -- "wep_smg",
            -- "util_ruinedotavest",
            -- "util_biolink",
            -- "item_healthvial",
            -- "util_metalplate",
            -- "ammo_rifle",
            -- "ammo_smg"
        -- }
    -- }
-- }local PLUGIN = PLUGINPLUGIN.name = "NPC Drops"PLUGIN.author = "eon"PLUGIN.description = "NPCs drop items when killed."impulse.NPCDrops = impulse.NPCDrops or {}impulse.NPCDrops.stored = impulse.NPCDrops.stored or {}function impulse.NPCDrops:Define(class, data)    self.stored[class] = dataendinclude("sv_plugin.lua")
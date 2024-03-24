local ragdolls = ents.FindByClass( "prop_ragdoll" )
local ClearRagsCommand = {
	adminOnly = true,
    description = "Clears all ragdolls for performance.",
    onRun = function(ent)
		for k, v in ipairs( ents.FindByClass( "prop_ragdoll" ) ) do
	v:Remove() 
end
	end
}
impulse.RegisterChatCommand("/clearrags", ClearRagsCommand)
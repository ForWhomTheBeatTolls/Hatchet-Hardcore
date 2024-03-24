local ClearItemsCommand = {
	adminOnly = true,
    description = "Clears all items for performance.",
    onRun = function(ent)
		for k, v in ipairs( ents.FindByClass( "impulse_item" ) ) do
	v:Remove() 
end
	end
}
impulse.RegisterChatCommand("/clearitems", ClearItemsCommand)
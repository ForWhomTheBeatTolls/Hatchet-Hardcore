-- put shared hooks here, format the same as sv_hooks.lua

hook.Add( "PlayerSay", "SpeechAnimations", function( ply, text )

	if not (timer.Exists(ply:SteamID64().." SpeechAnimDelay")) and not string.StartsWith(text, "/") and (ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_RESISTANCE) then
		ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE, 1739)
	
		if ply:GetVelocity():LengthSqr() == 0  then
			timer.Create(ply:SteamID64().." SpeechAnimDelay", ply:SequenceDuration() - 6.6, 1, function() end)
		else 
			timer.Create(ply:SteamID64().." SpeechAnimDelay", ply:SequenceDuration() + 3, 1, function() end)
		end
	
	end
	
end )

hook.Add("PlayerStartVoice", "SpeechAnimationsVC", function(ply)
	
	if not (timer.Exists(ply:SteamID64().." SpeechAnimDelayVC")) and ply:IsSpeaking()  then
	--ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE, 1739)
	
	if IsValid(ply) and ply:GetVelocity():LengthSqr() == 0  then
	timer.Create(ply:SteamID64().." SpeechAnimDelayVC", ply:SequenceDuration() - 6.6, 95, function() if IsValid(ply) and ply:IsSpeaking() then ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE, 1739) end end)
	else 
	timer.Create(ply:SteamID64().." SpeechAnimDelayVC", ply:SequenceDuration() + 3, 95, function() if IsValid(ply) and ply:IsSpeaking() then ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE, 1739) end end)
	end
	end
	--return true
	end)

local icon = Material("icon32/unmuted.png")
local function iconfunc()
	surface.SetDrawColor(255,166,0)
	surface.SetMaterial(icon)
	surface.DrawTexturedRect(1820,996,100,100)
end

hook.Add("PlayerStartVoice", "SpeechIcon", function(ply)
	if LocalPlayer():IsSpeaking() then
		hook.Add("HUDPaint", "SpeechIcon", iconfunc)
	end
	return true
	end)

hook.Add("PlayerEndVoice", "SpeechIcon", function(ply)
	if not LocalPlayer():IsSpeaking() then
		hook.Remove("HUDPaint", "SpeechIcon")
	end
end)

hook.Add( "PlayerSwitchFlashlight", "BlockFlashLight", function( ply, enabled )
	return (ply:Team() != TEAM_OTA and ply:HasInventoryItem("tool_flashlight") or ply:Team() == TEAM_CP) and ply:GetMoveType() != MOVETYPE_NOCLIP
end )


hook.Add("SetupMove","CustomSpeeds", function( ply, mvData )

local iscitizen = ply:Team() == TEAM_CITIZEN
local isrebel = ply:Team() == TEAM_RESISTANCE
local iscp = ply:Team() == TEAM_CP
local isover = ply:Team() == TEAM_OTA
local citizen = TEAM_CITIZEN
local rebel = TEAM_RESISTANCE
local cp = TEAM_CP
local over = TEAM_OTA

	--if iscitizen or isrebel then
	--mvData:SetMaxClientSpeed( 194.40 )
	--mvData:SetMaxSpeed( 194.40 )
	--elseif iscp then
	--mvData:SetMaxClientSpeed( 206.20 )
	--mvData:SetMaxSpeed( 206.20 )
	--elseif isover then
	--mvData:SetMaxClientSpeed( 184.20 )
	--mvData:SetMaxSpeed( 184.20 )
	--end
	
	if mvData:KeyDown(IN_MOVERIGHT) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / 2.5 )
	end
	if mvData:KeyDown(IN_MOVELEFT) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / -2.5 )
	end
	if mvData:KeyDown(IN_MOVERIGHT) and mvData:KeyDown(IN_FORWARD) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / 2 )
	mvData:SetForwardSpeed( mvData:GetMaxClientSpeed() / 1.9 )
	end
	if mvData:KeyDown(IN_MOVELEFT) and mvData:KeyDown(IN_FORWARD) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / -2 )
	mvData:SetForwardSpeed( mvData:GetMaxClientSpeed() / 1.9 )
	end
	if mvData:KeyDown(IN_MOVERIGHT) and mvData:KeyDown(IN_BACK) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / 3.5 )
	mvData:SetForwardSpeed( mvData:GetMaxClientSpeed() / -3.9 )
	end
	if mvData:KeyDown(IN_MOVELEFT) and mvData:KeyDown(IN_BACK) then
	mvData:SetSideSpeed( mvData:GetMaxClientSpeed() / -3.5 )
	mvData:SetForwardSpeed( mvData:GetMaxClientSpeed() / -3.9 )
	end
	if mvData:KeyDown(IN_BACK) then
	mvData:SetForwardSpeed( mvData:GetMaxClientSpeed() / -2.3 )
	end
end )

hook.Add( "OnPlayerHitGround", "HopperPunishment", function( player, inWater, onFloater, speed )
	local vel = player:GetVelocity()

	if speed > 10 and not onFloater then --inWater or onFloater then
	--print(player:GetVelocity())
	player:SetVelocity( Vector( -( vel.x / 3.8 ), -( vel.y / 3.8 ), -0 ) )
	end

end)

	for k,v in pairs(ents.FindByClass("player")) do
	v:ManipulateBoneScale( 22, Vector( 1,1,1 ))
	v:ManipulateBoneScale( 18, Vector( 1,1,1 ))
	v:ManipulateBoneScale( 0,  Vector( 1,1,1 ))
	v:ManipulateBoneJiggle( 22, 0 )
	v:ManipulateBoneJiggle( 18, 0 )
	v:ManipulateBoneJiggle( 0, 0 )
	
	end

-- hook.Add( "Think", "ResolveBoneFuckery", function()
	-- for _, ply in ipairs( player.GetAll() ) do
	-- local i = 0
	
	-- while i < ply:GetBoneCount() do
	-- if ply:GetBoneName(i) != "ValveBiped.Bip01_Head1" then
		-- ply:ManipulateBoneScale( i, Vector(1,1,1) )
		-- i = i + 1
	-- end
	-- end
-- end
-- end)
	
	-- ############################################################## --
	-- ### Cakeinator! Adjust values accordingly for April Fools. ### --
	-- ############################################################## --

// SUK ME OFF LIKE A BANANA YOU LUA HOOKER!!!! !! !!

hook.Add("PlayerSay", "NetCallerifSpeak", function(sender, text, teamchat)
	local msg
	local font = "BubbleChat-Talk"
	local teamcol = team.GetColor(sender:Team())
	local color = teamcol
	local chatradius = 0
	
	if string.StartsWith(text, "/me") then
		msg = string.Replace(text, "/me", "")
		if sender:Team() == TEAM_RESISTANCE then
		color = Color(224, 166, 57)
		else
		color = Color(224, 166, 57)
		end
		if string.EndsWith( text, "." ) or string.EndsWith( text, "?" ) or string.EndsWith( text, "!" ) then
			msg = string.upper( string.Left(msg, 1) )..string.Right( msg, string.len( msg ) - 1 )
		else
			msg = string.upper( string.Left(msg, 1) )..string.Right( msg, string.len( msg ) - 1 )..string.Replace(string.Right( msg, 1 ), string.Right( msg, 1 ), ".")
		end
		font = "BubbleChat-Me"
		chatradius = impulse.Config.TalkDistance
	elseif string.StartsWith(text, "/y") then
		if string.EndsWith( text, "." ) or string.EndsWith( text, "?" ) or string.EndsWith( text, "!" ) then
			text = string.upper(text)
		else
			text = string.upper(text)..string.Replace(string.Right( text, 1 ), string.Right( text, 1 ), "!")
		end
		print(text)
		msg = string.Replace(text, "/Y", "")
		if sender:Team() == TEAM_RESISTANCE then
		color = Color(255, 38, 0)
		else
		color = Color(255, 38, 0)
		end
		font = "BubbleChat-Yell"
		chatradius = impulse.Config.YellDistance
	elseif string.StartsWith(text, "/w") then
		if string.EndsWith( text, "." ) or string.EndsWith( text, "?" ) or string.EndsWith( text, "!" ) then
			text = string.upper(text)..string.Left(text, string.len(text) - 3)
		else
			text = string.upper(text)..string.Replace(string.Right( text, 1 ), string.Right( text, 1 ), ".")
		end
		msg = string.Replace(text, "/W", "")
		if sender:Team() == TEAM_RESISTANCE then
		color = Color(64, 201, 255)
		else
		color = Color(64, 201, 255)
		end
		font = "BubbleChat-Whisper"
		chatradius = impulse.Config.WhisperDistance
	elseif string.StartsWith(text, "/apply") then
		chatradius = impulse.Config.TalkDistance
		msg = text
	else
		if string.len(text) != 1 then
			if string.EndsWith( text, "." ) or string.EndsWith( text, "?" ) or string.EndsWith( text, "!" ) then
				text = string.upper( string.Left(text, 1) )..string.Right( text, string.len( text ) - 1 )
			else
				text = string.upper( string.Left(text, 1) )..string.Right( text, string.len( text ) - 1 )..string.Replace(string.Right( text, 1 ), string.Right( text, 1 ), ".")
			end
		else
			text = string.upper(string.Left(text, 1))..string.Replace(string.Right( text, 2 ), string.Right( text, 2 ), ".")
		end
		chatradius = impulse.Config.TalkDistance
		msg = text
		if sender:Team() == TEAM_RESISTANCE then
		color = team.GetColor(TEAM_CITIZEN)
		else
		color = team.GetColor(sender:Team())
		end
	end

    net.Start("HatchetBubbleChatCall")
    net.WriteString(msg)
	net.WriteColor(color)
	net.WriteString(font)
	net.WriteUInt(chatradius, 10)
    net.WritePlayer(sender)
	net.Broadcast()
end)


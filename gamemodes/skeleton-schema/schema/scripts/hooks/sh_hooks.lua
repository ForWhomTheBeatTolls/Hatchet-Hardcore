-- put shared hooks here, format the same as sv_hooks.lua

-- hook.Add( "PlayerSay", "OverheadMSG", function( ply, text )
		-- hook.Add( "HUDPaint", "OverheadMSGKid", function()
		-- local pos = ply:EyePos()

		-- pos.z = pos.z + 5
		-- pos = pos:ToScreen()
		-- pos.y = pos.y - 50
		-- surface.SetFont( "Default" )
		-- surface.SetTextColor( 255, 255, 255 )
		-- surface.SetTextPos( pos.x, pos.y ) 
		-- surface.DrawText( txt )
-- end )
-- end )

hook.Add( "PlayerSay", "SpeechAnimations", function( ply, text )
	--local animtime = ply:SequenceDuration(randomtalking)
	--local lastplayed = 0
	if not (timer.Exists(ply:SteamID64().." SpeechAnimDelay")) and not string.StartsWith(text, "/") and ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_RESISTANCE then
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE, 1739)
	
	if ply:GetVelocity():LengthSqr() == 0  then
	timer.Create(ply:SteamID64().." SpeechAnimDelay", ply:SequenceDuration() - 6.6, 1, function() end)
	else 
	timer.Create(ply:SteamID64().." SpeechAnimDelay", ply:SequenceDuration() + 3, 1, function() end)
	--lastplayed = CurTime()
	--print("I HATE IMPULSE!!!")
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

hook.Add( "PlayerSay", "GeorgeOrwellSponsorship", function( ply, text )
	if string.find( text, "nigger" ) then
		return string.gsub(text, "nigger", "racialslur")
	elseif string.find( text, "nigga" ) then
			return string.gsub(text, "nigga", "racialslur")
	elseif string.find( text, "n1gger" ) then
			return string.gsub(text, "n1gger", "racialslur")
	elseif string.find( text, "n1gga" ) then
			return string.gsub(text, "n1gga", "racialslur")
	elseif string.find( text, "faggot" ) then
			return string.gsub(text, "faggot", "racialslur")
	elseif string.find( text, "negro" ) then
			return string.gsub(text, "negro", "racialslur")
	elseif string.find( text, "NIGGER" ) then
			return string.gsub(text, "NIGGER", "racialslur")
	elseif string.find( text, "NIGGA" ) then
			return string.gsub(text, "NIGGA", "racialslur")
	elseif string.find( text, "N1GGER" ) then
			return string.gsub(text, "N1GGER", "racialslur")
	elseif string.find( text, "N1GGA" ) then
			return string.gsub(text, "N1GGA", "racialslur")
	elseif string.find( text, "FAGGOT" ) then
			return string.gsub(text, "FAGGOT", "racialslur")
	elseif string.find( text, "NEGRO" ) then
			return string.gsub(text, "NEGRO", "racialslur")
	end
end )

hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
		--if ply:KeyDown(IN_SPEED) then
		if ply:Team() == TEAM_CP and !ply:KeyDown(IN_SPEED) then
			--if ply == LocalPlayer() then
			--	EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, 65 / 100)
			--else
				ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 30)
			--end
		elseif ply:Team() == TEAM_CP and ply:KeyDown(IN_SPEED) then
				ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 70)
				
			return true
		end
		if ply:Team() == TEAM_OTA and !ply:KeyDown(IN_SPEED) then
			--if ply == LocalPlayer() then
				--EmitSound("NPC_CombineS.FootstepLeft", ply:GetPos(), 100, 100)
			--else
				ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 55)
		elseif ply:Team() == TEAM_OTA and ply:KeyDown(IN_SPEED) then
				ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 75)
			end
		if ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_RESISTANCE then
		return false
		end-- Don't allow default footsteps, or other addon footsteps
end)
	

hook.Add("PlayerHurt","dmgsounds",function(victim)
    if ( victim:Team() == TEAM_CP ) and (victim:Health() > 1) then
        victim:EmitSound("npc/metropolice/pain"..math.random(1,4)..".wav", 70)
	elseif ( victim:Team() == TEAM_OTA ) and (victim:Health() > 1) then
		victim:EmitSound("npc/combine_soldier/pain"..math.random(1,3)..".wav", 70)
	elseif ( victim:Team() == TEAM_CITIZEN or TEAM_RESISTANCE ) and (victim:Health() > 1) then
		victim:EmitSound("npc_citizen.pain0"..math.random(1,7).."", 80)
    end
end)

	local deathsounds = {
	"npc_citizen.die",
	"npc_citizen.startle01",
	"npc_citizen.startle02",
	"ep1_citizen.cit_pain04",
	"ep1_citizen.cit_pain06",
	"ep1_citizen.cit_pain07",
	"ep1_citizen.cit_shock02",
	"ep1_citizen.cit_shock08",
	"ep1_citizen.cit_shock11"
	}
	
	
hook.Add( "PlayerDeathSound", "CustomPlayerDeath", function( ply )
	if (ply:Team() == TEAM_CP) then
	ply:EmitSound("npc/metropolice/die"..math.random(1,4)..".wav", 70)
	--return true -- we don't want the default sound!
	end
	if (ply:Team() == TEAM_OTA) then
	ply:EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 70)
	--return true -- we don't want the default sound!
	end
	if (ply:Team() == TEAM_CITIZEN) then
	ply:EmitSound(table.Random(deathsounds), 100)
	--return true -- we don't want the default sound!
	end
	if (ply:Team() == TEAM_RESISTANCE) then
	ply:EmitSound(table.Random(deathsounds), 100)
	--return true -- we don't want the default sound!
	end
	return true
end )

hook.Add( "PlayerSwitchFlashlight", "BlockFlashLight", function( ply, enabled )
	return (ply:Team() != TEAM_OTA and ply:HasInventoryItem("tool_flashlight") or ply:Team() == TEAM_CP) and ply:GetMoveType() != MOVETYPE_NOCLIP  -- Allow the player to use their flashlight if they aren't OTA or have the Item for it
end )

hook.Add( "PlayerDeath", "ESPhackyfix", function( victim )
	victim:Give("gmod_tool")
	end)


hook.Add("SetupMove","CustomSpeeds", function( ply, mvData )

local iscitizen = ply:Team() == TEAM_CITIZEN
local isrebel = ply:Team() == TEAM_RESISTANCE
local iscp = ply:Team() == TEAM_CP
local isover = ply:Team() == TEAM_OTA
local citizen = TEAM_CITIZEN
local rebel = TEAM_RESISTANCE
local cp = TEAM_CP
local over = TEAM_OTA

	if iscitizen or isrebel then
	mvData:SetMaxClientSpeed( 194.40 )
	mvData:SetMaxSpeed( 194.40 )
	elseif iscp then
	mvData:SetMaxClientSpeed( 206.20 )
	mvData:SetMaxSpeed( 206.20 )
	elseif isover then
	mvData:SetMaxClientSpeed( 184.20 )
	mvData:SetMaxSpeed( 184.20 )
	end
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
	player:SetVelocity( Vector( -( vel.x / 3.8 ), -( vel.y / 3.8 ), -( vel.z / -3.5 ) ) )
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
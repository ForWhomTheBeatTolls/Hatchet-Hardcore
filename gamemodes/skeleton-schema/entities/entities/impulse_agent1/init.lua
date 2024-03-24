AddCSLuaFile( "shared.lua" ) 
include('shared.lua')
--include("gamemodes/impulse/gamemode/core/hooks/sv_net.lua" )
if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)  
		self:SetMoveType(SOLID_VPHYSICS)  
		self:SetSolid(SOLID_VPHYSICS)   
		self:SetUseType(SIMPLE_USE)
		self:SetModel("models/props_combine/breenconsole.mdl")


    	local physObj = self:GetPhysicsObject()
    	self.nodupe = true

    	if IsValid(physObj) then
			physObj:Wake()
		end
	end
	
	
end

    local teamChangeTime = impulse.Config.TeamChangeTime
	function ENT:Use(activator, caller)
	if caller:Team() == TEAM_CITIZEN then
	--	print(teamChangeTime)
	--	print(caller.lastTeamChange)
	--	print(teamChangeTime + caller.lastTeamChange)
	--	print(CurTime())
		caller:SetTeam(TEAM_CP)
		caller.lastTeamChange = CurTime()
		caller:Notify("You have changed your team to "..team.GetName(TEAM_CP)..".")
		self:EmitSound("ambient/machines/keyboard_slow_1second.wav", 60, 100, 1, CHAN_AUTO)
	-- elseif (caller.lastTeamChange + teamChangeTime > CurTime()) then
		-- caller:Notify("Wait "..math.ceil((caller.lastTeamChange + teamChangeTime) - CurTime()).." seconds before switching team again.")
	elseif caller:Team() == TEAM_CP then
		caller:SetTeam(TEAM_CITIZEN)
		caller.lastTeamChange = CurTime()
		caller:Notify("You have changed your team to "..team.GetName(TEAM_CITIZEN)..".")
		self:EmitSound("ambient/machines/keyboard_slow_1second.wav", 60, 100, 1, CHAN_AUTO)
	end
	-- if caller:Team() == TEAM_CP and caller:HasInventoryItem("wep_pistol") then
	-- caller:GiveInventoryItem("ammo_pistol")
	--end
	--elseif caller:Team() == TEAM_CP and caller:HasInventoryItem("wep_pistol") then
	--caller:GiveInventoryItem("ammo_pistol")
end
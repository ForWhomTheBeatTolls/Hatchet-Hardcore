AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- Sets the model of the NPC. // 
	self:SetSolid( SOLID_VPHYSICS ) 
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetModelScale(0.8)

    self.dummy = ents.Create("prop_dynamic")
    self.dummy:SetPos(self:GetPos())
    self.dummy:SetModel("models/props_combine/combine_dispenser.mdl")
    self.dummy:SetParent(self)
	self.dummy:SetUseType(SIMPLE_USE)
    self.dummy:SetPlaybackRate( 1.0 )
    self.dummy:Spawn()
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use( activator, ply ) 
    local sequencedispense = self.dummy:LookupSequence("dispense_package")
    local sequenceidle = self.dummy:LookupSequence("idle")
   
    local pos = self.dummy:GetPos() + self.dummy:GetForward() * 15 + self.dummy:GetRight() * -6 + self.dummy:GetUp() * -6
    local ang = self.dummy:GetAngles()
    if ( ( ply.antiSpamRation or 0 ) > CurTime() ) then return end 
    
    ply.antiSpamRation = CurTime() + 1
    if ( ( ply.NextRation or 0 ) < CurTime() ) then 
        
        -- timer.Simple(2, function()
            -- self.dummy:ResetSequence(sequencedispense)
        -- end)
		
		timer.Simple(5.5, function()
            self.dummy:SetSequence(sequenceidle)
        end)
        
        ply:Notify("Dispensing ration...")
        self.dummy:EmitSound("ambient/machines/combine_terminal_idle4.wav")

        --local ration = ents.Create("impulse_hl2rp_ration")
        timer.Simple(2, function()
            --if (!IsValid( ration )) then return end // Check whether we successfully made an entity, if not - bail
			if ply:GetPos():Distance(self:GetPos()) < 90 then
            --ration:SetPos(pos)
            --ration:SetAngles(ang)
            --ration:Spawn()
			if ply:CanHoldItem("item_citration") then
			ply:GiveInventoryItem("item_citration")
			ply:ForceSequence("takepackage", nil, nil, false)
			self.dummy:ResetSequence(sequencedispense)
			else
			ply:Notify("You cannot carry a ration!")
			end
			
			else
			ply:Notify("You were too far away from the machine.")
			end
        end)
		
		-- timer.Simple(4, function()
			-- self.dummy:ResetSequence(sequenceidle)
		-- end)
		
		if ply:GetPos():Distance(self:GetPos()) < 90 then
        ply.NextRation = CurTime() + impulse.Config.RationTime
		else
		--ply.NextRation = CurTime() + 1
		return end
    else
        ply:Notify("You can get your next ration in "..string.ToMinutesSeconds(ply.NextRation - CurTime())..".")
        
        self.dummy:EmitSound( "buttons/combine_button2.wav")
    end
end
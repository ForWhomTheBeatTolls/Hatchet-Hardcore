-- function meta:GetKills()
	-- return self:GetSyncVar(SYNC_KILLS, 0)
-- end

-- if SERVER then
	-- function meta:SetKills(amount)
		-- if not self.beenSetup or self.beenSetup == false then return end
		-- if not isnumber(amount) or amount < 0 or amount >= 1 / 0 then return end

		-- local query = mysql:Update("impulse_players")
		-- query:Update("kills", self:GetKills() + 1)
		-- query:Where("steamid", self:SteamID())
		-- query:Execute()

		-- return self:SetSyncVar(SYNC_KILLS, 1, true)
	-- end
-- end

--DEFUNCT, SHITTY, BROKEN CODE!!!
require("sourcebans")

local function storeBan(steamID, nick, duration, reason, adminName, adminSteam)
	local admin = FAdmin.FindPlayer(adminSteam)

	sourcebans.BanPlayerBySteamID(steamID, duration, reason, admin, nick, function(worked, message)
		if not worked then error("Storing ban failed: " .. message) end
	end)
end
hook.Add("FAdmin_StoreBan", "SourceModBans", storeBan)


local function unban(ply, steamID)
	sourcebans.UnbanPlayerBySteamID(steamID, "FAdmin", ply)
end
hook.Add("FAdmin_UnBan", "SourceModBans", unban)

local function retrieveBans()
	sourcebans.GetAllActiveBans(function(data)
		for _, tbl in pairs(data) do
			FAdmin.BANS[data.SteamID] = {
				time = data.BanEnd,
				name = data.Name,
				reason = data.BanReason,
				adminname = data.AdminName,
				adminsteam = data.AdminID
			}

			game.ConsoleCommand("banid ".. (data.BanEnd - os.time()) * 60 .." " .. data.SteamID.. " kick\n")
		end
	end)
end
hook.Add("FAdmin_RetrieveBans", "SourceModBans", retrieveBans)


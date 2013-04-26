require("sourcebans")

local function storeBan(steamID, nick, duration, reason, adminName, adminSteam)
	local admin = FAdmin.FindPlayer(adminSteam)
	admin = admin and admin[1] or nil

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
	sourcebans.GetAllActiveBans(function(data, err)
		if not data then
			error(err)
		end

		for _, tbl in pairs(data) do
			FAdmin.BANS = FAdmin.BANS or {}

			FAdmin.BANS[tbl.SteamID] = {
				time = tbl.BanEnd,
				name = tbl.Name,
				reason = tbl.BanReason,
				adminname = tbl.AdminName,
				adminsteam = tbl.AdminID
			}

			game.ConsoleCommand("banid ".. (tbl.BanEnd - os.time()) * 60 .." " .. tbl.SteamID.. " kick\n")
		end
	end)
end
hook.Add("FAdmin_RetrieveBans", "SourceModBans", retrieveBans)

hook.Add("InitPostEntity", "RemoveOtherFAdminHooks", function()
	for k,v in pairs(hook.GetTable().FAdmin_StoreBan) do
		if k ~= "SourceModBans" then
			hook.Remove("FAdmin_StoreBan", k)
		end
	end
end)

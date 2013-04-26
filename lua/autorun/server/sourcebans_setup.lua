--[[
	~ Sourcebans Setup Example ~
	~ Lexi ~
--]]
require("sourcebans")
sourcebans.SetConfig("hostname", "localhost");       -- Database Hostname
sourcebans.SetConfig("username", "root");            -- Database Login name
sourcebans.SetConfig("password", "");                -- Database Login Password
sourcebans.SetConfig("database", "sourcebans");      -- Database 'database' or 'schema' selection
sourcebans.SetConfig("dbprefix", "sbans");           -- Prefix for tables in the database. (This example would say your tables are called sbans_bans and so on)
sourcebans.SetConfig("portnumb", 3306);	             -- Database Port number
sourcebans.SetConfig("serverid", 1);                 -- The ID given to this server by the SourceBans website
sourcebans.SetConfig("website", "bans.example.com"); -- The URL where people can find your sourcebans install (Do not put http:// or the kick reason will break!)
sourcebans.SetConfig("showbanreason", false);        -- Show the ban reason in the kick message. Do not use if you do not have gatekeeper installed or you will crash people sometimes.
sourcebans.SetConfig("dogroups", false);             -- Set user groups or not. Set this to false unless your admins are in a servergroup called 'Admin' and your superadmins are in 'SuperAdmin'.
sourcebans.Activate();
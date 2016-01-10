-- Kalite lumps and ores taken from Glooptest mod, by GloopMaster.
-- Rope and craft guide taken from X-Decor mod, by jp.
-- Sprinting taken from sprint mod, by Gunship Penguin.
-- Shout limit by distance taken from shout mod, by ...

--[[
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	if player:get_player_name() == minetest.setting_get("name") then
		return true
	end
end)
--]]

kalite = {}

local modpath = minetest.get_modpath("kalite")

dofile(modpath .. "/autosupply.lua")
dofile(modpath .. "/backpack.lua")
dofile(modpath .. "/kalite.lua")
dofile(modpath .. "/craftguide.lua")
dofile(modpath .. "/chatcommands.lua")
dofile(modpath .. "/mapfix.lua")
dofile(modpath .. "/sprinting.lua")
dofile(modpath .. "/rope.lua")
dofile(modpath .. "/shout.lua")
dofile(modpath .. "/worldedge.lua")
dofile(modpath .. "/shop.lua")
dofile(modpath .. "/wardrobe.lua")

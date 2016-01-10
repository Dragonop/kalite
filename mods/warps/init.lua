--[[

Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

"warps" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

-- Make mese warp ward off attackers.
-- Disable PvP in area of mese warpstone?
-- Teleport away attacks if attack near warpstone? (Jail?)

warps = {}
warps_queue = {}
queue_state = 0
local warps_freeze = 5
-- t = time in usec
-- p = player obj
-- w = warp name

local warp = function(player, dest)
	for i = 1,table.getn(warps) do
		if warps[i].name == dest then
			player:setpos({x = warps[i].x, y = warps[i].y, z = warps[i].z})
			-- MT Core FIXME
			-- get functions don't output proper values for set!
			-- https://github.com/minetest/minetest/issues/2658
			player:set_look_yaw(warps[i].yaw - (math.pi/2))
			player:set_look_pitch(0 - warps[i].pitch)
			minetest.chat_send_player(player:get_player_name(), "Warped to \"" .. dest .. "\"")
			minetest.log("action", player:get_player_name() .. " warped to \"" .. dest .. "\"")
			minetest.sound_play("item_drop_pickup", {
				pos = {x = warps[i].x, y = warps[i].y, z = warps[i].z},
			})
			return
		end
	end
	minetest.chat_send_player(player:get_player_name(), "Unknown warp \"" .. dest .. "\"")
end

do_warp_queue = function()
	if table.getn(warps_queue) == 0 then
		queue_state = 0
		return
	end
	local t = minetest.get_us_time()
	for i = table.getn(warps_queue),1,-1 do
		local e = warps_queue[i]
		if e.p:getpos() then
			if e.p:getpos().x == e.pos.x and e.p:getpos().y == e.pos.y and e.p:getpos().z == e.pos.z then
				if t > e.t then
					warp(e.p, e.w)
					table.remove(warps_queue, i)
				end
			else
				minetest.sound_stop(e.sh)
				minetest.chat_send_player(e.p:get_player_name(), "You have to stand still for " .. warps_freeze .. " seconds!")
				table.remove(warps_queue, i)
			end
		end
	end
	if table.getn(warps_queue) == 0 then
		queue_state = 0
		return
	end
	minetest.after(1, do_warp_queue)
end

local warp_queue_add = function(player, dest)
	table.insert(warps_queue, {
		t = minetest.get_us_time() + ( warps_freeze * 1000000 ),
		pos = player:getpos(),
		p = player,
		w = dest,
		--sh = minetest.sound_play("warps_woosh", { pos = player:getpos() })
		sh = minetest.sound_play("warps_woosh", {pos = player:getpos(), gain = 1, max_hear_distance = 8})
	})
	minetest.chat_send_player(player:get_player_name(), "Don't move for " .. warps_freeze .. " seconds!")
	if queue_state == 0 then
		queue_state = 1
		minetest.after(1, do_warp_queue)
	end
end

local worldpath = minetest.get_worldpath()

local save = function ()
	local fh,err = io.open(worldpath .. "/warps.txt", "w")
	if err then
		print("No existing warps to read.")
		return
	end
	for i = 1,table.getn(warps) do
		local s = warps[i].name .. " " .. warps[i].x .. " " .. warps[i].y .. " " .. warps[i].z .. " " .. warps[i].yaw .. " " .. warps[i].pitch .. "\n"
		fh:write(s)
	end
	fh:close()
end

local load = function ()
	local fh,err = io.open(worldpath .. "/warps.txt", "r")
	if err then
		minetest.log("action", "[warps] loaded ")
		return
	end
	while true do
		local line = fh:read()
		if line == nil then
			break
		end
		local paramlist = string.split(line, " ")
		local w = {
			name = paramlist[1],
			x = tonumber(paramlist[2]),
			y = tonumber(paramlist[3]),
			z = tonumber(paramlist[4]),
			yaw = tonumber(paramlist[5]),
			pitch = tonumber(paramlist[6])
		}
		table.insert(warps, w)
	end
	fh:close()
	minetest.log("action", "[warps] loaded " .. table.getn(warps) .. " warp location(s)")
end

minetest.register_privilege("warp_admin", {
	description = "Allows modification of warp points",
	give_to_singleplayer = true,
	default = false
})

minetest.register_privilege("warp_user", {
	description = "Allows use of warp points",
	give_to_singleplayer = true,
	default = true
})

minetest.register_chatcommand("setwarp", {
	params = "name",
	description = "Set a warp location to the players location",
	privs = { warp_admin = true },
	func = function(name, param)
		param = param:gsub("%W", "")
		local h = "created"
		for i = 1,table.getn(warps) do
			if warps[i].name == param then
				table.remove(warps, i)
				h = "changed"
				break
			end
		end
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		table.insert(warps, { name = param, x = pos.x, y = pos.y, z = pos.z, yaw = player:get_look_yaw(), pitch = player:get_look_pitch() })
		save()
		minetest.log("action", name .. " " .. h .. " warp \"" .. param .. "\": " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
		return true, h .. " warp \"" .. param .. "\""
	end,
})

minetest.register_chatcommand("delwarp", {
	params = "name",
	description = "Set a warp location to the players location",
	privs = { warp_admin = true },
	func = function(name, param)
		for i = 1,table.getn(warps) do
			if warps[i].name == param then
				table.remove(warps, i)
				minetest.log("action", name .. " removed warp \"" .. param .. "\"")
				return true, "Removed warp \"" .. param .. "\""
			end
		end
		return false, "Unknown warp location \"" .. param .. "\""
	end,
})

minetest.register_chatcommand("listwarps", {
	params = "name",
	description = "List known warp locations",
	privs = { warp_user = true },
	func = function(name, param)
		local s = "List of known warp locations:\n"
		for i = 1,table.getn(warps) do
			s = s .. "- " .. warps[i].name .. "\n"
		end
		return true, s
	end
})

minetest.register_chatcommand("warp", {
	params = "name",
	description = "Warp to a warp location",
	privs = { warp_user = true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		warp_queue_add(player, param)
	end
})

minetest.register_craft({
	output = "warps:warpstone_amethyst",
	recipe = {
			{"caverealms:glow_amethyst", "caverealms:glow_amethyst", "caverealms:glow_amethyst"},
			{"caverealms:glow_amethyst", "default:diamond", "caverealms:glow_amethyst"},
			{"caverealms:glow_amethyst", "caverealms:glow_amethyst", "caverealms:glow_amethyst"}
	}
})

minetest.register_craft({
	output = "warps:warpstone_emerald",
	recipe = {
			{"caverealms:glow_emerald", "caverealms:glow_emerald", "caverealms:glow_emerald"},
			{"caverealms:glow_emerald", "default:diamond", "caverealms:glow_emerald"},
			{"caverealms:glow_emerald", "caverealms:glow_emerald", "caverealms:glow_emerald"}
	}
})

minetest.register_craft({
	output = "warps:warpstone_ruby",
	recipe = {
			{"caverealms:glow_ruby", "caverealms:glow_ruby", "caverealms:glow_ruby"},
			{"caverealms:glow_ruby", "default:diamond", "caverealms:glow_ruby"},
			{"caverealms:glow_ruby", "caverealms:glow_ruby", "caverealms:glow_ruby"}
	}
})

minetest.register_craft({
	output = "warps:warpstone_crystal",
	recipe = {
			{"caverealms:glow_crystal", "caverealms:glow_crystal", "caverealms:glow_crystal"},
			{"caverealms:glow_crystal", "default:diamond", "caverealms:glow_crystal"},
			{"caverealms:glow_crystal", "caverealms:glow_crystal", "caverealms:glow_crystal"}
	}
})

minetest.register_craft({
	output = "warps:warpstone_mese",
	recipe = {
			{"caverealms:glow_mese", "caverealms:glow_mese", "caverealms:glow_mese"},
			{"caverealms:glow_mese", "default:diamond", "caverealms:glow_mese"},
			{"caverealms:glow_mese", "caverealms:glow_mese", "caverealms:glow_mese"}
	}
})


minetest.register_abm({
	nodenames = {"warps:warpstone_amethyst"},
	interval = 1.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    for k, v in ipairs(minetest.get_objects_inside_radius(pos, 3)) do --5
		local hand = v:get_wielded_item()
		if hand:get_name() == "warps:warpstone_amethyst" then
			-- Automatically go to next warp
			local meta = minetest.get_meta(pos)
			--print(dump(meta:get_string("warps_destination")))
			warp(v, meta:get_string("warps_destination"))
		end
	    end
	end})

minetest.register_alias("warps:warpstone", "warps:warpstone_amethyst")
minetest.register_node("warps:warpstone_amethyst", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Amethyst Warp Stone",
	tiles = { "warps_amethyst_warpstone.png" },
	drawtype = "mesh",
	wield_scale = {x = 1.5, y = 1.5, z = 1.5},
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = {cracky = default.dig.glass},
	light_source = 13, --8
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;]")
		meta:set_string("infotext", "Uninitialized Warp Stone")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not minetest.check_player_privs(sender:get_player_name(), {warp_admin = true}) then
			minetest.chat_send_player(sender:get_player_name(), "You do not have permission to modify warp stones")
			return false
		end
		if not fields.destination then
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;" .. fields.destination .. "]")
		meta:set_string("infotext", "Warp stone to " .. fields.destination)
		meta:set_string("warps_destination", fields.destination)
		minetest.log("action", sender:get_player_name() .. " changed warp stone to \"" .. fields.destination .. "\"")
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		if puncher:get_player_control().sneak and minetest.check_player_privs(puncher:get_player_name(), {warp_admin = true}) then -- make sneak set name, otherwise don't
			minetest.remove_node(pos)
			minetest.chat_send_player(puncher:get_player_name(), "Warp stone removed!")
			return
		end
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("warps_destination")
		if destination == "" then
			minetest.chat_send_player(puncher:get_player_name(), "Unknown warp location for this warp stone, cannot warp!")
			return false
		end
		warp_queue_add(puncher, destination)
	end,
})

minetest.register_node("warps:warpstone_emerald", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Emerald Warp Stone",
	tiles = {"warps_emerald_warpstone.png"},
	drawtype = "mesh",
	wield_scale = {x = 1.5, y = 1.5, z = 1.5},
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = {cracky = default.dig.glass},
	light_source = 13,
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing) -- Make on_rightclick with formspec
		local name = placer:get_player_name()
		local home = "home_" .. name
		local h = "created"
		for i = 1,table.getn(warps) do
			if warps[i].name == home then
				table.remove(warps, i)
				h = "changed"
				break
			end
		end
		local pos = pointed_thing.above --placer:getpos()
		table.insert(warps, {name = home, x = pos.x, y = pos.y, z = pos.z, yaw = placer:get_look_yaw(), pitch = placer:get_look_pitch()})
		save()
		minetest.log("action", name .. " " .. h .. " warp \"" .. home .. "\": " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
		minetest.chat_send_player(name, "Your home warp location has been set.")
	end,
	on_use = function(itemstack, user, pointed_thing)
		warp_queue_add(user, "home_" .. user:get_player_name())
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		warp_queue_add(puncher, "home_" .. puncher:get_player_name())
	end,
})

minetest.register_node("warps:warpstone_ruby", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Ruby Warp Stone",
	tiles = {"warps_ruby_warpstone.png"},
	drawtype = "mesh",
	wield_scale = {x = 1.5, y = 1.5, z = 1.5},
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = {cracky = default.dig.glass},
	light_source = 13,
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	},
	on_use = function(itemstack, user, pointed_thing)
		warp_queue_add(user, "Spawn")
	end,
	on_punch = function(pos, node, puncher, pointed_thingo)
		if puncher:get_player_control().sneak and minetest.check_player_privs(puncher:get_player_name(), {warp_admin = true}) then -- TODO: make sneak set name, otherwise don't
			minetest.remove_node(pos)
			minetest.chat_send_player(puncher:get_player_name(), "Warp stone removed!")
			return
		end
		--[[
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("warps_destination")
		if destination == "" then
			minetest.chat_send_player(puncher:get_player_name(), "Unknown warp location for this warp stone, cannot warp!")
			return false
		end
		--]]
		warp_queue_add(puncher, "Spawn")
	end,
})

minetest.register_node("warps:warpstone_crystal", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Crystal Warp Stone",
	tiles = {"warps_crystal_warpstone.png"},
	drawtype = "mesh",
	--use_texture_alpha = true,
	wield_scale = {x = 1.5, y = 1.5, z = 1.5},
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = {cracky = default.dig.glass},
	light_source = 13,
	sounds = default.node_sound_glass_defaults(),
	--on_rotate =
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;]")
		meta:set_string("infotext", "Uninitialized Warp Stone")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not minetest.check_player_privs(sender:get_player_name(), {warp_admin = true}) then
			minetest.chat_send_player(sender:get_player_name(), "You do not have permission to modify warp stones")
			return false
		end
		if not fields.destination then
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;" .. fields.destination .. "]")
		meta:set_string("infotext", "Warp stone to " .. fields.destination)
		meta:set_string("warps_destination", fields.destination)
		minetest.log("action", sender:get_player_name() .. " changed warp stone to \"" .. fields.destination .. "\"")
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		if puncher:get_player_control().sneak and minetest.check_player_privs(puncher:get_player_name(), {warp_admin = true}) then -- make sneak set name, otherwise don't
			minetest.remove_node(pos)
			minetest.chat_send_player(puncher:get_player_name(), "Warp stone removed!")
			return
		end
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("warps_destination")
		if destination == "" then
			minetest.chat_send_player(puncher:get_player_name(), "Unknown warp location for this warp stone, cannot warp!")
			return false
		end
		warp_queue_add(puncher, destination)
	end
})



minetest.register_node("warps:warpstone_mese", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Mese Warp Stone",
	tiles = {"warps_mese_warpstone.png"},
	drawtype = "mesh",
	wield_scale = {x = 1.5, y = 1.5, z = 1.5},
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = {cracky = default.dig.glass},
	light_source = 13,
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	}
})

-- load existing warps
load()


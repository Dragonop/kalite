--[[

Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

"warps" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

-- Modified by James Stevenson

-- TODO
-- Teleport away attacker if player wields Mese Warpstone.
-- See through models / Improved textures
-- Rotation



warps = {}
warps_queue = {}
warps.stone_pos = {}
queue_state = 0
local warps_freeze = 5
-- t = time in usec
-- p = player obj
-- w = warp name

local warp = function(player, dest)
	local name = player:get_player_name()
	for i = 1, table.getn(warps) do
		if warps[i].name == dest then
			player:setpos({x = warps[i].x, y = warps[i].y, z = warps[i].z})
			-- MT Core FIXME
			-- get functions don't output proper values for set!
			-- https://github.com/minetest/minetest/issues/2658
			player:set_look_yaw(warps[i].yaw - (math.pi/2))
			player:set_look_pitch(0 - warps[i].pitch)
			minetest.log("action", name .. " warped to \"" .. dest .. "\"")
			minetest.sound_play("item_drop_pickup", {
				pos = {x = warps[i].x, y = warps[i].y, z = warps[i].z},
			})
			return
		end
	end
	if string.match(dest, "home_" .. name) then
		minetest.chat_send_player(name .. "No home set")
	end
	minetest.chat_send_player(name, "Unknown warp \"" .. dest .. "\"")
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
		sh = minetest.sound_play("warps_woosh", {pos = player:getpos(), gain = 0.5, max_hear_distance = 8})
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


-- INTERFACE

local function warp_menu(pos, node, clicker, itemstack, pointed_thing)
	local warpstone = node.name
	local name = clicker:get_player_name()
	if warpstone == "warps:warpstone_crystal" or
	    warpstone == "warps:warpstone_amethyst" then
		if not minetest.check_player_privs(clicker, {warp_admin = true}) then
			return
		end
		local formspec = "field[destination; Warp Destination;]"
		minetest.show_formspec(name, "warps:warpstone", formspec)
	elseif warpstone == "warps:warpstone_emerald" then
		local formspec = "size[3.5,0.15]" ..
			"button_exit[-0.2,-0.3;2,1;sethome;Set Home]" ..
			"button_exit[1.7,-0.3;2,1;gohome;Go Home]"
		minetest.show_formspec(name, "warps:warpstone", formspec)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "warps:warpstone" then
		return
	end

	local name = player:get_player_name()
	local pos = warps.stone_pos[name]
	if fields.destination then
		if string.match(fields.destination, "^home_") then
			minetest.chat_send_player(name, "Illegal name")
			return false
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("destination", fields.destination)
		minetest.log("action", name .. " changed warp stone to \"" .. fields.destination .. "\"")
	elseif fields.sethome then
		if minetest.is_protected(pos, name) then
			return
		end
		local home = "home_" .. name
		local h = "created"
		for i = 1, table.getn(warps) do
			if warps[i].name == home then
				table.remove(warps, i)
				h = "changed"
				break
			end
		end
		table.insert(warps, {name = home, x = pos.x, y = pos.y, z = pos.z, yaw = player:get_look_yaw(), pitch = player:get_look_pitch()})
		save()
		minetest.log("action", name .. " " .. h .. " warp \"" .. home .. "\": " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
		minetest.chat_send_player(name, "Your home warp location has been set")
	elseif fields.gohome then
		warp_queue_add(player, "home_" .. name)
	end
end)


-- WARP STONES

-- Amethyst
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
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		warps.stone_pos[clicker:get_player_name()] = pos
		warp_menu(pos, node, clicker, itemstack, pointed_thing)
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("destination")
		if destination ~= "" then
			warp_queue_add(puncher, destination)
		end
	end
})

-- Crystal
minetest.register_node("warps:warpstone_crystal", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "Crystal Warp Stone",
	tiles = {"warps_crystal_warpstone.png"},
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
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		warps.stone_pos[clicker:get_player_name()] = pos
		warp_menu(pos, node, clicker, itemstack, pointed_thing)
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("destination")
		if destination ~= "" then
			warp_queue_add(puncher, destination)
		end
	end
})

-- Emerald
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
	on_use = function(itemstack, user, pointed_thing)
		warp_queue_add(user, "home_" .. user:get_player_name())
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		warp_queue_add(puncher, "home_" .. puncher:get_player_name())
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		warps.stone_pos[clicker:get_player_name()] = pos
		warp_menu(pos, node, clicker, itemstack, pointed_thing)
	end
})

-- Ruby
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
		warp_queue_add(puncher, "Spawn")
	end
})

-- Anti-PvP
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

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
--[[	if player:get_weilded_item():get_name() == "warps:warpstone_mese" then
		hunger.poisenp(1.0, 5, 0, hitter)
		return true
	end--]]
end)

-- load existing warps
load()

-- clear warpstone position
minetest.register_on_leaveplayer(function(player)
	warps.stone_pos[player:get_player_name()] = nil
end)

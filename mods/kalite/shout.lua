-- Limit chat by distance [shout]
-- Original mod by Muhammad Rifqi Priyo Susanto (srifqi)

-- Copyright 2016 James Stevenson
-- License: GPL3

shout = {}
shout.hud = {}
local channel = {}


minetest.register_node("kalite:intercomm", {
	tiles = {"default_gold_block.png"}
})

minetest.register_craftitem("kalite:walkie_talkie", {
	description = "Walkie Talkie",
	inventory_image = "kalite_walkie_talkie.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		minetest.show_formspec(name, "kalite:walkie_talkie",
		    "field[channel;Channel:;" .. channel[name] .. "]")
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "kalite:walkie_talkie" then
		return
	end

	local input = tonumber(fields.channel)
	local name = player:get_player_name()
	if not input
			or input > 30912 or input < 1 then
		return
	else
		channel[name] = input
	end

end)

minetest.register_craft({
	output = "kalite:walkie_talkie",
	recipe = {
		{"default:copper_ingot", "default:iron_ingot", "default:copper_ingot"},
		{"default:iron_ingot", "default:diamond", "default:iron_ingot"},
		{"default:copper_ingot", "default:iron_ingot", "default:copper_ingot"}
	}
})

-- Always join on channel 1
minetest.register_on_joinplayer(function(player)
	channel[player:get_player_name()] = 1
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	channel[name] = nil
	shout.hud[name] = nil
end)

-- Parameter
shout.DISTANCE	= 64

shout.DISTANCESQ = shout.DISTANCE ^ 2
-- Limit chat by distance given in shout.DISTANCE parameter


local server_owner = minetest.setting_get("name")
local function is_owner(name)
	return name == server_owner
end

local function has_walkie(player)
	return player:get_inventory():contains_item("main", "kalite:walkie_talkie")
end

local function near_intercomm(pos)
	return minetest.find_node_near(pos, 8, {"kalite:intercomm"})
end


-- Conditional shout
minetest.register_on_chat_message(function(name, message)
	if is_owner(name) then
		return false
	end

	if message == "/spawn" then
		minetest.chat_send_player(name, "Use a Ruby Warpstone to get back to spawn.")
		return true
	elseif message == "/sethome" then
		minetest.chat_send_player(name, "Use an Emerald Warpstone to set your home.")
		return true
	end

	minetest.log("action", "CHAT: <" .. name .. "> " .. message)

	local shouter = minetest.get_player_by_name(name)
	local spos = shouter:getpos()
	
	-- Minetest library (modified)
	local function vdistancesq(a,b) local x,y,z = a.x-b.x,a.y-b.y,a.z-b.z return x*x+y*y+z*z end

	if not has_walkie(shouter) and not near_intercomm(spos) then
		for _, player in ipairs(minetest.get_connected_players()) do
			local dest = player:get_player_name()
			if not dest then
				return true
			end
			if dest ~= name then
				if is_owner(dest) or vdistancesq(spos, player:getpos()) <= shout.DISTANCESQ then
					minetest.chat_send_player(dest, "<" .. name .. "> " .. message)
				end
			end
		end
		return true
	elseif near_intercomm(spos) and not has_walkie(shouter) then
		for _, player in ipairs(minetest.get_connected_players()) do
			local dest = player:get_player_name()
			if not dest then
				return true
			end
			if dest ~= name then
				if is_owner(dest)
						or (has_walkie(player) and channel[dest] == 1)
						or near_intercomm(player:getpos())
						or vdistancesq(spos, player:getpos()) <= shout.DISTANCESQ then
					minetest.chat_send_player(dest, "<" .. name .. "> " .. message)
				end
			end
		end
		return true
	elseif near_intercomm(spos) and has_walkie(shouter) then
		for _, player in ipairs(minetest.get_connected_players()) do
			local dest = player:get_player_name()
			if not dest then
				return true
			end
			if dest ~= name then
				if is_owner(dest)
						or (has_walkie(player) and channel[dest] == 1)
						or (has_walkie(player) and channel[dest] == channel[name])
						or vdistancesq(spos, player:getpos()) <= shout.DISTANCESQ then
					minetest.chat_send_player(dest, "<" .. name .. "> " .. message)
				end
			end
		end
		return true
	elseif has_walkie(shouter) and not near_intercomm(spos) then
		for _, player in ipairs(minetest.get_connected_players()) do
			local dest = player:get_player_name()
			if not dest then
				return true
			end
			if dest ~= name then
				if is_owner(dest)
						or (has_walkie(player) and channel[dest] == channel[name])
						or near_intercomm(player:getpos())
						or vdistancesq(spos, player:getpos()) <= shout.DISTANCESQ then
					minetest.chat_send_player(dest, "<" .. name .. "> " .. message)
				end
			end
		end
		return true
	end
end)


minetest.register_chatcommand("me", {
	params = "<action>",
	description = "Perform an action for nearby players.",
	privs = {shout = true},
	func = function(name, param)
		local shouter = minetest.get_player_by_name(name)
		local spos = shouter:getpos()
		
		-- Minetest library (modified)
		local function vdistancesq(a, b)
			local x,y,z = a.x-b.x,a.y-b.y,a.z-b.z
			return x*x+y*y+z*z
		end
		
		for _, player in ipairs(minetest.get_connected_players()) do
			if not player:get_player_name() ~= nil then
				if player:get_player_name() ~= name then
					local pos = player:getpos()
					if vdistancesq(spos, pos) <= shout.DISTANCESQ then
						minetest.chat_send_player(player:get_player_name(), "* " .. name .. " " .. param)
					end
				end
			end
		end
		return true, "* " .. name .. " " .. param
	end
})

minetest.register_chatcommand("msg", {
        params = "<name> <message>",
        description = "Send a private message",
        privs = {shout = true},
        func = function(name, param)
		if minetest.get_player_by_name(name):get_inventory():contains_item("main", "kalite:walkie_talkie") then
			local sendto, message = param:match("^(%S+)%s(.+)$")
			if not sendto then
				return false, "Invalid usage, see /help msg."
			end
			if not minetest.get_player_by_name(sendto) then
				return false, "The player " .. sendto
						.. " is not online."
			end
			if not minetest.get_player_by_name(sendto):get_inventory():contains_item("main", "kalite:walkie_talkie") then
				return false, sendto .. " doesn't have a walkie talkie!"
			end
			minetest.log("action", "PM from " .. name .. " to " .. sendto
					.. ": " .. message)
			minetest.chat_send_player(sendto, "PM from " .. name .. ": "
					.. message)
			return true, "Message sent."
		else
			return false, "You need a walkie talkie."
		end
        end
})

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos = vector.round(player:getpos())

		local wielded = player:get_wielded_item():get_name()
		if not wielded then return end

		if wielded == "kalite:walkie_talkie" then
			local chatters = {}
			for _, player in pairs(minetest.get_connected_players()) do
				if player:get_player_name() ~= name then
					if player:get_inventory():contains_item("main", "kalite:walkie_talkie")
							and channel[name] == channel[player:get_player_name()] then
						table.insert(chatters, player:get_player_name())
					end
				end
			end
			local hud = shout.hud[name]
			if not hud then
				hud = {}
				shout.hud[name] = hud
				hud.comms = player:hud_add({
					hud_elem_type = "text",
					name = "Comms",
					number = 0xFFFFFF,
					position = {x=0, y=1},
					offset = {x=8, y=-8},
					text = "Channel: " .. channel[name] .. "\n" .. "Players: " .. tostring(#chatters),
					scale = {x=200, y=60},
					alignment = {x=1, y=-1},
				})
				return
			else
				player:hud_change(hud.comms, "text", "Channel: " .. channel[name] .. "\n" .. "Players: " .. tostring(#chatters))
			end
		else
			local hud = shout.hud[name]
			if hud then
				player:hud_remove(shout.hud[name].comms)
				shout.hud[name] = nil
			end
		end
	end
end)

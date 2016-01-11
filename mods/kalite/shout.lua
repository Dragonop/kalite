-- Limit chat by distance [shout]
-- by Muhammad Rifqi Priyo Susanto (srifqi)
-- License: CC0 1.0 Universal
-- Dependencies: (none)


shout = {}
local channel = {}

-- WALKIE TALKIE

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
	print(dump(fields))

	local input = tonumber(fields.channel)
	local name = player:get_player_name()
	if not input or
	    input > 30912 or input < 1 then
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
	channel[player:get_player_name()] = nil
end)

-- Parameter
shout.DISTANCE	= 64

shout.DISTANCESQ = shout.DISTANCE ^ 2
-- Limit chat by distance given in shout.DISTANCE parameter

minetest.register_on_chat_message(function(name, message)
	if minetest.setting_get("name") == name then
		return
	else
		if message == "/spawn" then
			minetest.chat_send_player(name, "Use a Ruby Warpstone to get back to spawn.")
		elseif message == "/sethome" then
			minetest.chat_send_player(name, "Use an Emerald Warpstone to set your home.")
		end

		minetest.log("action", "CHAT: <" .. name .. "> " .. message)

		local shouter = minetest.get_player_by_name(name)
		local spos = shouter:getpos()
		
		-- Minetest library (modified)
		local function vdistancesq(a,b) local x,y,z = a.x-b.x,a.y-b.y,a.z-b.z return x*x+y*y+z*z end
		if shouter:get_inventory():contains_item("main", "kalite:walkie_talkie") then
			for _, player in ipairs(minetest.get_connected_players()) do
				local dest = player:get_player_name()
				if not dest ~= nil then
					if dest ~= name then
						if player:get_inventory():contains_item("main", "kalite:walkie_talkie") and
						    channel[dest] == channel[name] then
							minetest.chat_send_player(dest,
							    "<" .. name .. "> " .. message)
						else
							local pos = player:getpos()
							if vdistancesq(spos, pos) <= shout.DISTANCESQ then
								minetest.chat_send_player(dest,
								    "<" .. name .. "> " .. message)
							end
						end
					end
				end
			end
		else
			for _, player in ipairs(minetest.get_connected_players()) do
				local dest = player:get_player_name()
				if not dest ~= nil then
					if dest ~= name then
						local pos = player:getpos()
						if vdistancesq(spos, pos) <= shout.DISTANCESQ then
							minetest.chat_send_player(dest,
							    "<" .. name .. "> " .. message)
						end
					end
				end
			end
		end
		return true
	end
end)


minetest.register_chatcommand("me", {
	params = "<action>",
	description = "Perform an action for nearby players.",
	privs = {shout=true},
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
		return true, "* " .. name .. " " .. param -- Good place for a semi-colon.
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
        end,
})


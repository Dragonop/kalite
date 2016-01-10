minetest.register_chatcommand("killme", {
        --params = "",
        description = "Kill yourself",
        func = function(playerName, param)
                minetest.after(0.1, function()
                        minetest.get_player_by_name(playerName):set_hp(0)
                end)
        end
})

minetest.register_chatcommand("reset", {
        --params = "",
        description = "Resets position, spawn point, and clears inventory",
        func = function(name, param)
                minetest.after(0.1, function()
                        local player = minetest.get_player_by_name(name)
                        player:setpos({x=-1, y=-26112, z=20}) --TODO: make minetest.setting_get("static_spawnpoint")
                        local player_inv = player:get_inventory()

                        for i=1, player_inv:get_size("main") do
                                player_inv:set_stack("main", i, nil)
                        end
                        for i=1, player_inv:get_size("craft") do
                                player_inv:set_stack("craft", i, nil)
                        end
			player:set_hp(20)
			hunger.update_hunger(player, 20)
                        --player:get_inventory():add_item('main', 'kalite:walkie_talkie')
                        --player:get_inventory():add_item('main', 'default:gold_ingot')
                        beds.spawn[name] = {x=-1, y=-26112, z=20}
                        beds.save_spawns()
                end)
        end
})

minetest.register_chatcommand("skin", {
	params = "<name>",
	description = "Enter either sam or dusty as your skin name",
	func = function(name, param)
		local skin
		if param == "" then
			skin = "dusty" -- Set default skin
		else
			skin = param
		end
		local player = minetest.get_player_by_name(name)
		player:set_properties({textures = {"character_" .. skin .. ".png"}})
	end
})

minetest.register_chatcommand("funds", {
	params = "<withdraw>",
	description = "List or get funds",
	func = function(name, param)
		local player_inv = minetest.get_player_by_name(name):get_inventory()
		local n = player_inv:get_stack("funds", 1):get_count()
		print(dump(player_inv:get_stack("funds", 1):get_name()))
		if param == "withdraw" then
			minetest.chat_send_player(name, "Testing only.  Currently not implemented.")
		else
			minetest.chat_send_player(name, "You have " .. n .. " credit(s).")
		end
	end
})

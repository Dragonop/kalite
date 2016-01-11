minetest.register_chatcommand("killme", {
        description = "Die and respawn",
        func = function(playerName, param)
                minetest.after(0.1, function()
                        minetest.get_player_by_name(playerName):set_hp(0)
                end)
        end
})

minetest.register_chatcommand("reset", {
        description = "Reset position, respawn, and inventory",
        func = function(name, param)
                minetest.after(0.1, function()
                        local player = minetest.get_player_by_name(name)
                        player:setpos({x = -1, y = -26112, z = 20}) --TODO: make minetest.setting_get("static_spawnpoint")
                        local player_inv = player:get_inventory()

                        for i=1, player_inv:get_size("main") do
                                player_inv:set_stack("main", i, nil)
                        end
                        for i=1, player_inv:get_size("craft") do
                                player_inv:set_stack("craft", i, nil)
                        end
			player:set_hp(20)
			hunger.update_hunger(player, 20)
                        beds.spawn[name] = {x = -1, y = -26112, z = 20}
                        beds.save_spawns()
                end)
        end
})

minetest.register_chatcommand("funds", {
	description = "Print funds",
	func = function(name)
		--local player = minetest.get_player_by_name()
		local inv = minetest.get_inventory({type = "player", name = name})
		local e = inv:get_stack("emerald", 1)
		local d = inv:get_stack("diamond", 1)
		local g = inv:get_stack("gold", 1)
		minetest.chat_send_player(name, "Emeralds: " .. e:get_count())
		minetest.chat_send_player(name, "Diamonds: " .. d:get_count())
		minetest.chat_send_player(name, "Gold Ingots: " .. g:get_count())
	end
})

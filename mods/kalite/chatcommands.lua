minetest.register_chatcommand("killme", {
        description = "Set HP to zero",
        func = function(playerName, param)
		local player = minetest.get_player_by_name(playerName)
                minetest.after(0.25, function()
			player:set_hp(player:get_hp())
			player:set_hp(0)
                end)
        end
})

minetest.register_chatcommand("reset", {
        description = "Reset position, respawn, and inventory",
        func = function(name, param)
		local player = minetest.get_player_by_name(name)
                minetest.after(0.25, function()
			local spawnpoint = minetest.setting_get_pos("static_spawnpoint")
			if spawnpoint then
				player:setpos(spawnpoint)
                        	beds.spawn[name] = spawnpoint
			else
				player:setpos({x = 0, y = 0, z = 0})
				beds.spawn[name] = {x = 0, y = 0, z = 0}
			end

                        local player_inv = player:get_inventory()
                        for i = 1, player_inv:get_size("main") do
                                player_inv:set_stack("main", i, nil)
                        end
                        for i = 1, player_inv:get_size("craft") do
                                player_inv:set_stack("craft", i, nil)
                        end

			player:set_hp(20)
			hunger.update_hunger(player, 20)
                        beds.save_spawns()
                end)
        end
})

minetest.register_chatcommand("list", {
	description = "Show players on current chat channel",
	func = function()
		return true, "This doesn't work yet."
	end
})

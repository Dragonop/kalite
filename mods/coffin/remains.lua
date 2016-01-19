minetest.register_on_dieplayer(function(player)
	local pos = player:getpos() -- initial position of remains
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	
	local nn = minetest.get_node(pos).name
	print("Node name is: " .. nn)

	local name = player:get_player_name()
	local protected = false
	if minetest.is_protected(pos, name)
			or nn == "default:cloud"
			or string.match(nn, "protector:protect") then
		-- Raise remains a node so we don't override other
		-- player's protected areas.
		pos.y = pos.y + 1
		protected = true
		print(nn .. " is protected")
	end
--[[
	for i = 1, player_inv:get_size("main") do
		player_inv:set_stack("main", i, nil)
	end
	for i = 1, player_inv:get_size("craft") do
		player_inv:set_stack("craft", i, nil)
	end
--]]
	local meta
	local player_inv = player:get_inventory()
	if not protected then
		minetest.set_node(pos, {name = "coffin:coffin", param2 = param2})

		pos.y = pos.y + 1
		minetest.set_node(pos, {name="coffin:gravestone", param2 = param2})

		meta = minetest.get_meta(pos)
		meta:set_string("infotext", "RIP " .. name)

		pos.y = pos.y - 1
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
		
		local empty_list = inv:get_list("main")
		inv:set_list("main", player_inv:get_list("main"))
		player_inv:set_list("main", empty_list)
	
		for i = 1, player_inv:get_size("craft") do
			inv:add_item("main", player_inv:get_stack("craft", i))
			player_inv:set_stack("craft", i, nil)
		end
	else
		minetest.set_node(pos, {name = "coffin:bones", param2 = param2})
		meta = minetest.get_meta(pos)
		meta:set_string("infotext", name .. "'s bones")
		meta:set_string("owner", name)

		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
		
		local empty_list = inv:get_list("main")
		inv:set_list("main", player_inv:get_list("main"))
		player_inv:set_list("main", empty_list)
	
		for i = 1, player_inv:get_size("craft") do
			inv:add_item("main", player_inv:get_stack("craft", i))
			player_inv:set_stack("craft", i, nil)
		end
	end
end)

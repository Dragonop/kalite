local form = "size[8,9]" ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;main;0,0.3;8,4]" ..
	"list[current_player;main;0,4.85;8,1]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]"
	

minetest.register_node("kalite:backpack", {
	description = "Backpack",
	tiles = {"kalite_backpack.png",
		"kalite_backpack.png",
		"kalite_backpack.png",
		"kalite_backpack.png",
		"kalite_backpack.png",
		"kalite_backpack_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.375, 0.4375, 0.5, 0.375},
			{0.125, -0.375, 0.4375, 0.375, 0.3125, 0.5},
			{-0.375, -0.375, 0.4375, -0.125, 0.3125, 0.5},
			{0.125, 0.1875, 0.375, 0.375, 0.375, 0.4375},
			{-0.375, 0.1875, 0.375, -0.125, 0.375, 0.4375},
			{0.125, -0.375, 0.375, 0.375, -0.25, 0.4375},
			{-0.375, -0.375, 0.375, -0.125, -0.25, 0.4375},
			{-0.3125, -0.375, -0.4375, 0.3125, 0.1875, -0.375},
			{-0.25, -0.3125, -0.5, 0.25, 0.125, -0.4375},
		}
	},
	groups = {dig = default.dig.instant},
	stack_max = 1,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Backpack")
		meta:set_string("formspec", form)
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local stuff = minetest.deserialize(itemstack:get_metadata())
		if stuff then
			meta:from_table(stuff)
		end
	end,
	on_dig = function(pos, node, digger)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		local list = {}
		for i, stack in ipairs(inv:get_list("main")) do
			if stack:get_name() == "" then
				list[i] = ""
			else 
				list[i] = stack:to_string()
			end
		end

		local new_list = {inventory = {main = list}, fields = {infotext = "Backpack", formspec = form}}
		local new_list_as_string = minetest.serialize(new_list)

		local new = ItemStack("kalite:backpack")
		new:set_metadata(new_list_as_string)

		minetest.remove_node(pos)

		local player_inv = digger:get_inventory()
		if player_inv:room_for_item("main", new) then
			player_inv:add_item("main", new)
		else
			--minetest.add_item(pos, {name = "kalite:backpack"})
			minetest.add_item(pos, new)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if stack:get_name() ~= "kalite:backpack" then
			return stack:get_count()
		else
			return 0
		end
	end
})

minetest.register_craft({
	output = "kalite:backpack",
	recipe = {
		{"farming:string", "farming:string", "farming:string"},
		{"farming:string", "", "farming:string"},
		{"farming:string", "farming:string", "farming:string"}
	}
})

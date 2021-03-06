-- Minetest 0.4 mod: vessels
-- See README.txt for licensing and other information.

local vessels_shelf_formspec =
	"size[8,8;]" ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;vessels;0,0.3;8,2]" ..
	"list[current_name;protect;3.5,2.5;1,1]" ..
	"item_image[3.5,2.5;1,1;protector:protect2]" ..
	"list[current_player;main;0,3.85;8,1]" ..
	"list[current_player;main;0,5.08;8,3;8]" ..
	"listring[current_name;vessels]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0, 3.85)

minetest.register_node("vessels:shelf", {
	description = "Vessels Shelf",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png^vessels_shelf.png"
	},
	is_ground_content = false,
	groups = {
		choppy = default.dig.wood,
		wood = 1,
		flammable = 3
	},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Vessels Shelf")
		meta:set_string("formspec", vessels_shelf_formspec)
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8 * 2)
		inv:set_size("protect", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("vessels") and inv:is_empty("protect")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		local name = player:get_player_name()
		if listname == "vessels" then
			if inv:get_stack("protect", 1):is_empty() then
				if minetest.get_item_group(stack:get_name(), "vessel") ~= 0
						and to_stack:is_empty() then
					return 1
				else
					return 0
				end
			else
				if not minetest.is_protected(pos, name) then
					return 1
				else
					return 0
				end
			end
		elseif listname == "protect" then
			if stack:get_name() == "protector:protect2"
					and to_stack:is_empty()
					and not minetest.is_protected(pos, name) then
				return 1
			else
				return 0
			end
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if not inv:is_empty("protect") then
			if not minetest.is_protected(pos, player:get_player_name()) then
				return 1
			else
				return 0
			end
		else
			return 1
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "vessels" then
			if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 
					and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			   " moves stuff in vessels shelf at " ..
			   minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			   " moves stuff to vessels shelf at " ..
			   minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			   " takes stuff from vessels shelf at "
			   .. minetest.pos_to_string(pos))
	end
})

minetest.register_craft({
	output = "vessels:shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

minetest.register_node("vessels:glass_bottle", {
	description = "Glass Bottle",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png"},
	inventory_image = "vessels_glass_bottle_inv.png",
	wield_image = "vessels_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {
		dig = default.dig.instant,
		vessel = 1,
		attached_node = 1
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	output = "vessels:glass_bottle 10",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "", "default:glass"},
		{"", "default:glass", "" }
	}
})

minetest.register_node("vessels:drinking_glass", {
	description = "Drinking Glass",
	drawtype = "plantlike",
	tiles = {"vessels_drinking_glass.png"},
	inventory_image = "vessels_drinking_glass_inv.png",
	wield_image = "vessels_drinking_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {
		dig = default.dig.instant,
		vessel = 1,
		attached_node = 1
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	output = "vessels:drinking_glass 14",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

minetest.register_node("vessels:steel_bottle", {
	description = "Heavy Steel Bottle",
	drawtype = "plantlike",
	tiles = {"vessels_steel_bottle.png"},
	inventory_image = "vessels_steel_bottle_inv.png",
	wield_image = "vessels_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {
		dig = default.dig.instant,
		vessel = 1,
		attached_node = 1
	},
	sounds = default.node_sound_defaults()
})

minetest.register_craft( {
	output = "vessels:steel_bottle 5",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", "" }
	}
})


-- Make sure we can recycle them

minetest.register_craftitem("vessels:glass_fragments", {
	description = "Glass Fragments",
	inventory_image = "vessels_glass_fragments.png",
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"vessels:glass_bottle",
		"vessels:glass_bottle",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"vessels:drinking_glass",
		"vessels:drinking_glass",
	},
})

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "vessels:glass_fragments",
})

minetest.register_craft( {
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "vessels:steel_bottle",
})

--[[
    Copyright 2016 James Stevenson.
    This file is part of Kalite

    Kalite is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Kalite is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Kalite.  If not, see <http://www.gnu.org/licenses/>.
--]]

minetest.register_craftitem("coffin:bone", {
	inventory_image = "coffin_bone.png",
	stack_max = 60
})

minetest.register_craftitem("coffin:skull", {
	inventory_image = "coffin_skull.png",
	stack_max = 60
})

minetest.register_craft({output="default:bone_meal 9",
	type = "shapeless",
	recipe = {"coffin:bone"}
})

minetest.register_craft({output="default:bone_meal 9",
	type = "shapeless",
	recipe = {"coffin:skull"}
})

minetest.register_craft({output="coffin:bones",
	recipe = {
		{"coffin:bone", "coffin:bone", "coffin:bone"},
		{"coffin:bone", "coffin:skull", "coffin:bone"},
		{"coffin:bone", "coffin:bone", "coffin:bone"}
	}
})

minetest.register_node("coffin:bones", {
	description = "Bones",
	tiles = {
		"bones_top.png",
		"bones_bottom.png",
		"bones_side.png",
		"bones_side.png",
		"bones_rear.png",
		"bones_front.png"
	},
	paramtype2 = "facedir",
	groups = {dig = default.dig.instant},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_gravel_footstep", gain = 0.5},
		dug = {name = "default_gravel_footstep", gain = 1.0},
	}),
	stack_max = 40,
	can_dig = function(pos, player)
		return true
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		if owner then
			if owner == puncher:get_player_name() then
				local inv = meta:get_inventory()
				for i = 1, inv:get_size("main") do
					local stack = inv:get_stack("main", i)
					print(stack:get_name())
					if not stack:is_empty() then
						print("not empty")
						local p = {
							x = pos.x + math.random(0, 5) / 5 - 0.5,
							y = pos.y + 1,
							z = pos.z + math.random(0, 5) / 5 - 0.5
						}
						minetest.add_item(p, stack)
					end
				end
				minetest.remove_node(pos)
				minetest.add_item(pos, {name = "coffin:bone"})
			end
		end
	end
})

minetest.register_node("coffin:gravestone", {
	description = "Gravestone",
	tiles = {"default_stone.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = default.dig.stone},
	sounds = default.node_sound_stone_defaults(),
	drop = "default:cobble",
	drawtype = "nodebox",
	node_box = {type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.1,0.5,-0.3,0.5},
			{-0.3,-0.3,0.1,0.3,0.7,0.3}
		}
	}
})

minetest.register_node("coffin:coffin", {
	description = "Coffin",
	tiles = {
		"coffin_top.png",
		"coffin_top.png",
		"coffin_side.png",
		"coffin_side.png",
		"coffin_side.png",
		"coffin_side.png",
	},
	paramtype2 = "facedir",
	groups = {choppy = default.dig.old_chest},
	sounds = default.node_sound_wood_defaults({
		dug = {name = "ruins_chest_break", gain = 0.6},
	}),
	drop = "coffin:bone 2",
	after_dig_node = default.drop_node_inventory()
})

minetest.register_alias("bones:bones", "coffin:coffin")
minetest.register_alias("bones:gravestone", "coffin:gravestone")

dofile(minetest.get_modpath("coffin") .. "/remains.lua"
-- Coffin and tombstone if not protected and not clouds and not a protector
-- Bones otherwise
--[[
minetest.register_on_dieplayer(function(player)
	local pos = player:getpos()
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	
	local nn = minetest.get_node(pos).name
	print("Node name is: " .. nn)

	local protected = false
	if minetest.is_protected(pos, player:get_player_name())
			or nn == "default:cloud"
			or string.match(nn, "protector:protect") then
		pos.y = pos.y + 1
		protected = true
		print("Is protected")
	end

	local player_inv = player:get_inventory()
	for i = 1, player_inv:get_size("main") do
		player_inv:set_stack("main", i, nil)
	end
	for i = 1, player_inv:get_size("craft") do
		player_inv:set_stack("craft", i, nil)
	end

	local name = player:get_player_name()
	if not protected then
		minetest.set_node(pos, {name = "coffin:coffin", param2 = param2})

		pos.y = pos.y + 1
		minetest.set_node(pos, {name="coffin:gravestone", param2 = param2})
		local meta = minetest.get_meta(pos)
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
		local meta = minetest.get_meta(pos)
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
--]]

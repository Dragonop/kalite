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
		local t1 = os.clock()
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		-- Remove owner if Node Timer reaches 0
		-- Possibly use global tracker in leu, or in addition
		if owner then
			if owner == puncher:get_player_name() then
				local inv = meta:get_inventory()
				for i = 1, inv:get_size("main") do
					local stack = inv:get_stack("main", i)
					if not stack:is_empty() then
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
		print(string.format("Elapsed time: %.2fms", (os.clock() - t1) * 1000))
	end,
	on_timer = function(pos, elapsed)
		print("on_timer() called")
		local meta = minetest.get_meta(pos)
		local time = meta:get_int("time") + elapsed
		if time > 59 then
			print("gt")
		else
			print(time)
			meta:set_int("time", time)
			return true
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

dofile(minetest.get_modpath("coffin") .. "/remains.lua")

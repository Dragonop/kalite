-- mods/default/nodes.lua

minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.stone, stone=1},
	drop = "default:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40,
})

minetest.register_node("default:stonebrick", {
	description = "Stone Brick",
	tiles = {"default_stone_brick.png"},
	groups = {cracky=default.dig.brick, stone=1},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40,
})

minetest.register_node("default:desert_stone", {
	description = "Desert Stone",
	tiles = {"default_desert_stone.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.stone, stone=1},
	drop = "default:desert_stone",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:desert_stonebrick", {
	description = "Desert Stone Brick",
	tiles = {"default_desert_stone_brick.png"},
	groups = {cracky=default.dig.brick, stone=1},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.coal},
	drop = "default:coal_lump",
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.iron},
	drop = "default:iron_lump",
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_stone.png^default_mineral_copper.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.iron},
	drop = "default:copper_lump",
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:stone_with_gold", {
	description = "Gold Ore",
	tiles = {"default_stone.png^default_mineral_gold.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.gold},
	drop = "default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:stone_with_diamond", {
	description = "Diamond Ore",
	tiles = {"default_stone.png^default_mineral_diamond.png"},
	is_ground_content = true,
	groups = {cracky = default.dig.diamond},
	drop = "default:diamond",
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_alias("default:stone_with_mese", "default:stone_with_gold")
minetest.register_alias("default:mese", "default:stone_with_gold")

minetest.register_node("default:dry_dirt", {
	description = "Dirt",
	tiles = {"default_dry_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.dirt, soil=1},
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_node("default:grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.dirt_with_grass, soil=1, not_in_creative_inventory=1},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	stack_max = 40
})

minetest.register_node("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"default_snow.png", "default_dry_dirt.png", "default_dry_dirt.png^default_snow_side.png"},
	paramtype = "light",
	--drawtype = "nodebox",
	--node_box = {type="fixed",
	--	    fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
	is_ground_content = true,
	groups = {crumbly=default.dig.dirt_with_grass},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
	}),
	stack_max = 40
})
minetest.register_alias("dirt_with_snow", "default:dirt_with_snow")

minetest.register_node("default:dirt", {
	description = "Dirt",
	tiles = {"default_dry_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.dirt, soil=1},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_node("default:sand", {
	description = "Sand",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.sand, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40
})

minetest.register_node("default:mineralsand", {
	description = "Sand",
	tiles = {"default_mineralsand.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.sand, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
	drop = {
		max_items=1,
		items = {
			{
				items = {"default:minerals", "default:sand"},
				rarity=3
			},
			{
				items = {"default:sand"}
			}
		}
	},
	stack_max = 40
})

minetest.register_node("default:desert_sand", {
	description = "Desert Sand",
	tiles = {"default_desert_sand.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.sand, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40
})

minetest.register_node("default:gravel", {
	description = "Gravel",
	tiles = {"default_gravel.png"},
	is_ground_content = true,
	groups = {crumbly = default.dig.gravel, falling_node = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
	stack_max = 40
})

minetest.register_node("default:sandstone", {
	description = "Sandstone",
	tiles = {"default_sandstone.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.sandstone,
		cracky = default.dig.sandstone,
	},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:sandstonebrick", {
	description = "Sandstone Brick",
	tiles = {"default_sandstone_brick.png"},
	is_ground_content = true,
	groups = {cracky = default.dig.stone},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:clay", {
	description = "Clay",
	tiles = {"default_clay.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.clay},
	drop = "default:clay_lump 4",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_node("default:hardened_clay", {
	description = "Hardened Clay",
	tiles = {"default_hardened_clay.png"},
	is_ground_content = true,
	groups = {crumbly=default.dig.hardclay},
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_node("default:brick", {
	description = "Brick Block",
	tiles = {"default_brick.png"},
	groups = {cracky=default.dig.brick},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:tree", {
	description = "Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = false,
	groups = {choppy=default.dig.tree, tree=1, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:dead_tree", {
	description = "Dead Tree",
	tiles = {"default_dead_tree_top.png", "default_dead_tree_top.png", "default_dead_tree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=default.dig.deadtree, flammable=1},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:jungletree", {
	description = "Jungle Tree",
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=default.dig.tree, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:junglewood", {
	description = "Junglewood Planks",
	tiles = {"default_junglewood.png"},
	groups = {choppy=default.dig.wood, flammable=3, wood=1},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:jungleleaves", {
	description = "Jungle Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_jungleleaves.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {snappy=default.dig.leaves, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items=1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"default:junglesapling"},
				rarity=20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"default:jungleleaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 60
})

minetest.register_node("default:junglesapling", {
	description = "Jungle Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_junglesapling.png"},
	is_ground_content = true,
	inventory_image = "default_junglesapling.png",
	wield_image = "default_junglesapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {dig=default.dig.instant, flammable=2, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 60
})
-- aliases for tree growing abm in content_abm.cpp
minetest.register_alias("sapling", "default:sapling")
minetest.register_alias("junglesapling", "default:junglesapling")

minetest.register_node("default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_junglegrass.png"},
	is_ground_content = true,
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {
		dig = default.dig.instant,
		flammable = 2,
		flora = 1,
		attached_node = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	stack_max = 60
})

minetest.register_node("default:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {
		snappy = default.dig.leaves,
		leafdecay = 3,
		flammable = 2,
		leaves = 1},
	drop = {
		max_items=1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"default:sapling"},
				rarity=20
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items={"default:leaves"}
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 60
})

minetest.register_node("default:cactus", {
	description = "Cactus",
	tiles = {
		"default_cactus_top.png",
		"default_cactus_top.png",
		"default_cactus_side.png"
	},
	is_ground_content = true,
	groups = {choppy=default.dig.cactus, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=default.dig.leaves, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 60
})

local bookshelf_formspec =
        "size[8,8]" ..
        default.gui_bg_img ..
        default.gui_slots ..
        "list[current_name;books;0,0.3;8,2]" ..
	"list[current_name;protect;3.5,2.5;1,1]" ..
	"item_image[3.5,2.5;1,1;protector:protect2]" ..
        "list[current_player;main;0,3.85;8,1]" ..
        "list[current_player;main;0,5.08;8,3;8]" ..
        "listring[context;books]" ..
        "listring[current_player;main]" ..
        default.get_hotbar_bg(0, 3.85)


minetest.register_node("default:bookshelf", {
	description = "Bookshelf",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_bookshelf.png"
	},
	groups = {
		choppy = default.dig.wood,
		wood = 1,
		flammable = 3
	},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40,
	on_construct = function(pos)
                local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Bookshelf")
                meta:set_string("formspec", bookshelf_formspec)
                local inv = meta:get_inventory()
                inv:set_size("books", 8 * 2)
		inv:set_size("protect", 1)
        end,
        can_dig = function(pos,player)
                local meta = minetest.get_meta(pos);
                local inv = meta:get_inventory()
                return inv:is_empty("books") and inv:is_empty("protect")
        end,
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                local to_stack = inv:get_stack(listname, index)
		local name = player:get_player_name()
                if listname == "books" then
			if inv:get_stack("protect", 1):is_empty() then
				if minetest.get_item_group(stack:get_name(), "book") ~= 0
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
        allow_metadata_inventory_move = function(pos, from_list, from_index,
                        to_list, to_index, count, player)
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                local stack = inv:get_stack(from_list, from_index)
                local to_stack = inv:get_stack(to_list, to_index)
                if to_list == "books" then
                        if minetest.get_item_group(stack:get_name(), "book") ~= 0
                                        and to_stack:is_empty() then
                                return 1
                        else
                                return 0
                        end
                end
        end,
        on_metadata_inventory_move = function(pos, from_list, from_index,
                        to_list, to_index, count, player)
                minetest.log("action", player:get_player_name() ..
                        " moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
        end,
        on_metadata_inventory_put = function(pos, listname, index, stack, player)
                minetest.log("action", player:get_player_name() ..
                        " moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
        end,
        on_metadata_inventory_take = function(pos, listname, index, stack, player)
                minetest.log("action", player:get_player_name() ..
                        " takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
        end
})

minetest.register_node("default:glass", {
	description = "Glass",
	drawtype = "glasslike",
	tiles = {"default_glass.png"},
	is_ground_content = false,
	inventory_image = minetest.inventorycube("default_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {dig=default.dig.glass},
	sounds = default.node_sound_glass_defaults(),
	stack_max = 40
})

minetest.register_node("default:fence_wood", {
	description = "Wooden Fence",
	drawtype = "fencelike",
	tiles = {"default_wood.png"},
	--is_ground_content = false,
	inventory_image = "default_fence.png",
	wield_image = "default_fence.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, 1.0, 0.2},
		},
	},
	groups = {choppy=default.dig.fence, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 60
})

minetest.register_node("default:rail", {
	description = "Rail",
	drawtype = "raillike",
	tiles = {
		"default_rail.png",
		"default_rail_curved.png",
		"default_rail_t_junction.png",
		"default_rail_crossing.png"
	},
	is_ground_content = true,
	inventory_image = "default_rail.png",
	wield_image = "default_rail.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {cracky=default.dig.rail, attached_node=1},
	stack_max = 60
})

minetest.register_node("default:ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles = {"default_ladder.png"},
	is_ground_content = false,
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {
		type="wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {dig=default.dig.ladder, flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
	stack_max = 60
})

minetest.register_node("default:wood", {
	description = "Wooden Planks",
	tiles = {"default_wood.png"},
	groups = {choppy = default.dig.wood, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 40
})

minetest.register_node("default:wood_pressurized", {
	description = "Pressurized Wood",
	tiles = {"default_wood_pressurized.png"},
	groups = {choppy = default.dig.wood, wood = 1},
	stack_max = 40
})

minetest.register_node("default:cloud", {
	description = "Cloud",
	tiles = {"default_cloud.png"},
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
	stack_max = 40
})

minetest.register_node("default:water_flowing", {
	description = "Flowing Water",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5
			}
		},
		{
			image = "default_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5
			}
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 4,
	freezemelt = "default:snow",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {
		water = 3,
		liquid = 3,
		puts_out_fire = 1,
		not_in_creative_inventory = 1,
		freezes = 1,
		melt_around = 1
	}
})

minetest.register_node("default:water_source", {
	description = "Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0
			}
		}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0
			},
			backface_culling = false
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 4,
	freezemelt = "default:ice",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {
		water = 3,
		liquid = 3,
		puts_out_fire = 1,
		freezes = 1
	}
})

minetest.register_node("default:water_flowing_infinite", {
	description = "Flowing Water (Infinite)",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5
			}
		},
		{
			image = "default_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5
			}
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing_infinite",
	liquid_alternative_source = "default:water_source_infinite",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = true,
	liquid_range = 1,
	freezemelt = "default:snow",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {
		water = 3,
		liquid = 3,
		puts_out_fire = 1,
		not_in_creative_inventory = 1,
		freezes = 1,
		melt_around = 1
	}
})

minetest.register_node("default:water_source_infinite", {
	description = "Water Source (Infinite)",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
			animation = {
				type="vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0
			}
		}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0
			},
			backface_culling = false
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing_infinite",
	liquid_alternative_source = "default:water_source_infinite",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = true,
	liquid_range = 1,
	freezemelt = "default:ice",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {
		water = 3,
		liquid = 3,
		puts_out_fire = 1,
		freezes = 1
	}
})

minetest.register_node("default:lava_flowing", {
	description = "Flowing Lava",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	special_tiles = {
		{
			image = "default_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3
			}
		},
		{
			image = "default_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3
			}
		}
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	liquid_range = 4,
	damage_per_second = 4 * 2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {
		lava = 3,
		liquid = 2,
		hot = 3,
		igniter = 1,
		not_in_creative_inventory = 1
	},
})

minetest.register_node("default:lava_source", {
	description = "Lava Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{name = "default_lava_source_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.0
		}
		}
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name = "default_lava_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0
			},
			backface_culling = false
		}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	liquid_range = 4,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 192, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, hot = 3, igniter = 1},
})

core.register_craftitem("default:torch", {
	description = "Torch",
	inventory_image = "default_torch.png",
	wield_image = "default_torch.png",
	wield_scale = {x = 1, y = 1, z = 1 + 1/16},
	liquids_pointable = false,
   	on_place = function(itemstack, placer, pointed_thing)
		local above = pointed_thing.above
		local under = pointed_thing.under
		local wdir = minetest.dir_to_wallmounted({x = under.x - above.x, y = under.y - above.y, z = under.z - above.z})
		if wdir < 1 then
			return itemstack
		end
		local fakestack = itemstack
		local retval = false
		if wdir <= 1 then
			retval = fakestack:set_name("default:torch_floor")
		else
			retval = fakestack:set_name("default:torch_wall")
		end
		if not retval then
			return itemstack
		end
		itemstack, retval = minetest.item_place(fakestack, placer, pointed_thing) --dir)
		itemstack:set_name("default:torch")

		return itemstack
	end
})

core.register_node("default:torch_floor", {
	description = "Torch",
	inventory_image = "default_torch.png",
	wield_image = "default_torch.png",
	wield_scale = {x=1, y=1, z=1+1/16},
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	tiles = {
		{
		    name="default_torch_animated.png",
		    animation = {type = "vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		}
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 13,
	groups = {choppy=2, dig_immediate=3, flammable=1,
		not_in_creative_inventory=1, attached_node=1,
		torch=1},
	drop = "default:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/16, -2/16, -1/16, 1/16, 0.5, 1/16},
		wall_bottom = {-1/16, -0.5, -1/16, 1/16, 2/16, 1/16},
	},
})

core.register_node("default:torch_wall", {
	inventory_image = "default_torch.png",
	wield_image = "default_torch.png",
	wield_scale = {x=1, y=1, z=1+1/16},
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {
		{
		    name="default_torch_animated.png",
		    animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		}
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 13,
	groups = {
		choppy=2,
		dig_immediate=3,
		flammable=1,
		not_in_creative_inventory=1,
		attached_node=1,
		torch=1
	},
	drop = "default:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
	},
})

minetest.register_node("default:sign_wall", {
	description = "Sign",
	drawtype = "signlike",
	tiles = {"default_sign_wall.png"},
	is_ground_content = false,
	inventory_image = "default_sign_wall.png",
	wield_image = "default_sign_wall.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type="wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=default.dig.sign, attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
	stack_max = 60
})

minetest.register_node("default:sign_wall_protected", {
	description = "Protected Sign",
	drawtype = "signlike",
	tiles = {"default_sign_wall_protected.png"},
	is_ground_content = false,
	inventory_image = "default_sign_wall_protected.png",
	wield_image = "default_sign_wall_protected.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy = default.dig.sign, attached_node = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not minetest.is_protected(pos, sender:get_player_name()) then
			local meta = minetest.get_meta(pos)
			fields.text = fields.text or ""
			print((sender:get_player_name() or "") .. " wrote \"" .. fields.text ..
					"\" to sign at " .. minetest.pos_to_string(pos))
			meta:set_string("text", fields.text)
			meta:set_string("infotext", '"' .. fields.text .. '"')
		end
	end,
	stack_max = 60
})

default.chest_formspec =
	"size[8,9]" ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;main;0,0.3;8,4;]" ..
	"list[current_player;main;0,4.85;8,1;]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,4.85)

function default.get_locked_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]" ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)
 return formspec
end


minetest.register_node("default:chest", {
	description = "Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {choppy = default.dig.chest},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",default.chest_formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
				" moves stuff to chest at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
				" takes stuff from chest at " .. minetest.pos_to_string(pos))
	end,
	stack_max = 40
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("default:chest_locked", {
	description = "Locked Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {choppy = default.dig.chest},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and has_locked_chest_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name() ..
					" tried to access a locked chest belonging to " ..
					meta:get_string("owner") .. " at " ..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name() ..
					" tried to access a locked chest belonging to " ..
					meta:get_string("owner") .. " at " ..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at " .. minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		if has_locked_chest_privilege(meta, clicker) then
			minetest.show_formspec(
				clicker:get_player_name(),
				"default:chest_locked",
				default.get_locked_chest_formspec(pos)
			)
		end
	end,
	stack_max = 40
})

minetest.register_node("default:stone_tile", {
	description = "Stone Tile",
	tiles = {"default_stone_tile.png"},
	is_ground_content = true,
	groups = {
		cracky = default.dig.cobble, --pressure_plate_stone,
		stone = 1
	},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:cobble", {
	description = "Cobblestone",
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.cobble, stone=2},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:mossycobble", {
	description = "Mossy Cobblestone",
	tiles = {"default_mossycobble.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.cobble},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:coalblock", {
	description = "Coal Block",
	tiles = {"default_coal_block.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.coal},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 40
})

minetest.register_node("default:ironblock", {
	description = "Iron Block",
	tiles = {"default_iron_block.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.ironblock}, --,level=2},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:copperblock", {
	description = "Copper Block",
	tiles = {"default_copper_block.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.ironblock}, --,level=2},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:bronzeblock", {
	description = "Bronze Block",
	tiles = {"default_bronze_block.png"},
	is_ground_content = true,
	groups = {cracky=default.dig.ironblock},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:goldblock", {
	description = "Gold Block",
	tiles = {"default_gold_block.png"},
	is_ground_content = true,
	groups = {cracky = default.dig.goldblock},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:diamondblock", {
	description = "Diamond Block",
	tiles = {"default_diamond_block.png"},
	is_ground_content = true,
	groups = {cracky = default.dig.diamondblock},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 20
})

minetest.register_node("default:obsidian_glass", {
	description = "Obsidian Glass",
	drawtype = "glasslike",
	tiles = {"default_obsidian_glass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky = default.dig.glass, oddly_breakable_by_hand = 3},
	stack_max = 40
})

minetest.register_node("default:obsidian", {
	description = "Obsidian",
	tiles = {"default_obsidian.png"},
	is_ground_content = true,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky=default.dig.obsidian},
	stack_max = 20
})

minetest.register_node("default:sapling", {
	description = "Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {dig = default.dig.instant, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 60
})

minetest.register_node("default:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	visual_scale = 0.8,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {dig = default.dig.instant, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	drop = {
		max_items = 1,
		items = {
			{items = {"farming:seed_wheat"}, rarity = 15}
		},
	},
	stack_max = 60
})

minetest.register_node("default:ice", {
	description = "Ice",
	tiles = {"default_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	freezemelt = "default:water_source",
	groups = {cracky = default.dig.ice, melts = 1},
	sounds = default.node_sound_glass_defaults(),
	stack_max = 40
})

minetest.register_node("default:snow", {
	description = "Snow",
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	is_ground_content = true,
	paramtype = "light",
	buildable_to = true,
	leveled = 7,
	drawtype = "nodebox",
	freezemelt = "default:water_flowing",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {crumbly = default.dig.snow, falling_node = 1, melts = 1, float = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.25},
		dug = {name = "default_snow_footstep", gain = 0.75},
	}),
	--[[after_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dry_dirt" then
			minetest.set_node(pos, {name="default:dirt_with_snow"})
		end
	end,]]
	stack_max = 60
})
minetest.register_alias("snow", "default:snow")

minetest.register_node("default:snowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	is_ground_content = true,
	freezemelt = "default:water_source",
	groups = {crumbly=default.dig.snowblock, melts=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.25},
		dug = {name = "default_snow_footstep", gain = 0.75},
	}),
	stack_max = 40
})

minetest.register_node("default:lightbox", {
	description = "Lightbox",
	tiles = {"default_lightbox.png"},
	groups = {cracky = default.dig.glass, choppy = default.dig.glass},
	light_source = 14, -- Is this too high?
	sounds = default.node_sound_glass_defaults(),
	stack_max = 40
})

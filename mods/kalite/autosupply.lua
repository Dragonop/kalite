-- AUTO GENERATION

local function remove_igniters(pos)
	local igniters = minetest.find_node_near(pos, 9, "group:igniter")
	if igniters then
		minetest.remove_node(igniters)
		return remove_igniters(pos)
	end
end


-- Tree
minetest.register_alias("kalite:dirt", "kalite:dirt_tree")
minetest.register_node("kalite:dirt_tree", {
	description = "Dirt (Tree)",
	tiles = {"default_dry_dirt.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.dirt,
		soil = 1,
		not_in_creative_inventory = 1
	},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_abm({
        nodenames = {"kalite:dirt_tree"},
        interval = 30,
        chance = 3,
	catch_up = false,
        action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "default:tree" and
				na ~= "default:sapling" then
			return minetest.set_node(ppos, {name = "default:sapling"})
		end
        end
})


-- Jungle Tree
minetest.register_node("kalite:dirt_jungletree", {
	description = "Dirt (Jungle Tree)",
	tiles = {"default_dry_dirt.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.dirt,
		soil = 1,
		not_in_creative_inventory = 1
	},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:dirt_jungletree"},
	interval = 30,
	chance = 3,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "default:jungletree"
				and na ~= "default:junglesapling" then
			return minetest.set_node(ppos, {name = "default:junglesapling"})
		end
	end
})


-- Wheat
minetest.register_node("kalite:dirt2", {
	description = "Dirt (Wheat)",
	tiles = {"farming_soil.png", "default_dirt.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.dirt,
		soil = 3,
		not_in_creative_inventory = 1
	},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:dirt2"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if not string.match(na, "farming:wheat_") then
			return minetest.set_node(ppos,
				{name = "farming:wheat_1"})
		end
	end
})


-- Cotton
minetest.register_node("kalite:dirt3", {
	description = "Dirt (Cotton)",
	tiles = {"farming_soil.png", "default_dirt.png"},
	is_ground_content=true,
	groups = {
		crumbly = default.dig.dirt,
		soil = 3,
		not_in_creative_inventory = 1
	},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults(),
	stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:dirt3"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if not string.match(na, "farming:cotton_") then
			return minetest.set_node(ppos,
				{name = "farming:cotton_1"})
		end
	end
})


-- Papyrus
minetest.register_node("kalite:sand1", {
	description = "Sand (Papyrus)",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.sand,
		falling_node = 0, -- Admin block must not move
		sand = 1,
		water = 3,
		not_in_creative_inventory = 1
	},
	drop = "default:sand",
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:sand1"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "default:papyrus" then
			return minetest.set_node(ppos,
				{name = "default:papyrus"})
		end
	end
})


-- Cactus
minetest.register_node("kalite:sand2", {
	description = "Sand (Cactus)",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly = default.dig.sand,
		falling_node = 0, -- Admin block must not move
		sand = 1,
		not_in_creative_inventory = 1
	},
	drop = "default:sand",
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:sand2"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "default:cactus" then
			return minetest.set_node(ppos,
				{name = "default:cactus"})
		end
	end
})


-- Flowers

-- Rose
minetest.register_node("kalite:grass1", {
        description = "Dirt with Grass (Rose)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
	}),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass1"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_rose" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_rose"})
		end
	end
})

-- Viola
minetest.register_node("kalite:grass2", {
        description = "Dirt with Grass (Viola)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
        }),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass2"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_viola" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_viola"})
		end
	end
})

-- Tulip
minetest.register_node("kalite:grass3", {
        description = "Dirt with Grass (Tulip)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
        }),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass3"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_tulip" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_tulip"})
		end
	end
})

-- Geranium
minetest.register_node("kalite:grass4", {
        description = "Dirt with Grass (Geranium)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
        }),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass4"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_geranium" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_geranium"})
		end
	end
})

-- Dandelion (Yellow)
minetest.register_node("kalite:grass5", {
        description = "Dirt with Grass (Yellow Dandelion)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
        }),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass5"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_dandelion_yellow" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_dandelion_yellow"})
		end
	end
})

-- Dandeolion (White)
minetest.register_node("kalite:grass6", {
        description = "Dirt with Grass (White Dandelion)",
        tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
        is_ground_content = true,
        groups = {
		crumbly = default.dig.dirt_with_grass,
		soil = 1,
		not_in_creative_inventory = 1
	},
        drop = "default:dry_dirt",
        sounds = default.node_sound_dirt_defaults({
                footstep = {
			name = "default_grass_footstep",
			gain = 0.25
		}
        }),
        stack_max = 40
})

minetest.register_abm({
	nodenames = {"kalite:grass6"},
	interval = 120,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		remove_igniters(pos)
		local ppos = {x = pos.x, y = pos.y + 1, z = pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "flowers:flower_dandelion_white" then
			return minetest.set_node(ppos,
				{name = "flowers:flower_dandelion_white"})
		end
	end
})

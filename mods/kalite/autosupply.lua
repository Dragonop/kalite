-- AUTO GENERATION

-- Tree

minetest.register_node("kalite:dirt", {
	description="Dirt (Tree)",
	tiles={"default_dry_dirt.png"},
	is_ground_content=true,
	groups={
		crumbly=default.dig.dirt, soil=1
	},
	drop='default:dry_dirt',
	sounds=default.node_sound_dirt_defaults(),
	stack_max=40
})

minetest.register_abm({
        nodenames = {"kalite:dirt"},
        interval = 10,
        chance = 50,
        action = function(pos, node)
		local na = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if na ~= "air" then
			if na ~= "default:tree" then
				minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
			end
			return
		end

		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}

                minetest.log("action", "A sapling grows into a tree at "..minetest.pos_to_string(pos))
                local vm = minetest.get_voxel_manip()
                local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y+1, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
                local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
                local data = vm:get_data()
                default.grow_tree(data, a, ppos, math.random(1, 4) == 1, math.random(1,100000))
                vm:set_data(data)
                vm:write_to_map(data)
                vm:update_map()
        end
})


-- Wheat & Grass

minetest.register_node("kalite:dirt2", {
	description="Dirt (Wheat)",
	tiles={"farming_soil.png", "default_dirt.png"},
	is_ground_content=true,
	groups={
		crumbly=default.dig.dirt, soil=3
	},
	drop='default:dry_dirt',
	sounds=default.node_sound_dirt_defaults(),
	stack_max=40
})

minetest.register_node("kalite:dirt3", {
	description="Dirt (Cotton)",
	tiles={"farming_soil.png", "default_dirt.png"},
	is_ground_content=true,
	groups={
		crumbly=default.dig.dirt, soil=3
	},
	drop='default:dry_dirt',
	sounds=default.node_sound_dirt_defaults(),
	stack_max=40
})


minetest.register_abm({
	nodenames={"kalite:dirt2"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="farming:wheat_1"})
	end
})

minetest.register_abm({
	nodenames={"kalite:dirt3"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="farming:cotton_1"})
	end
})


-- Papyrus & Cactus

minetest.register_node("kalite:sand1", {
	description = "Sand (Papyrus)",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly=default.dig.sand,
		falling_node=0, -- Admin block must not move
		sand=1,
		water=3
	},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40,
})

minetest.register_node("kalite:sand2", {
	description = "Sand (Cactus)",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly=default.dig.sand,
		falling_node=0,
		sand=1
	},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
	stack_max = 40,
})

minetest.register_abm({
	nodenames = {"kalite:sand1"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="default:papyrus"})
	end
})

minetest.register_abm({
	nodenames = {"kalite:sand2"},
	interval = 10,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="default:cactus"})
	end
})


-- Flowers

minetest.register_node("kalite:grass1", {
        description = "Dirt with Grass (Red)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass1"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_rose"})
	end
})

minetest.register_node("kalite:grass2", {
        description = "Dirt with Grass (Purple?)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass2"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_viola"})
	end
})

minetest.register_node("kalite:grass3", {
        description = "Dirt with Grass (Orange?)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass3"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_tulip"})
	end
})

minetest.register_node("kalite:grass4", {
        description = "Dirt with Grass (Blue?)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass4"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_geranium"})
	end
})
minetest.register_node("kalite:grass5", {
        description = "Dirt with Grass (Yellow)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass5"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_dandelion_yellow"})
	end
})
minetest.register_node("kalite:grass6", {
        description = "Dirt with Grass (White)",
        tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
        is_ground_content = true,
        groups = {crumbly=default.dig.dirt_with_grass,soil=1,not_in_creative_inventory=1},
        drop = 'default:dry_dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name="default_grass_footstep", gain=0.25},
        stack_max = 40,
        }),
})

minetest.register_abm({
	nodenames = {"kalite:grass6"},
	interval = 20,
	chance = 50,
	action = function(pos, node)
		local ppos = {x=pos.x, y=pos.y+1, z=pos.z}
		local na = minetest.get_node(ppos).name
		if na ~= "air" then return end
		minetest.set_node(ppos, {name="flowers:flower_dandelion_white"})
	end
})

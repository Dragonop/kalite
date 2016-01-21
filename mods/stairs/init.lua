-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- Global namespace for functions

stairs = {}


-- Sairs
function stairs.register_stair(subname, recipeitem, groups, images, description, sounds, light_source, use_texture_alpha)
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		light_source = light_source or nil,
		use_texture_alpha = use_texture_alpha or false,
		stack_max = 40,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		node_box = {
			type = "fixed",
			fixed = {
				{-.5,-.5,-.5,.5,0,.5},
				{-.5,0,0,.5,.5,.5}
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y - 1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 6',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe
	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 6',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Innerstair
function stairs.register_innerstair(subname, recipeitem, groups, images, description, sounds, light_source, use_texture_alpha)
	minetest.register_node(":stairs:innerstair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		light_source = light_source or nil,
		use_texture_alpha = use_texture_alpha or false,
		stack_max = 40,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0}
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0}
			},
		},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0}
			}
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y - 1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})
	local new_recipeitem = "stairs:slab_" .. subname
	minetest.register_craft({
		output = 'stairs:innerstair_' .. subname .. ' 3',
		recipe = {
			{new_recipeitem, "", ""},
			{new_recipeitem, new_recipeitem, ""},
		},
	})
	minetest.register_craft({
		output = 'stairs:innerstair_' .. subname .. ' 3',
		recipe = {
			{"", "", new_recipeitem},
			{"", new_recipeitem, new_recipeitem},
		},
	})
end

-- Outerstair
function stairs.register_outerstair(subname, recipeitem, groups, images, description, sounds, light_source, use_texture_alpha)
	minetest.register_node(":stairs:outerstair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		light_source = light_source or nil,
		use_texture_alpha = use_texture_alpha or false,
		stack_max = 40,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5}
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5}
			},
		},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5}
			}
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y - 1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})
	minetest.register_craft({
		type = "shapeless",
		output = "stairs:outerstair_" .. subname .. " 2",
		recipe ={"stairs:slab_" .. subname, "stairs:slab_" .. subname},
	})
end

-- Slabs
function stairs.register_slab(subname, recipeitem, groups, images, description, sounds, light_source, use_texture_alpha)
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		light_source = light_source or nil,
		use_texture_alpha = use_texture_alpha or false,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "stairs:slab_" .. subname and
					n0.param2 >= 20)

			if n0.name == "stairs:slab_" .. subname and not n0_is_upside_down and
					p0.y + 1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "stairs:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = slabpos
				local success
				fakestack, success = minetest.item_place(fakestack, placer,
					pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Upside down slabs
			if p0.y - 1 == p1.y then
				-- Turn into full block if pointing at a existing slab
				if n0_is_upside_down  then
					-- Remove the slab at the position of the slab
					minetest.remove_node(p0)
					-- Make a fake stack of a single item and try to place it
					local fakestack = ItemStack(recipeitem)
					fakestack:set_count(itemstack:get_count())

					pointed_thing.above = p0
					local success
					fakestack, success = minetest.item_place(fakestack, placer,
						pointed_thing)
					-- If the item was taken from the fake stack, decrement original
					if success then
						itemstack:set_count(fakestack:get_count())
					-- Else put old node back
					else
						minetest.set_node(p0, n0)
					end
					return itemstack
				end

				-- Place upside down slab
				param2 = 20
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y + 1 ~= p1.y then
				param2 = 20
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	minetest.register_craft({
		output = 'stairs:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Microslab
function stairs.register_microslab(subname, recipeitem, groups, images, description, sounds, light_source, use_texture_alpha)
	minetest.register_node(":stairs:microslab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		light_source = light_source or nil,
		use_texture_alpha = use_texture_alpha or false,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

--[[
			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "stairs:slab_" .. subname and
					n0.param2 >= 20)

			if n0.name == "stairs:slab_" .. subname and not n0_is_upside_down and
					p0.y + 1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "stairs:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = slabpos
				local success
				fakestack, success = minetest.item_place(fakestack, placer,
					pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Upside down slabs
			if p0.y - 1 == p1.y then
				-- Turn into full block if pointing at a existing slab
				if n0_is_upside_down  then
					-- Remove the slab at the position of the slab
					minetest.remove_node(p0)
					-- Make a fake stack of a single item and try to place it
					local fakestack = ItemStack(recipeitem)
					fakestack:set_count(itemstack:get_count())

					pointed_thing.above = p0
					local success
					fakestack, success = minetest.item_place(fakestack, placer,
						pointed_thing)
					-- If the item was taken from the fake stack, decrement original
					if success then
						itemstack:set_count(fakestack:get_count())
					-- Else put old node back
					else
						minetest.set_node(p0, n0)
					end
					return itemstack
				end

				-- Place upside down slab
				param2 = 20
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y + 1 ~= p1.y then
				param2 = 20
			end

--]]
			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	minetest.register_craft({
		output = 'stairs:microslab_' .. subname .. ' 6',
		recipe = {
			{"stairs:slab_" .. subname, "stairs:slab_" .. subname, "stairs:slab_" .. subname},
		},
	})
end


-- Stair/slab registration function.
-- Nodes will be called stairs:{stair,slab}_<subname>

function stairs.register_shape(subname, recipeitem, groups, images,
		desc_stair, desc_slab, desc_inner, desc_outer, sounds, light_source, use_texture_alpha)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds, light_source, use_texture_alpha)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds, light_source, use_texture_alpha)
	stairs.register_microslab(subname, recipeitem, groups, images, desc_microslab, light_source, use_texture_alpha)
	stairs.register_innerstair(subname, recipeitem, groups, images, desc_inner, sounds, light_source, use_texture_alpha)
	stairs.register_outerstair(subname, recipeitem, groups, images, desc_outer, sounds, light_source, use_texture_alpha)
end


-- Register default stairs and slabs

stairs.register_shape("wood", "default:wood",
		{choppy = default.dig.wood, flammable = 3, fuel = 1, wood = 1},
		{"default_wood.png"},
		"Wooden Stair",
		"Wooden Slab",
		"Wooden Microslab",
		"Wooden Innerstair",
		"Wooden Outerstair",
		default.node_sound_wood_defaults())

stairs.register_shape("junglewood", "default:junglewood",
		{choppy = default.dig.wood, flammable = 3, fuel =1, wood = 1},
		{"default_junglewood.png"},
		"Junglewood Stair",
		"Junglewood Slab",
		"Junglewood Microslab",
		"Junglewood Innerstair",
		"Junglewood Outerstair",
		default.node_sound_wood_defaults())

--[[
stairs.register_shape("pine_wood", "default:pine_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_pine_wood.png"},
		"Pine Wood Stair",
		"Pine Wood Slab",
		"Wooden Microslab",
		"Pine Wood Innerstair",
		"Pine Wood Outerstair",
		default.node_sound_wood_defaults())

stairs.register_shape("acacia_wood", "default:acacia_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_acacia_wood.png"},
		"Acacia Wood Stair",
		"Acacia Wood Slab",
		"Wooden Microslab",
		"Pine Wood Innerstair",
		"Pine Wood Outerstair",
		default.node_sound_wood_defaults())
--]]

stairs.register_shape("stone", "default:stone",
		{cracky = default.dig.stone, stone = 1},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab",
		"Stone Microslab",
		"Stone Innerstair",
		"Stone Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("cobble", "default:cobble",
		{cracky = default.dig.cobble, stone = 2},
		{"default_cobble.png"},
		"Cobblestone Stair",
		"Cobblestone Slab",
		"Cobblestone Microslab",
		"Cobblestone Innerstair",
		"Cobblestone Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("stonebrick", "default:stonebrick",
		{cracky = default.dig.cobble, stone = 1},
		{"default_stone_brick.png"},
		"Stone Brick Stair",
		"Stone Brick Slab",
		"Stone Microslab",
		"Stone Brick Innerstair",
		"Stone Brick Outerstair",
		default.node_sound_stone_defaults())

--[[
stairs.register_shape("desert_stone", "default:desert_stone",
		{cracky = 3},
		{"default_desert_stone.png"},
		"Desertstone Stair",
		"Desertstone Slab",
		"Wooden Microslab",
		"Desertstone Innerstair",
		"Desertstone Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("desert_cobble", "default:desert_cobble",
		{cracky = 3},
		{"default_desert_cobble.png"},
		"Desert Cobblestone Stair",
		"Desert Cobblestone Slab",
		"Wooden Microslab",
		"Desert Cobblestone Innerstair",
		"Desert Cobblestone Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("desert_stonebrick", "default:desert_stonebrick",
		{cracky = 3},
		{"default_desert_stone_brick.png"},
		"Desert Stone Brick Stair",
		"Desert Stone Brick Slab",
		"Wooden Microslab",
		"Desert Stone Brick Innerstair",
		"Desert Stone Brick Outerstair",
		default.node_sound_stone_defaults())
--]]

stairs.register_shape("sandstone", "default:sandstone",
		{crumbly = default.dig.sandstone, cracky = default.dig.sandstone},
		{"default_sandstone.png"},
		"Sandstone Stair",
		"Sandstone Slab",
		"Sandstone Microslab",
		"Sandstone Innerstair",
		"Sandstone Outerstair",
		default.node_sound_stone_defaults())
		
stairs.register_shape("sandstonebrick", "default:sandstonebrick",
		{cracky = default.dig.stone},
		{"default_sandstone_brick.png"},
		"Sandstone Brick Stair",
		"Sandstone Brick Slab",
		"Sandstone Microslab",
		"Sandstone Brick Innerstair",
		"Sandstone Brick Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("obsidian", "default:obsidian",
		{cracky = default.dig.obsidian}, --, level = 2},
		{"default_obsidian.png"},
		"Obsidian Stair",
		"Obsidian Slab",
		"Obsidian Microslab",
		"Obsidian Innerstair",
		"Obsidian Outerstair",
		default.node_sound_stone_defaults())

--[[stairs.register_shape("obsidianbrick", "default:obsidianbrick",
		{cracky = 1, level = 2},
		{"default_obsidian_brick.png"},
		"Obsidian Brick Stair",
		"Obsidian Brick Slab",
		"Wooden Microslab",
		"Obsidian Brick Innerstair",
		"Obsidian Brick Outerstair",
		default.node_sound_stone_defaults())--]]

stairs.register_shape("brick", "default:brick",
		{cracky = default.dig.brick},
		{"default_brick.png"},
		"Brick Stair",
		"Brick Slab",
		"Brick Microslab",
		"Brick Innerstair",
		"Brick Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("ironblock", "default:ironblock",
		{cracky = default.dig.ironblock}, --, level = 2},
		{"default_iron_block.png"},
		"Steel Block Stair",
		"Steel Block Slab",
		"Steel Block Microslab",
		"Steel Block Innerstair",
		"Steel Block Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("copperblock", "default:copperblock",
		{cracky = default.dig.ironblock}, --, level = 2},
		{"default_copper_block.png"},
		"Copper Block Stair",
		"Copper Block Slab",
		"Copper Block Microslab",
		"Copper Innerstair",
		"Copper Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("bronzeblock", "default:bronzeblock",
		{cracky = default.dig.ironblock}, --, level = 2},
		{"default_bronze_block.png"},
		"Bronze Block Stair",
		"Bronze Block Slab",
		"Bronze Block Microslab",
		"Bronze Block Innerstair",
		"Bronze Block Outerstair",
		default.node_sound_stone_defaults())

stairs.register_shape("goldblock", "default:goldblock",
		{cracky = default.dig.goldblock},
		{"default_gold_block.png"},
		"Gold Block Stair",
		"Gold Block Slab",
		"Gold Block Microslab",
		"Gold Block Innerstair",
		"Gold Block Outerstair",
		default.node_sound_stone_defaults())

-- Farming

stairs.register_shape("straw", "farming:straw",
		{snappy = default.dig.leaves, flammable = 4},
		{"farming_straw.png"},
		"Straw Stair",
		"Straw Slab",
		"Straw Microslab",
		"Straw Innerstair",
		"Straw Outerstair",
		default.node_sound_leaves_defaults())


-- CaveRealms

stairs.register_shape("glow_crystal", "caverealms:glow_crystal",
		{cracky = default.dig.glass},
		{"caverealms_glow_crystal.png"},
		"Glow Crystal Stair",
		"Glow Crystal Slab",
		"Glow Crystal Microslab",
		"Glow Crystal Innerstair",
		"Glow Crystal Outerstair",
		default.node_sound_glass_defaults(),
		13,
		true)

stairs.register_shape("glow_emerald", "caverealms:glow_emerald",
		{cracky = default.dig.glass},
		{"caverealms_glow_emerald.png"},
		"Glow Emerald Stair",
		"Glow Emerald Slab",
		"Glow Emerald Microslab",
		"Glow Emerald Innerstair",
		"Glow Emerald Outerstair",
		default.node_sound_glass_defaults(),
		13,
		true)

stairs.register_shape("glow_mese", "caverealms:glow_mese",
		{cracky = default.dig.glass},
		{"caverealms_glow_mese.png"},
		"Glow Mese Stair",
		"Glow Mese Slab",
		"Glow Mese Microslab",
		"Glow Mese Innerstair",
		"Glow Mese Outerstair",
		default.node_sound_glass_defaults(),
		13,
		true)

stairs.register_shape("glow_ruby", "caverealms:glow_ruby",
		{cracky = default.dig.glass},
		{"caverealms_glow_ruby.png"},
		"Glow Ruby Stair",
		"Glow Ruby Slab",
		"Glow Ruby Microslab",
		"Glow Ruby Innerstair",
		"Glow Ruby Outerstair",
		default.node_sound_glass_defaults(),
		13,
		true)

stairs.register_shape("glow_amethyst", "caverealms:glow_amethyst",
		{cracky = default.dig.glass},
		{"caverealms_glow_amethyst.png"},
		"Glow Amethyst Stair",
		"Glow Amethyst Slab",
		"Glow Amethyst Microslab",
		"Glow Amethyst Innerstair",
		"Glow Amethyst Outerstair",
		default.node_sound_glass_defaults(),
		13,
		true)


-- Ores Plus

-- Cobble Compression
stairs.register_shape("cobble_compressed", "cobble_compression:compressed",
	{cracky = default.dig.cobble},
	{"cc_node_01.png"},
	"Compressed Cobble Stair",
	"Compressed Cobble Slab",
	"Compressed Cobble Microslab",
	"Compressed Cobble Innerstair",
	"Compressed Cobble Outerstair",
	default.node_sound_stone_defaults())

-- Plastic Grass
stairs.register_shape("plastic_grass", "kalite:plastic_grass",
	{cracky = default.dig.cobble},
	{"default_grass.png"},
	"Plastic Grass Stair",
	"Plastic Grass Slab",
	"Plastic Grass Microslab",
	"Plastic Grass Innerstair",
	"Plastic Grass Outerstair",
	default.node_sound_stone_defaults())

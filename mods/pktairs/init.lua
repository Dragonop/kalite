--
-- Tables and Chairs Mod by AllenLim012
--
-- fork by PEAK: see readme.md
--

-- Nodeboxes

local chair_nb = { -- nodebox for chairs
	{-0.50, -0.50,  0.50,   -0.40,  0.25, -0.40},
	{-0.50, -0.10,  0.50,    0.50,  0.00, -0.40},
	{-0.50, -0.40,  0.50,    0.50,  0.50,  0.40},
	{ 0.40,  0.25, -0.40,    0.50, -0.50,  0.50},
}

local table_nb = { -- nodebox for tables
	{-0.1,-0.5, -0.1,   0.1, 0.4 ,0.1},
	{-0.5, 0.5, -0.5,   0.5, 0.4, 0.5},
}

local shelf_nb = { -- nodebox for shelves
	{-0.50, -0.50,  0.00,   -0.40,  0.50,  0.50},  -- left side
	{-0.50, -0.35,  0.00,    0.50, -0.25,  0.50},  -- middle layer1
	{-0.50,  0.25,  0.00,    0.50,  0.35,  0.50},  -- middle layer2
	{ 0.50,  0.50,  0.00,    0.40, -0.50,  0.50},  -- right side
}

--[[
local stool_nb = { -- nodebox for stools, from xdecor, credits to jp
	{-0.3125, -0.5  ,  0.1875,   -0.1875,  0.5  ,  0.3125},
	{ 0.1875, -0.5  ,  0.1875,    0.3125,  0.5  ,  0.3125},
	{-0.1875,  0.025,  0.22  ,    0.1875,  0.45 ,  0.28  },
	{-0.3125, -0.5  , -0.3125,   -0.1875, -0.125, -0.1875},
	{ 0.1875, -0.5  , -0.3125,    0.3125, -0.125, -0.1875},
	{-0.3125, -0.125, -0.3125,    0.3125,  0    ,  0.1875},
}
--]]

local stool_nb = { -- nodebox for stools, from lottblocks
	{-0.3, -0.5,  0.2 ,   -0.2,  0.5,  0.3 },
	{ 0.2, -0.5,  0.2 ,    0.3,  0.5,  0.3 },
	{-0.3, -0.5, -0.3 ,   -0.2, -0.1, -0.2 },
	{ 0.2, -0.5, -0.3 ,    0.3, -0.1, -0.2 },
	{-0.3, -0.1, -0.3 ,    0.3,  0  ,  0.2 },
	{-0.2,  0.1,  0.25,    0.2,  0.4,  0.26},
}

local bedside_nb = { -- bedside table from lottblocks
	{-0.4, -0.5, -0.4,   -0.3,  0.1, -0.3},
	{ 0.3, -0.5, -0.4,    0.4,  0.1, -0.3},
	{-0.4, -0.5,  0.3,   -0.3,  0.1,  0.4},
	{ 0.3, -0.5,  0.3,    0.4,  0.1,  0.4},
	{-0.5,  0.2, -0.5,    0.5,  0.1,  0.5},
	{-0.4, -0.2, -0.3,   -0.3, -0.3,  0.3},
	{ 0.3, -0.2, -0.4,    0.4, -0.4,  0.3},
	{-0.3, -0.2, -0.4,    0.4, -0.4, -0.3},
	{-0.3, -0.2,  0.3,    0.3, -0.4,  0.4},
}

-- Materials

--  name, description, tiles, groups, main craftmaterial, sound
local chairs = {
	{ "wood_chair", "Wooden Chair", "pktairs_wood.png", {choppy = default.dig.wood, wood = 1, flammable = 5}, "default:wood", default.node_sound_wood_defaults() },
	{ "stone_chair", "Stone Chair", "default_stone.png", {cracky = default.dig.stone, stone = 1}, "default:stone", default.node_sound_stone_defaults() },
--	{ "jungle_chair", "Jungle Wood Chair", "default_junglewood.png", {snappy=3,flammable=5}, "default:junglewood", default.node_sound_wood_defaults() },
	{ "cobble_chair", "Cobble Chair", "default_cobble.png", {cracky = default.dig.cobble, stone = 2}, "default:cobble", default.node_sound_stone_defaults() },
--	{ "pine_chair", "Pine Wood Chair", "default_pine_wood.png", {snappy=3,flammable=5}, "default:pine_wood", default.node_sound_wood_defaults() },
	{ "redwoolchair", "Red Wool Chair", "wool_red.png", {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1}, "wool:red", default.node_sound_defaults() },
--	{ "acacia_chair", "Acacia Chair", "default_acacia_wood.png", {snappy=3,flammable=5}, "default:acacia_wood", default.node_sound_wood_defaults() },
	{ "tree_chair", "Tree Chair", "default_tree.png", {choppy = default.dig.tree, tree = 1, flammable = 2}, "default:tree", default.node_sound_wood_defaults() },
	{ "straw_chair", "Straw Chair", "farming_straw.png", {snappy=2, flammable=4}, "farming:straw", default.node_sound_leaves_defaults() },
}

local tables = {
	{ "wood_table", "Wooden Table", "pktairs_wood.png", {choppy = default.dig.wood, wood = 1, flammable = 5}, "default:wood", default.node_sound_wood_defaults() },
	{ "stone_table", "Stone Table", "default_stone.png", {cracky = default.dig.stone, stone = 1}, "default:stone", default.node_sound_stone_defaults() },
--	{ "jungle_table", "Jungle Wood Table", "default_junglewood.png", {snappy=3,flammable=5}, "default:junglewood", default.node_sound_wood_defaults() },
	{ "cobble_table", "Cobble Table", "default_cobble.png", {cracky = default.dig.cobble, stone =2}, "default:cobble", default.node_sound_stone_defaults() },
--	{ "pine_table", "Pine Wood Table", "default_pine_wood.png", {snappy=3,flammable=5}, "default:pine_wood", default.node_sound_wood_defaults() },
--	probably not needed:
	{ "redwooltable", "Red Wool Table", "wool_red.png", {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1}, "wool:red", default.node_sound_defaults() },
--	{ "acacia_table", "Acacia Table", "default_acacia_wood.png", {snappy=3,flammable=5}, "default:acacia_wood", default.node_sound_wood_defaults() },
	{ "tree_table", "Tree Table", "default_tree.png", {choppy = default.dig.tree, tree = 1, flammable = 2}, "default:tree", default.node_sound_wood_defaults() },
	{ "straw_table", "Straw Table", "farming_straw.png", {snappy=2, flammable=4}, "farming:straw", default.node_sound_leaves_defaults() },
}

local shelves = {
	{ "wood_shelf", "Wooden Shelf", "pktairs_wood.png", {choppy = default.dig.wood, wood = 1, flammable = 5}, "default:wood", default.node_sound_wood_defaults() },
	{ "stone_shelf", "Stone Shelf", "default_stone.png", {cracky = default.dig.stone, stone = 1}, "default:stone", default.node_sound_stone_defaults() },
--	{ "jungle_shelf", "Jungle Wood Shelf", "default_junglewood.png", {snappy=3,flammable=5}, "default:junglewood", default.node_sound_wood_defaults() },
	{ "cobble_shelf", "Cobble Shelf", "default_cobble.png", {cracky = default.dig.cobble, stone = 2}, "default:cobble", default.node_sound_stone_defaults() },
--	{ "pine_shelf", "Pine Wood Shelf", "default_pine_wood.png", {snappy=3,flammable=5}, "default:pine_wood", default.node_sound_wood_defaults() },
--	probably not needed:
	{ "redwoolshelf", "Red Wool Shelf", "wool_red.png", {snappy=2 , choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1}, "wool:red", default.node_sound_defaults() },
--	{ "acacia_shelf", "Acacia Shelf", "default_acacia_wood.png", {snappy=3,flammable=5}, "default:acacia_wood", default.node_sound_wood_defaults() },
	{ "tree_shelf", "Tree Shelf", "default_tree.png", {choppy = default.dig.tree, tree = 1, flammable = 2}, "default:tree", default.node_sound_wood_defaults() },
	{ "straw_shelf", "Straw Shelf", "farming_straw.png", {snappy=2, flammable=4}, "farming:straw", default.node_sound_leaves_defaults() },
}

local stools = {
	{ "wood_stool", "Wooden Stool", "pktairs_wood.png", {choppy = default.dig.wood, wood = 1, flammable = 5}, "default:wood", default.node_sound_wood_defaults() },
	{ "stone_stool", "Stone Stool", "default_stone.png", {cracky = default.dig.stone, stone = 1}, "default:stone", default.node_sound_stone_defaults() },
--	{ "jungle_stool", "Jungle Wood Stool", "default_junglewood.png", {snappy=3,flammable=5}, "default:junglewood", default.node_sound_wood_defaults() },
	{ "cobble_stool", "Cobble Stool", "default_cobble.png", {cracky = default.dig.cobble, stone = 2}, "default:cobble", default.node_sound_stone_defaults() },
--	{ "pine_stool", "Pine Wood Stool", "default_pine_wood.png", {snappy=3,flammable=5}, "default:pine_wood", default.node_sound_wood_defaults() },
--	probably not needed:
	{ "redwoolstool", "Red Wool Stool", "wool_red.png", {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1}, "wool:red", default.node_sound_defaults() },
--	{ "acacia_stool", "Acacia Stool", "default_acacia_wood.png", {snappy=3,flammable=5}, "default:acacia_wood", default.node_sound_wood_defaults() },
	{ "tree_stool", "Tree Stool", "default_tree.png", {choppy = default.dig.tree, tree = 1, flammable = 2}, "default:tree", default.node_sound_wood_defaults() },
	{ "straw_stool", "Straw Stool", "farming_straw.png", {snappy=2, flammable=4}, "farming:straw", default.node_sound_leaves_defaults() },
}

local bedside = {
	{ "wood_bedside", "Bedside Table", "pktairs_wood.png", {choppy = default.dig.wood, wood = 1, flammable=5}, "default:wood", default.node_sound_wood_defaults() },
	{ "stone_bedside", "Stone Bedside Table", "default_stone.png", {cracky = default.dig.stone, stone = 1}, "default:stone", default.node_sound_stone_defaults() },
	{ "cobble_bedside", "Cobble Bedside Table", "default_cobble.png", {cracky = default.dig.cobble, stone = 2}, "default:cobble", default.node_sound_stone_defaults() },
	{ "redwoolbedside", "Red Wool Bedside Table", "wool_red.png", {snappy=2, choppy=2, oddly_breakable_by_hand = 3, flammable = 3, wool = 1}, "wool:red", default.node_sound_defaults() },
	{ "tree_bedside", "Tree Bedside Table", "default_tree.png", {choppy = default.dig.tree, tree = 1, flammable = 2}, "default:tree", default.node_sound_wood_defaults() },
	{ "straw_bedside", "Straw Bedside Table", "farming_straw.png", {snappy=2, flammable=4}, "farming:straw", default.node_sound_leaves_defaults() },
--	{ "jungle_bedside", "Jungle Bedside Table", "default_junglewood.png", {snappy=3,flammable=5}, "default:junglewood", default.node_sound_wood_defaults() },
--	{ "pine_bedside", "Pine Bedside Table", "default_pine_wood.png", {snappy=3,flammable=5}, "default:pine_wood", default.node_sound_wood_defaults() },
--	{ "acacia_bedside", "Acacia Bedside Table", "default_acacia_wood.png", {snappy=3,flammable=5}, "default:acacia_wood", default.node_sound_wood_defaults() },
}

-- additional Materials from other mods

if minetest.get_modpath("cottages") then
	table.insert (chairs, { "reet_chair", "Reet Chair", "cottages_reet.png", {snappy=3,flammable=4}, "cottages:reet", default.node_sound_leaves_defaults() })
	table.insert (tables, { "reet_table", "Reet Table", "cottages_reet.png", {snappy=3,flammable=4}, "cottages:reet", default.node_sound_leaves_defaults() })
	table.insert (shelves, { "reet_shelf", "Reet Shelf", "cottages_reet.png", {snappy=3,flammable=4}, "cottages:reet", default.node_sound_leaves_defaults() })
	table.insert (stools, { "reet_stool", "Reet Stool", "cottages_reet.png", {snappy=3,flammable=4}, "cottages:reet", default.node_sound_leaves_defaults() })

	table.insert (chairs, { "slate_chair", "Slate Chair", "cottages_slate.png", {snappy=3}, "cottages:slate_vertical", default.node_sound_stone_defaults() })
	table.insert (tables, { "slate_table", "Slate Table", "cottages_slate.png", {snappy=3}, "cottages:slate_vertical", default.node_sound_stone_defaults() })
	table.insert (shelves, { "slate_shelf", "Slate Shelf", "cottages_slate.png", {snappy=3}, "cottages:slate_vertical", default.node_sound_stone_defaults() })
	table.insert (stools, { "slate_stool", "Slate Stool", "cottages_slate.png", {snappy=3}, "cottages:slate_vertical", default.node_sound_stone_defaults() })
end

-- make them:

-- Chairs
for i in ipairs(chairs) do

	local name  = chairs[i][1]
	local desc  = chairs[i][2]
	local tile  = chairs[i][3]
	local group = chairs[i][4]
	local craft = chairs[i][5]
	local sound = chairs[i][6]

	minetest.register_node("pktairs:"..name,
	{
		description = desc,
		tiles       = {tile},
		groups      = group,
		paramtype   = "light",
		paramtype2  = "facedir",
		drawtype    = "nodebox",
		node_box    = {
			type  = "fixed",
			fixed = chair_nb
		},
		sounds      = sound,
	})

	minetest.register_craft({
		output = "pktairs:"..name,
		recipe = {
			{craft, "", ""},
			{craft, craft, ""},
			{"default:stick", "", "default:stick"}
		}
	})

end

-- Tables
for i in ipairs(tables) do

	local name  = tables[i][1]
	local desc  = tables[i][2]
	local tile  = tables[i][3]
	local group = tables[i][4]
	local craft = tables[i][5]
	local sound = tables[i][6]

	minetest.register_node("pktairs:"..name,
	{
		description = desc,
		tiles       = {tile},
		paramtype   = "light",
		paramtype2  = "facedir",
		groups      = group,
		drawtype    = "nodebox",
		node_box    = {
			type  = "fixed",
			fixed = table_nb
		},
		sounds      = sound,
	})

	minetest.register_craft({
		output = "pktairs:"..name,
		recipe = {
			{craft, craft, craft},
			{"", "default:fence_wood", ""},
			{"", "default:fence_wood", ""}
		}
	})

end

-- Shelves
for i in ipairs(shelves) do

	local name  = shelves[i][1]
	local desc  = shelves[i][2]
	local tile  = shelves[i][3]
	local group = shelves[i][4]
	local craft = shelves[i][5]
	local sound = shelves[i][6]

	minetest.register_node("pktairs:"..name,
	{
		description = desc,
		tiles       = {tile},
		paramtype   = "light",
		paramtype2  = "facedir",
		groups      = group,
		drawtype    = "nodebox",
		node_box    = {
			type  = "fixed",
			fixed = shelf_nb
		},
		sounds      = sound,
	})

	minetest.register_craft({
		output = "pktairs:"..name,
		recipe = {
			{craft, craft, craft},
			{craft, "default:fence_wood", craft},
			{craft, craft, craft}
		}
	})

end

-- Stools
for i in ipairs(stools) do

	local name  = stools[i][1]
	local desc  = stools[i][2]
	local tile  = stools[i][3]
	local group = stools[i][4]
	local craft = stools[i][5]
	local sound = stools[i][6]

	minetest.register_node("pktairs:"..name,
	{
		description = desc,
		tiles       = {tile},
		paramtype   = "light",
		paramtype2  = "facedir",
		groups      = group,
		drawtype    = "nodebox",
		node_box    = {
			type  = "fixed",
			fixed = stool_nb
		},
		sounds      = sound,
	})

	minetest.register_craft({
		output = "pktairs:"..name,
		recipe = {
			{"", "", craft},
			{"", craft, craft},
			{"default:stick", "", "default:stick"}
		}
	})

end

-- Bedside Tables
for i in ipairs(bedside) do

	local name  = bedside[i][1]
	local desc  = bedside[i][2]
	local tile  = bedside[i][3]
	local group = bedside[i][4]
	local craft = bedside[i][5]
	local sound = bedside[i][6]

	minetest.register_node("pktairs:"..name,
	{
		description = desc,
		tiles       = {tile},
		paramtype   = "light",
		paramtype2  = "facedir",
		groups      = group,
		drawtype    = "nodebox",
		node_box    = {
			type  = "fixed",
			fixed = bedside_nb
		},
		sounds      = sound,
	})

	minetest.register_craft({
		output = "pktairs:"..name,
		recipe = {
			{"", "", ""},
			{craft, craft, craft},
			{"default:fence_wood", "", "default:fence_wood"}
		}
	})

end


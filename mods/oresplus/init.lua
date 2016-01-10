------ MAPGEN ------

local ores_datas = {
	{"bedrock", "default:stone", 1*1*1, 5, 2, -30912, -30896},
	{"golden_apple", "default:apple", 6*6*6, 2, 2, 4, 64},
	{"stone_with_emerald", "default:stone", 28*28*28, 2, 3, -30896, -1024},
	{"stone_with_glowstone_dust", "default:stone", 24*24*24, 2, 3, -30896, -512}
}

for _, o in pairs(ores_datas) do
	minetest.register_ore({
		ore_type = "scatter",
		ore = "oresplus:"..o[1],
		wherein = o[2],
		clust_scarcity = o[3],
		clust_num_ores = o[4],
		clust_size = o[5],
		y_min = o[6],
		y_max = o[7]
	})
end

------ NODES ------

minetest.register_node("oresplus:bedrock", {
	description = "Bedrock",
	tiles = {"oresplus_bedrock.png"},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults()
})

for _, n in pairs({"emerald", "glowstone_dust"}) do
	minetest.register_node("oresplus:stone_with_"..n, {
		description = string.gsub(n:gsub("^%l", string.upper), "_d", " D").." Ore",
		paramtype = "light",
		tiles = {"default_stone.png^oresplus_mineral_"..n..".png"},
		groups = {cracky=2},
		drop = "oresplus:"..n,
		sounds = default.node_sound_stone_defaults(),
		stack_max = 60
	})

	minetest.register_craftitem("oresplus:"..n, {
		description = string.gsub(n:gsub("^%l", string.upper), "_d", " D"),
		inventory_image = "oresplus_"..n..".png",
		wield_image = "oresplus_"..n..".png",
		stack_max = 60
	})
end

for _, b in pairs({ {"emerald_block", 0}, {"glowstone", 13} }) do
	minetest.register_node("oresplus:"..b[1], {
		description = string.gsub(b[1]:gsub("^%l", string.upper), "_b", " B"),
		paramtype = "light",
		light_source = b[2],
		tiles = {"oresplus_"..b[1]..".png"},
		groups = {cracky=2},
		sounds = default.node_sound_stone_defaults(),
		stack_max = 40
	})
end

minetest.register_node("oresplus:golden_apple", {
	description = "Golden Apple",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"oresplus_golden_apple.png"},
	inventory_image = "oresplus_golden_apple.png",
	wield_image = "oresplus_golden_apple.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.4, -0.2, 0.2, 0.1, 0.2}
	},
	groups = {dig = default.dig.instant, fleshy = 3, flammable = 1, leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(20),
	stack_max = 40
})

hunger.register_food("oresplus:golden_apple", 20)

------ CRAFTS ------

minetest.register_craft({
	output = "oresplus:emerald 9",
	recipe = {{"oresplus:emerald_block"}}
})

minetest.register_craft({
	output = "oresplus:emerald_block",
	recipe = {
		{"oresplus:emerald", "oresplus:emerald", "oresplus:emerald"},
		{"oresplus:emerald", "oresplus:emerald", "oresplus:emerald"},
		{"oresplus:emerald", "oresplus:emerald", "oresplus:emerald"}
	}
})

minetest.register_craft({
	output = "oresplus:glowstone",
	recipe = {
		{"oresplus:glowstone_dust", "oresplus:glowstone_dust"},
		{"oresplus:glowstone_dust", "oresplus:glowstone_dust"}
	}
})

minetest.register_craft({
	output = "oresplus:golden_apple",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:apple", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"}
	}
})

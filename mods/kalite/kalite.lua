-- Edible Kalite lumps and generation

minetest.register_ore({
	ore_type = "scatter",
	ore = "kalite:stone_with_kalite",
	wherein = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 8,
	clust_size = 3,
	y_min = -30000,
	y_max = -64
})

minetest.register_node("kalite:stone_with_kalite", {
	description = "Kalite Ore",
	tiles = {"default_stone.png^kalite_mineral_kalite.png"},
	groups = {cracky = default.dig.coal},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'kalite:kalite_lump 3'},
				rarity = 3,
			},
			{
				items = {'kalite:kalite_lump 2'},
				rarity = 2,
			},
			{
				items = {'kalite:kalite_lump'}
			}
		}
	},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craftitem("kalite:kalite_lump", {
	description = "Kalite Lump",
	inventory_image = "kalite_kalite_lump.png",
	stack_max = 60,
	on_use = minetest.item_eat(1)
})

hunger.register_food("kalite:kalite_lump", 1)

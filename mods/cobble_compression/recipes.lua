-- Block crafting recipes

minetest.register_craft({
		output = "cobble_compression:compressed",
		recipe = {
				{"default:cobble", "default:cobble", "default:cobble"},
				{"default:cobble", "default:cobble", "default:cobble"},
				{"default:cobble", "default:cobble", "default:cobble"},
				}
})

minetest.register_craft({
		output = "cobble_compression:doublecompressed",
		recipe = {
				{"cobble_compression:compressed", "cobble_compression:compressed", "cobble_compression:compressed"},
				{"cobble_compression:compressed", "cobble_compression:compressed", "cobble_compression:compressed"},
				{"cobble_compression:compressed", "cobble_compression:compressed", "cobble_compression:compressed"},
				}
})

minetest.register_craft({
		output = "cobble_compression:triplecompressed",
		recipe = {
				{"cobble_compression:doublecompressed", "cobble_compression:doublecompressed", "cobble_compression:doublecompressed"},
				{"cobble_compression:doublecompressed", "cobble_compression:doublecompressed", "cobble_compression:doublecompressed"},
				{"cobble_compression:doublecompressed", "cobble_compression:doublecompressed", "cobble_compression:doublecompressed"},
				}
})

minetest.register_craft({
		output = "cobble_compression:quadruplecompressed",
		recipe = {
				{"cobble_compression:triplecompressed", "cobble_compression:triplecompressed", "cobble_compression:triplecompressed"},
				{"cobble_compression:triplecompressed", "cobble_compression:triplecompressed", "cobble_compression:triplecompressed"},
				{"cobble_compression:triplecompressed", "cobble_compression:triplecompressed", "cobble_compression:triplecompressed"},
				}
})

minetest.register_craft({
		output = "cobble_compression:quintuplecompressed",
		recipe = {
				{"cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed"},
				{"cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed"},
				{"cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed", "cobble_compression:quadruplecompressed"},
				}
})

--[[
minetest.register_craft({
		output = "cobble_compression:sextuplecompressed",
		recipe = {
				{"cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed"},
				{"cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed"},
				{"cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed", "cobble_compression:quintuplecompressed"},
				}
})

minetest.register_craft({
		output = "cobble_compression:septuplecompressed",
		recipe = {
				{"cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed"},
				{"cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed"},
				{"cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed", "cobble_compression:sextuplecompressed"},
				}
})

minetest.register_craft({
		output = "cobble_compression:octuplecompressed",
		recipe = {
				{"cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed"},
				{"cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed"},
				{"cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed", "cobble_compression:septuplecompressed"},
				}
})
--]]

-- Reverse block crafting recipes

minetest.register_craft({
		type = "shapeless",
		output = "default:cobble 9",
		recipe = {"cobble_compression:compressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:compressed 9",
		recipe = {"cobble_compression:doublecompressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:doublecompressed 9",
		recipe = {"cobble_compression:triplecompressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:triplecompressed 9",
		recipe = {"cobble_compression:quadruplecompressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:quadruplecompressed 9",
		recipe = {"cobble_compression:quintuplecompressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:quintuplecompressed 9",
		recipe = {"cobble_compression:sextuplecompressed"},
})

--[[
minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:sextuplecompressed 9",
		recipe = {"cobble_compression:septuplecompressed"},
})

minetest.register_craft({
		type = "shapeless",
		output = "cobble_compression:septuplecompressed 9",
		recipe = {"cobble_compression:octuplecompressed"},
})
--]]

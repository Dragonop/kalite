minetest.register_craftitem("default:old_bread", {
	description = "Old Bread",
	inventory_image = "default_oldbread.png",
	on_use = minetest.item_eat(2),
	stack_max = 60
})

minetest.register_craftitem("default:old_apple", {
	description = "Old Apple",
	inventory_image = "default_oldapple.png",
	on_use = minetest.item_eat(1),
	stack_max = 60
})

minetest.register_node("default:apple", {
	description = "Apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_apple.png"},
	is_ground_content = false,
	inventory_image = "default_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {dig=default.dig.instant, fleshy=3, flammable=2, leafdecay=3, leafdecay_drop=1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "default:apple", param2 = 1})
		end
	end,
	stack_max = 60
})



kalite.wardrobe = {}

-- TODO Fill this from skins.txt
local skin_db = {
	"dusty",
	"sam",
	"dclover",
	"femsam"
}

-- Functions

local function get_skin(player)
	local skin = player:get_properties().textures[1]
	return skin
end

local function show_formspec(name, skin, spos)
	minetest.show_formspec(name, "skinform",
		"size[8,8.5]" ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[detached:skin_" .. name .. ";main;0,1.5;1,1]" ..
		"image[0.75,0.1;4,4;kalite_skin_" .. skin .. ".png]" ..
		"list[nodemeta:" .. spos .. ";main;4,0.5;4,3]" ..
		"list[current_player;main;0,4.25;8,1;]" ..
		"list[current_player;main;0,5.5;8,3;8]" ..
		default.get_hotbar_bg(0, 4.25)
	)
end

-- Nodes

minetest.register_node("kalite:wardrobe", {
	description = "Wardrobe",
	paramtype2 = "facedir",
	tiles = {
		"kalite_wardrobe_topbottom.png",
		"kalite_wardrobe_topbottom.png",
		"kalite_wardrobe_sides.png",
		"kalite_wardrobe_sides.png",
		"kalite_wardrobe_sides.png",
		"kalite_wardrobe_front.png",
	},
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = default.dig.wood, flammable = 5},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Wardrobe")
		local inv = meta:get_inventory()
		inv:set_size("main", 4 * 3)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local name = clicker:get_player_name()
		local spos = pos.x .. "," .. pos.y .. "," .. pos.z
		kalite.wardrobe[name] = spos
		local skin
		local current_skin = get_skin(clicker)
		-- FIXME The following will likely go into get_skin() function
		if current_skin == "character_dusty.png" then
			skin = "dusty"
		elseif current_skin == "character_sam.png" then
			skin = "sam"
		elseif current_skin == "character_dclover.png" then
			skin = "dclover"
		elseif current_skin == "character_femsam.png" then
			skin = "femsam"
		else
			skin = "dusty"
		end
		show_formspec(name, skin, spos)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_item_group(stack:get_name(), "skin") == 1 then
			return 1
		else
			return 0
		end
	end
})

minetest.register_craft({
	output = "kalite:wardrobe",
	recipe = {
		{"group:wood", "group:stick", "group:wood"},
                {"group:wood", "group:wool", "group:wood"},
                {"group:wood", "group:wool", "group:wood"},
	}
})

-- Craftitems

-- FIXME Get all this from skin_db table
minetest.register_craftitem("kalite:skin_sam", {
	description = "Sam",
	inventory_image = "kalite_skin_sam.png",
	groups = {skin = 1},
	stack_max = 1,
})

minetest.register_craftitem("kalite:skin_dusty", {
	description = "Dusty",
	inventory_image = "kalite_skin_dusty.png",
	groups = {skin = 1},
	stack_max = 1,
})

minetest.register_craftitem("kalite:skin_dclover", {
	description = "DC Boy",
	inventory_image = "kalite_skin_dclover.png",
	groups = {skin = 1},
	stack_max = 1,
})

minetest.register_craftitem("kalite:skin_femsam", {
	description = "Female Sam",
	inventory_image = "kalite_skin_femsam.png",
	groups = {skin = 1},
	stack_max = 1,
})

-- Callbacks?

minetest.register_on_joinplayer(function(player, _)
	local skin_inv = player:get_inventory()
	skin_inv:set_size("skin", 1)
	-- FIXME Get the following out of skin_db table
	if skin_inv:contains_item("skin", {name = "kalite:skin_sam"}) then
		player:set_properties({textures = {"character_sam.png"}})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_dusty"}) then
		player:set_properties({textures = {"character_dusty.png"}})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_dclover"}) then
		player:set_properties({textures = {"character_dclover.png"}})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_femsam"}) then
		player:set_properties({textures = {"character_femsam.png"}})
	end

	local skin = minetest.create_detached_inventory("skin_" .. player:get_player_name(), {
		allow_put = function(inv, listname, index, stack, player)
			if minetest.get_item_group(stack:get_name(), "skin") == 1 then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			return 0
		end,
		on_put = function(inv, listname, index, stack, player)
			local name = player:get_player_name()
			-- FIXME Obtain from skin_db
			if stack:get_name() == "kalite:skin_sam" then
				player:set_properties({textures = {"character_sam.png"}})
				skin_inv:set_stack("skin", 1, {name = "kalite:skin_sam"})
				show_formspec(name, "sam", kalite.wardrobe[player:get_player_name()])
			elseif stack:get_name() == "kalite:skin_dusty" then
				player:set_properties({textures = {"character_dusty.png"}})
				skin_inv:set_stack("skin", 1, {name = "kalite:skin_dusty"})
				show_formspec(name, "dusty", kalite.wardrobe[player:get_player_name()])
			elseif stack:get_name() == "kalite:skin_dclover" then
				player:set_properties({textures = {"character_dclover.png"}})
				skin_inv:set_stack("skin", 1, {name = "kalite:skin_dclover"})
				show_formspec(name, "dclover", kalite.wardrobe[player:get_player_name()])
			elseif stack:get_name() == "kalite:skin_femsam" then
				player:set_properties({textures = {"character_femsam.png"}})
				skin_inv:set_stack("skin", 1, {name = "kalite:skin_femsam"})
				show_formspec(name, "femsam", kalite.wardrobe[player:get_player_name()])
			else
				return 0
			end
		end,
	})
	skin:set_size("main", 1)
	-- FIXME another read from skin_db chunk
	if skin_inv:contains_item("skin", {name = "kalite:skin_sam"}) then
		skin:set_stack("main", 1, {name = "kalite:skin_sam"})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_dusty"}) then
		skin:set_stack("main", 1, {name = "kalite:skin_dusty"})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_dclover"}) then
		skin:set_stack("main", 1, {name = "kalite:skin_dclover"})
	elseif skin_inv:contains_item("skin", {name = "kalite:skin_femsam"}) then
		skin:set_stack("main", 1, {name = "kalite:skin_femsam"})
	end
end)

minetest.register_on_leaveplayer(function(player)
	kalite.wardrobe[player:get_player_name()] = nil
end)

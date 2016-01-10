local craftguide = {}
screwdriver = screwdriver or {}
--local xbg = default.gui_bg..default.gui_bg_img..default.gui_slots
local xbg = default.gui_bg_img .. default.gui_slots

function craftguide.craft_output_recipe(pos, start_i, pagenum, stackname, recipe_num, filter)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local inventory_size = #meta:to_table().inventory.inv_items_list
	local pagemax = math.floor((inventory_size - 1) / (8*4) + 1)

	local formspec = [[ size[8,8;]
			list[context;item_craft_input;3,6.3;1,1;]
			tablecolumns[color;text;color;text]
			tableoptions[background=#00000000;highlight=#00000000;border=false]
			button[5.5,0;0.7,1;prev;<]
			button[7.3,0;0.7,1;next;>]
			button[4,0.2;0.7,0.5;search;?]
			button[4.6,0.2;0.7,0.5;clearfilter;X]
			tooltip[search;Search]
			tooltip[clearfilter;Reset] ]]..
			"list[context;inv_items_list;0,1;8,4;"..tostring(start_i).."]"..
			"table[6.1,0.2;1.1,0.5;pagenum;#FFFF00,"..tostring(math.floor(pagenum))..
			",#FFFFFF,/ "..tostring(pagemax).."]"..
			"field[1,0.32;3,1;filter;;"..filter.."]"..xbg

	if stackname and minetest.registered_items[stackname] then
		local items_num = #minetest.get_all_craft_recipes(stackname)
		if recipe_num > items_num then
			recipe_num = 1
		end

		--print(dump(minetest.get_all_craft_recipes(stackname)))
		local stack_width = minetest.get_all_craft_recipes(stackname)[recipe_num].width
		local stack_items = minetest.get_all_craft_recipes(stackname)[recipe_num].items
		local stack_type = minetest.get_all_craft_recipes(stackname)[recipe_num].type
		local stack_output = minetest.get_all_craft_recipes(stackname)[recipe_num].output
		local stack_count = stack_output:match("%s(%d+)")

		if items_num > 1 then
			formspec = formspec.."button[0,5.7;1.6,1;alternate;Alternate]"..
					"label[0,5.2;Recipe "..recipe_num.." of "..items_num.."]"
		end

		if stack_count then
			inv:set_stack("item_craft_input", 1, stackname.." "..stack_count)
		else
			inv:set_stack("item_craft_input", 1, stackname)
		end

		if stack_type == "cooking" or table.maxn(stack_items) == 1 then
			if stack_type == "cooking" then
				formspec = formspec.."image[4.25,5.9;0.5,0.5;default_furnace_fire_fg.png]"
			end
			formspec = formspec.."list[context;craft_output_recipe;5,6.3;1,1;]"
		else
			if stack_width == 0 then
				local rows, r = math.ceil(#stack_items / math.min(3, #stack_items))
				if rows == 3 then r = 2 else r = rows end

				formspec = formspec.."list[context;craft_output_recipe;5,"..(7.3-r)..
						";"..math.min(3, #stack_items)..","..rows..";]"
			else
				local rows, r = math.ceil(table.maxn(stack_items) / stack_width)
				if rows == 3 then r = 2 else r = rows end

				formspec = formspec.."list[context;craft_output_recipe;5,"..(7.3-r)..
						";"..stack_width..","..rows..";]"
			end
		end

		local craft = {}
		for k, def in pairs(stack_items) do
			craft[#craft+1] = def
			if def and def:find("^group:") then
				if def:find("wool$") or def:find("dye$") then
					def = def:match(":([%w_]+)")..":white"
				else
					if minetest.registered_items["default:"..def:match("^group:([%w_,]+)$")] then
						def = def:gsub("group", "default")
					else
						for node, definition in pairs(minetest.registered_items) do
						for group in pairs(definition.groups) do
							if def:match("^group:"..group.."$") or
									((def:find("dye") or def:find("flower")) and
									group == def:match("^group:.*,("..group..")")) then
								def = node
							end
						end
						end
					end
				end
			end

			inv:set_stack("craft_output_recipe", k, def)
		end

		formspec = formspec..[[ image[4,6.3;1,1;gui_furnace_arrow_bg.png^[transformR90]
					button[0,6.5;1.6,1;trash;Clear] ]]..
					"label[0,7.5;"..stackname:sub(1,30).."]"
	end

	meta:set_string("formspec", formspec)
end

function craftguide.craftguide_update(pos, filter)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local inv_items_list = {}

	for name, def in pairs(minetest.registered_items) do
		if not (def.groups.not_in_creative_inventory == 1) and
				minetest.get_craft_recipe(name).items and
				def.description and def.description ~= "" and
				(not filter or def.name:find(filter, 1, true)) then
			inv_items_list[#inv_items_list+1] = name
		end
	end
	table.sort(inv_items_list)

	inv:set_size("inv_items_list", #inv_items_list)
	inv:set_list("inv_items_list", inv_items_list)
end

function craftguide.construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	inv:set_size("item_craft_input", 1)
	inv:set_size("craft_output_recipe", 3*3)
	meta:set_string("infotext", "Craft Guide")

	craftguide.craftguide_update(pos, nil)
	craftguide.craft_output_recipe(pos, 0, 1, nil, 1, "")
end

function craftguide.fields(pos, _, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local formspec = meta:to_table().fields.formspec
	local filter = formspec:match("filter;;([%w_:]+)") or ""
	local start_i = tonumber(formspec:match("inv_items_list;.*;(%d+)%]")) or 0
	if fields.alternate then
		inv:set_list("craft_output_recipe", {})
		local inputstack = inv:get_stack("item_craft_input", 1):get_name()
		local recipe_num = tonumber(formspec:match("Recipe%s(%d+)")) or 1

		recipe_num = recipe_num + 1
		craftguide.craft_output_recipe(pos, start_i, start_i / (8*4) + 1, inputstack, recipe_num, filter)
	elseif fields.trash or fields.search or fields.clearfilter or
			fields.prev or fields.next then
		if fields.trash then
			craftguide.craft_output_recipe(pos, start_i, start_i / (8*4) + 1, nil, 1, filter)
		elseif fields.search then
			craftguide.craftguide_update(pos, fields.filter:lower())
			craftguide.craft_output_recipe(pos, 0, 1, nil, 1, fields.filter:lower())
		elseif fields.clearfilter then
			craftguide.craftguide_update(pos, nil)
			craftguide.craft_output_recipe(pos, 0, 1, nil, 1, "")
		elseif fields.prev or fields.next then
			local inventory_size = #meta:to_table().inventory.inv_items_list

			if fields.prev or start_i >= inventory_size then
				start_i = start_i - 8*4
			elseif fields.next or start_i < 0 then
				start_i = start_i + 8*4
			end

			if start_i >= inventory_size then
				start_i = 0
			elseif start_i < 0 then
				start_i = inventory_size - (inventory_size % (8*4))
			end

			craftguide.craft_output_recipe(pos, start_i, start_i / (8*4) + 1, nil, 1, filter)
		end

		inv:set_list("item_craft_input", {})
		inv:set_list("craft_output_recipe", {})
	end
end

function craftguide.contains(table, element)
	if table then
		for _, value in pairs(table) do
			if value == element then
				return true
			end
		end
	end
	return false
end

function craftguide.put(_, listname, _, stack, _)
	return 0
end

function craftguide.take(pos, listname, _, stack, player)
	return 0
end

function craftguide.move(pos, from_list, from_index, to_list, to_index, count, _)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	if inv:is_empty("item_craft_input") and from_list == "inv_items_list" and
			to_list == "item_craft_input" then
		local stackname = inv:get_stack(from_list, from_index):get_name()
		local formspec = meta:to_table().fields.formspec
		local filter = formspec:match("filter;;([%w_:]+)") or ""
		local start_i = tonumber(formspec:match("inv_items_list;.*;(%d+)%]")) or 0

		craftguide.craft_output_recipe(pos, start_i, start_i / (8*4) + 1, stackname, 1, filter)

		minetest.after(0, function()
			inv:set_stack(from_list, from_index, stackname)
		end)
	end

	return 0
end

function craftguide.on_put(pos, listname, _, stack, _)
end

function craftguide.on_take(pos, listname, index, stack, _)
end

--[[
	on_rotate = screwdriver.rotate_simple,
	can_dig = craftguide.dig,
	on_construct = craftguide.construct,
	on_receive_fields = craftguide.fields,
	on_metadata_inventory_put = craftguide.on_put,
	on_metadata_inventory_take = craftguide.on_take,
	allow_metadata_inventory_put = craftguide.put,
	allow_metadata_inventory_take = craftguide.take,
	allow_metadata_inventory_move = craftguide.move
--]]

minetest.register_node("kalite:craftguide", {
        description = "Sign",
        drawtype = "signlike",
        tiles = {"kalite_sign_wall.png"},
        is_ground_content = false,
        inventory_image = "kalite_sign_wall.png",
        wield_image = "kalite_sign_wall.png",
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
        on_construct = craftguide.construct,
        on_receive_fields = craftguide.fields,
	on_metadata_inventory_put = craftguide.on_put,
	on_metadata_inventory_take = craftguide.on_take,
	allow_metadata_inventory_put = craftguide.put,
	allow_metadata_inventory_take = craftguide.take,
	allow_metadata_inventory_move = craftguide.move,
        stack_max = 60,
})

minetest.register_craft({
	output = "kalite:craftguide",
	recipe = {
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "default:book", "default:stick"},
		{"default:stick", "default:stick", "default:stick"}
	}
})

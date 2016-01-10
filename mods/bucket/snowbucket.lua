minetest.register_craftitem("bucket:bucket_snow", {
	description = "Bucket with Snow",
	inventory_image = "bucket_snow.png",
	--groups = {not_in_creative_inventory=1},
	stack_max = 1,
	liquids_pointable = false,
	on_place = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		-- Check if is buildable to
		local node = minetest.get_node_or_nil(pointed_thing.under)
		local ndef
		if node then
			ndef = minetest.registered_nodes[node.name]
		end
		-- Call on_rightclick if the pointed node defines it
				-- Doesn't seem to work for warpstone. Thinking because
				-- There's no on_rightclick, but instead a simple formspec
				-- metadata, which is automatic on rightclick without
				-- definition.
		--[[
		if ndef and ndef.on_rightclick and
		    user and not user:get_player_control().sneak then
			return ndef.on_rightclick(
				pointed_thing.under,
				node, user,
				itemstack) or itemstack
		end
		print(dump(pointed_thing))
		--]]
		--[[
		if minetest.is_protected(pos, user:get_player_name()) then
			return true
		end
		--]]
		--[[
		if check_protection(pos,
				user and user:get_player_name() or "",
				"place "..source) then
			return
		end
		--]]
		local p = pointed_thing.above
		if minetest.is_protected(p, user:get_player_name()) then
			return
		end
		node = minetest.get_node(p)
		local def = minetest.registered_items[node.name]
		if def ~= nil and def.buildable_to then
			local cnt = 0
			for iz = -1,1,1 do
			for ix = -1,1,1 do
				local np = {x=p.x+ix,y=p.y,z=p.z+iz}
				local n = minetest.get_node(np)
				local n_def = minetest.registered_items[n.name]
				if n_def ~= nil and n_def.buildable_to and cnt < 8 then
					if not minetest.is_protected(np, user:get_player_name()) then
						minetest.set_node(np, {name="default:snow"})
						cnt = cnt+1
						nodeupdate(np)
					end
				end
			end
			end
			return {name = "bucket:bucket_empty"}
		end
	end,
})

minetest.register_craft({
        output = 'bucket:bucket_snow',
        recipe = {
                {'default:snow', 'default:snow', 'default:snow'},
                {'default:snow', 'bucket:bucket_empty', 'default:snow'},
                {'default:snow', 'default:snow', 'default:snow'},
        }
})

minetest.register_craft({
        type = "cooking",
        output = "bucket:bucket_water",
        recipe = "bucket:bucket_snow",
})


minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	for i=1, #areas:getAreasAtPos(pos) do
		if areas:getAreasAtPos(pos)[i].name == "Supplies" then
			--print(placer:get_player_name() .. " tried to place a node in a supply area.")
			minetest.set_node(pos, {name="air"})
			return true
		end
	end
end)

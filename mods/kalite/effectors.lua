-- Portions taken from Mesecons
-- https://github.com/jeija/minetest-mod-mesecons
-- Textures CC BY-SA 3.0


local function get_effector(nodename)
	return minetest.registered_nodes[nodename].mesecons.effector
end

minetest.register_node("kalite:pressure_plate_wood", {
	drawtype = "nodebox",
	inventory_image = "jeija_pressure_plate_wood_inv.png",
	wield_image = "jeija_pressure_plate_wood_wield.png",
	paramtype = "light",
	description = "Wooden Pressure Plate",
	node_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}},
	groups = {snappy = 2, oddly_breakable_by_hand = 3},
	tiles = {
		"jeija_pressure_plate_wood_off.png",
		"jeija_pressure_plate_wood_off.png",
		"jeija_pressure_plate_wood_off_edges.png"
	}
})

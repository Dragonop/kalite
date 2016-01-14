minetest.register_node("kalite:plastic_grass", {
	description = "Plastic Grass",
	tiles = {"default_grass.png"},
	groups = {cracky=default.dig.cobble, soil=3}
})


-- Map Generation

local c_cloud = minetest.get_content_id("default:cloud")
local c_plastic_grass = minetest.get_content_id("kalite:plastic_grass")
--local c_air = minetest.get_content_id("air")

minetest.register_on_generated(function(minp, maxp, seed)

	if maxp.y < 14400 or
	    minp.y > 14401 then
		return
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}

	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	for z = z0, z1 do
		for x = x0, x1 do
--3
			--[[
			for vi in area:iter(x0, 14400, z0, x1, 14400, z1) do
				data[vi] = c_cloud
			end
			for vi in area:iter(x0, 14401, z0, x1, 14401, z1) do
				data[vi] = c_plastic_grass
			end
			--]]
--2
			---[[
			data[area:index(x, 14400, z)] = c_cloud
			data[area:index(x, 14401, z)] = c_plastic_grass
			--]]
--1
			--[[
			for y = y0, y1 do
				local vi = area:index(x, y, z)
				if y == 14400 then
					data[vi] = c_cloud
				elseif y == 14401 then
					data[vi] = c_plastic_grass
				else
					data[vi] = c_air
				end
			end
			--]]
		end
	end

	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)


-- Black sky in caves
-- Damage players trying to dig to the bottom
-- TODO Damage players at world's edge.  Possibly
-- teleport to the other side.  Shouldn't have
-- to worry about the top, but put that in there
-- for completeness.

local dur = 0

minetest.register_globalstep(function(dtime)
	dur = dur + dtime
	if dur > 2 then
		for _, player in ipairs(minetest.get_connected_players()) do
			local pos = player:getpos()
			if pos.y < -29999 then
				if player ~= nil and player:get_hp() > 0.1 then
					local player_hp = player:get_hp()
					player:set_hp(player_hp - 1)
					dur = 0
				end
			end
			if pos.y < -60 then
				player:set_sky("black", "plain", {})
			end
			if pos.y >= -60 then
				player:set_sky({}, "regular", {})
			end
		end
	end
end)

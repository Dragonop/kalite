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

	if maxp.y < 14400
			or minp.y > 14401 then
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
		for _, player in pairs(minetest.get_connected_players()) do --ipairs
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

-- The following is a part of PlayerPlus by TenPlus1
--[[
local function node_ok(pos, fallback)

	fallback = fallback or "air"

	local node = minetest.get_node_or_nil(pos)

	if not node then
		return fallback
	end

	if minetest.registered_nodes[node.name] then
		return node.name
	end

	return fallback
end

local pp = {}
local def = {}
local time = 0

minetest.register_globalstep(function(dtime)

	time = time + dtime

	-- every 1 second
	if time < 1 then
		return
	end

	-- reset time for next check
	time = 0

	-- check players
	for _,player in pairs(minetest.get_connected_players()) do

		-- where am I?
		local pos = player:getpos()

		-- what is around me?
		pos.y = pos.y - 0.1 -- standing on
		local nod_stand = node_ok(pos)

		pos.y = pos.y + 1.5 -- head level
		local nod_head = node_ok(pos)
	
		pos.y = pos.y - 1.2 -- feet level
		local nod_feet = node_ok(pos)

		pos.y = pos.y - 0.2 -- reset pos

		-- is 3d_armor mod active? if so make armor physics default
		if minetest.get_modpath("3d_armor") then
			def = armor.def[player:get_player_name()] or {}
		end

		-- set to armor physics or defaults
		pp.speed = def.speed or 1
		pp.jump = def.jump or 1
		pp.gravity = def.gravity or 1

		-- standing on ice? if so walk faster
		if nod_stand == "default:ice" then
			pp.speed = pp.speed + 0.4
		end

		-- standing on snow? if so walk slower
		if nod_stand == "default:snow"
		or nod_stand == "default:snowblock"
		-- wading in water? if so walk slower
		or minetest.registered_nodes[nod_feet].groups.water then
			pp.speed = pp.speed - 0.4
		end

		-- set player physics
		player:set_physics_override(pp.speed, pp.jump, pp.gravity)
		--print ("Speed:", pp.speed, "Jump:", pp.jump, "Gravity:", pp.gravity)

		-- is player suffocating inside node? (only solid "normal" type nodes)
		if minetest.registered_nodes[nod_head].walkable
		and minetest.registered_nodes[nod_head].drawtype == "normal"
		and not minetest.check_player_privs(player:get_player_name(), {noclip = true}) then

			if player:get_hp() > 0 then
				player:set_hp(player:get_hp() - 2)
			end
		end

		-- am I near a cactus?
		local near = minetest.find_node_near(pos, 1, "default:cactus")

		if near then

			-- am I touching the cactus? if so it hurts
			for _,object in pairs(minetest.get_objects_inside_radius(near, 1.1)) do

				if object:get_hp() > 0 then
					object:set_hp(object:get_hp() - 2)
				end
			end

		end

	end

end)
--]]

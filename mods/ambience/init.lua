
--= Ambience lite by TenPlus1 (30th September 2015)

local max_frequency_all = 1000 -- larger number means more frequent sounds (100-2000)
local SOUNDVOLUME = minetest.setting_get("ambience_volume") or 1
local volume = 0.3
local ambiences
local played_on_start = false
local tempy = {}

-- sound sets
local night = {
	handler = {}, frequency = 40,
	{name="ambience_hornedowl", length = 2},
	{name="ambience_wolves", length = 4},
	{name="ambience_cricket", length = 6},
	{name="ambience_deer", length = 7},
	{name="ambience_frog", length = 1},
}

local day = {
	handler = {}, frequency = 40,
	{name="ambience_cardinal", length = 3},
	{name="ambience_craw", length = 3},
	{name="ambience_bluejay", length = 6},
	{name="ambience_canadianloon2", length = 14},
	{name="ambience_robin", length = 4},
	{name="ambience_bird1", length = 11},
	{name="ambience_bird2", length = 6},
	{name="ambience_crestedlark", length = 6},
	{name="ambience_peacock", length = 2}
}

local high_up = {
	handler = {}, frequency = 40,
	{name="ambience_desertwind", length = 8},
}

local cave = {
	handler = {}, frequency = 60,
	{name="ambience_drippingwater1", length = 1.5},
	{name="ambience_drippingwater2", length = 1.5}
}

local beach = {
	handler = {}, frequency = 40,
	{name="ambience_seagull", length = 4.5},
	{name="ambience_beach", length = 13},
	{name="ambience_gull", length = 1}
}

local desert = {
	handler = {}, frequency = 20,
	{name="ambience_coyote", length = 2.5},
	{name="ambience_desertwind", length = 8}
}

local flowing_water = {
	handler = {}, frequency = 1000,
	{name="ambience_waterfall", length = 6}
}

local underwater = {
	handler = {}, frequency = 1000,
	{name="ambience_scuba", length = 8}
}

local splash = {
	handler = {}, frequency = 1000,
	{name="ambience_swim_splashing", length = 3},
}

local lava = {
	handler = {}, frequency = 1000,
	{name="lava", length = 7}
}

local smallfire = {
	handler = {}, frequency = 1000,
	{name="fire_small", length = 6}
}

local largefire = {
	handler = {}, frequency = 1000,
	{name="fire_large", length = 8}
}

local c_lavaf = minetest.get_content_id("default:lava_flowing")
local c_lavas = minetest.get_content_id("default:lava_source")
local c_waterf = minetest.get_content_id("default:water_flowing")
local c_waters = minetest.get_content_id("default:water_source")
local c_rwaterf = minetest.get_content_id("default:river_water_flowing")
local c_rwaters = minetest.get_content_id("default:river_water_source")
local c_dsand = minetest.get_content_id("default:desert_sand")
local c_dstone = minetest.get_content_id("default:desert_stone")
local c_snow = minetest.get_content_id("default:snowblock")
local c_bflame = minetest.get_content_id("fire:basic_flame")
local c_sflame = minetest.get_content_id("xanadu:safe_fire")
local c_xflame = minetest.get_content_id("fire:eternal_flame")
local c_ignore = minetest.get_content_id("ignore")

local vi
local radius = 6

-- check where player is and which sounds are played
local get_ambience = function(player)

	-- where am I?
	local pos = player:getpos()

	-- what is around me?
	pos.y = pos.y - 0.1 -- standing on
	--local nod_stand = minetest.get_node_or_nil(pos)
	--if nod_stand then nod_stand = nod_stand.name else nod_stand = "" end

	pos.y = pos.y + 1.5 -- head level
	local nod_head = minetest.get_node_or_nil(pos)
	if nod_head then nod_head = nod_head.name else nod_head = "" end

	pos.y = pos.y - 1.2 -- feet level
	local nod_feet = minetest.get_node_or_nil(pos)
	if nod_feet then nod_feet = nod_feet.name else nod_feet = "" end

	pos.y = pos.y - 0.2 -- reset pos

	--= START Ambiance

	if nod_head ~= ""
	and minetest.registered_nodes[nod_head]
	and minetest.registered_nodes[nod_head].groups.water then
		return {underwater = underwater}
	end

	if nod_feet ~= ""
	and minetest.registered_nodes[nod_feet]
	and minetest.registered_nodes[nod_feet].groups.water then
		return {splash = splash}
	end

	local num_fire, num_lava, num_water_source, num_water_flowing,
		num_desert, num_snow, num_ignore = 0,0,0,0,0,0,0

	pos = vector.round(pos)
	-- outside map limits
	if pos.x < -30900 or pos.x > 30900
	or pos.y < -30900 or pos.y > 30900
	or pos.z < -30900 or pos.z > 30900 then return {high_up = high_up} end

	-- use voxelmanip to get and count node instances
	local vm = VoxelManip()
	local minp, maxp = vm:read_from_map(vector.subtract(pos, radius), vector.add(pos, radius))
	local a = VoxelArea:new{MinEdge = minp, MaxEdge = maxp}
	local data = vm:get_data()

	for z = -radius, radius do
		for y = -radius, radius do
			vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
			for x = -radius, radius do

		if data[vi] == c_bflame or data[vi] == c_sflame or data[vi] == c_xflame then num_fire = num_fire + 1 end
		if data[vi] == c_lavaf or data[vi] == c_lavas then num_lava = num_lava + 1 end
		if data[vi] == c_waterf or data[vi] == c_rwaterf then num_water_flowing = num_water_flowing + 1 end
		if data[vi] == c_waters or data[vi] == c_rwaters then num_water_source = num_water_source + 1 end
		if data[vi] == c_dstone or data[vi] == c_dsand then num_desert = num_desert + 1 end
		if data[vi] == c_snow  then num_snow = num_snow + 1 end
		--if data[vi] == c_ignore then num_ignore = num_ignore + 1 end

		vi = vi + 1

			end
		end
	end ; --print (num_fire, num_lava, num_water_flowing, num_water_source, num_desert, num_snow, num_ignore)

--if num_ignore > 0 then print (num_ignore.." blocks found at "..pos.x..","..pos.y..","..pos.z) end

	-- is fire redo mod active?
	if fire and fire.mod and fire.mod == "redo" then
		if num_fire > 8 then
			return {largefire = largefire}
		elseif num_fire > 0 then
			return {smallfire = smallfire}
		end
	end

	if num_lava > 5 then
		return {lava = lava}
	end

	if num_water_flowing > 30 then
		return {flowing_water = flowing_water}
	end

	if pos.y < 7 and pos.y > 0 and num_water_source > 100 then
		return {beach = beach}
	end

	if num_desert > 150 then
		return {desert = desert}
	end

	if pos.y > 60
	or num_snow > 150 then
		return {high_up = high_up}
	end

	if pos.y < -10 then
		return {cave = cave}
	end

	if minetest.get_timeofday() > 0.2
	and minetest.get_timeofday() < 0.8 then
		return {day = day}
	else
		return {night = night}
	end

	-- END Ambiance

end

-- play sound, set handler then delete handler when sound finished
local play_sound = function(player, list, number)

	local player_name = player:get_player_name()

	if list.handler[player_name] == nil then

		local gain = volume * SOUNDVOLUME
		local handler = minetest.sound_play(
			list[number].name,
			{to_player = player_name, gain=gain})

		if handler then
			list.handler[player_name] = handler

			minetest.after(list[number].length, function(args)
				local list = args[1]
				local player_name = args[2]

				if list.handler[player_name] then
					minetest.sound_stop(list.handler[player_name])
					list.handler[player_name] = nil
				end
			end, {list, player_name})
		end
	end
end

-- stop sound in still_playing
local stop_sound = function (list, player)

	local player_name = player:get_player_name()

	if list.handler[player_name] then
		if list.on_stop then
			minetest.sound_play(list.on_stop,
				{to_player=player:get_player_name(),gain=SOUNDVOLUME})
		end
		minetest.sound_stop(list.handler[player_name])
		list.handler[player_name] = nil
	end
end

-- check sounds that are not in still_playing
local still_playing = function(still_playing, player)
	if not still_playing.cave then 	stop_sound(cave, player) end
	if not still_playing.high_up then stop_sound(high_up, player) end
	if not still_playing.beach then stop_sound(beach, player) end
	if not still_playing.desert then stop_sound(desert, player) end
	if not still_playing.night then stop_sound(night, player) end
	if not still_playing.day then stop_sound(day, player) end
	if not still_playing.flowing_water then stop_sound(flowing_water, player) end
	if not still_playing.splash then stop_sound(splash, player) end
	if not still_playing.underwater then stop_sound(underwater, player) end
	if not still_playing.lava then stop_sound(lava, player) end
	if not still_playing.smallfire then stop_sound(smallfire, player) end
	if not still_playing.largefire then stop_sound(largefire, player) end
end

-- player routine
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime

	-- every 1 second
	if timer < 1 then return end
	timer = 0

	for _,player in ipairs(minetest.get_connected_players()) do
--local t1 = os.clock()
		ambiences = get_ambience(player)
--print ("[TEST] "..math.ceil((os.clock() - t1) * 1000).." ms")
		still_playing(ambiences, player)

		for _,ambience in pairs(ambiences) do

			if math.random(1, 1000) <= ambience.frequency then
				if ambience.on_start and played_on_start == false then
					played_on_start = true
					minetest.sound_play(ambience.on_start,
					{to_player=player:get_player_name(),gain=SOUNDVOLUME})
				end
				play_sound(player, ambience, math.random(1, #ambience))
			end
		end
	end
end)

-- set volume command
minetest.register_chatcommand("svol", {
	params = "<svol>",
	description = "set sound volume (0.1 to 1.0)",
	privs = {server = true},
	func = function(name, param)
		if not param then
			return true, "Ambience volume is set to " .. tostring(SOUNDVOLUME)
		end
		SOUNDVOLUME = param
		--minetest.chat_send_player(name, "Sound volume set.")
		return true, "Sound volume set to " .. tostring(SOUNDVOLUME)
	end
})

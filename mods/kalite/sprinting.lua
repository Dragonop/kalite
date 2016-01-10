--[[
Sprint mod for Minetest by GunshipPenguin

To the extent possible under law, the author(s)
have dedicated all copyright and related and neighboring rights 
to this software to the public domain worldwide. This software is
distributed without any warranty. 
]]

SPRINT_METHOD = 1
SPRINT_SPEED = 1
--SPRINT_JUMP = 1.01
SPRINT_STAMINA = 20


local players = {}

minetest.register_on_joinplayer(function(player)
	local playerName = player:get_player_name()
	player:set_physics_override({speed=0.5}) --,jump=1.0})
	players[playerName] = {
		sprinting = false,
		timeOut = 0, 
		stamina = SPRINT_STAMINA, 
		shouldSprint = false,
	}
end)

minetest.register_on_leaveplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = nil
end)

minetest.register_globalstep(function(dtime)
	--Get the gametime
	local gameTime = minetest.get_gametime()

	--Loop through all connected players
	for playerName,playerInfo in pairs(players) do
		local player = minetest.get_player_by_name(playerName)
		if player ~= nil then
			--Check if the player should be sprinting
			if player:get_player_control()["aux1"] then --and player:get_player_control()["up"] then
				players[playerName]["shouldSprint"] = true
			else
				players[playerName]["shouldSprint"] = false
			end
			
			--Adjust player states
			if players[playerName]["shouldSprint"] == true then --Stopped
				setSprinting(playerName, true)
			elseif players[playerName]["shouldSprint"] == false then
				setSprinting(playerName, false)
			end
			
			--Lower the player's stamina by dtime if he/she is sprinting and set his/her state to 0 if stamina is zero
			if playerInfo["sprinting"] == true then 
				playerInfo["stamina"] = playerInfo["stamina"] - dtime
				if playerInfo["stamina"] <= 0 then
					playerInfo["stamina"] = 0
					setSprinting(playerName, false)
				end
			
			--Increase player's stamina if he/she is not sprinting and his/her stamina is less than SPRINT_STAMINA
			elseif playerInfo["sprinting"] == false and playerInfo["stamina"] < SPRINT_STAMINA then
				playerInfo["stamina"] = playerInfo["stamina"] + dtime
			end
			-- Cap stamina at SPRINT_STAMINA
			if playerInfo["stamina"] > SPRINT_STAMINA then
				playerInfo["stamina"] = SPRINT_STAMINA
			end
		end
	end
end)

function setSprinting(playerName, sprinting) --Sets the state of a player (0=stopped/moving, 1=sprinting)
	local player = minetest.get_player_by_name(playerName)
	if players[playerName] then
		players[playerName]["sprinting"] = sprinting
		if sprinting == true then
			player:set_physics_override({speed=SPRINT_SPEED}) --,jump=SPRINT_JUMP})
		elseif sprinting == false then
			player:set_physics_override({speed=0.5}) --,jump=1.0})
		end
		return true
	end
	return false
end


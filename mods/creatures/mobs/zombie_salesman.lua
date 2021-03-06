--= Zombie for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015 BlockMen <blockmen2015@gmail.com>
--
-- init.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--

local def = {
  -- general
  name = "creatures:zombie_salesman",
  stats = {
    hp = 80,
    lifetime = 300, -- 5 Minutes
    can_jump = 0,
    can_swim = false,
    can_burn = true,
    has_falldamage = true,
    has_kockback = true,
    light = {min = 0, max = 14}, --8
    hostile = false,
  },

  modes = {
    idle = {chance = 1, duration = 10, update_yaw = 0},
    --walk = {chance = 0.3, duration = 5.5, moving_speed = 1.5},
    -- special modes
    --attack = {chance = 0, moving_speed = 2.5},
  },

  model = {
    mesh = "creatures_zombie.b3d",
    textures = {"creatures_zombie.png"},
    collisionbox = {-0.25, -0.01, -0.3, 0.25, 1.75, 0.3},
    rotation = 0, -- -90.0,
    animations = {
      idle = {start = 0, stop = 80, speed = 15},
      --[[
      walk = {start = 102, stop = 122, speed = 15.5},
      attack = {start = 102, stop = 122, speed = 25},
      --]]
      death = {start = 81, stop = 101, speed = 28, loop = false, duration = 2.12},
    },
  },

  sounds = {
      on_damage = {name = "creatures_zombie_hit", gain = 0.4, distance = 10},
      on_death = {name = "creatures_zombie_death", gain = 0.7, distance = 10},
      swim = {name = "creatures_splash", gain = 1.0, distance = 10},
      random = {
        idle = {name = "creatures_zombie", gain = 0.7, distance = 12},
      },
  },

  combat = {
    attack_damage = 1,
    attack_speed = 0.6,
    attack_radius = 1.1,

    search_enemy = true,
    search_timer = 2,
    search_radius = 12,
    search_type = "player",
  },
  spawning = {

---[[
    abm_nodes = {
      spawn_on = {"kalite:shop"},
    },
    abm_interval = 144, --72,
    abm_chance = 15600, --7600,
    max_number = 1,
    number = 1,
    light = {min = 0, max = 14},
    height_limit = {min = -29000, max = 5000}, --min = -200

--]]
    spawn_egg = {
      description = "Zombie Salesman Spawn-Egg",
      texture = "creatures_egg_zombie.png",
    },

    spawner = {
      description = "Zombie Salesman Spawner",
      range = 8,
      number = 6,
      light = {min = 0, max = 14},
    }
  },

  drops = {
    {"creatures:rotten_flesh", {min = 1, max = 2}, chance = 0.7},
    {"kalite:coin", {min = 1, max = 1}, chance = 0.3}
  }
}

creatures.register_mob(def)


-- Place spawners in dungeons

--[[
local function place_spawner(tab)
	local pos = tab[math.random(1, (#tab or 4))]
	pos.y = pos.y - 1
	local n = core.get_node_or_nil(pos)
	if n and n.name ~= "air" then
		pos.y = pos.y + 1
		core.set_node(pos, {name = "creatures:zombie_spawner"})
	end
end
core.set_gen_notify("dungeon")
core.register_on_generated(function(minp, maxp, blockseed)
	local ntf = core.get_mapgen_object("gennotify")
	if ntf and ntf.dungeon and #ntf.dungeon > 1 then
		core.after(3, place_spawner, table.copy(ntf.dungeon))
	end
end)
--]]

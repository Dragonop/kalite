-- "Nametag" [nametag]
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


local current_obj = {}
local current_stack = {}

local function set_nametag(self, clicker)
	if self and self.object and clicker then
		if self.object:is_player() then
			core.chat_send_player(clicker:get_player_name(), "You can't rename players, sorry.")
			return false
		end
		local item = clicker:get_wielded_item()
    if item then
      local name = item:get_name()
      if name == "nametag:tag" then
				local player_name = clicker:get_player_name()
				current_obj[player_name] = self
				current_stack[player_name] = item
				--show formspec
				local formspec = "size[8,8]" .. --default.gui_bg ..
					"field[0.5,1;7.5,0;name;Name:;]" ..
					"button_exit[2.5,7.5;3,1;save_name;Save name]"

				core.show_formspec(player_name, "nametag_name_obj", formspec)
				return true
			end
		end
	else
		if clicker then
			core.chat_send_player(clicker:get_player_name(), "You can't name this object, sorry.")
		end
	end
end

local function getentities()
	for a,b in pairs(core.registered_entities) do
		local org = table.copy(b)

		b.on_activate = function(self, staticdata, dtime_s)
			local new_stats
			if staticdata then
				new_stats = core.deserialize(staticdata)
			end

			if new_stats and new_stats.flag then
				if new_stats.nametag then
					self.nametag = new_stats.nametag
				end
			end

			if self.object and self.nametag and self.nametag ~= "" then
				self.object:set_properties({nametag = self.nametag, nametag_color = "#FFFF00"})
			end

			if org.on_activate then
				return org.on_activate(self, (new_stats and new_stats.org) or "", dtime_s)
			end
		end

		b.on_rightclick = function(self, clicker)
			local retval = set_nametag(self, clicker)
			if retval then
				return
			end

			if org.on_rightclick then
				org.on_rightclick(self, clicker)
			end
		end

		b.get_staticdata = function(self)
			local retval
			local tab = {}
			if org.get_staticdata then
				retval = org.get_staticdata(self)
			end

			if retval then
				tab.org = retval
			else
				tab.org = {}
			end

			-- insert own data
			tab.nametag = self.nametag
			tab.flag = "yes"

			return core.serialize(tab)
		end
	end
end

core.register_craftitem("nametag:tag", {
	  description = "Nametag",
    inventory_image = "nametag_tag.png",
    liquids_pointable = false
})

core.register_craft({
	type = "shapeless",
	output = "nametag:tag",
	recipe = {"default:paper", "default:coal_lump"},
})


core.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= "nametag_name_obj" or not fields.save_name or fields.name == "" then
		return
	end

	local name = player:get_player_name()
	local obj = current_obj[name]
	if obj and obj.object then
		obj.object:set_properties({nametag = fields.name, nametag_color = "#FFFF00"})
		obj.nametag = fields.name
		current_obj[name] = nil
		if not core.setting_getbool("creative_mode") then
			local itemstack = current_stack[name]
			itemstack:take_item()
			player:set_wielded_item(itemstack)
		end
		current_stack[name] = nil
	end
end)


core.after(0.1, getentities)

-- ATM

-- automatically convert lower denoms to higher

local denom = {
	gold = {"kalite:coin", "default:gold_ingot", "default:goldblock"},
	diamond = {"default:diamond", "default:diamondblock"},
	emerald = {"oresplus:emerald", "oresplus:emeraldblock"}
}

local function detached_funds(name)
	return minetest.create_detached_inventory("funds_" .. name, {
			allow_move = function(inv, from_list, to_list, to_index, count, player)
				return 0
			end,
			allow_put = function(inv, listname, index, stack, player)
				local stack_name = stack:get_name()
				if listname == "gold" then
					if stack_name == denom.gold[1] or
					    stack_name == denom.gold[2] or
					    stack_name == denom.gold[3] then
						return stack:get_count()
					end
					return 0
				elseif listname == "diamond" then
					if stack_name == denom.diamond[1] or
					    stack_name == denom.diamond[2] then
						return stack:get_count()
					end
					return 0
				elseif listname == "emerald" then
					if stack_name == denom.emerald[1] or
					    stack_name == denom.emerald[2] then
						return stack:get_count()
					end
					return 0
				end
				return 0
			end,
			allow_take = function(inv, listname, index, stack, player)
				return stack:get_count() -- TODO not count, but stack max...
			end,
			on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
				return 0
			end,
			on_put = function(inv, listname, index, stack, player)
				return stack:get_count()
			end,
			on_take = function(inv, listname, index, stack, player)
				return stack:get_count()
			end
		})
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local p_inv = minetest.get_inventory({type = "player", name = name})
	p_inv:set_size("gold", 3)
	p_inv:set_size("diamond", 2)
	p_inv:set_size("emerald", 2)
	local funds = detached_funds(name)
	funds:set_size("gold", 3)
	funds:set_size("diamond", 2)
	funds:set_size("emerald", 2)
end)

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()

	local inv = minetest.get_inventory({type = "player", name = name})
	inv:set_size("gold", 3)
	inv:set_size("diamond", 2)
	inv:set_size("emerald", 2)
	inv:set_stack("gold", 1, {name = "default:goldblock", count = 1.5})
minetest.after(1, function()
	local d_inv = detached_funds(name)
	d_inv:set_size("gold", 3)
	d_inv:set_size("diamond", 2)
	d_inv:set_size("emerald", 2)
	d_inv:set_stack("gold", 1, {name = "default:goldblock", count = 1.5})
end)
end)


local function get_atm_interface(name)
	local formspec = "size[8,6]" ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[detached:funds_" .. name .. ";gold;2,0.2;1,1]" ..
		"list[detached:funds_" .. name .. ";diamond;3.5,0.2;1,1]" ..
		"list[detached:funds_" .. name .. ";emerald;5,0.2;1,1]" ..
		"list[current_player;main;0,2;8,4]"
	return formspec
end

--[[
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "kalite:atm" then
		return
	end
end)
--]]


-- ATM Node
minetest.register_node("kalite:atm", {
	description = "Automated Teller Machine (ATM)",
	tiles = {"pktairs_wood.png^kalite_shop_coin.png"},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Automated Teller Machine (ATM)")
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local name = clicker:get_player_name()
		minetest.show_formspec(name, "kalite:atm", get_atm_interface(name))
	end,
})



-- SHOP


local function get_register_formspec(pos)
	local meta = minetest.get_meta(pos)
	local spos = pos.x.. "," ..pos.y .. "," .. pos.z
	local formspec =
		"size[8,6.5]" ..
		default.gui_bg_img ..
		default.gui_slots ..
		"label[2.1,0;Sell]" ..
		"label[5.15,0;For]" ..
		"button[0,1.5;1.75,1;stock;Stock]" ..
		"button[6.25,1.5;1.75,1;register;Register]" ..
		"button[3.5,1.25;1,1;ok;OK]" ..
		"list[nodemeta:" .. spos .. ";sell;2,0.5;1,1;]" ..
		"list[nodemeta:" .. spos .. ";buy;5,0.5;1,1;]" ..
		"list[current_player;main;0,2.75;8,4;]"
	return formspec
end

local formspec_register =
	"size[8,9]" ..
	default.gui_bg_img ..
	default.gui_slots ..
	"label[0,0;Register]" ..
	"list[current_name;register;0,0.75;8,4;]" ..
	"list[current_player;main;0,5.25;8,4;]" ..
	"listring[]"

local formspec_stock =
	"size[8,9]" ..
	default.gui_bg_img ..
	default.gui_slots ..
	"label[0,0;Stock]" ..
	"list[current_name;stock;0,0.75;8,4;]" ..
	"list[current_player;main;0,5.25;8,4;]" ..
	"listring[]"


minetest.register_node("kalite:shop", {
	description = "Shop",
	tiles = {
		"pktairs_wood.png^kalite_shop_coin.png",
		"pktairs_wood.png",
		"pktairs_wood.png^kalite_shop_coin.png",
		"pktairs_wood.png^kalite_shop_coin.png",
		"pktairs_wood.png^kalite_shop_coin.png",
		"pktairs_wood.png^kalite_shop_coin.png"
	},
	groups = {choppy = default.dig.wood},
	paramtype2 = "facedir",
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()

		meta:set_string("owner", owner)
		meta:set_string("infotext", "Shop (Owned by " .. owner .. ")")
		meta:set_string("formspec", get_register_formspec(pos))

		local inv = meta:get_inventory()
		inv:set_size("buy", 1)
		inv:set_size("sell", 1)
		inv:set_size("stock", 8*4)
		inv:set_size("register", 8*4)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local player = sender:get_player_name()
		local inv = meta:get_inventory()
		local s = inv:get_list("sell")
		local b = inv:get_list("buy")
		local stk = inv:get_list("stock")
		local reg = inv:get_list("register")
		local pinv = sender:get_inventory()

		if fields.register then
			if player ~= owner and (not minetest.check_player_privs(player, {server = true})) then
				minetest.chat_send_player(player, "Only the shop owner can open the register.")
				return
			else
				minetest.show_formspec(player, "kalite:shop", formspec_register)
			end
		elseif fields.stock then
			minetest.show_formspec(player, "kalite:shop", formspec_stock)
			return
		elseif fields.ok then
			if inv:is_empty("sell") or
			    inv:is_empty("buy") or
			    (not inv:room_for_item("register", b[1])) then
				minetest.chat_send_player(player, "Shop closed.")
				return
			end

			if (pinv:contains_item("main", b[1]) or
			  pinv:contains_item("funds", b[1])) and
			    inv:contains_item("stock", s[1]) and
			    pinv:room_for_item("main", s[1]) then
				pinv:remove_item("main", b[1])
				inv:add_item("register", b[1])
				inv:remove_item("stock", s[1])
				pinv:add_item("main", s[1])
			else
				minetest.chat_send_player(player, "No funds.")
			end
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		local s = inv:get_list("sell")
		local n = stack:get_name()
		local playername = player:get_player_name()
		if playername ~= owner and
		    (not minetest.check_player_privs(playername, {server = true})) then
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and
		    (not minetest.check_player_privs(playername, {server = true}))then
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_move = function(pos, _, _, _, _, count, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and
		    (not minetest.check_player_privs(playername, {server = true}))then
			return 0
		else
			return count
		end
	end,
	can_dig = function(pos, player) 
                local meta = minetest.get_meta(pos) 
                local owner = meta:get_string("owner") 
                local inv = meta:get_inventory() 
                return player:get_player_name() == owner and
		    inv:is_empty("register") and
		    inv:is_empty("stock") and
		    inv:is_empty("buy") and
		    inv:is_empty("sell")
	end,

})

-- CRAFTS

minetest.register_craftitem("kalite:coin", {

	description = "Gold Coin",
	inventory_image = "kalite_shop_coin.png",
})

minetest.register_craft({
	output = "kalite:coin 9",
	recipe = {
		{"default:gold_ingot"},
	}
})

minetest.register_craft({
	output = "default:gold_ingot",
	recipe = {
		{"kalite:coin", "kalite:coin", "kalite:coin"},
		{"kalite:coin", "kalite:coin", "kalite:coin"},
		{"kalite:coin", "kalite:coin", "kalite:coin"}
	}
})

minetest.register_craft({
	output = "kalite:shop",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "default:goldblock", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

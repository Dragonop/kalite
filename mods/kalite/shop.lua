minetest.register_on_newplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("funds", 1)
	inv:set_stack("funds", 1, {name = "kalite:coin 99"})
end)

local function get_register_formspec(pos)
	local meta = minetest.get_meta(pos)
	local spos = pos.x.. "," ..pos.y .. "," .. pos.z
	local formspec =
		"size[8,6.5]" ..
		--default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"label[2.1,0;Sell]" ..
		"label[5.15,0;For]" ..
		"button[0,1.5;1.75,1;stock;Stock]" ..
		"button[6.25,1.5;1.75,1;register;Register]" ..
		"button[3.5,1.25;1,1;ok;OK]" ..
		"list[nodemeta:" ..spos.. ";sell;2,0.5;1,1;]" ..
		"list[nodemeta:" ..spos.. ";buy;5,0.5;1,1;]" ..
		"list[current_player;main;0,2.75;8,4;]"
	return formspec
end

local formspec_register =
	"size[8,9]" ..
	--default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"label[0,0;Register]" ..
	"list[current_name;register;0,0.75;8,4;]" ..
	"list[current_player;main;0,5.25;8,4;]" ..
	"listring[]"

local formspec_stock =
	"size[8,9]" ..
	--default.gui_bg ..
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
			if player ~= owner and (not minetest.check_player_privs(player, {server=true})) then
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

			--print(dump(pinv:get_stack("funds", 1):get_name()))


			if (pinv:contains_item("main", b[1]) or
			  pinv:contains_item("funds", b[1])) and -- FIXME FIXME FIXME
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
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true})) then
			return 0
		else
			return 99
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true}))then
			return 0
		else
			return 99
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true}))then
			return 0
		else
			return 99
		end
	end,
	can_dig = function(pos, player) 
                local meta = minetest.get_meta(pos) 
                local owner = meta:get_string("owner") 
                local inv = meta:get_inventory() 
                return player:get_player_name() == owner and inv:is_empty("register") and inv:is_empty("stock") and inv:is_empty("buy") and inv:is_empty("sell")
	end,

})


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

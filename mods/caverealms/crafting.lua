--CaveRealms crafting.lua

--CRAFT ITEMS--

--mycena powder
minetest.register_craftitem("caverealms:mycena_powder", {
	description = "Mycena Powder",
	inventory_image = "caverealms_mycena_powder.png",
})

--CRAFT RECIPES--

--mycena powder
minetest.register_craft({
	output = "caverealms:mycena_powder",
	type = "shapeless",
	recipe = {"caverealms:mycena"}
})

-- Thin ice from ice for four
minetest.register_craft({
	output = "caverealms:thin_ice 4",
	type = "shapeless",
	recipe = {"default:ice"}
})

minetest.register_craft({
	output = "default:ice",
	--type = "shapeless",
	recipe = {{"caverealms:thin_ice", "caverealms:thin_ice"},
		  {"caverealms:thin_ice", "caverealms:thin_ice"}}})

minetest.register_craft({
	output = "default:obsidian_shard 9",
	type = "shapeless",
	recipe = {"caverealms:glow_obsidian"},
})

minetest.register_craft({
	output = "default:obsidian_shard 9",
	type = "shapeless",
	recipe = {"caverealms:glow_obsidian_2"},
})

--glow mese block
--[[
minetest.register_craft({
	output = "caverealms:glow_mese",
	recipe = {
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","caverealms:mycena_powder","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"}
	}
})
--]]

--reverse craft for glow mese
--[[
minetest.register_craft({
	output = "default:mese_crystal_fragment 8",
	type = "shapeless",
	recipe = {"caverealms:glow_mese"}
})
--]]

--thin ice to water
--[[
minetest.register_craft({
	output = "bucket:bucket_water",
	type = "shapeless",
	recipe = {"caverealms:thin_ice", "bucket:bucket_empty"},
})
--]]

minetest.register_craft({
	type = "shapeless",
	output = "default:snow 8",
	recipe = {"caverealms:thin_ice"}
})

--use for coal dust
minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:torch 2",
	recipe = {"default:stick", "caverealms:coal_dust"}
})

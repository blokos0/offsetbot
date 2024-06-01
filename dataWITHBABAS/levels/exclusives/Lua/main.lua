table.insert(editor_objlist_order, "anni")
table.insert(editor_objlist_order, "text_anni")
table.insert(editor_objlist_order, "mobile")
table.insert(editor_objlist_order, "text_mobile")
table.insert(editor_objlist_order, "rain")
table.insert(editor_objlist_order, "text_rain")
table.insert(editor_objlist_order, "tuto")
table.insert(editor_objlist_order, "text_tuto")
table.insert(editor_objlist_order, "text_image")
table.insert(editor_objlist_order, "text_hold")


editor_objlist["anni"] = 
{
	name = "anni",
	sprite_in_root = false,
	unittype = "object",
	tags = {},
	tiling = 0,
	type = 0,
	layer = 18,
	colour = {6, 2},
}
editor_objlist["text_anni"] = 
{
	name = "text_anni",
	sprite_in_root = false,
	unittype = "text",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 0},
	colour_active = {6, 1},
}
editor_objlist["text_hold"] = 
{
	name = "text_hold",
	sprite_in_root = false,
	unittype = "text",
	tags = {},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}
editor_objlist["text_image"] = 
{
	name = "text_image",
	sprite_in_root = false,
	unittype = "text",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {5, 0},
	colour_active = {5, 1},
}
editor_objlist["mobile"] = 
{
	name = "mobile",
	sprite_in_root = false,
	unittype = "object",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 16,
	colour = {0, 1},
}
editor_objlist["text_mobile"] = 
{
	name = "text_mobile",
	sprite_in_root = false,
	unittype = "text",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 2},
	colour_active = {0, 3},
}
editor_objlist["rain"] = 
{
	name = "rain",
	sprite_in_root = false,
	unittype = "object",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 12,
	colour = {1, 3},
}
editor_objlist["text_rain"] = 
{
	name = "text_rain",
	sprite_in_root = false,
	unittype = "text",
	tags = {},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {1, 2},
	colour_active = {1, 3},
}
editor_objlist["tuto"] = 
{
	name = "tuto",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 3},
}
editor_objlist["text_tuto"] = 
{
	name = "text_tuto",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 2},
	colour_active = {0, 3},
}

formatobjlist()
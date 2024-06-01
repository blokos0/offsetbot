table.insert(editor_objlist_order, "off") -- (A)
table.insert(editor_objlist_order, "text_off")

editor_objlist["off"] = 
{
	name = "off",
	sprite_in_root = false,
	unittype = "object",
	tags = {"off"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 2},
}

editor_objlist["text_off"] = 
{
	name = "text_off",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}
formatobjlist() -- (C)
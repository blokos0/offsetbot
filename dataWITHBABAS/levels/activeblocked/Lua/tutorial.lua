-- Here we add two new objects to the object list

table.insert(editor_objlist_order, "text_active")
table.insert(editor_objlist_order, "text_blocked")

-- This defines the exact data for them (note that since the sprites are specific to this levelpack, sprite_in_root must be false!)

editor_objlist["text_active"] = 
{
	name = "text_active",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","abstract", "word - prefix"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {2, 3},
	colour_active = {2, 4},
}

editor_objlist["text_blocked"] = 
{
	name = "text_blocked",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","abstract", "word - prefix"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}

-- After adding new objects to the list, formatobjlist() must be run to setup everything correctly.

formatobjlist()
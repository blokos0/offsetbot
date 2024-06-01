-- Here we add two new objects to the object list

table.insert(editor_objlist_order, "killkill")
table.insert(editor_objlist_order, "text_killkill")
table.insert(editor_objlist_order, "shrub")
table.insert(editor_objlist_order, "text_shrub")
table.insert(editor_objlist_order, "crusher")
table.insert(editor_objlist_order, "text_crusher")
table.insert(editor_objlist_order, "balt")
table.insert(editor_objlist_order, "text_balt")
table.insert(editor_objlist_order, "killbot")
table.insert(editor_objlist_order, "text_killbot")
table.insert(editor_objlist_order, "ussr_flag")
table.insert(editor_objlist_order, "text_ussr_flag")
table.insert(editor_objlist_order, "text_corner")
table.insert(editor_objlist_order, "mobile")
table.insert(editor_objlist_order, "text_mobile")
table.insert(editor_objlist_order, "text_there")


-- This defines the exact data for them (note that since the sprites are specific to this levelpack, sprite_in_root must be false!)

editor_objlist["killkill"] = 
{
	name = "killkill",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = 2,
	type = 0,
	layer = 20,
	colour = {3, 1},
}
editor_objlist["text_killkill"] = 
{
	name = "text_killkill",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}
editor_objlist["shrub"] = 
{
	name = "shrub",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 2},
}
editor_objlist["text_shrub"] = 
{
	name = "text_shrub",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 2},
	colour_active = {4, 3},
}
editor_objlist["crusher"] = 
{
	name = "crusher",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 1},
}
editor_objlist["text_crusher"] = 
{
	name = "text_crusher",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 0},
	colour_active = {4, 1},
}
editor_objlist["balt"] = 
{
	name = "balt",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = 3,
	type = 0,
	layer = 18,
	colour = {0, 1},
}
editor_objlist["text_balt"] = 
{
	name = "text_balt",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 0},
	colour_active = {0, 1},
}
editor_objlist["killbot"] = 
{
	name = "killbot",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = 2,
	type = 0,
	layer = 20,
	colour = {0, 3},
}
editor_objlist["text_killbot"] = 
{
	name = "text_killbot",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}
editor_objlist["ussr_flag"] = 
{
	name = "ussr_flag",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 3},
}
editor_objlist["text_ussr_flag"] = 
{
	name = "text_corner",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 1},
	colour_active = {0, 2},
}
editor_objlist["text_corner"] = 
{
	name = "text_ussr_flag",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}
editor_objlist["mobile"] = 
{
	name = "mobile",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 18,
	colour = {0, 1},
}
editor_objlist["text_mobile"] = 
{
	name = "text_mobile",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 0},
	colour_active = {0, 1},
}
editor_objlist["text_there"] = 
{
	name = "text_there",
	sprite_in_root = false,
	unittype = "text",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {1, 2},
	colour_active = {1, 4},
}

-- After adding new objects to the list, formatobjlist() must be run to setup everything correctly.

formatobjlist()

-- Here we load a sound to memory so that it can be played during runtime.

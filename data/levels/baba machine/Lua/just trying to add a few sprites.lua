table.insert(editor_objlist_order, "bgcenter") -- (A)
table.insert(editor_objlist_order, "bgedge") -- (A)
table.insert(editor_objlist_order, "bgcorner") -- (A)
table.insert(editor_objlist_order, "bgincorner") -- (A)
table.insert(editor_objlist_order, "generator") -- (A)
table.insert(editor_objlist_order, "text_generator")
table.insert(editor_objlist_order, "mover") -- (A)
table.insert(editor_objlist_order, "text_mover")
table.insert(editor_objlist_order, "driller") -- (A)
table.insert(editor_objlist_order, "text_driller")
table.insert(editor_objlist_order, "pusher") -- (A)
table.insert(editor_objlist_order, "text_pusher")
table.insert(editor_objlist_order, "slider") -- (A)
table.insert(editor_objlist_order, "text_slider")
table.insert(editor_objlist_order, "directional") -- (A)
table.insert(editor_objlist_order, "text_directional")
table.insert(editor_objlist_order, "rotator_ccw") -- (A)
table.insert(editor_objlist_order, "text_rotator_ccw")
table.insert(editor_objlist_order, "rotator_cw") -- (A)
table.insert(editor_objlist_order, "text_rotator_cw")
table.insert(editor_objlist_order, "enemy") -- (A)
table.insert(editor_objlist_order, "text_enemy")
table.insert(editor_objlist_order, "immobile") -- (A)
table.insert(editor_objlist_order, "text_immobile")
table.insert(editor_objlist_order, "trash") -- (A)
table.insert(editor_objlist_order, "text_trash")
table.insert(editor_objlist_order, "fallcell") -- (A)
table.insert(editor_objlist_order, "text_fallcell")
table.insert(editor_objlist_order, "repulsor") -- (A)
table.insert(editor_objlist_order, "text_repulsor")
table.insert(editor_objlist_order, "flipper") -- (A)
table.insert(editor_objlist_order, "text_flipper")
table.insert(editor_objlist_order, "bread") -- (A)
table.insert(editor_objlist_order, "text_bread")
table.insert(editor_objlist_order, "strange") -- (A)
table.insert(editor_objlist_order, "text_strange")
table.insert(editor_objlist_order, "cellke") -- (A)
table.insert(editor_objlist_order, "text_cellke")
table.insert(editor_objlist_order, "oni") -- (A)
table.insert(editor_objlist_order, "text_oni")
editor_objlist["immobile"] = 
{
	name = "immobile",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {0, 1},
}

editor_objlist["text_immobile"] = 
{
	name = "text_immobile",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 0},
	colour_active = {0, 1},
}

editor_objlist["mover"] = 
{
	name = "mover",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {1, 3},
}

editor_objlist["text_mover"] = 
{
	name = "text_mover",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 3},
	colour_active = {1, 3},
}

editor_objlist["enemy"] = 
{
	name = "enemy",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 2},
}

editor_objlist["text_enemy"] = 
{
	name = "text_enemy",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}

editor_objlist["fallcell"] = 
{
	name = "fallcell",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {1, 2},
}

editor_objlist["text_fallcell"] = 
{
	name = "text_fallcell",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 0},
	colour_active = {4, 3},
}

editor_objlist["rotator_ccw"] = 
{
	name = "rotator_ccw",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 3},
}

editor_objlist["text_rotator_ccw"] = 
{
	name = "text_rotator_ccw",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 2},
	colour_active = {3, 3},
}

editor_objlist["rotator_cw"] = 
{
	name = "rotator_cw",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 3},
}

editor_objlist["text_rotator_cw"] = 
{
	name = "text_rotator_cw",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 2},
	colour_active = {2, 3},
}

editor_objlist["pusher"] = 
{
	name = "pusher",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 4},
}

editor_objlist["text_pusher"] = 
{
	name = "text_pusher",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
	colour_active = {3, 4},
}

editor_objlist["slider"] = 
{
	name = "slider",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {3, 4},
}

editor_objlist["text_slider"] = 
{
	name = "text_slider",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
	colour_active = {3, 4},
}

editor_objlist["trash"] = 
{
	name = "trash",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {3, 1},
}

editor_objlist["text_trash"] = 
{
	name = "text_trash",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}

editor_objlist["generator"] = 
{
	name = "generator",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {5, 2},
}

editor_objlist["text_generator"] = 
{
	name = "text_generator",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {5, 1},
	colour_active = {5, 2},
}

editor_objlist["flipper"] = 
{
	name = "flipper",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {3, 1},
}

editor_objlist["text_flipper"] = 
{
	name = "text_flipper",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}

editor_objlist["directional"] = 
{
	name = "directional",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {3, 4},
}

editor_objlist["text_directional"] = 
{
	name = "text_directional",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
	colour_active = {3, 4},
}

editor_objlist["driller"] = 
{
	name = "driller",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {3, 1},
}

editor_objlist["text_driller"] = 
{
	name = "text_driller",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}

editor_objlist["repulsor"] = 
{
	name = "repulsor",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 3},
}

editor_objlist["text_repulsor"] = 
{
	name = "text_repulsor",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {1, 1},
	colour_active = {4, 3},
}

editor_objlist["bread"] = 
{
	name = "bread",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
}

editor_objlist["text_bread"] = 
{
	name = "text_bread",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 0},
	colour_active = {6, 1},
}

editor_objlist["strange"] = 
{
	name = "strange",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 1},
}

editor_objlist["text_strange"] = 
{
	name = "text_strange",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {4, 0},
	colour_active = {4, 1},
}

editor_objlist["cellke"] = 
{
	name = "cellke",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 2},
}

editor_objlist["text_cellke"] = 
{
	name = "text_cellke",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {2, 1},
	colour_active = {2, 2},
}

editor_objlist["oni"] = 
{
	name = "oni",
	sprite_in_root = false,
	unittype = "object",
	tags = {"dimensional rift"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {0, 3},
}

editor_objlist["text_oni"] = 
{
	name = "text_oni",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","dimensional rift"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 2},
	colour_active = {0, 3},
}

editor_objlist["bgcenter"] = 
{
	name = "bgcenter",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 3},
}

editor_objlist["bgedge"] = 
{
	name = "bgedge",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {0, 3},
}

editor_objlist["bgcorner"] = 
{
	name = "bgcorner",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {0, 3},
}

editor_objlist["bgincorner"] = 
{
	name = "bgincorner",
	sprite_in_root = false,
	unittype = "object",
	tags = {"cell-machine"},
	tiling = 0,
	type = 0,
	layer = 20,
	colour = {0, 3},
}

formatobjlist() -- (C)
glyphunits = {}
glyphnouns = {"baba", "glyph", "flag", "keke", "it", "text", "all", "wall", "skull", "empty", "level", "me", "fofo", "water","badbad"}
glyphprops = {"win", "you", "bonus", "defeat", "stop", "sink", "float", "push", "still", "you2"}
glyphverbs = {"become"}
glyphnames = {"baba", "glyph", "flag", "keke", "it", "text", "wall", "skull", "empty", "level", "me", "fofo", "water", "badbad", "win", "you", "bonus", "defeat", "stop", "sink", "float", "push", "still", "you2", "not", "and", "become", "all", "meta", "metatext"}
glyphnear = {{0,1}, {1,0}, {0,-1}, {-1,0}}
surroundings = {}
metaglyphdata = {}

table.insert(editor_objlist_order, "text_glyph")
table.insert(editor_objlist_order, "glyph_glyph")
table.insert(editor_objlist_order, "glyph_baba")
table.insert(editor_objlist_order, "glyph_flag")
table.insert(editor_objlist_order, "glyph_keke")
table.insert(editor_objlist_order, "glyph_it")
table.insert(editor_objlist_order, "glyph_text")
table.insert(editor_objlist_order, "glyph_all")
table.insert(editor_objlist_order, "glyph_wall")
table.insert(editor_objlist_order, "glyph_skull")
table.insert(editor_objlist_order, "glyph_empty")
table.insert(editor_objlist_order, "glyph_level")
table.insert(editor_objlist_order, "glyph_me")
table.insert(editor_objlist_order, "glyph_fofo")
table.insert(editor_objlist_order, "glyph_water")
table.insert(editor_objlist_order, "glyph_badbad")
table.insert(editor_objlist_order, "glyph_win")
table.insert(editor_objlist_order, "glyph_not")
table.insert(editor_objlist_order, "glyph_you")
table.insert(editor_objlist_order, "glyph_bonus")
table.insert(editor_objlist_order, "glyph_defeat")
table.insert(editor_objlist_order, "glyph_stop")
table.insert(editor_objlist_order, "glyph_sink")
table.insert(editor_objlist_order, "glyph_float")
table.insert(editor_objlist_order, "glyph_push")
table.insert(editor_objlist_order, "glyph_still")
table.insert(editor_objlist_order, "glyph_you2")
table.insert(editor_objlist_order, "glyph_become")
table.insert(editor_objlist_order, "glyph_and")
table.insert(editor_objlist_order, "glyph_meta")
table.insert(editor_objlist_order, "glyph_metatext")

editor_objlist["text_glyph"] = 
{
	name = "text_glyph",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {3, 2},
	colour_active = {3, 3},
}

editor_objlist["glyph_glyph"] = 
{
	name = "glyph_glyph",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {3, 2},
}
editor_objlist["glyph_it"] = 
{
	name = "glyph_it",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {1, 4},
}


editor_objlist["glyph_baba"] = 
{
	name = "glyph_baba",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {0, 3},
}

editor_objlist["glyph_not"] = 
{
	name = "glyph_not",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 2,
	colour = {2, 1},
}

editor_objlist["glyph_you"] = 
{
	name = "glyph_you",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 1},
}

editor_objlist["glyph_bonus"] = 
{
	name = "glyph_bonus",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 0},
}

editor_objlist["glyph_win"] = 
{
	name = "glyph_win",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 4},
}


editor_objlist["glyph_flag"] = 
{
	name = "glyph_flag",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {6, 2},
}

editor_objlist["glyph_text"] = 
{
	name = "glyph_text",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 0},
}

editor_objlist["glyph_keke"] = 
{
	name = "glyph_keke",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 2},
}

editor_objlist["glyph_all"] = 
{
	name = "glyph_all",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {0, 3},
}

editor_objlist["glyph_become"] = 
{
	name = "glyph_become",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = 0,
	type = 0,
	layer = 1,
	colour = {0, 3},
}

editor_objlist["glyph_defeat"] = 
{
	name = "glyph_defeat",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 1},
}

editor_objlist["glyph_stop"] = 
{
	name = "glyph_stop",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 1},
}

editor_objlist["glyph_wall"] = 
{
	name = "glyph_wall",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {1, 1},
}


editor_objlist["glyph_sink"] = 
{
	name = "glyph_sink",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 4},
}

editor_objlist["glyph_float"] = 
{
	name = "glyph_float",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {1, 4},
}

editor_objlist["glyph_push"] = 
{
	name = "glyph_push",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {6, 1},
}

editor_objlist["glyph_skull"] = 
{
	name = "glyph_skull",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 1},
}
editor_objlist["glyph_and"] = 
{
	name = "glyph_and",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {0, 2},
}
editor_objlist["glyph_empty"] = 
{
	name = "glyph_empty",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {0, 3},
	pairedwith = "empty",
}
editor_objlist["glyph_level"] = 
{
	name = "glyph_level",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 1},
}
editor_objlist["glyph_still"] = 
{
	name = "glyph_still",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {2, 1},
}
editor_objlist["glyph_you2"] = 
{
	name = "glyph_you2",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 1},
}
editor_objlist["glyph_meta"] = 
{
	name = "glyph_meta",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {3, 3},
}
editor_objlist["glyph_metatext"] = 
{
	name = "glyph_metatext",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {4, 1},
}
editor_objlist["glyph_me"] = 
{
	name = "glyph_me",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {3, 0},
}
editor_objlist["glyph_fofo"] = 
{
	name = "glyph_fofo",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {5, 2},
}

editor_objlist["glyph_water"] = 
{
	name = "glyph_water",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {1, 4},
}

editor_objlist["glyph_badbad"] = 
{
	name = "glyph_badbad",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 1,
	colour = {1, 4},
}

formatobjlist()

condlist['references'] = function(params,checkedconds,checkedconds_,cdata)
	local unitname = mmf.newObject(cdata.unitid).strings[UNITNAME]
	if (string.sub(unitname, 1, 5) == "text_") then
		return (string.sub(unitname, 6) == params[1]), checkedconds
	end
	if (string.sub(unitname, 1, 6) == "glyph_") then
		return (string.sub(unitname, 7) == params[1]), checkedconds
	end
	return false, checkedconds
end

function referencestext(unit, param)
	local unitname = unit.strings[UNITNAME]
	if (string.sub(unitname, 1, 5) == "text_") then
		return (string.sub(unitname, 6) == params[1]), checkedconds
	end
	return false, checkedconds
end

function referencesglyph(unit, param)
	local unitname = unit.strings[UNITNAME]
	if (string.sub(unitname, 1, 6) == "glyph_") then
		return (string.sub(unitname, 7) == params[1]), checkedconds
	end
	return false, checkedconds
end

function isnoun(input_string, id)
	if (metaglyphdata[id] ~= 0) and (metaglyphdata[id] ~= nil) then
		return true
	end
    for i,j in pairs(glyphnouns) do
        if ("glyph_" .. j == input_string) or ("glyph_glyph_" .. j == input_string) or ("glyph_text_" .. j == input_string) then
            return true
        end
    end
    return false
end

function isprop(input_string, id)
	if (metaglyphdata[id] ~= 0) and (metaglyphdata[id] ~= nil) then
		return false
	end
    for i,j in pairs(glyphprops) do
        if ("glyph_" .. j == input_string) then
            return true
        end
    end
    return false
end

function isverb(input_string, id)
	if (metaglyphdata[id] == 1) then
		return false
	end
	for i,j in pairs(glyphverbs) do
        if ("glyph_" .. j == input_string) then
            return true
        end
    end
    return false
end

function isglyphnot(input_string, id)
	if (metaglyphdata[id] ~= 0) and (metaglyphdata[id] ~= nil) then
		return false
	end
	return (input_string == "glyph_not")
end

function isglyphand(input_string, id)
	if (metaglyphdata[id] ~= 0) and (metaglyphdata[id] ~= nil) then
		return false
	end
	return (input_string == "glyph_and")
end

function donegateglyph(x, y)
    local negate = false
    local ids = {}
    if (unitmap[x + y * roomsizex] ~= nil) then
        for i2, j2 in pairs(unitmap[x + y * roomsizex]) do
            if (mmf.newObject(j2).strings[UNITNAME] == "glyph_not") then
                negate = not negate
            end
        end
    end
    return negate
end

function metaprefix(x, y)
	local is_meta = false
	local is_text = false
	local im_done = false
	for i,j in pairs(glyphnear) do
		if (unitmap[(x + j[1]) + (y + j[2]) * roomsizex] ~= nil) then
			for i2,v2 in pairs(unitmap[(x + j[1]) + (y + j[2]) * roomsizex]) do
				local unit = mmf.newObject(v2)
				local name = unit.strings[UNITNAME]
				if (name == "glyph_metatext") then
					is_text = true
					im_done = true
					break
				elseif (name == "glyph_meta") then
					is_meta = true
					im_done = true
					break
				end
			end
			if im_done then
				break
			end
		end
	end
	if is_meta then
		return "glyph_"
	elseif is_text then
		return "text_"
	else
		return ""
	end
end

function nearbyglyphs(x, y, base_id)
    local return_table = {
		noun = {},
		prop = {},
		glyphnot = {},
		verb = {},
		glyphand = {},
	}
    for i,j in pairs(glyphnear) do
        if (unitmap[(x + j[1]) + (y + j[2]) * roomsizex] ~= nil) then
            local sub_result = {
				noun = {},
				prop = {},
				glyphnot = {},
				verb = {},
				glyphand = {},
			}
            for i2, j2 in pairs(unitmap[(x + j[1]) + (y + j[2]) * roomsizex]) do
                local unit = mmf.newObject(j2)
                local name = unit.strings[UNITNAME]
				local dir = ndirs[unit.values[DIR]+1]
                if (getname(unit) == "glyph") then
                    if isprop(name, j2) then
                        table.insert(sub_result["prop"], {string.sub(name, 7), j2})
					elseif isnoun(name, j2) then
                        table.insert(sub_result["noun"], {string.sub(name, 7), j2})

					elseif isglyphnot(name, j2) then
                        table.insert(sub_result["glyphnot"], {string.sub(name, 7), j2})

					elseif isglyphand(name, j2) then
                        table.insert(sub_result["glyphand"], {string.sub(name, 7), j2, x +j[1], y + j[2]})

					elseif isverb(name, j2) then
						local away = false
						if ((j[1] == dir[1]) and (j[2] == dir[2])) then
							away = true
						end
						local objects = {}
						if away then
							if (unitmap[(x + 2 * j[1]) + (y + 2 * j[2]) * roomsizex] ~= nil) then
								for i3, j3 in pairs(unitmap[(x + 2 * j[1]) + (y + 2 * j[2]) * roomsizex]) do
									local unit2 = mmf.newObject(j3)
									local name2 = unit2.strings[UNITNAME]
									if isnoun(name2, j3) and isglyph(unit2) then
										if donegateglyph(x + 2 * j[1], y + 2 * j[2]) then
											table.insert(objects, {"not " ..string.sub( name2, 7), j3})
										else
											table.insert(objects, {string.sub(name2, 7), j3})
										end
									end
								end
							end
						end
						table.insert(sub_result["verb"], {string.sub(name, 7), j2, away, objects})
					end
				end
            end
            if donegateglyph(x+ j[1], y + j[2]) then
                for i2, j2 in pairs(sub_result["prop"]) do
                    sub_result["prop"][i2][1] = "not " .. sub_result["prop"][i2][1]
                end
                for i2, j2 in pairs(sub_result["noun"]) do
                    sub_result["noun"][i2][1] = "not " .. sub_result["noun"][i2][1]
                end
            end
            for i2, j2 in pairs(sub_result["noun"]) do
                table.insert(return_table["noun"], j2)
            end
            for i2, j2 in pairs(sub_result["prop"]) do
                table.insert(return_table["prop"], j2)
            end
            for i2, j2 in pairs(sub_result["glyphnot"]) do
                table.insert(return_table["glyphnot"], j2)
            end
            for i2, j2 in pairs(sub_result["verb"]) do
                table.insert(return_table["verb"], j2)
            end
            for i2, j2 in pairs(sub_result["glyphand"]) do
                table.insert(return_table["glyphand"], j2)
            end
        end
    end
    return return_table
end

function getandparams(base_id, x, y, evaluate_, id)
	local return_table = {}
	local evaluate = evaluate_ or true
	if evaluate then
		for i,j in pairs(glyphnear) do
			if (unitmap[(x + j[1]) + (y + j[2]) * roomsizex] ~= nil) then
				for i2,v2 in pairs(unitmap[(x + j[1]) + (y + j[2]) * roomsizex]) do
					if (v2 == base_id) then
						goto continue
					end
					local unit = mmf.newObject(v2)
					local name = unit.strings[UNITNAME]
					local meta_prefix = metaprefix(x + j[1], y +j[2])
					if isnoun(name, v2) or isprop(name, v2) then
						if donegateglyph(x + j[1], y +j[2]) and (meta_prefix == "") then
							table.insert(return_table, {"not " .. string.sub(name, 7),v2})
						elseif (meta_prefix ~= "") then
							table.insert(return_table, {meta_prefix .. string.sub(name, 7),v2})
						else
							table.insert(return_table, {string.sub(name, 7),v2})

						end
					end
					::continue::
				end
			end
		end
	else
		for i, j in pairs(surroundings[id]) do
			if (j[2] ~= base_id) then
				table.insert(return_table, j)
			end
		end
	end
	return return_table
end

function getnounandparams(x, y, id)
	local return_table = {}
	local noun = mmf.newObject(id)
	local am_i_meta = metaprefix(x, y)
	if donegateglyph(x, y) and (am_i_meta == "") then
		table.insert(return_table, {"not " .. string.sub(noun.strings[UNITNAME], 7),id})
	elseif (am_i_meta ~= "") then
		table.insert(return_table, {am_i_meta .. string.sub(noun.strings[UNITNAME], 7),id})
	else
		table.insert(return_table, {string.sub(noun.strings[UNITNAME], 7),id})
	end
	for i,j in pairs(glyphnear) do
		if (unitmap[(x + j[1]) + (y + j[2]) * roomsizex] ~= nil) then
			for i2,v2 in pairs(unitmap[(x + j[1]) + (y + j[2]) * roomsizex]) do
				local unit = mmf.newObject(v2)
				local name = unit.strings[UNITNAME]
				local meta_prefix = metaprefix(x + j[1], y +j[2])
				if isnoun(name, v2) then
					if donegateglyph(x + j[1], y+ j[2]) and (meta_prefix == "") then
						table.insert(return_table, {"not " ..string.sub(name, 7),v2})
					elseif (meta_prefix ~= "") then
						table.insert(return_table, {meta_prefix .. string.sub(name, 7),v2})
					else
						table.insert(return_table, {string.sub(name, 7),v2})
					end
				end
				if isglyphand(name, v2) then
					for i3,j3 in pairs(getandparams(id, x + j[1], y + j[2], false, v2)) do
						if isnoun("glyph_" .. j3[1], j3[2]) then
							table.insert(return_table, j3)
						end
					end
				end
			end
		end
	end
	return return_table
end

function getpropandparams(x, y, id)
	local return_table = {}
	local prop = mmf.newObject(id)
	if donegateglyph(x, y) then
		table.insert(return_table, {"not " .. string.sub(prop.strings[UNITNAME], 7),id})
	else
		table.insert(return_table, {string.sub(prop.strings[UNITNAME], 7),id})
	end
	for i,j in pairs(glyphnear) do
		if (unitmap[(x + j[1]) + (y + j[2]) * roomsizex] ~= nil) then
			for i2,v2 in pairs(unitmap[(x + j[1]) + (y + j[2]) * roomsizex]) do
				local unit = mmf.newObject(v2)
				local name = unit.strings[UNITNAME]
				if isprop(name, v2) then
					if donegateglyph(x + j[1], y+ j[2]) then
						table.insert(return_table, {"not " ..string.sub(name, 7),v2})
					else
						table.insert(return_table, {string.sub(name, 7),v2})
					end
				end
				if isglyphand(name, v2) then
					for i3,j3 in pairs(getandparams(id, x + j[1], y + j[2], false, v2)) do
						if isprop("glyph_" .. j3[1], j3[2]) then
							table.insert(return_table, j3)
						end
					end
				end
			end
		end
	end
	return return_table
end

function determinemetaglyphs()
	for i, j in pairs(glyphunits) do
		local unit = mmf.newObject(j)
		local x, y = unit.values[XPOS], unit.values[YPOS]
		local name = unit.strings[UNITNAME]
		local prefix = metaprefix(x, y)
		if (prefix == "glyph_") then
			metaglyphdata[j] = 1
		elseif (prefix == "text_") and (name ~= "glyph_become") and (name ~= "glyph_meta") and (name ~= "glyph_metatext") then
			metaglyphdata[j] = 2
		else
			metaglyphdata[j] = 0
		end
	end
end

function doglyphs()
    local rules = {}
    local ids = {}
	metaglyphdata = {}
	surroundings = {}
	local rulecount = 0
	determinemetaglyphs()
	for i,v in pairs(glyphunits) do
        local unit = mmf.newObject(v)
        local name = unit.strings[UNITNAME]
        local x = unit.values[XPOS]
        local y = unit.values[YPOS]
		if isglyphand(name, v) then
			surroundings[v] = getandparams(nil, x, y)
		end
	end
	for i,v in pairs(glyphunits) do
        local unit = mmf.newObject(v)
        local name = unit.strings[UNITNAME]
        local x = unit.values[XPOS]
        local y = unit.values[YPOS]
		if isnoun(name, v) then
			surroundings[v] = getnounandparams(x, y, v)
		end
		if isprop(name, v) then
			surroundings[v] = getpropandparams(x, y, v)
		end
	end

    for i,v in pairs(glyphunits) do
        local unit = mmf.newObject(v)
        local name = unit.strings[UNITNAME]
        if isnoun(name, v) then
            local x = unit.values[XPOS]
            local y = unit.values[YPOS]
			local negation = donegateglyph(x, y)
			local nearglyphs = nearbyglyphs(x, y, v)
			local andextras = surroundings[v]
            for i2, v2 in pairs(nearglyphs["prop"]) do
				propextras = surroundings[v2[2]]
				for i3, v3 in pairs(andextras) do
					for i4, v4 in pairs(propextras) do
						rulecount = rulecount + 1
						table.insert(rules, {v3[1], "is", v4[1]})
						table.insert(ids, {{v4[2]}, {v3[2]}})
					end
				end
            end
            for i2, v2 in pairs(nearglyphs["verb"]) do
                if v2[3] then
					for i3, v3 in pairs(v2[4]) do
						propextras = surroundings[v3[2]]
						for i4, v4 in pairs(andextras) do		
							for i5, v5 in pairs(propextras) do
								rulecount = rulecount + 1
								table.insert(rules, {v4[1], v2[1], v5[1], false})
								table.insert(ids, {{v2[2]}, {v5[2]}, {v4[2]}})
							end
						end
					end
				end
            end
        end
    end
	if (rulecount > 3000) then
		destroylevel("toocomplex")
		return
	end
    for i, v in pairs(rules) do
		if (string.sub(v[3], 1, 4) == "not ") then
        	-- addoption({v[1], v[2], v[3]}, nil, ids[i], nil, {v[3], #featureindex[v[3]]})
			addoption({v[1], v[2], v[3]}, nil, ids[i])
		else
			addoption({v[1], v[2], v[3]}, nil, ids[i])
		end
    end
end

function isglyph(unit, unitname_)
	if (unit == nil) then
		return false
	end
	local unitname = unitname_
	if (unitname_ == nil) then
		unitname = unit.strings[UNITNAME]
	end
    return (string.sub(unitname,1, 6) == "glyph_")
end



table.insert(nlist.full, "glyph")
table.insert(nlist.short, "glyph")
table.insert(nlist.objects, "glyph")

for i,j in pairs(glyphnames) do
    table.insert(nlist.full, "glyph_" .. j)
    table.insert(nlist.short, "glyph_" .. j)
    table.insert(nlist.objects, "glyph_" .. j)
end

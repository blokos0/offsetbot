function delunit(unitid)
	local unit = mmf.newObject(unitid)
	
	-- MF_alert("DELUNIT " .. unit.strings[UNITNAME])
	
	if (unit ~= nil) then
		local name = getname(unit)
		local x,y = unit.values[XPOS],unit.values[YPOS]
		local unitlist = unitlists[name]
		local unitlist_ = unitlists[unit.strings[UNITNAME]] or {}
		local unittype = unit.strings[UNITTYPE]
		
		if (unittype == "text") or (name == "glyph") then
			updatecode = 1
		end
		
		x = math.floor(x)
		y = math.floor(y)
		
		if (unitlist ~= nil) then
			for i,v in pairs(unitlist) do
				if (v == unitid) then
					v = {}
					table.remove(unitlist, i)
					break
				end
			end
		end
		
		if (unitlist_ ~= nil) then
			for i,v in pairs(unitlist_) do
				if (v == unitid) then
					v = {}
					table.remove(unitlist_, i)
					break
				end
			end
		end
		
		-- TÄMÄ EI EHKÄ TOIMI
		local tileid = x + y * roomsizex
		
		if (unitmap[tileid] ~= nil) then
			for i,v in pairs(unitmap[tileid]) do
				if (v == unitid) then
					v = {}
					table.remove(unitmap[tileid], i)
				end
			end
		
			if (#unitmap[tileid] == 0) then
				unitmap[tileid] = nil
			end
		end
		
		if (unittypeshere[tileid] ~= nil) then
			local uth = unittypeshere[tileid]
			
			local n = unit.strings[UNITNAME]
			
			if (uth[n] ~= nil) then
				uth[n] = uth[n] - 1
				
				if (uth[n] == 0) then
					uth[n] = nil
				end
			end
		end
		
		if (unit.strings[UNITTYPE] == "text") and (codeunits ~= nil) then
			for i,v in pairs(codeunits) do
				if (v == unitid) then
					v = {}
					table.remove(codeunits, i)
				end
			end
			
			if (unit.values[TYPE] == 5) then
				for i,v in pairs(letterunits) do
					if (v == unitid) then
						v = {}
						table.remove(letterunits, i)
					end
				end
			end
		end

        if (string.sub(unit.strings[UNITNAME], 1, 6) == "glyph_") and (glyphunits ~= nil) then
			for i,v in pairs(glyphunits) do
				if (v == unitid) then
					v = {}
					table.remove(glyphunits, i)
				end
			end
        end
		
		if (unit.values[TILING] > 1) and (animunits ~= nil) then
			for i,v in pairs(animunits) do
				if (v == unitid) then
					v = {}
					table.remove(animunits, i)
				end
			end
		end
		
		if (unit.values[TILING] == 1) and (tiledunits ~= nil) then
			for i,v in pairs(tiledunits) do
				if (v == unitid) then
					v = {}
					table.remove(tiledunits, i)
				end
			end
		end
		
		if (#wordunits > 0) and (unit.values[TYPE] == 0) and (unit.strings[UNITTYPE] ~= "text") then
			for i,v in pairs(wordunits) do
				if (v[1] == unitid) then
					local currentundo = undobuffer[1]
					table.insert(currentundo.wordunits, unit.values[ID])
					updatecode = 1
					v = {}
					table.remove(wordunits, i)
				end
			end
		end
		
		if (#wordrelatedunits > 0) then
			for i,v in pairs(wordrelatedunits) do
				if (v[1] == unitid) then
					local currentundo = undobuffer[1]
					table.insert(currentundo.wordrelatedunits, unit.values[ID])
					updatecode = 1
					v = {}
					table.remove(wordrelatedunits, i)
				end
			end
		end
		
		if (#visiontargets > 0) then
			for i,v in pairs(visiontargets) do
				if (v == unitid) then
					local currentundo = undobuffer[1]
					--table.insert(currentundo.visiontargets, unit.values[ID])
					v = {}
					table.remove(visiontargets, i)
				end
			end
		end
	else
		MF_alert("delunit(): no object found with id " .. tostring(unitid) .. " (delunit)")
	end
		
	for i,v in ipairs(units) do
		if (v.fixed == unitid) then
			v = {}
			table.remove(units, i)
		end
	end
	
	for i,data in pairs(updatelist) do
		if (data[1] == unitid) and (data[2] ~= "convert") then
			data[2] = "DELETED"
		end
	end
end

function getname(unit,meta_)
	local result = unit.strings[UNITNAME]
	local meta = meta_ or false
	
	if (meta == false) and (unit.strings[UNITTYPE] == "text") then
		result = "text"
	end

	if (string.sub(result, 1, 6) == "glyph_") then
		result = "glyph"
	end
	
	return result
end

function findtype(typedata,x,y,unitid_,just_testing_)
	local result = {}
	local unitid = 0
	local tileid = x + y * roomsizex
	local name = typedata[1]
	local conds = typedata[2]
	
	local just_testing = just_testing_ or false
	
	if (unitid_ ~= nil) then
		unitid = unitid_
	end
	
	if (unitmap[tileid] ~= nil) then
		for i,v in ipairs(unitmap[tileid]) do
			if (v ~= unitid) then
				local unit = mmf.newObject(v)
				
				if (unit.strings[UNITNAME] == name) or ((unit.strings[UNITTYPE] == "text") and (name == "text")) or (isglyph(unit) and (name == "glyph")) then
					if testcond(conds,v) then
						table.insert(result, v)
						
						if just_testing then
							return result
						end
					end
				end
			end
		end
	end
	
	return result
end

function update(unitid,x,y,dir_)
	if (unitid ~= nil) then
		local unit = mmf.newObject(unitid)

		local unitname = unit.strings[UNITNAME]
		local dir,olddir = unit.values[DIR],unit.values[DIR]
		local tiling = unit.values[TILING]
		local unittype = unit.strings[UNITTYPE]
		local oldx,oldy = unit.values[XPOS],unit.values[YPOS]
		
		if (dir_ ~= nil) then
			dir = dir_
		end
		
		if (x ~= oldx) or (y ~= oldy) or (dir ~= olddir) then
			updateundo = true
			
			addundo({"update",unitname,oldx,oldy,olddir,x,y,dir,unit.values[ID]},unitid)
			
			local ox,oy = x-oldx,y-oldy
			
			if (math.abs(ox) + math.abs(oy) == 1) and (unit.values[MOVED] == 0) then
				unit.x = unit.x + ox * tilesize * spritedata.values[TILEMULT] * generaldata2.values[ZOOM] * 0.25
				unit.y = unit.y + oy * tilesize * spritedata.values[TILEMULT] * generaldata2.values[ZOOM] * 0.25
			end
			
			unit.values[XPOS] = x
			unit.values[YPOS] = y
			unit.values[DIR] = dir
			unit.values[MOVED] = 1
			unit.values[POSITIONING] = 0

			updateunitmap(unitid,oldx,oldy,x,y,unit.strings[UNITNAME])
			
			if (tiling == 1) then
				dynamic(unitid)
				dynamicat(oldx,oldy)
			end
			
			if (unittype == "text") or isglyph(unit) then
				updatecode = 1
			end
			
			if (featureindex["word"] ~= nil) then
				checkwordchanges(unitid,unitname)
			end
		end
	else
		MF_alert("Tried to update a nil unit")
	end
end

function updatedir(unitid,dir,noundo_)
	if (unitid ~= nil) then
		local unit = mmf.newObject(unitid)
		local x,y = unit.values[XPOS],unit.values[YPOS]
		local unitname = unit.strings[UNITNAME]
		local unittype = unit.strings[UNITTYPE]
		local olddir = unit.values[DIR]
		
		local noundo = noundo_ or false
		
		if (dir ~= olddir) then
			if (noundo == false) then
				updateundo = true
				addundo({"update",unitname,x,y,olddir,x,y,dir,unit.values[ID]},unitid)
			end
			unit.values[DIR] = dir
			
			if (unittype == "text") or isglyph(unit) then
				updatecode = 1
			end
		end
	else
		MF_alert("Tried to updatedir a nil unit")
	end
end

function findall(name_,ignorebroken_,just_testing_)
	local result = {}
	local name = name_[1]
	local meta = true
	
	local checklist = unitlists[name]
	
	if (name == "text") then
		checklist = codeunits
		meta = false
	end

	if (name == "glyph") then
		checklist = glyphunits
	end
	
	local ignorebroken = ignorebroken_ or false
	local just_testing = just_testing_ or false
	
	if (checklist ~= nil) then
		for i,unitid in ipairs(checklist) do
			local unit = mmf.newObject(unitid)
			local unitname = getname(unit,meta)
			
			local oldbroken = unit.broken
			if ignorebroken then
				unit.broken = 0
			end
			
			if (unitname == name) then
				if testcond(name_[2],unitid) then
					table.insert(result, unitid)
					
					if just_testing then
						return result
					end
				end
			end
			
			unit.broken = oldbroken
		end
	end
	
	return result
end
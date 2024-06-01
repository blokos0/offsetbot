doordata = {}
keydata = {}
pickkeys = {}
display0 = {}
datanames = {}
auras = {}
cursed = {}
iscursed = {}
starval = {}
layers = {}

mastermode = false
pressedm = false

imode = false
pressedi = false

glitchcolor = "glitch"
glitches = {}
glitchlocks = {}

combosync = {}
comboreq = {}
combodata = {}
combodisplay = {}
showlayer = {}
combocursed = {}
comboiscursed = {}

pickkeysi = {}
layersi = {}

salvageid = {}
salvaging = -1
origspecial = {}
doorsalvaged = false

shorthand = {
    red = "red",
    blue = "blu",
    brown = "brn",
    master = "mst",
    pure = "pur",
    green = "grn",
    yellow = "yel",
    orange = "ora",
    purple = "pur",
    glitch = "glc"
}

lookup1 = {"F", "E", "EF", "P", "FP", "EP", "EFP"}

local freezes = {}
local paints = {}
local erodes = {}

table.insert(editor_objlist_order, "iwldoor")
table.insert(editor_objlist_order, "text_iwldoor")
table.insert(editor_objlist_order, "iwlkey")
table.insert(editor_objlist_order, "text_iwlkey")
table.insert(editor_objlist_order, "iwlmkey")
table.insert(editor_objlist_order, "text_iwlmkey")
table.insert(editor_objlist_order, "inputpoint")
table.insert(editor_objlist_order, "outputpoint")

editor_objlist["iwldoor"] = 
{
	name = "iwldoor",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 15,
	colour = {2, 4},
    sprite = "iwlDoor"
}

editor_objlist["text_iwldoor"] = 
{
	name = "text_iwldoor",
	sprite_in_root = true,
	unittype = "text",
	tags = {"text", "abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
	colour_active = {2, 4},
    sprite = "text_door"
}

editor_objlist["iwlkey"] = 
{
	name = "iwlkey",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 15,
	colour = {2, 4},
    sprite = "iwlKey"
}

editor_objlist["text_iwlkey"] = 
{
	name = "text_iwlkey",
	sprite_in_root = true,
	unittype = "text",
	tags = {"text", "abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {6, 1},
    colour_active = {2, 4},
    sprite = "text_key"
}

editor_objlist["iwlmkey"] = 
{
	name = "iwlmkey",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 15,
	colour = {0, 3},
    sprite = "iwlMKey"
}

editor_objlist["inputpoint"] = 
{
	name = "inputpoint",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 2,
	colour = {4, 1},
    sprite = "iwlInput"
}

editor_objlist["outputpoint"] = 
{
	name = "outputpoint",
	sprite_in_root = false,
	unittype = "object",
	tags = {"abstract"},
	tiling = -1,
	type = 0,
	layer = 2,
	colour = {1, 4},
    sprite = "iwlOutput"
}

editor_objlist["text_iwlmkey"] = 
{
	name = "text_iwlmkey",
	sprite_in_root = true,
	unittype = "text",
	tags = {"text", "abstract"},
	tiling = -1,
	type = 0,
	layer = 20,
	colour = {0, 1},
    colour_active = {0, 3},
    sprite = "text_key"
}

formatobjlist()

table.insert(mod_hook_functions["level_start"], function()
    doorcount = {}
    keycount = {}
    doordata = {}
    keydata = {}
    layers = {}
    pickkeys = {
        master = 0
    }
    auras = {}
    datanames = {}
    display0 = {}
    freezes = {}
    paints = {}
    starval = {}
    erodes = {}
    cursed = {}
    iscursed = {}
    glitchcolor = "glitch"
    glitches = {}

    combosync = {}
    comboreq = {}
    combodisplay = {}
    combodata = {}
    showlayer = {}
    combocursed = {}
    comboiscursed = {}

    pickkeysi = {}
    layersi = {}

    salvageid = {}
    salvaging = -1
    origspecial = {}
    doorsalvaged = false

    mastermode = false
    pressedm = false
    imode = false
    pressedi = false
    local curr = generaldata.strings[CURRLEVEL]
    local world = generaldata.strings[WORLD]
    MF_setfile("level","Data/Worlds/" .. world .. "/" .. curr .. ".ld")
    MF_setfile("world","Data/Worlds/" .. generaldata.strings[WORLD] .. "/" .. "world_data.txt")
    local valid = true
    local index = 0
    while valid do
        local i = tostring(index)
	    local speicalthing = MF_read("level","specials",i .. "data")
        if (speicalthing ~= nil) and (speicalthing ~= "") then
            local x = tonumber(MF_read("level","specials",i .. "X"))
            local y = tonumber(MF_read("level","specials",i .. "Y"))
            local result = {""}
            local j = 1
            while j <= string.len(speicalthing) do
                local char = string.sub(speicalthing,j,j)
                if char == "," then
                    table.insert(result, "")
                else
                    result[#result] = result[#result] .. char
                end
                j = j + 1
            end
            local kind = result[1]
            table.remove(result,1)
            handlemyspeicals(x,y,kind,result, speicalthing)
        else
            valid = false
        end
        index = index + 1
    end
    handleoutputpoints()
end)

table.insert(mod_hook_functions["turn_end"], function()
    if doorsalvaged then
        if (editor.values[INEDITOR] == 0) then
            uplevel()
        end
        level_to_convert = {}
        MF_levelconversion()
    end
end)

function unlockable(unitid)
    if imode then
        local result = unlockablemode(unitid,true)
        if result ~= "no" then
            return result
        end
        return unlockablemode(unitid,false)
    else
        local result = unlockablemode(unitid,false)
        if result ~= "no" then
            return result
        end
        return unlockablemode(unitid,true)
    end
end

function unlockablemode(unitid,usingimode)
    local unit = mmf.newObject(unitid)
    if unit == nil then
        return "no"
    end
    local id = unit.values[ID]
    if ((doordata[id]) == nil) and (combosync[id] == nil) then
        return "no"
    end
    if (auras[id] ~= nil) and (auras[id] ~= 0) then
        return "no"
    end
    if not usingimode then
        if combosync[id] == nil then
            local color = doordata[id][1]
            if color == "glitch" then
                color = glitchlocks[id][2]
            end
            local count = doordata[id][2]
            local doortype = doordata[id][3]
            local spend = doordata[id][4]
            if spend == "glitch" then
                spend = glitchlocks[id][1]
            end
            local layer = layers[id]
            local thenext = layer - 1
            if (layer < 0) then
                thenext = layer + 1
                count = count * -1
            end
            local layeri = layersi[id]
            local keycount = pickkeys[color]
            local keycounti = pickkeysi[color]
            if pickkeys[spend] == nil then
                pickkeys[spend] = 0
            end
            if pickkeysi[spend] == nil then
                pickkeysi[spend] = 0
            end
            if keycount == nil then
                pickkeys[color] = 0
                pickkeysi[color] = 0
                keycount = 0
                keycounti = 0
            end
            if mastermode and (pickkeys["master"] >= 1) and (color ~= "master") and (color ~= "pure") and (spend ~= "master") and (spend ~= "pure") then
                return {"master", 1, layer - 1, 0, layeri}
            end
            if mastermode and (pickkeys["master"] <= -1) and (color ~= "master") and (color ~= "pure") and (spend ~= "master") and (spend ~= "pure") then
                return {"master", -1, layer + 1, 0, layeri}
            end
            if (layer == 0) then
                return "no"
            end
            if count >= 0 then
                if (keycount >= count) and (doortype == "normal") then
                    return {spend, count, thenext, 0, layeri}
                elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
                    return {spend, 0, thenext, 0, layeri}
                elseif (keycount >= 1) and (doortype == "blast") then
                    return {spend, keycount, thenext, 0, layeri}
                elseif (keycounti >= count) and (doortype == "i") then
                    return {spend, 0, thenext, count, layeri}
                elseif (keycounti >= 1) and (doortype == "blasti") then
                    return {spend, 0, thenext, keycounti, layeri}
                elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                    return {spend, keycount, thenext, keycounti, layeri}
                else
                    return "no"
                end
            else
                if (keycount <= count) and (doortype == "normal") then
                    return {spend, count, thenext, 0, layeri}
                elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
                    return {spend, 0, thenext, 0, layeri}
                elseif (keycount <= -1) and (doortype == "blast") then
                    return {spend, keycount, thenext, 0, layeri}
                elseif (keycounti <= count) and (doortype == "i") then
                    return {spend, 0, thenext, count, layeri}
                elseif (keycounti <= -1) and (doortype == "blasti") then
                    return {spend, 0, thenext, keycounti, layeri}
                elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                    return {spend, keycount, thenext, keycounti, layeri}
                else
                    return "no"
                end
            end
        else
            local sync = combosync[id]
            local spendcolor = combodata[sync][1]
            if spendcolor == "glitch" then
                spendcolor = glitchlocks[id][1]
            end
            local aura = combodata[sync][2]
            local layer = combodata[sync][3]
            local layeri = combodata[sync][4]
            local spendcount = 0
            local spendcounti = 0
            local thenext = layer - 1
            if (layer < 0) then
                thenext = layer + 1
            end
            if pickkeys[spendcolor] == nil then
                pickkeys[spendcolor] = 0
            end
            if pickkeysi[spendcolor] == nil then
                pickkeysi[spendcolor] = 0
            end
            if (aura ~= nil) and (aura ~= 0) then
                return "no"
            end
            local valid = true
            local foundpure = false
            if (spendcolor == "pure") or (spendcolor == "master") then
                foundpure = true
            end
            if pickkeys[spendcolor] == nil then
                pickkeys[spendcolor] = 0
            end
            for i, j in pairs(comboreq[sync]) do
                local color = j[1]
                if color == "glitch" then
                    color = glitchlocks[id][i + 1]
                end
                local count = j[2]
                if (layer < 0) then
                    count = count * -1
                end
                local doortype = j[3]
                local keycount = pickkeys[color]
                local keycounti = pickkeysi[color]
                if (keycount == nil) or (keycounti == nil) then
                    pickkeys[color] = 0
                    pickkeysi[color] = 0
                    keycount = 0
                    keycounti = 0
                end
                if (color == "pure") or (color == "master") then
                    foundpure = true
                end
                if count >= 0 then
                    if (keycount >= count) and (doortype == "normal") then
                        spendcount = spendcount + count
                    elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then

                    elseif (keycount >= 1) and (doortype == "blast") then
                        spendcount = spendcount + keycount
                    elseif (keycounti >= count) and (doortype == "i") then
                        spendcounti = spendcounti + count
                    elseif (keycount >= 1) and (doortype == "blasti") then
                        spendcounti = spendcounti + keycounti
                    elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                        spendcounti = spendcounti + keycounti
                        spendcount = spendcount + keycount
                    else
                        valid = false
                    end
                else
                    if (keycount <= count) and (doortype == "normal") then
                        spendcount = spendcount + count
                    elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then

                    elseif (keycount <= -1) and (doortype == "blast") then
                        spendcount = spendcount + keycount
                    elseif (keycounti <= count) and (doortype == "i") then
                        spendcounti = spendcounti + count
                    elseif (keycount <= 1) and (doortype == "blasti") then
                        spendcounti = spendcounti + keycounti
                    elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                        spendcounti = spendcounti + keycounti
                        spendcount = spendcount + keycount
                    else
                        valid = false
                    end
                end
            end
            if mastermode and (pickkeys["master"] >= 1) and (spendcolor ~= "master") and (spendcolor ~= "pure") and not foundpure then
                return {"master", 1, layer - 1, 0, layeri}
            end
            if mastermode and (pickkeys["master"] <= -1) and (spendcolor ~= "master") and (spendcolor ~= "pure") and not foundpure then
                return {"master", -1, layer + 1, 0, layeri}
            end
            if (layer == 0) then
                return "no"
            end
            if valid then
                return {spendcolor, spendcount, thenext, spendcounti, layeri}
            else
                return "no"
            end
        end
    else
        if combosync[id] == nil then
            local color = doordata[id][1]
            if color == "glitch" then
                color = glitchlocks[id][2]
            end
            local count = doordata[id][2]
            local doortype = doordata[id][3]
            local spend = doordata[id][4]
            if spend == "glitch" then
                spend = glitchlocks[id][1]
            end
            local layer = layers[id]
            local layeri = layersi[id]
            local thenext = layeri - 1
            if (layeri < 0) then
                thenext = layeri + 1
                count = count * -1
            end
            local keycount = pickkeys[color]
            local keycounti = pickkeysi[color]
            if pickkeys[spend] == nil then
                pickkeys[spend] = 0
            end
            if pickkeysi[spend] == nil then
                pickkeysi[spend] = 0
            end
            if keycount == nil then
                pickkeys[color] = 0
                keycount = 0
            end
            if mastermode and (pickkeysi["master"] >= 1) and (color ~= "master") and (color ~= "pure") and (spend ~= "master") and (spend ~= "pure") then
                return {"master", 0, layer, 1, layeri - 1}
            end
            if mastermode and (pickkeysi["master"] <= -1) and (color ~= "master") and (color ~= "pure") and (spend ~= "master") and (spend ~= "pure") then
                return {"master", 0, layer, -1, layeri + 1}
            end
            if (layeri == 0) then
                return "no"
            end
            if doortype == "normal" then
                doortype = "i"
            elseif doortype == "blast" then
                doortype = "blasti"
            elseif doortype == "i" then
                doortype = "normal"
                count = count * -1
            elseif doortype == "blasti" then
                doortype = "blast"
                count = count * -1
            end
            if count >= 0 then
                if (keycount >= count) and (doortype == "normal") then
                    return {spend, count, layer, 0, thenext}
                elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
                    return {spend, 0, layer, 0, layeri - 1}
                elseif (keycount >= 1) and (doortype == "blast") then
                    return {spend, keycount, layer, 0, thenext}
                elseif (keycounti >= count) and (doortype == "i") then
                    return {spend, 0, layer, count, thenext}
                elseif (keycounti >= 1) and (doortype == "blasti") then
                    return {spend, 0, layer, keycounti, thenext}
                elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                    return {spend, keycount, layer, keycounti, thenext}
                else
                    return "no"
                end
            else
                if (keycount <= count) and (doortype == "normal") then
                    return {spend, count, layer, 0, thenext}
                elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
                    return {spend, 0, layer, 0, thenext}
                elseif (keycount <= -1) and (doortype == "blast") then
                    return {spend, keycount, layer, 0, thenext}
                elseif (keycounti <= count) and (doortype == "i") then
                    return {spend, 0, layer, count, thenext}
                elseif (keycounti <= -1) and (doortype == "blasti") then
                    return {spend, 0, layer, keycounti, thenext}
                elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                    return {spend, keycount, layer, keycounti, thenext}
                else
                    return "no"
                end
            end
        else
            local sync = combosync[id]
            local spendcolor = combodata[sync][1]
            if spendcolor == "glitch" then
                spendcolor = glitchlocks[id][1]
            end
            local aura = combodata[sync][2]
            local layer = combodata[sync][3]
            local layeri = combodata[sync][4]
            local thenext = layeri - 1
            if (layeri < 0) then
                thenext = layeri + 1
            end
            local spendcount = 0
            local spendcounti = 0
            if pickkeys[spendcolor] == nil then
                pickkeys[spendcolor] = 0
            end
            if pickkeysi[spendcolor] == nil then
                pickkeysi[spendcolor] = 0
            end
            if (aura ~= nil) and (aura ~= 0) then
                return "no"
            end
            local valid = true
            local foundpure = false
            if (spendcolor == "pure") or (spendcolor == "master") then
                foundpure = true
            end
            if pickkeys[spendcolor] == nil then
                pickkeys[spendcolor] = 0
            end
            for i, j in pairs(comboreq[sync]) do
                local color = j[1]
                if color == "glitch" then
                    color = glitchlocks[id][i + 1]
                end
                local count = j[2]
                if (layeri < 0) then
                    count = count * -1
                end
                local doortype = j[3]
                local keycount = pickkeys[color]
                local keycounti = pickkeysi[color]
                if keycount == nil then
                    pickkeys[color] = 0
                    pickkeysi[color] = 0
                    keycount = 0
                    keycounti = 0
                end
                if (color == "pure") or (color == "master") then
                    foundpure = true
                end
                if doortype == "normal" then
                    doortype = "i"
                elseif doortype == "blast" then
                    doortype = "blasti"
                elseif doortype == "i" then
                    doortype = "normal"
                    count = count * -1
                elseif doortype == "blasti" then
                    doortype = "blast"
                    count = count * -1
                end
                if count >= 0 then
                    if (keycount >= count) and (doortype == "normal") then
                        spendcount = spendcount + count
                    elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
    
                    elseif (keycount >= 1) and (doortype == "blast") then
                        spendcount = spendcount + keycount
                    elseif (keycounti >= count) and (doortype == "i") then
                        spendcounti = spendcounti + count
                    elseif (keycount >= 1) and (doortype == "blasti") then
                        spendcounti = spendcounti + keycounti
                    elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                        spendcounti = spendcounti + keycounti
                        spendcount = spendcount + keycount
                    else
                        valid = false
                    end
                else
                    if (keycount <= count) and (doortype == "normal") then
                        spendcount = spendcount + count
                    elseif ((keycount == 0) and (keycounti == 0)) and (doortype == "blank") then
    
                    elseif (keycount <= -1) and (doortype == "blast") then
                        spendcount = spendcount + keycount
                    elseif (keycounti <= count) and (doortype == "i") then
                        spendcounti = spendcounti + count
                    elseif (keycount <= -1) and (doortype == "blasti") then
                        spendcounti = spendcounti + keycounti
                    elseif ((keycount ~= 0) or (keycounti ~= 0)) and (doortype == "all") then
                        spendcounti = spendcounti + keycounti
                        spendcount = spendcount + keycount
                    else
                        valid = false
                    end
                end
            end
            if mastermode and (pickkeysi["master"] >= 1) and (spendcolor ~= "master") and (spendcolor ~= "pure") and not foundpure then
                return {"master", 0, layer, 1, layeri - 1}
            end
            if mastermode and (pickkeysi["master"] <= -1) and (spendcolor ~= "master") and (spendcolor ~= "pure") and not foundpure then
                return {"master", 0, layer, -1, layeri + 1}
            end
            if (layeri == 0) then
                return "no"
            end
            if valid then
                return {spendcolor, spendcount, layer, spendcounti, layeri - 1}
            else
                return "no"
            end
        end
    end
end

function getkeys(x, y)
    local things = findallhere(x, y)
    local result = {}
    for i, j in pairs(things) do
        local unit = mmf.newObject(j)
        if unit ~= nil then
            local id = unit.values[ID]
            if keydata[id] ~= nil then
                table.insert(result, {j, keydata[id]})
            end
        end
    end
    return result
end

function doauras(x, y,num)
    local things = {findallhere(x, y + 1), findallhere(x, y - 1), findallhere(x + 1, y), findallhere(x - 1, y)}
    for i, j0 in pairs(things) do
        for i2, j in pairs(j0) do
            local unit = mmf.newObject(j)
            if unit ~= nil then
                local id = unit.values[ID]
                if (auras[id] ~= nil) and (auras[id] ~= 0) then
                    if ((auras[id] // num) % 2) == 1 then
                        addundo({"updateaura", id, auras[id]})
                        auras[id] = auras[id] - num
                        updateundo = true
                    end
                elseif (combosync[id] ~= nil) and (combodata[combosync[id]][2] ~= nil) and (combodata[combosync[id]][2] ~= 0) then
                    if ((combodata[combosync[id]][2] // num) % 2) == 1 then
                        addundo({"updatecomboaura", combosync[id], combodata[combosync[id]][2]})
                        combodata[combosync[id]][2] = combodata[combosync[id]][2] - num
                        updateundo = true
                    end
                end
            end
        end
    end
end

function applybrownkeys(x,y,num)
    local things = {findallhere(x, y + 1), findallhere(x, y - 1), findallhere(x + 1, y), findallhere(x - 1, y)}
    for i, j0 in pairs(things) do
        for i2, j in pairs(j0) do
            local unit = mmf.newObject(j)
            if unit ~= nil then
                local id = unit.values[ID]
                if (doordata[id] ~= nil) and (doordata[id][1] ~= "pure") and (doordata[id][4] ~= "pure") then
                    if (num == 1) and (iscursed[id] ~= true) then
                        addundo({"updatecolor", id, doordata[id][1]})
                        addundo({"updatecolorspend", id, doordata[id][4]})
                        addundo({"flipbrownkey", id})
                        doordata[id][1] = "brown"
                        doordata[id][4] = "brown"
                        iscursed[id] = true
                        updateundo = true
                    elseif (num == -1) and (iscursed[id] == true) then
                        addundo({"updatecolor", id, doordata[id][1]})
                        addundo({"updatecolorspend", id, doordata[id][4]})
                        addundo({"flipbrownkey", id})
                        doordata[id][1] = cursed[id][1]
                        doordata[id][4] = cursed[id][2]
                        iscursed[id] = false
                        updateundo = true
                    end
                    resetdoordisplay(id)
                elseif (combosync[id] ~= nil) then
                    local sync = combosync[id]
                    local valid = ((combodata[sync][1] ~= "pure") and ((combodata[sync][1] ~= "glitch") or (glitchlocks[id][1] ~= "pure")))
                    if valid then
                        for i3,j3 in pairs(comboreq[sync]) do
                            if (j3[1] == "pure") or ((glitchlocks[id][i + 1] == "pure") and (j3[1] == "glitch")) then
                                valid = false
                            end
                        end
                    end
                    if valid then
                        if (num == 1) and (comboiscursed[sync] ~= true) then
                            addundo({"updatecombocolorspend", sync, combodata[sync][1]})
                            addundo({"flipcombobrownkey", sync})
                            combodata[sync][1] = "brown"
                            comboiscursed[sync] = true
                            for i3, j3 in pairs(comboreq[sync]) do
                                addundo({"updatecombocolor", sync, i3, comboreq[sync][i3][1]})
                                comboreq[sync][i3][1] = "brown"
                            end
                            updateundo = true
                        elseif (num == -1) and (comboiscursed[sync] == true) then
                            addundo({"updatecombocolorspend", sync, combodata[sync][1]})
                            addundo({"flipcombobrownkey", sync})
                            combodata[sync][1] = combocursed[sync][1]
                            comboiscursed[sync] = false
                            for i3, j3 in pairs(comboreq[sync]) do
                                addundo({"updatecombocolor", sync, i3, comboreq[sync][i3][1]})
                                comboreq[sync][i3][1] = combocursed[sync][i3 + 1]
                            end
                            updateundo = true
                        end
                        resetcombodisplay(sync)
                    end
                end
            end
        end
    end
end

function getdisplays(x, y)
    local things = findallhere(x, y)
    local result = {}
    local isdoor = {}
    if inbounds(x,y,1) then
        for i, j in pairs(things) do
            local unit = mmf.newObject(j)
            if unit ~= nil then
                local id = unit.values[ID]
                if keydata[id] ~= nil then
                    table.insert(result, datanames[id])
                    table.insert(isdoor, false)
                end
                if doordata[id] ~= nil then
                    table.insert(result, datanames[id])
                    table.insert(isdoor, true)
                    ---- AURAS ----
                    -- 1 - frozen
                    -- 2 - erroded
                    -- 4 - painted
                    ---------------
                    if (auras[id] ~= 0) and (auras[id] ~= nil) then
                        local str = " (" .. lookup1[auras[id]] .. ")"
                        result[#result] = result[#result] .. str
                    end
                end
            end
        end
    end
    return result, isdoor
end

function getcombodisplays(x, y)
    local things = findallhere(x, y)
    local result = {}
    if inbounds(x,y,1) then
        for i, j in pairs(things) do
            local unit = mmf.newObject(j)
            if unit ~= nil then
                local id = unit.values[ID]
                local sync = combosync[id]
                if (sync ~= nil) and (combodisplay[sync] ~= nil) then
                    table.insert(result, combodisplay[sync])
                end
            end
        end
    end
    return result
end

function resetcombodisplay(sync)
    if showlayer[sync] ~= nil then
        local result = {}
        local combos = (#comboreq[sync]) + 1
        local i = 1
        while i <= combos do
            table.insert(result, getcomboname(showlayer[sync], sync,i))
            i = i + 1
        end
        combodisplay[sync] = result
    end
end

function resetdoordisplay(id)
    local showcolor = doordata[id][1]
    local visual1 = showcolor
    local visual2 = doordata[id][4]
    if (glitchlocks[id][2] ~= nil) and (glitchlocks[id][2] ~= "glitch") then
        if showcolor == "glitch" then
            visual1 = glitchlocks[id][2] .. "(G)"
        end
	end
	if (glitchlocks[id][1] ~= nil) and (glitchlocks[id][1] ~= "glitch")then
        if doordata[id][4] == "glitch" then
            visual2 = glitchlocks[id][1] .. "(G)"
        end
    end
    if (showcolor ~= doordata[id][4]) then
        if shorthand[visual1] ~= nil then
            visual1 = shorthand[visual1]
        end
        if shorthand[visual2] ~= nil then
            visual2 = shorthand[visual2]
        end
        if (showcolor == "glitch") and (glitchlocks[id][1] ~= nil) and (glitchlocks[id][2] ~= "glitch") then
            visual1 = shorthand[glitchlocks[id][2]] .. "(G)"
        end
        if (doordata[id][4] == "glitch") and (glitchlocks[id][1] ~= nil) and (glitchlocks[id][1] ~= "glitch") then
            visual2 = shorthand[glitchlocks[id][1]] .. "(G)"
        end
        showcolor = visual2 .. "/" .. visual1
    else
        showcolor = visual1
    end
    if (doordata[id][3] == "blast") and (doordata[id][2] >= 0) then
        datanames[id] =  showcolor .. " X"
    elseif (doordata[id][3] == "blast") then
        datanames[id] =  showcolor .. " -X"
    elseif (doordata[id][3] == "blank") then
        datanames[id] = showcolor .. " B"
    elseif (doordata[id][3] == "i") then
        datanames[id] = showcolor .. " " .. tostring(doordata[id][2]) .. "i"
    elseif (doordata[id][3] == "blasti") and (doordata[id][2] >= 0) then
        datanames[id] = showcolor .. " Xi"
    elseif (doordata[id][3] == "blasti") then
        datanames[id] =  showcolor .. " -Xi"
    elseif (doordata[id][3] == "all") then
        datanames[id] =  showcolor .. " A"
    else
        datanames[id] = showcolor .. " " .. tostring(doordata[id][2])
    end
end

function resetkeydisplay(id)
    local color = keydata[id][1]
    if color == "glitch" and (glitchcolor ~= "glitch")then
        color = glitchcolor .. "(G)"
    end
    local count = keydata[id][2]
    local counti = keydata[id][4]
    local showcount = ""
    if counti == 0 then
        show = tostring(count)
    elseif count == 0 then
        show = tostring(counti) .. "i"
    elseif counti > 0 then
        show = tostring(count) .. "+" .. tostring(counti) .. "i"
    else
        show = tostring(count) .. "-" .. tostring(-counti) .. "i"
    end
    local keytype = keydata[id][3]
    if (keytype == "exact") then
        datanames[id] =  color .. " E" .. show
    elseif (keytype == "signflip") then
        datanames[id] =  color .. " x-1"
    elseif (keytype == "star") then
        datanames[id] =  color .. " *"
    elseif (keytype == "unstar") then
        datanames[id] =  color .. " -*"
    elseif (keytype == "rotor") then
        datanames[id] =  color .. " xi"
    elseif (keytype == "unrotor") then
        datanames[id] =  color .. " x-i"
    else
        datanames[id] = color .. " " .. show
    end
end

function getlayerdisplays()
    local result = {}
    for id, j in pairs(layers) do
        local unitid = MF_getfixed(id)
        local unit = mmf.newObject(unitid)
        if unit ~= nil then
            local x, y = unit.values[XPOS], unit.values[YPOS]
            x = Xoffset + (x + .5) * tilesize * spritedata.values[TILEMULT]
            y = Yoffset + (y) * tilesize * spritedata.values[TILEMULT]
            if (layers[id] ~= nil) and ((layers[id] ~= 1) or (layersi[id] ~= 0)) then
                local show = ""
                if layersi[id] == 0 then
                    show = tostring(layers[id])
                elseif layers[id] == 0 then
                    show = tostring(layersi[id]) .. "i"
                elseif layersi[id] > 0 then
                    show = tostring(layers[id]) .. "+" .. tostring(layersi[id]) .. "i"
                else
                    show = tostring(layers[id]) .. "-" .. tostring(-layersi[id]) .. "i"
                end
                table.insert(result, {x, y, "x" .. show})
            end
        end
    end
    for sync, id in pairs(showlayer) do
        local unitid = MF_getfixed(id)
        local unit = mmf.newObject(unitid)
        if unit ~= nil then
            local x, y = unit.values[XPOS], unit.values[YPOS]
            x = Xoffset + (x + .5) * tilesize * spritedata.values[TILEMULT]
            y = Yoffset + (y) * tilesize * spritedata.values[TILEMULT]
            if (combodata[sync][3] ~= nil) and ((combodata[sync][3] ~= 1) or (combodata[sync][4] ~= 0)) then
                local show = ""
                if combodata[sync][4] == 0 then
                    show = tostring(combodata[sync][3])
                elseif combodata[sync][3] == 0 then
                    show = tostring(combodata[sync][4]) .. "i"
                elseif combodata[sync][4] > 0 then
                    show = tostring(combodata[sync][3]) .. "+" .. tostring(combodata[sync][4]) .. "i"
                else
                    show = tostring(combodata[sync][3]) .. "-" .. tostring(-combodata[sync][4]) .. "i"
                end
                table.insert(result, {x, y, "x" .. show})
            end
        end
    end
    return result
end

function getcomboname(id, sync, line)
    if (line == 1) then
        local curr = combodata[sync][1]
        if curr == "glitch" and (glitchlocks[id][1] ~= "glitch") then
            curr = glitchlocks[id][1] .. "(G)"
        end
        if (combodata[sync][2] ~= 0) and (combodata[sync][2] ~= nil) then
            local str = " (" .. lookup1[combodata[sync][2]] .. ")"
            curr = curr .. str
        end
        return curr
    else
        local color = comboreq[sync][line-1][1]
        if color == "glitch" and (glitchlocks[id][line] ~= 'glitch') then
            color = glitchlocks[id][line] .. "(G)"
        end
        local count = comboreq[sync][line-1][2]
        local result = ""
        if (comboreq[sync][line-1][3] == "blast") and (count >= 0) then
            result =  color .. " X"
        elseif (comboreq[sync][line-1][3] == "blast")then
            result =  color .. " -X"
        elseif (comboreq[sync][line-1][3] == "blank") then
            result = color .. " B"
        elseif (comboreq[sync][line-1][3] == "blasti") and (count >= 0) then
            result =  color .. " Xi"
        elseif (comboreq[sync][line-1][3] == "blasti")then
            result =  color .. " -Xi"
        elseif (comboreq[sync][line-1][3] == "i")then
            result =  color .. " " .. tostring(count) .. "i"
        elseif (comboreq[sync][line-1][3] == "blank") then
            result = color .. " A"
        else
            result = color .. " " .. tostring(count)
        end
        return result
    end
end

function handlemyspeicals(x,y,type,data, fullspecial)
    if (type == "door") then
        local color = data[1]
        local count = tonumber(data[2])
		local things = findallhere(x,y)
        local doortype = data[3]
        local aura = tonumber(data[4])
        local spend = data[5]
        local layer = tonumber(data[6])
        local layeri = tonumber(data[7])
        if (layer == nil) then
            layer = 1
        end
        if (layeri == nil) then
            layeri = 0
        end
        if (spend == nil) then
            spend = color
        end
        if (doortype ~= "blast") and (doortype ~= "blank") and (doortype ~= "i") and (doortype ~= "blasti") and (doortype ~= "all") then
            doortype = "normal"
        end
        for i,v in ipairs(things) do
			local vunit = mmf.newObject(v)
            local id = vunit.values[ID]
			glitchlocks[id] = {}
            origspecial[id] = fullspecial
            doordata[id] = {color, count, doortype, spend}
            if (aura ~= nil) then
                auras[id] = aura
            end
            layers[id] = layer
            layersi[id] = layeri
            cursed[id] = {color,spend}
			if (color == "glitch") or (spend == "glitch") then
                table.insert(glitches, id)
			end
            if (color == "glitch") then
				glitchlocks[id][2] = "glitch"
            end
			if (spend == "glitch") then
				glitchlocks[id][1] = "glitch"
			end
            resetdoordisplay(id)
        end
        if pickkeys[color] == nil then
            pickkeys[color] = 0
        end
        if pickkeys[spend] == nil then
            pickkeys[spend] = 0
        end
    elseif (type == "key") then
        local color = data[1]
        local count = tonumber(data[2])
		local things = findallhere(x,y)
        local keytype = data[3]
        local counti = tonumber(data[4])
        if (keytype ~= "exact") and (keytype ~= "signflip") and (keytype ~= "star") and (keytype ~= "unstar") and (keytype ~= "rotor") and (keytype ~= "unrotor") then
            keytype = "normal"
        end
        if counti == nil then
            counti = 0
        end
        for i,v in ipairs(things) do
			local vunit = mmf.newObject(v)
            local id = vunit.values[ID]
            keydata[id] = {color, count, keytype, counti}
            resetkeydisplay(id)
            if color == "glitch" then
                table.insert(glitches, id)
            end
        end
        if pickkeys[color] == nil then
            pickkeys[color] = 0
        end
    elseif (type == "display") then
        local color = data[1]
        local c1 = tonumber(data[2])
        local c2 = tonumber(data[3])
        if pickkeys[color] == nil then
            pickkeys[color] = 0
        end
        if pickkeysi[color] == nil then
            pickkeysi[color] = 0
        end
        table.insert(display0, {Xoffset + (x + .5) * tilesize * spritedata.values[TILEMULT], Yoffset + (y + .5) * tilesize * spritedata.values[TILEMULT], color, c1, c2})
    elseif (type == "combo") then
        local things = findallhere(x,y)
        for i,v in ipairs(things) do
            local vunit = mmf.newObject(v)
            local id = vunit.values[ID]
            origspecial[id] = fullspecial
			glitchlocks[id] = {}
            local color = data[1]
            local aura = tonumber(data[2])
            local sync = tonumber(data[5])
            local layer = tonumber(data[3])
            local layeri = tonumber(data[4])
			if (color == "glitch") then
				glitchlocks[id][1] = "glitch"
			end
            if layer == nil then
                layer = 1
            end
            if layeri == nil then
                layeri = 0
            end
            local speicalreqs = {}
            local i = 6
            combocursed[sync] = {color}
            local glitchfound = (color == "glitch")

            if pickkeys[color] == nil then
                pickkeys[color] = 0
            end
            while data[i] ~= nil do
                local curr = data[i]
                local specialreq = {""}
                local j = 1
                while j <= string.len(curr) do
                    local char = string.sub(curr,j,j)
                    if char == ":" then
                        table.insert(specialreq, "")
                    else
                        specialreq[#specialreq] = specialreq[#specialreq] .. char
                    end
                    j = j + 1
                end
                local spend = specialreq[1]
                local req = tonumber(specialreq[2])
                local doortype = specialreq[3]
				if (spend == "glitch") then
					glitchlocks[id][i - 4] = "glitch"
				end
                if (doortype ~= "blast") and (doortype ~= "blank") then
                    doortype = "normal"
                end
                table.insert(speicalreqs, {spend, req, doortype})
                table.insert(combocursed[sync], spend)
                if spend == "glitch" then
                    glitchfound = true
                end
                i = i + 1

                if pickkeys[spend] == nil then
                    pickkeys[spend] = 0
                end
            end
            comboreq[sync] = speicalreqs
            combosync[id] = sync
            combodata[sync] = {color, aura, layer, layeri}
            showlayer[sync] = id
            resetcombodisplay(sync)
            if glitchfound then
                table.insert(glitches, id)
            end
        end
    elseif (type == "sid") then
        local things = findallhere(x,y)
        for i,v in ipairs(things) do
            local vunit = mmf.newObject(v)
            local id = vunit.values[ID]
            salvageid[id] = tonumber(data[1])
        end
	end
end

function applydoordatasalvage(id, type, data, fullspecial)
	glitchlocks[id] = {}
    if (type == "door") then
        local color = data[1]
        local count = tonumber(data[2])
        local doortype = data[3]
        local aura = 0
        local spend = data[5]
        local layer = 1
        local layeri = 0
        if (spend == nil) then
            spend = color
        end
        if (doortype ~= "blast") and (doortype ~= "blank") and (doortype ~= "i") and (doortype ~= "blasti") and (doortype ~= "all") then
            doortype = "normal"
        end
        origspecial[id] = fullspecial
        doordata[id] = {color, count, doortype, spend}
        auras[id] = aura
        layers[id] = layer
        layersi[id] = layeri
        cursed[id] = {color,spend}
        if (color == "glitch") or (spend == "glitch") then
            table.insert(glitches, id)
        end
		if (color == "glitch") then
			glitchlocks[id][2] = "glitch"
		end
		if (spend == "glitch") then
			glitchlocks[id][1] = "glitch"
		end
        if pickkeys[color] == nil then
            pickkeys[color] = 0
        end
        if pickkeys[spend] == nil then
            pickkeys[spend] = 0
        end
        resetdoordisplay(id)
    elseif (type == "combo") then
        origspecial[id] = fullspecial
        local color = data[1]
        local aura = 0
        local sync = 1
        while showlayer[sync] ~= nil do
            sync = sync + 1
        end
        local layer = 1
        local layeri = 0
        local speicalreqs = {}
        local i = 6
		if (color == "glitch") then
			glitchlocks[id][1] = "glitch"
		end
        combocursed[sync] = {color}
        local glitchfound = (color == "glitch")
        if pickkeys[color] == nil then
            pickkeys[color] = 0
        end
        while data[i] ~= nil do
            local curr = data[i]
            local specialreq = {""}
            local j = 1
            while j <= string.len(curr) do
                local char = string.sub(curr,j,j)
                if char == ":" then
                    table.insert(specialreq, "")
                else
                    specialreq[#specialreq] = specialreq[#specialreq] .. char
                end
                j = j + 1
            end
            local spend = specialreq[1]
            local req = tonumber(specialreq[2])
            local doortype = specialreq[3]
			if (spend == "glitch") then
				glitchlocks[id][i - 4] = "glitch"
			end
            if (doortype ~= "blast") and (doortype ~= "blank") then
                doortype = "normal"
            end
            table.insert(speicalreqs, {spend, req, doortype})
            table.insert(combocursed[sync], spend)
            if spend == "glitch" then
                glitchfound = true
            end
            i = i + 1
            if pickkeys[spend] == nil then
                pickkeys[spend] = 0
            end
        end
        comboreq[sync] = speicalreqs
        combosync[id] = sync
        combodata[sync] = {color, aura, layer, layeri}
        showlayer[sync] = id
        resetcombodisplay(sync)
        if glitchfound then
            table.insert(glitches, id)
        end
    end
end

function handleoutputpoints()
    local removethese = {}
    if unitlists["outputpoint"] ~= nil then
        for i, j in pairs(unitlists["outputpoint"]) do
            local unit = mmf.newObject(j)
            local id = unit.values[ID]
            local x, y, dir = unit.values[XPOS], unit.values[YPOS], unit.values[DIR]
            if salvageid[id] ~= nil then
                local data = getsalvage(salvageid[id])
                if data ~= nil then
                    local unitid, id2 = create(data[2], x, y, dir, nil, nil, nil, true)
                    local result = {""}
                    local j0 = 1
                    while j0 <= string.len(data[1]) do
                        local char = string.sub(data[1],j0,j0)
                        if char == "," then
                            table.insert(result, "")
                        else
                            result[#result] = result[#result] .. char
                        end
                        j0 = j0 + 1
                    end
                    local kind = result[1]
                    table.remove(result,1)
                    applydoordatasalvage(id2, kind, result, data[1])
                    table.insert(removethese, j)
                end
            end
        end
    end
    for i, j in pairs(removethese) do
        delete(j,nil,nil,nil,true)
    end
end

function resetglitchdisplays()
    for i,j in pairs(glitches) do
        if doordata[j] ~= nil then
            resetdoordisplay(j)
        end
        if keydata[j] ~= nil then
            resetkeydisplay(j)
        end
        if combosync[j] ~= nil then
            resetcombodisplay(j)
        end 
    end
end

table.insert(mod_hook_functions["effect_always"], function()
    local docommand = false
    if MF_keydown("x") then
        if pressedm == false then
            mastermode = not mastermode
            pressedm = true
            docommand = true
        end
    else
        pressedm = false
    end
    if MF_keydown("i") then
        if pressedi == false then
            imode = not imode
            pressedi = true
            docommand = true
        end
    else
        pressedi = false
    end
	MF_letterclear("keyshow")
	if generaldata2.values[INPAUSEMENU] ~= 1 then
		for _, i in pairs(display0) do
            local show = ""
            if pickkeysi[i[3]] == 0 then
                show = tostring(pickkeys[i[3]])
            elseif pickkeys[i[3]] == 0 then
                show = tostring(pickkeysi[i[3]]) .. "i"
            elseif pickkeysi[i[3]] > 0 then
                show = tostring(pickkeys[i[3]]) .. "+" .. tostring(pickkeysi[i[3]]) .. "i"
            else
                show = tostring(pickkeys[i[3]]) .. "-" .. tostring(-pickkeysi[i[3]]) .. "i"
            end
            if starval[i[3]] ~= true then
                writetext(i[3] .. ": " .. show,0,i[1],i[2],"keyshow",true,2,nil,{i[4], i[5]})
            else
                writetext(i[3] .. ": *" .. show,0,i[1],i[2],"keyshow",true,2,nil,{i[4], i[5]})
            end
		end
        local x, y = MF_mouse()
        x = (x - Xoffset) // (tilesize * spritedata.values[TILEMULT])
        y = (y - Yoffset) // (tilesize * spritedata.values[TILEMULT])
        local display1, isdoor = getdisplays(x,y)
        local display3 = getcombodisplays(x,y)
        x = Xoffset + (x + .5) * tilesize * spritedata.values[TILEMULT]
        y = Yoffset + (y + .5) * tilesize * spritedata.values[TILEMULT]
        for i0, i in pairs(display1) do
            if isdoor[i0] then
                writetext(i,0,x,y,"keyshow",true,2,nil,{2, 3})
            else
                writetext(i,0,x,y,"keyshow",true,2,nil,{1, 3})

            end
		end
        for id, i in pairs(salvageid) do
            local j = MF_getfixed(id)
            if j ~= nil then
                local unit = mmf.newObject(j)
                if unit ~= nil then
                    local x0, y0 = unit.values[XPOS], unit.values[YPOS]
                    x0 = Xoffset + (x0 + .5) * tilesize * spritedata.values[TILEMULT]
                    y0 = Yoffset + (y0 + .5) * tilesize * spritedata.values[TILEMULT]
                    writetext(i,0,x0,y0,"keyshow",true,2,nil,{5, 4})
                end
            end
        end
        for _, i0 in pairs(display3) do
            for i, j in pairs(i0) do
                writetext(j,0,x,y + (-(#i0) + (i * 2) - 1) * 10,"keyshow",true,2,nil,{2, 3})
            end
		end
        local display2 = getlayerdisplays()
        for _, i in pairs(display2) do
            writetext(i[3],0,i[1],i[2],"keyshow",true,2,nil,{0, 3})
		end
        local fcount = 1
        local pcount = 1
        local ecount = 1
        for i, j in pairs(auras) do
            local unitid = MF_getfixed(i)
            local unit = mmf.newObject(unitid)
            if unit ~= nil then
                if ((j // 1) % 2) == 1 then
                    local displayunit = freezes[fcount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(freezes, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 26
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"ice_0",26,false)
                        MF_setcolour(k,3,3)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        fcount = fcount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        fcount = fcount + 1
                    end
                end
                if ((j // 2) % 2) == 1 then
                    local displayunit = erodes[ecount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(erodes, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 27
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"erosion_0",27,true)
                        MF_setcolour(k,2,1)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        ecount = ecount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        ecount = ecount + 1
                    end
                end
                if ((j // 4) % 2) == 1 then
                    local displayunit = paints[pcount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(paints, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 28
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"painted_0",28,true)
                        MF_setcolour(k,4,3)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        pcount = pcount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        pcount = pcount + 1
                    end
                end
            end
        end
        for i, j0 in pairs(combosync) do
            local unitid = MF_getfixed(i)
            local unit = mmf.newObject(unitid)
            local j = combodata[j0][2]
            if (unit ~= nil) and (j ~= nil) then
                if ((j // 1) % 2) == 1 then
                    local displayunit = freezes[fcount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(freezes, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 26
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"ice_0",26,false)
                        MF_setcolour(k,3,3)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        fcount = fcount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        fcount = fcount + 1
                    end
                end
                if ((j // 2) % 2) == 1 then
                    local displayunit = erodes[ecount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(erodes, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 27
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"erosion_0",27,true)
                        MF_setcolour(k,2,1)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        ecount = ecount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        ecount = ecount + 1
                    end
                end
                if ((j // 4) % 2) == 1 then
                    local displayunit = paints[pcount]
                    if displayunit == nil then
                        local k = MF_specialcreate("customsprite")
                        displayunit = mmf.newObject(k)
                        table.insert(paints, displayunit)
                        displayunit.values[ONLINE] = 1
                        displayunit.layer = 2
                        displayunit.direction = 28
                        displayunit.values[ZLAYER] = 23
                        MF_loadsprite(k,"painted_0",28,true)
                        MF_setcolour(k,4,3)
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        displayunit.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        displayunit.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
                        pcount = pcount + 1
                    else
                        displayunit.values[XPOS] = unit.x
                        displayunit.values[YPOS] = unit.y
                        displayunit.visible = unit.visible
                        pcount = pcount + 1
                    end
                end
            end
        end
        while fcount <= #freezes do
            MF_cleanremove(freezes[fcount].fixed)
            table.remove(freezes,fcount)
        end
        while pcount <= #paints do
            MF_cleanremove(paints[pcount].fixed)
            table.remove(paints,pcount)
        end
        while ecount <= #erodes do
            MF_cleanremove(erodes[ecount].fixed)
            table.remove(erodes,ecount)
        end
	end
    if docommand then
        command("idle")
    end
end
)

function getsalvage(sid)
    if (editor.values[INEDITOR] == 0) then
        MF_setfile("world","Data/Worlds/" .. generaldata.strings[WORLD] .. "/" .. "world_data.txt")
        local value = MF_read("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_val" .. tostring(sid))
        local name = MF_read("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_name" .. tostring(sid))
        if (value == nil) or (value == "") or (value == "empty") or (name == nil) or (name == "") or (name == "empty") then
            return nil
        end
        return {value, name}
    end
end

function setsalvage(sid, val, name)
    if (editor.values[INEDITOR] == 0) then
        MF_setfile("world","Data/Worlds/" .. generaldata.strings[WORLD] .. "/" .. "world_data.txt")
        MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_val" .. tostring(sid), val)
        MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_name" .. tostring(sid), name)
        local index = 0
        local valid = true
        while valid do
            index = index + 1
            local curr = MF_read("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_sid" .. tostring(index))
            if (curr == nil) or (curr == "") or (curr == "empty") then
                valid = false
            end
            if (curr == tostring(sid)) then
                return
            end
        end
        MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_sid" .. tostring(index), tostring(sid))
    end
end

function clearsalvages()
    if (editor.values[INEDITOR] == 0) then
        MF_setfile("world","Data/Worlds/" .. generaldata.strings[WORLD] .. "/" .. "world_data.txt")
        local index = 0
        local valid = true
        while valid do
            index = index + 1
            local sid = MF_read("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_sid" .. tostring(index))
            if (sid == nil) or (sid == "") or (sid == "empty") then
                valid = false
                break
            end
            MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_sid" .. tostring(index), "empty")
            MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_val" .. sid, "empty")
            MF_store("world","salvages",tostring(generaldata2.values[SAVESLOT]) .. "_name" .. sid, "empty")
        end
    end
end

function applyglitchcolor(color)
	for id, j0 in pairs(glitchlocks) do
		if #j0 ~= 0 then
			if combosync[id] ~= nil then
				local sync = combosync[id]
				local c = comboiscursed[sync]
				if not c then
					for i, j in pairs(j0) do
						addundo({"updateglitchlock", id, i, glitchlocks[id][i]})
						glitchlocks[id][i] = color
					end
				end
			elseif doordata[id] ~= nil then
				local c = iscursed[id]
				if not c then
					for i, j in pairs(j0) do
						addundo({"updateglitchlock", id, i, glitchlocks[id][i]})
						glitchlocks[id][i] = color
					end
				end
			end
		end
	end
end

------------------------


function check(unitid,x,y,dir,pulling_,reason)
	local pulling = false
	if (pulling_ ~= nil) then
		pulling = pulling_
	end
	
	local dir_ = dir
	if pulling then
		dir_ = rotate(dir)
	end
	
	local ndrs = ndirs[dir_ + 1]
	local ox,oy = ndrs[1],ndrs[2]
	
	local result = {}
	local results = {}
	local specials = {}
	local unit = {}
	local name = ""
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		name = getname(unit)
	else
		name = "empty"
	end
	
	local lockpartner = ""
	local open = hasfeature(name,"is","open",unitid,x,y)
	local shut = hasfeature(name,"is","shut",unitid,x,y)
	local eat = hasfeature(name,"eat",nil,unitid,x,y)
	local phantom = hasfeature(name,"is","phantom",unitid,x,y)
	local you = hasfeature(name,"is","you",unitid,x,y)
	
	if pulling then
		phantom = nil
	end
	
	if (open ~= nil) then
		lockpartner = "shut"
	elseif (shut ~= nil) then
		lockpartner = "open"
	end
	
	local obs = findobstacle(x+ox,y+oy)
	
	if (#obs > 0) and (phantom == nil) then
		for i,id in ipairs(obs) do
			if (id == -1) then
				table.insert(result, -1)
				table.insert(results, -1)
			else
				local obsunit = mmf.newObject(id)
				local obsname = getname(obsunit)
				
				local alreadymoving = findupdate(id,"update")
				local valid = true
				
				local localresult = 0
				
				if (#alreadymoving > 0) then
					for a,b in ipairs(alreadymoving) do
						local nx,ny = b[3],b[4]
						
						if ((nx ~= x) and (ny ~= y)) and ((reason == "shift") and (pulling == false)) then
							valid = false
						end
						
						if ((nx == x) and (ny == y + oy * 2)) or ((ny == y) and (nx == x + ox * 2)) then
							valid = false
						end
					end
				end
				
				if (lockpartner ~= "") and (pulling == false) then
					local partner = hasfeature(obsname,"is",lockpartner,id,x+ox,y+oy)
					
					if (partner ~= nil) and ((issafe(id,x+ox,y+oy) == false) or (issafe(unitid,x,y) == false)) and floating(id,unitid,x+ox,y+oy) then
						valid = false
						table.insert(specials, {id, "lock"})
					end
				end
				
				if (eat ~= nil) and (pulling == false) then
					local eats = hasfeature(name,"eat",obsname,unitid,x+ox,y+oy)
					
					if (eats ~= nil) and (issafe(id,x+ox,y+oy) == false) and floating(id,unitid,x+ox,y+oy) then
						valid = false
						table.insert(specials, {id, "eat"})
					end
				end
				
				local weak = hasfeature(obsname,"is","weak",id,x+ox,y+oy)
				if (weak ~= nil) and (pulling == false) then
					if (issafe(id,x+ox,y+oy) == false) and floating(id,unitid,x+ox,y+oy) then
						--valid = false
						table.insert(specials, {id, "weak"})
					end
				end

                local unlocky = unlockable(id)
                if (you ~= nil) and (unlocky ~= "no") and (pulling == false) then
                    if floating(id,unitid,x+ox,y+oy) then
                        if (issafe(id,x+ox,y+oy) == false) then
                            if (unlocky[3] == 0) and (unlocky[5] == 0) then
                                valid = false
                                table.insert(specials, {id, "lock2", unlocky})
                            else
                                table.insert(specials, {id, "lock3", unlocky})
                            end
                        elseif (unlocky[3] ~= 0) or (unlocky[5] ~= 0) or safenullity then
                            table.insert(specials, {id, "lock3", unlocky})
                        end
					end
                end
				
				local added = false
				
				if valid then
					--MF_alert("checking for solidity for " .. obsname .. " by " .. name .. " at " .. tostring(x) .. ", " .. tostring(y))
					
					local isstop = hasfeature(obsname,"is","stop",id,x+ox,y+oy)
					local ispush = hasfeature(obsname,"is","push",id,x+ox,y+oy)
					local ispull = hasfeature(obsname,"is","pull",id,x+ox,y+oy)
					local isswap = hasfeature(obsname,"is","swap",id,x+ox,y+oy)
					local isstill = cantmove(obsname,id,dir,x+ox,y+oy)
					
					--MF_alert(obsname .. " -- stop: " .. tostring(isstop) .. ", push: " .. tostring(ispush))
					
					if (ispush ~= nil) and isstill then
						ispush = nil
						isstop = true
					end
					
					if (ispull ~= nil) and isstill then
						ispull = nil
						isstop = true
					end
					
					if (isswap ~= nil) and isstill then
						isswap = nil
					end
					
					if (isstop ~= nil) and (obsname == "level") and (obsunit.visible == false) then
						isstop = nil
					end
					
					if (((isstop ~= nil) and (ispush == nil) and ((ispull == nil) or ((ispull ~= nil) and (pulling == false)))) or ((ispull ~= nil) and (pulling == false) and (ispush == nil))) and (isswap == nil) then
						if (weak == nil) or ((weak ~= nil) and (floating(id,unitid,x+ox,y+oy) == false)) then
							table.insert(result, 1)
							table.insert(results, id)
							localresult = 1
							added = true
						end
					end
					
					if (localresult ~= 1) and (localresult ~= -1) then
						if (ispush ~= nil) and (pulling == false) and (isswap == nil) then
							--MF_alert(obsname .. " added to push list")
							table.insert(result, id)
							table.insert(results, id)
							added = true
						end
						
						if (ispull ~= nil) and pulling then
							table.insert(result, id)
							table.insert(results, id)
							added = true
						end
					end
				end
				
				if (added == false) then
					table.insert(result, 0)
					table.insert(results, id)
				end
			end
		end
	elseif (phantom == nil) then
		local emptystop = hasfeature("empty","is","stop",2,x+ox,y+oy)
		local emptypush = hasfeature("empty","is","push",2,x+ox,y+oy)
		local emptypull = hasfeature("empty","is","pull",2,x+ox,y+oy)
		local emptyswap = hasfeature("empty","is","swap",2,x+ox,y+oy)
		local emptystill = cantmove("empty",2,dir_,x+ox,y+oy)
		
		local localresult = 0
		local valid = true
		local bname = "empty"
		
		if (eat ~= nil) and (pulling == false) then
			local eats = hasfeature(name,"eat","empty",unitid,x+ox,y+oy)
			
			if (eats ~= nil) and (issafe(2,x+ox,y+oy) == false) and floating(unitid,2,x+ox,y+oy) then
				valid = false
				table.insert(specials, {2, "eat"})
			end
		end
		
		if (lockpartner ~= "") and (pulling == false) then
			local partner = hasfeature("empty","is",lockpartner,2,x+ox,y+oy)
			
			if (partner ~= nil) and ((issafe(2,x+ox,y+oy) == false) or (issafe(unitid,x,y) == false)) and floating(unitid,2,x+ox,y+oy) then
				valid = false
				table.insert(specials, {2, "lock"})
			end
		end
		
		local weak = hasfeature("empty","is","weak",2,x+ox,y+oy)
		if (weak ~= nil) and (pulling == false) then
			if (issafe(2,x+ox,y+oy) == false) and floating(unitid,2,x+ox,y+oy) then
				valid = false
				table.insert(specials, {2, "weak"})
			end
		end
		
		local added = false
		
		if valid then
			local estop = 0
			
			if (emptyswap ~= nil) and emptystill then
				emptyswap = nil
			end
			
			if (emptypush == nil) and (emptyswap == nil) then
				if (emptypull ~= nil) and (pulling == false) then
					estop = 1
				elseif (emptypull ~= nil) and pulling and emptystill then
					estop = 1
				elseif (emptypull == nil) and (emptystop ~= nil) then
					estop = 1
				end
			elseif emptystill then
				estop = 1
			end
			
			if (estop == 1) then
				localresult = 1
				table.insert(result, 1)
				table.insert(results, 2)
				added = true
			end
			
			if (localresult ~= 1) then
				if (emptypush ~= nil) and (pulling == false) and (emptyswap == nil) then
					table.insert(result, 2)
					table.insert(results, 2)
					added = true
				end
				
				if (emptypull ~= nil) and pulling then
					table.insert(result, 2)
					table.insert(results, 2)
					added = true
				end
			end
		end
		
		if (added == false) then
			table.insert(result, 0)
			table.insert(results, 2)
		end
	end
	
	if (#results == 0) then
		result = {0}
		results = {0}
	end
	
	return result,results,specials
end

function move(unitid,ox,oy,dir,specials_,instant_,simulate_,x_,y_)
	local instant = instant_ or false
	local simulate = simulate_ or false
	
	local x,y = 0,0
	local unit = {}
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		x,y = unit.values[XPOS],unit.values[YPOS]
	else
		x = x_
		y = y_
	end
	
	local specials = {}
	if (specials_ ~= nil) then
		specials = specials_
	end
	
	local gone = false
	
	for i,v in pairs(specials) do
		if (gone == false) then
			local b = v[1]
			local reason = v[2]
			local dodge = false
			
			local bx,by = 0,0
			if (b ~= 2) and (deleted[b] ~= nil) then
				MF_alert("Already gone")
				dodge = true
			elseif (b ~= 2) and (reason ~= "weak") then
				local bunit = mmf.newObject(b)
				bx,by = bunit.values[XPOS],bunit.values[YPOS]
				
				if (bx ~= x+ox) or (by ~= y+oy) then
					dodge = true
				else
					for c,d in ipairs(movelist) do
						if (d[1] == b) then
							local nx,ny = d[2],d[3]
							
							--print(tostring(nx) .. "," .. tostring(ny) .. " --> " .. tostring(x+ox) .. "," .. tostring(y+oy) .. " (" .. tostring(bx) .. "," .. tostring(by) .. ")")
							if (nx ~= x+ox) or (ny ~= y+oy) then
								dodge = true
							end
						end
					end
				end
			else
				bx,by = x+ox,y+oy
			end
			
			if (dodge == false) then
				if (reason == "lock") then
					local unlocked = false
					local valid = true
					local soundshort = ""
					
					if (b ~= 2) then
						local bunit = mmf.newObject(b)
						
						if bunit.flags[DEAD] then
							valid = false
						end
					end
					
					if (unitid ~= 2) and unit.flags[DEAD] then
						valid = false
					end
					
					if valid then
						local pmult = 1.0
						local effect1 = false
						local effect2 = false
						
						if (issafe(b,bx,by) == false) then
							delete(b,bx,by)
							unlocked = true
							effect1 = true
						end
						
						if (issafe(unitid,x,y) == false) then
							delete(unitid,x,y)
							unlocked = true
							gone = true
							effect2 = true
						end
						
						if effect1 or effect2 then
							local pmult,sound = checkeffecthistory("unlock")
							soundshort = sound
						end
						
						if effect1 then
							MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
							generaldata.values[SHAKE] = 8
						end
						
						if effect2 then
							MF_particles("unlock",x,y,15 * pmult,2,4,1,1)
							generaldata.values[SHAKE] = 8
						end
					end
					
					if unlocked then
						setsoundname("turn",7,soundshort)
					end
				elseif (reason == "lock2") then
                    mastermode = false
					local unlocked = false
					local valid = true
					local soundshort = ""
                    local bunit = nil
                    local bid = 0
                    local bname = ""
					
					if (b ~= 2) then
						bunit = mmf.newObject(b)
                        bid = bunit.values[ID]
                        bname = bunit.strings[UNITNAME]
						
						if bunit.flags[DEAD] then
							valid = false
						end
					end
					
					if (unitid ~= 2) and unit.flags[DEAD] then
						valid = false
					end
					
					if valid then
						local pmult = 1.0
						local effect1 = false
						
						if (issafe(b,bx,by) == false) then
							delete(b,bx,by)
							unlocked = true
							effect1 = true
						end
						
						if effect1 then
							local pmult,sound = checkeffecthistory("unlock")
							soundshort = sound
						end
						
						if effect1 then
							MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
							generaldata.values[SHAKE] = 8
						end
					end
					
					if unlocked then
						setsoundname("turn",7,soundshort)
                        local color = v[3][1]
                        local count = v[3][2]
                        local counti = v[3][4]
                        if pickkeys[color] == nil then
                            pickkeys[color] = 0
                        end
                        if pickkeysi[color] == nil then
                            pickkeysi[color] = 0
                        end
                        addundo({"updatekey", color, pickkeys[color], pickkeysi[color]})
                        if starval[color] ~= true then
                            pickkeys[color] = pickkeys[color] - count
                            pickkeysi[color] = pickkeysi[color] - counti
                        end
                        addundo({"updateglitch", glitchcolor})
                        glitchcolor = color
						applyglitchcolor(color)
                        resetglitchdisplays()
                        updateundo = true
                        if (salvaging ~= -1) then
                            setsalvage(salvageid[salvaging], origspecial[bid], bname)
                            doorsalvaged = true
                        end
					end
				elseif (reason == "lock3") then
                    mastermode = false
                    local valid = true
                    local soundshort = ""
                    local bunit = mmf.newObject(b)
                    
                    if (b ~= 2) then
                        
                        if bunit.flags[DEAD] then
                            valid = false
                        end
                    end
                    
                    if (unitid ~= 2) and unit.flags[DEAD] then
                        valid = false
                    end
                    
                    if valid then
                        local pmult = 1.0

                        soundshort = sound
                        MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
                        generaldata.values[SHAKE] = 8
                    end
                    setsoundname("turn",7,soundshort)
                    local color = v[3][1]
                    local count = v[3][2]
                    local counti = v[3][4]
                    local bid = bunit.values[ID]
                    addundo({"updatekey", color, pickkeys[color], pickkeysi[color]})
                    if starval[color] ~= true then
                        pickkeys[color] = pickkeys[color] - count
                        pickkeysi[color] = pickkeysi[color] - counti
                    end
                    if layers[bid] ~= nil then
                        addundo({"updatelayer", bid, layers[bid], layersi[bid]})
                        layers[bid] = v[3][3]
                        layersi[bid] = v[3][5]
                    end
                    if (combosync[bid] ~= nil) and (combodata[combosync[bid]][3] ~= nil) then
                        addundo({"updatecombolayer", combosync[bid], combodata[combosync[bid]][3], combodata[combosync[bid]][4]})
                        combodata[combosync[bid]][3] = v[3][3]
                        combodata[combosync[bid]][4] = v[3][5]
                    end
                    updateundo = true
                
                elseif (reason == "eat") then
					local pmult,sound = checkeffecthistory("eat")
					MF_particles("eat",bx,by,10 * pmult,0,3,1,1)
					generaldata.values[SHAKE] = 3
					delete(b,bx,by)
					
					setsoundname("removal",1,sound)
				elseif (reason == "weak") then
					if (b == 2) and (unitid ~= 2) then
						local pmult,sound = checkeffecthistory("weak")
						MF_particles("destroy",bx,by,5 * pmult,0,3,1,1)
						generaldata.values[SHAKE] = 3
						delete(b,bx,by)
						
						setsoundname("removal",1,sound)
					end
				end
			end
		end
	end
	
	if (gone == false) and (simulate == false) and (unitid ~= 2) then
		if instant then
			update(unitid,x+ox,y+oy,dir)
			MF_alert("Instant movement on " .. tostring(unitid))
		else
			addaction(unitid,{"update",x+ox,y+oy,dir})
		end
		
		if unit.visible and (#movelist < 700) and (spritedata.values[VISION] == 0) then
			if (generaldata.values[DISABLEPARTICLES] == 0) and (generaldata5.values[LEVEL_DISABLEPARTICLES] == 0) then
				local effectid = MF_effectcreate("effect_bling")
				local effect = mmf.newObject(effectid)
				
				local midxdelta = spritedata.values[XMIDTILE] - roomsizex * 0.5
				local midydelta = spritedata.values[YMIDTILE] - roomsizey * 0.5
				local midx = roomsizex * 0.5 + midxdelta * generaldata2.values[ZOOM]
				local midy = roomsizey * 0.5 + midydelta * generaldata2.values[ZOOM]
				local mx = x - midx
				local my = y - midy
				
				local c1,c2 = 0,0
				
				if (unit.colour ~= nil) and (unit.colour[1] ~= nil) and (unit.colour[2] ~= nil) then
					c1 = unit.colour[1]
					c2 = unit.colour[2]
				else
					if (unit.active == false) then
						c1,c2 = getcolour(unitid)
					else
						c1,c2 = getcolour(unitid,"active")
					end
				end
				MF_setcolour(effectid,c1,c2)
				
				local xvel,yvel = 0,0
				
				if (ox ~= 0) then
					xvel = 0 - ox / math.abs(ox)
				end
				
				if (oy ~= 0) then
					yvel = 0 - oy / math.abs(oy)
				end
				
				local dx = mx + 0.5
				local dy = my + 0.75
				local dxvel = xvel
				local dyvel = yvel
				
				if (generaldata2.values[ROOMROTATION] == 90) then
					dx = my + 0.75
					dy = 0 - mx - 0.5
					dxvel = yvel
					dyvel = 0 - xvel
				elseif (generaldata2.values[ROOMROTATION] == 180) then
					dx = 0 - mx - 0.5
					dy = 0 - my - 0.75
					dxvel = 0 - xvel
					dyvel = 0 - yvel
				elseif (generaldata2.values[ROOMROTATION] == 270) then
					dx = 0 - my - 0.75
					dy = mx + 0.5
					dxvel = 0 - yvel
					dyvel = xvel
				end
				
				effect.values[ONLINE] = 3
				effect.values[XPOS] = Xoffset + (midx + (dx) * generaldata2.values[ZOOM]) * tilesize * spritedata.values[TILEMULT]
				effect.values[YPOS] = Yoffset + (midy + (dy) * generaldata2.values[ZOOM]) * tilesize * spritedata.values[TILEMULT]
				effect.scaleX = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
				effect.scaleY = generaldata2.values[ZOOM] * spritedata.values[TILEMULT]
				
				effect.values[XVEL] = dxvel * math.random(10,30) * 0.1 * spritedata.values[TILEMULT] * generaldata2.values[ZOOM]
				effect.values[YVEL] = dyvel * math.random(10,30) * 0.1 * spritedata.values[TILEMULT] * generaldata2.values[ZOOM]
			end
			
			if (unit.values[TILING] == 2) then
				unit.values[VISUALDIR] = ((unit.values[VISUALDIR] + 1) + 4) % 4
			end
		end
	end
	
	return gone
end

function block(small_)
	local delthese = {}
	local doned = {}
	local unitsnow = #units
	local removalsound = 1
	local removalshort = ""
	
	local small = small_ or false
	
	local doremovalsound = false
	
	if (small == false) then
		if (generaldata2.values[ENDINGGOING] == 0) then
			local isdone = getunitswitheffect("done",false,delthese)
			
			for id,unit in ipairs(isdone) do
				table.insert(doned, unit)
			end
			
			if (#doned > 0) then
				setsoundname("turn",10)
			end
			
			for i,unit in ipairs(doned) do
				updateundo = true
				
				local ufloat = unit.values[FLOAT]
				local ded = unit.flags[DEAD]
				
				unit.values[FLOAT] = 2
				unit.values[EFFECTCOUNT] = math.random(-10,10)
				unit.values[POSITIONING] = 7
				unit.flags[DEAD] = true
				
				local x,y = unit.values[XPOS],unit.values[YPOS]
				
				if (spritedata.values[VISION] == 1) and (unit.values[ID] == spritedata.values[CAMTARGET]) then
					updatevisiontargets()
				end
				
				if (ufloat ~= 2) and (ded == false) then
					addundo({"done",unit.strings[UNITNAME],unit.values[XPOS],unit.values[YPOS],unit.values[DIR],unit.values[ID],unit.fixed,ufloat,unit.originalname})
				end
				
				delunit(unit.fixed)
				dynamicat(x,y)
			end
		end
		
		local ismore = getunitswitheffect("more",false,delthese)
		
		for id,unit in ipairs(ismore) do
			local x,y = unit.values[XPOS],unit.values[YPOS]
			local name = unit.strings[UNITNAME]
			local doblocks = {}
			
			for i=1,4 do
				local drs = ndirs[i]
				ox = drs[1]
				oy = drs[2]
				
				local valid = true
				local obs = findobstacle(x+ox,y+oy)
				local tileid = (x+ox) + (y+oy) * roomsizex
				
				if (#obs > 0) then
					for a,b in ipairs(obs) do
						if (b == -1) then
							valid = false
						elseif (b ~= 0) and (b ~= -1) then
							local bunit = mmf.newObject(b)
							local obsname = bunit.strings[UNITNAME]
							
							local obsstop = hasfeature(obsname,"is","stop",b,x+ox,y+oy)
							local obspush = hasfeature(obsname,"is","push",b,x+ox,y+oy)
							local obspull = hasfeature(obsname,"is","pull",b,x+ox,y+oy)
							
							if (obsstop ~= nil) or (obspush ~= nil) or (obspull ~= nil) or (obsname == name) then
								valid = false
								break
							end
						end
					end
				else
					local obsstop = hasfeature("empty","is","stop",2,x+ox,y+oy)
					local obspush = hasfeature("empty","is","push",2,x+ox,y+oy)
					local obspull = hasfeature("empty","is","pull",2,x+ox,y+oy)
					
					if (obsstop ~= nil) or (obspush ~= nil) or (obspull ~= nil) then
						valid = false
					end
				end
				
				if valid then
					local newunit = copy(unit.fixed,x+ox,y+oy)
				end
			end
		end
	end
	
	local isplay = getunitswithverb("play",delthese)
	
	for id,ugroup in ipairs(isplay) do
		local sound_freq = ugroup[1]
		local sound_units = ugroup[2]
		local sound_name = ugroup[3]
		
		if (#sound_units > 0) then
			local ptunes = play_data.tunes
			local pfreqs = play_data.freqs
			
			local tune = "beep"
			local freq = pfreqs[sound_freq] or 24000
			
			if (ptunes[sound_name] ~= nil) then
				tune = ptunes[sound_name]
			end
			
			-- MF_alert(sound_name .. " played at " .. tostring(freq) .. " (" .. sound_freq .. ")")
			
			MF_playsound_freq(tune,freq)
			setsoundname("turn",11,nil)
			
			if (sound_name ~= "empty") then
				for a,unit in ipairs(sound_units) do
					local x,y = unit.values[XPOS],unit.values[YPOS]
					
					MF_particles("music",unit.values[XPOS],unit.values[YPOS],1,0,3,3,1)
				end
			end
		end
	end
	
	if (generaldata.strings[WORLD] == "museum") then
		local ishold = getunitswitheffect("hold",false,delthese)
		local holders = {}
		
		for id,unit in ipairs(ishold) do
			local x,y = unit.values[XPOS],unit.values[YPOS]
			local tileid = x + y * roomsizex
			holders[unit.values[ID]] = 1
			
			if (unitmap[tileid] ~= nil) then
				local water = findallhere(x,y)
				
				if (#water > 0) then
					for a,b in ipairs(water) do
						if floating(b,unit.fixed,x,y) then
							if (b ~= unit.fixed) then
								local bunit = mmf.newObject(b)
								addundo({"holder",bunit.values[ID],bunit.holder,unit.values[ID],},unitid)
								bunit.holder = unit.values[ID]
							end
						end
					end
				end
			end
		end
		
		for i,unit in ipairs(units) do
			if (unit.holder ~= nil) and (unit.holder ~= 0) then
				if (holders[unit.holder] ~= nil) then
					local unitid = getunitid(unit.holder)
					local bunit = mmf.newObject(unitid)
					local x,y = bunit.values[XPOS],bunit.values[YPOS]
					
					update(unit.fixed,x,y,unit.values[DIR])
				else
					addundo({"holder",unit.values[ID],unit.holder,0,},unitid)
					unit.holder = 0
				end
			else
				unit.holder = 0
			end
		end
	end
	
	local issink = getunitswitheffect("sink",false,delthese)
	
	for id,unit in ipairs(issink) do
		local x,y = unit.values[XPOS],unit.values[YPOS]
		local tileid = x + y * roomsizex
		
		if (unitmap[tileid] ~= nil) then
			local water = findallhere(x,y)
			local sunk = false
			
			if (#water > 0) then
				for a,b in ipairs(water) do
					if floating(b,unit.fixed,x,y) then
						if (b ~= unit.fixed) then
							local dosink = true
							
							for c,d in ipairs(delthese) do
								if (d == unit.fixed) or (d == b) then
									dosink = false
								end
							end
							
							local safe1 = issafe(b)
							local safe2 = issafe(unit.fixed)
							
							if safe1 and safe2 then
								dosink = false
							end
							
							if dosink then
								generaldata.values[SHAKE] = 3
								
								if (safe1 == false) then
									table.insert(delthese, b)
								end
								
								local pmult,sound = checkeffecthistory("sink")
								removalshort = sound
								removalsound = 3
								local c1,c2 = getcolour(unit.fixed)
								MF_particles("destroy",x,y,15 * pmult,c1,c2,1,1)
								
								if (b ~= unit.fixed) and (safe2 == false) then
									sunk = true
								end
							end
						end
					end
				end
			end
			
			if sunk then
				table.insert(delthese, unit.fixed)
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	local isboom = getunitswitheffect("boom",false,delthese)
	
	for id,unit in ipairs(isboom) do
		local ux,uy = unit.values[XPOS],unit.values[YPOS]
		local sunk = false
		local doeffect = true
		
		if (issafe(unit.fixed) == false) then
			sunk = true
		else
			doremovalsound = true
		end
		
		local name = unit.strings[UNITNAME]
		local count = hasfeature_count(name,"is","boom",unit.fixed,ux,uy)
		local dim = math.min(count - 1, math.max(roomsizex, roomsizey))
		
		local locs = {}
		if (dim <= 0) then
			table.insert(locs, {0,0})
		else
			for g=-dim,dim do
				for h=-dim,dim do
					table.insert(locs, {g,h})
				end
			end
		end
		
		for a,b in ipairs(locs) do
			local g = b[1]
			local h = b[2]
			local x = ux + g
			local y = uy + h
			local tileid = x + y * roomsizex
			
			if (unitmap[tileid] ~= nil) and inbounds(x,y,1) then
				local water = findallhere(x,y)
				
				if (#water > 0) then
					for e,f in ipairs(water) do
						if floating(f,unit.fixed,x,y) then
							if (f ~= unit.fixed) then
								local doboom = true
								
								for c,d in ipairs(delthese) do
									if (d == f) then
										doboom = false
									elseif (d == unit.fixed) then
										sunk = false
									end
								end
								
								if doboom and (issafe(f) == false) then
									table.insert(delthese, f)
									MF_particles("smoke",x,y,4,0,2,1,1)
								end
							end
						end
					end
				end
			end
		end
		
		if doeffect then
			generaldata.values[SHAKE] = 6
			local pmult,sound = checkeffecthistory("boom")
			removalshort = sound
			removalsound = 1
			local c1,c2 = getcolour(unit.fixed)
			MF_particles("smoke",ux,uy,15 * pmult,c1,c2,1,1)
		end
		
		if sunk then
			table.insert(delthese, unit.fixed)
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	local isweak = getunitswitheffect("weak",false,delthese)
	
	for id,unit in ipairs(isweak) do
		if (issafe(unit.fixed) == false) and (unit.new == false) then
			local x,y = unit.values[XPOS],unit.values[YPOS]
			local stuff = findallhere(x,y)
			
			if (#stuff > 0) then
				for i,v in ipairs(stuff) do
					if floating(v,unit.fixed,x,y) then
						local vunit = mmf.newObject(v)
						local thistype = vunit.strings[UNITTYPE]
						if (v ~= unit.fixed) then
							local pmult,sound = checkeffecthistory("weak")
							MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
							removalshort = sound
							removalsound = 1
							generaldata.values[SHAKE] = 4
							table.insert(delthese, unit.fixed)
							break
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound,true)
	
	local ismelt = getunitswitheffect("melt",false,delthese)
	
	for id,unit in ipairs(ismelt) do
		local hot = findfeature(nil,"is","hot")
		local x,y = unit.values[XPOS],unit.values[YPOS]
		
		if (hot ~= nil) then
			for a,b in ipairs(hot) do
				local lava = findtype(b,x,y,0)
			
				if (#lava > 0) and (issafe(unit.fixed) == false) then
					for c,d in ipairs(lava) do
						if floating(d,unit.fixed,x,y) then
							local pmult,sound = checkeffecthistory("hot")
							MF_particles("smoke",x,y,5 * pmult,0,1,1,1)
							generaldata.values[SHAKE] = 5
							removalshort = sound
							removalsound = 9
							table.insert(delthese, unit.fixed)
							break
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound,true)
	
	local isyou = getunitswitheffect("you",false,delthese)
	local isyou2 = getunitswitheffect("you2",false,delthese)
	local isyou3 = getunitswitheffect("3d",false,delthese)
	
	for i,v in ipairs(isyou2) do
		table.insert(isyou, v)
	end
	
	for i,v in ipairs(isyou3) do
		table.insert(isyou, v)
	end
	
	for id,unit in ipairs(isyou) do
		local x,y = unit.values[XPOS],unit.values[YPOS]
		local defeat = findfeature(nil,"is","defeat")
		
		if (defeat ~= nil) then
			for a,b in ipairs(defeat) do
				if (b[1] ~= "empty") then
					local skull = findtype(b,x,y,0)
					
					if (#skull > 0) and (issafe(unit.fixed) == false) then
						for c,d in ipairs(skull) do
							local doit = false
							
							if (d ~= unit.fixed) then
								if floating(d,unit.fixed,x,y) then
									local kunit = mmf.newObject(d)
									local kname = kunit.strings[UNITNAME]
									
									local weakskull = hasfeature(kname,"is","weak",d)
									
									if (weakskull == nil) or ((weakskull ~= nil) and issafe(d)) then
										doit = true
									end
								end
							else
								doit = true
							end
							
							if doit then
								local pmult,sound = checkeffecthistory("defeat")
								MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
								generaldata.values[SHAKE] = 5
								removalshort = sound
								removalsound = 1
								table.insert(delthese, unit.fixed)
							end
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	local isshut = getunitswitheffect("shut",false,delthese)
	
	for id,unit in ipairs(isshut) do
		local open = findfeature(nil,"is","open")
		local x,y = unit.values[XPOS],unit.values[YPOS]
		
		if (open ~= nil) then
			for i,v in ipairs(open) do
				local key = findtype(v,x,y,0)
				
				if (#key > 0) then
					local doparts = false
					for a,b in ipairs(key) do
						if (b ~= 0) and floating(b,unit.fixed,x,y) then
							if (issafe(unit.fixed) == false) then
								generaldata.values[SHAKE] = 8
								table.insert(delthese, unit.fixed)
								doparts = true
								online = false
							end
							
							if (b ~= unit.fixed) and (issafe(b) == false) then
								table.insert(delthese, b)
								doparts = true
							end
							
							if doparts then
								local pmult,sound = checkeffecthistory("unlock")
								setsoundname("turn",7,sound)
								MF_particles("unlock",x,y,15 * pmult,2,4,1,1)
							end
							
							break
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	local iseat = getunitswithverb("eat",delthese)
	local iseaten = {}
	
	for id,ugroup in ipairs(iseat) do
		local v = ugroup[1]
		
		if (ugroup[3] ~= "empty") then
			for a,unit in ipairs(ugroup[2]) do
				local x,y = unit.values[XPOS],unit.values[YPOS]
				local things = findtype({v,nil},x,y,unit.fixed)
				
				if (#things > 0) then
					for a,b in ipairs(things) do
						if (issafe(b) == false) and floating(b,unit.fixed,x,y) and (b ~= unit.fixed) and (iseaten[b] == nil) then
							generaldata.values[SHAKE] = 4
							table.insert(delthese, b)
							
							iseaten[b] = 1
							
							local pmult,sound = checkeffecthistory("eat")
							MF_particles("eat",x,y,5 * pmult,0,3,1,1)
							removalshort = sound
							removalsound = 1
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound,true)
	
	if (small == false) then
		local ismake = getunitswithverb("make",delthese)
		
		for id,ugroup in ipairs(ismake) do
			local v = ugroup[1]
			
			for a,unit in ipairs(ugroup[2]) do
				local x,y,dir,name = 0,0,4,""
				
				local leveldata = {}
				
				if (ugroup[3] ~= "empty") then
					x,y,dir = unit.values[XPOS],unit.values[YPOS],unit.values[DIR]
					name = getname(unit)
					leveldata = {unit.strings[U_LEVELFILE],unit.strings[U_LEVELNAME],unit.flags[MAPLEVEL],unit.values[VISUALLEVEL],unit.values[VISUALSTYLE],unit.values[COMPLETED],unit.strings[COLOUR],unit.strings[CLEARCOLOUR]}
				else
					x = math.floor(unit % roomsizex)
					y = math.floor(unit / roomsizex)
					name = "empty"
					dir = emptydir(x,y)
				end
				
				if (dir == 4) then
					dir = fixedrandom(0,3)
				end
				
				local exists = false
				
				if (v ~= "text") and (v ~= "all") then
					for b,mat in pairs(objectlist) do
						if (b == v) then
							exists = true
						end
					end
				else
					exists = true
				end
				
				if exists then
					local domake = true
					
					if (name ~= "empty") then
						local thingshere = findallhere(x,y)
						
						if (#thingshere > 0) then
							for a,b in ipairs(thingshere) do
								local thing = mmf.newObject(b)
								local thingname = thing.strings[UNITNAME]
								
								if (thing.flags[CONVERTED] == false) and ((thingname == v) or ((thing.strings[UNITTYPE] == "text") and (v == "text"))) then
									domake = false
								end
							end
						end
					end
					
					if domake then
						if (findnoun(v,nlist.short) == false) then
							create(v,x,y,dir,x,y,nil,nil,leveldata)
						elseif (v == "text") then
							if (name ~= "text") and (name ~= "all") then
								create("text_" .. name,x,y,dir,x,y,nil,nil,leveldata)
								updatecode = 1
							end
						elseif (string.sub(v, 1, 5) == "group") then
							--[[
							local mem = findgroup(v)
							
							for c,d in ipairs(mem) do
								local thishere = findtype({d},x,y,nil,true)
								
								if (#thishere == 0) then
									create(d,x,y,dir,x,y,nil,nil,leveldata)
								end
							end
							]]--
						end
					end
				end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	isyou = getunitswitheffect("you",false,delthese)
	isyou2 = getunitswitheffect("you2",false,delthese)
	isyou3 = getunitswitheffect("3d",false,delthese)
	
	for i,v in ipairs(isyou2) do
		table.insert(isyou, v)
	end
	
	for i,v in ipairs(isyou3) do
		table.insert(isyou, v)
	end

    for id, unit in pairs(isyou) do
        if (unit.flags[DEAD] == false) and (delthese[unit.fixed] == nil) and (small == false) then
            local x,y = unit.values[XPOS],unit.values[YPOS]
            local keys0 = getkeys(x, y)
            for c,d0 in ipairs(keys0) do
                local d = d0[1]
                local color = d0[2][1]
                if color == "glitch" then
                    color = glitchcolor
                end
                local count = d0[2][2]
                local kind = d0[2][3]
                local counti = d0[2][4]
                if floating(d,unit.fixed,x,y) and (issafe(d,x,y) == false) then
                    local pmult,sound = checkeffecthistory("bonus")
					local c1,c2 = getcolour(d)
                    MF_particles("bonus",x,y,10 * pmult,c1,c2,1,1)
                    removalshort = sound
                    removalsound = 2
                    generaldata.values[SHAKE] = 5
                    table.insert(delthese, d)
                    if pickkeys[color] == nil then
                        pickkeys[color] = 0
                    end
                    if pickkeysi[color] == nil then
                        pickkeysi[color] = 0
                    end
                    addundo({"updatekey", color, pickkeys[color], pickkeysi[color]})
                    if (kind == "exact") then
                        if starval[color] ~= true then
                            pickkeys[color] = count
                            pickkeysi[color] = counti
                        end
                    elseif (kind == "signflip") then
                        if starval[color] ~= true then
                            pickkeys[color] = pickkeys[color] * -1
                            pickkeysi[color] = pickkeysi[color] * -1
                        end
                    elseif (kind == "star") then
                        if starval[color] ~= true then
                            addundo({"updatestar",color,"ignore"})
                            starval[color] = true
                        end
                    elseif (kind == "unstar") then
                        if starval[color] == true then
                            addundo({"updatestar",color,"ignore"})
                            starval[color] = false
                        end
                    elseif (kind == "rotor") then
                        if starval[color] ~= true then
                            local temp = pickkeys[color]
                            pickkeys[color] = -1 * pickkeysi[color]
                            pickkeysi[color] = temp
                        end
                    elseif (kind == "unrotor") then
                        if starval[color] ~= true then
                            local temp = pickkeys[color]
                            pickkeys[color] = pickkeysi[color]
                            pickkeysi[color] = -temp
                        end
                    else
                        if starval[color] ~= true then
                            pickkeys[color] = pickkeys[color] + count
                            pickkeysi[color] = pickkeysi[color] + counti
                        end
                    end
                    updateundo = true
                end
            end
        end
    end

    for id, unit in pairs(isyou) do
        if (unit.flags[DEAD] == false) and (delthese[unit.fixed] == nil) and (small == false) then
            local x,y = unit.values[XPOS],unit.values[YPOS]
            if (pickkeys["brown"] ~= nil) and (pickkeys["brown"] >= 1) then
                applybrownkeys(x,y,1)
            end
            if (pickkeys["brown"] ~= nil) and (pickkeys["brown"] <= -1) then
                applybrownkeys(x,y,-1)
            end
            if (pickkeys["red"] ~= nil) and (pickkeys["red"] >= 1) then
                doauras(x, y, 1)
            end
            if (pickkeys["green"] ~= nil) and (pickkeys["green"] >= 5) then
                doauras(x, y, 2)
            end
            if (pickkeys["blue"] ~= nil) and (pickkeys["blue"] >= 3) then
                doauras(x, y, 4)
            end
        end
    end

    delthese,doremovalsound = handledels(delthese,doremovalsound)

    isyou = getunitswitheffect("you",false,delthese)
	isyou2 = getunitswitheffect("you2",false,delthese)
	isyou3 = getunitswitheffect("3d",false,delthese)
	
	for i,v in ipairs(isyou2) do
		table.insert(isyou, v)
	end
	
	for i,v in ipairs(isyou3) do
		table.insert(isyou, v)
	end
	
	for id,unit in ipairs(isyou) do
		if (unit.flags[DEAD] == false) and (delthese[unit.fixed] == nil) then
			local x,y = unit.values[XPOS],unit.values[YPOS]
			
			if (small == false) then
				local bonus = findfeature(nil,"is","bonus")
				
				if (bonus ~= nil) then
					for a,b in ipairs(bonus) do
						if (b[1] ~= "empty") then
							local flag = findtype(b,x,y,0)
							
							if (#flag > 0) then
								for c,d in ipairs(flag) do
									if floating(d,unit.fixed,x,y) then
										local pmult,sound = checkeffecthistory("bonus")
										MF_particles("bonus",x,y,10 * pmult,4,1,1,1)
										removalshort = sound
										removalsound = 2
										MF_playsound("bonus")
										MF_bonus(1)
										addundo({"bonus",1})
										
										if (issafe(d,x,y) == false) then
											generaldata.values[SHAKE] = 5
											table.insert(delthese, d)
										end
									end
								end
							end
						end
					end
				end
				
				local ending = findfeature(nil,"is","end")
				
				if (ending ~= nil) then
					for a,b in ipairs(ending) do
						if (b[1] ~= "empty") then
							local flag = findtype(b,x,y,0)
							
							if (#flag > 0) then
								for c,d in ipairs(flag) do
									if floating(d,unit.fixed,x,y) and (generaldata.values[MODE] == 0) then
										if (generaldata.strings[WORLD] == generaldata.strings[BASEWORLD]) then
											MF_particles("unlock",x,y,10,1,4,1,1)
											MF_end(unit.fixed,d)
											break
										elseif (editor.values[INEDITOR] ~= 0) then
											local pmult = checkeffecthistory("win")
									
											MF_particles("win",x,y,10 * pmult,2,4,1,1)
											MF_end_single()
											MF_win()
											break
										else
											local pmult = checkeffecthistory("win")
											
											local mods_run = do_mod_hook("levelpack_end", {})
											
											if (mods_run == false) then
												MF_particles("win",x,y,10 * pmult,2,4,1,1)
												MF_end_single()
												MF_win()
												MF_credits(1)
											end
											break
										end
									end
								end
							end
						end
					end
				end
			end
			
			local win = findfeature(nil,"is","win")
			
			if (win ~= nil) then
				for a,b in ipairs(win) do
					if (b[1] ~= "empty") then
						local flag = findtype(b,x,y,0)
						if (#flag > 0) then
							for c,d in ipairs(flag) do
								if floating(d,unit.fixed,x,y) and (hasfeature(b[1],"is","done",d,x,y) == nil) and (hasfeature(b[1],"is","end",d,x,y) == nil) then
									local pmult = checkeffecthistory("win")
									
									MF_particles("win",x,y,10 * pmult,2,4,1,1)
									MF_win()
									break
								end
							end
						end
					end
				end
			end
		end
	end

    for id,unit in ipairs(isyou) do
		if (unit.flags[DEAD] == false) and (delthese[unit.fixed] == nil) then
			local x,y = unit.values[XPOS],unit.values[YPOS]
			
			if (small == false) then
				local inputs = findtype({"inputpoint",{}},x,y,0)
                for i, j in pairs(inputs) do
                    local unit = mmf.newObject(j)
                    local id = unit.values[ID]
                    addundo({"updatesalvage", salvaging})
                    salvaging = id
                    updateundo = true
                end
			end
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	for i,unit in ipairs(units) do
		if (inbounds(unit.values[XPOS],unit.values[YPOS],1) == false) then
			--MF_alert("DELETED!!!")
			table.insert(delthese, unit.fixed)
		end
	end
	
	delthese,doremovalsound = handledels(delthese,doremovalsound)
	
	if (small == false) then
		local iscrash = getunitswitheffect("crash",false,delthese)
		
		if (#iscrash > 0) then
			HACK_INFINITY = 200
			destroylevel("infinity")
			return
		end
	end
	
	if doremovalsound then
		setsoundname("removal",removalsound,removalshort)
	end
end

function addundo(line,uid_)
	local uid = tostring(uid_)
	if doundo then
		local currentundo = undobuffer[1]
		local text = tostring(#undobuffer) .. ", "
		
		table.insert(currentundo, 1, {})
		currentundo[1] = {}
		
		for i,v in ipairs(line) do
			table.insert(currentundo[1], v)
			text = text .. tostring(v) .. ", "
		end
		
		text = text .. uid
		
		local ename = line[1]
		
		if generaldata.flags[LOGGING] and logevents then
			local details = ""
			
			if (ename == "update") then
				details = line[2] .. ":" .. tostring(line[6]) .. ":" .. tostring(line[7]) .. ":" .. tostring(line[8])
			elseif (ename == "remove") then
				details = line[2] .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4]) .. ":" .. tostring(line[5])
			elseif (ename == "create") then
				details = line[2] .. ":" .. tostring(line[6]) .. ":" .. tostring(line[7]) .. ":" .. tostring(line[8])
			elseif (ename == "float") then
				details = line[2] .. ":" .. tostring(line[4]) .. ":" .. tostring(line[5])
			elseif (ename == "levelupdate") then
				details = tostring(line[4]) .. ":" .. tostring(line[5])
			elseif (ename == "maprotation") then
				details = tostring(line[3]) .. ":" .. tostring(line[4])
			elseif (ename == "mapcursor") then
				details = tostring(line[8]) .. ":" .. tostring(line[9]) .. ":" .. tostring(line[10])
			elseif (ename == "broken") then
				details = tostring(line[4]) .. ":" .. tostring(line[2])
			elseif (ename == "followed") then
				details = tostring(line[5]) .. ":" .. tostring(line[3])
			elseif (ename == "updatekey") then
				details = tostring(line[2]) .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4])
			elseif (ename == "updateaura") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatecolor") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatecolorspend") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "flipbrownkey") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatestar") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatelayer") then
				details = tostring(line[2]) .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4])
			elseif (ename == "updatecombolayer") then
				details = tostring(line[2]) .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4])
			elseif (ename == "updatecomboaura") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatecombocolorspend") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatecombocolor") then
				details = tostring(line[2]) .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4])
			elseif (ename == "flipcombobrownkey") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updateglitch") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updatesalvage") then
				details = tostring(line[2]) .. ":" .. tostring(line[3])
			elseif (ename == "updateglitchlock") then
				details = tostring(line[2]) .. ":" .. tostring(line[3]) .. ":" .. tostring(line[4])
			end
			
			dolog(ename,"change",details)
		end
		
		-- MF_alert(text)
	end
end

function undo()
	local result = 0
	HACK_INFINITY = 0
	logevents = false
	
	if (#undobuffer > 1) then
		result = 1
		local currentundo = undobuffer[2]
		
		-- MF_alert("Undoing: " .. tostring(#undobuffer))
		
		do_mod_hook("undoed")
		
		last_key = currentundo.key or 0
		Fixedseed = currentundo.fixedseed or 100
		
		if (currentundo ~= nil) then
			for i,line in ipairs(currentundo) do
				local style = line[1]
				
				if (style == "update") then
					local uid = line[9]
					
					if (paradox[uid] == nil) then
						local unitid = getunitid(line[9])
						
						local unit = mmf.newObject(unitid)
						
						local oldx,oldy = unit.values[XPOS],unit.values[YPOS]
						local x,y,dir = line[3],line[4],line[5]
						unit.values[XPOS] = x
						unit.values[YPOS] = y
						unit.values[DIR] = dir
						unit.values[POSITIONING] = 0
						
						updateunitmap(unitid,oldx,oldy,x,y,unit.strings[UNITNAME])
						dynamic(unitid)
						dynamicat(oldx,oldy)
						
						if (spritedata.values[CAMTARGET] == uid) then
							MF_updatevision(dir)
						end
						
						local ox = math.abs(oldx-x)
						local oy = math.abs(oldy-y)
						
						if (ox + oy == 1) and (unit.values[TILING] == 2) then
							unit.values[VISUALDIR] = ((unit.values[VISUALDIR] - 1)+4) % 4
							unit.direction = unit.values[DIR] * 8 + unit.values[VISUALDIR]
						end
						
						if (unit.strings[UNITTYPE] == "text") then
							updatecode = 1
						end
						
						local undowordunits = currentundo.wordunits
						local undowordrelatedunits = currentundo.wordrelatedunits
						
						if (#undowordunits > 0) then
							for a,b in pairs(undowordunits) do
								if (b == line[9]) then
									updatecode = 1
								end
							end
						end
						
						if (#undowordrelatedunits > 0) then
							for a,b in pairs(undowordrelatedunits) do
								if (b == line[9]) then
									updatecode = 1
								end
							end
						end
					else
						particles("hot",line[3],line[4],1,{1, 1})
					end
				elseif (style == "remove") then
					local uid = line[6]
					local baseuid = line[7] or -1
					
					if (paradox[uid] == nil) and (paradox[baseuid] == nil) then
						local x,y,dir,levelfile,levelname,vislevel,complete,visstyle,maplevel,colour,clearcolour,followed,back_init,ogname,signtext = line[3],line[4],line[5],line[8],line[9],line[10],line[11],line[12],line[13],line[14],line[15],line[16],line[17],line[18],line[19]
						local name = line[2]
						
						local unitname = ""
						local unitid = 0
						
						--MF_alert("Trying to create " .. name .. ", " .. tostring(unitreference[name]))
						unitname = unitreference[name]
						if (name == "level") and (unitreference[name] ~= "level") then
							unitname = "level"
							unitreference["level"] = "level"
							MF_alert("ALERT! Unitreference for level was wrong!")
						end
						
						unitid = MF_emptycreate(unitname,x,y)
						
						local unit = mmf.newObject(unitid)
						unit.values[ONLINE] = 1
						unit.values[XPOS] = x
						unit.values[YPOS] = y
						unit.values[DIR] = dir
						unit.values[ID] = line[6]
						unit.flags[9] = true
						
						unit.strings[U_LEVELFILE] = levelfile
						unit.strings[U_LEVELNAME] = levelname
						unit.flags[MAPLEVEL] = maplevel
						unit.values[VISUALLEVEL] = vislevel
						unit.values[VISUALSTYLE] = visstyle
						unit.values[COMPLETED] = complete
						
						unit.strings[COLOUR] = colour
						unit.strings[CLEARCOLOUR] = clearcolour
						unit.strings[UNITSIGNTEXT] = signtext or ""
						
						if (unit.className == "level") then
							MF_setcolourfromstring(unitid,colour)
						end
						
						addunit(unitid,true)
						addunitmap(unitid,x,y,unit.strings[UNITNAME])
						dynamic(unitid)
						
						unit.followed = followed
						unit.back_init = back_init
						unit.originalname = ogname
						
						if (unit.strings[UNITTYPE] == "text") then
							updatecode = 1
						end
						
						if (spritedata.values[VISION] == 1) then
							unit.x = -24
							unit.y = -24
						end
						
						local undowordunits = currentundo.wordunits
						local undowordrelatedunits = currentundo.wordrelatedunits
						
						if (#undowordunits > 0) then
							for a,b in ipairs(undowordunits) do
								if (b == line[6]) then
									updatecode = 1
								end
							end
						end
						
						if (#undowordrelatedunits > 0) then
							for a,b in ipairs(undowordrelatedunits) do
								if (b == line[6]) then
									updatecode = 1
								end
							end
						end
					else
						particles("hot",line[3],line[4],1,{1, 1})
					end
				elseif (style == "create") then
					local uid = line[3]
					local baseid = line[4]
					local source = line[5]
					
					if (paradox[uid] == nil) then
						local unitid = getunitid(line[3])
						
						local unit = mmf.newObject(unitid)
						local unitname = unit.strings[UNITNAME]
						local x,y = unit.values[XPOS],unit.values[YPOS]
						local unittype = unit.strings[UNITTYPE]
						
						unit = {}
						delunit(unitid)
						MF_remove(unitid)
						dynamicat(x,y)
						
						if (unittype == "text") then
							updatecode = 1
						end
						
						local undowordunits = currentundo.wordunits
						local undowordrelatedunits = currentundo.wordrelatedunits
						
						if (#undowordunits > 0) then
							for a,b in ipairs(undowordunits) do
								if (b == line[3]) then
									updatecode = 1
								end
							end
						end
						
						if (#undowordrelatedunits > 0) then
							for a,b in ipairs(undowordrelatedunits) do
								if (b == line[3]) then
									updatecode = 1
								end
							end
						end
					end
				elseif (style == "backset") then
					local uid = line[3]
					
					if (paradox[uid] == nil) then
						local unitid = getunitid(line[3])
						local unit = mmf.newObject(unitid)
						
						unit.back_init = line[4]
					end
				elseif (style == "done") then
					local unitid = line[7]
					--print(unitid)
					local unit = mmf.newObject(unitid)
					
					unit.values[FLOAT] = line[8]
					unit.angle = 0
					unit.values[POSITIONING] = 0
					unit.values[A] = 0
					unit.values[VISUALLEVEL] = 0
					unit.flags[DEAD] = false
					
					--print(unit.className .. ", " .. tostring(unitid) .. ", " .. tostring(line[3]) .. ", " .. unit.strings[UNITNAME])
					
					addunit(unitid,true)
					unit.originalname = line[9]
					
					if (unit.values[TILING] == 1) then
						dynamic(unitid)
					end
				elseif (style == "float") then
					local uid = line[3]
					
					if (paradox[uid] == nil) then
						local unitid = getunitid(line[3])
						
						-- K�kk� ratkaisu!
						if (unitid ~= nil) and (unitid ~= 0) then
							local unit = mmf.newObject(unitid)
							unit.values[FLOAT] = tonumber(line[4])
						end
					end
				elseif (style == "levelupdate") then
					MF_setroomoffset(line[2],line[3])
					mapdir = line[6]
				elseif (style == "maprotation") then
					maprotation = line[2]
					MF_levelrotation(maprotation)
				elseif (style == "mapdir") then
					mapdir = line[2]
				elseif (style == "mapcursor") then
					mapcursor_set(line[3],line[4],line[5],line[10])
					
					local undowordunits = currentundo.wordunits
					local undowordrelatedunits = currentundo.wordrelatedunits
					
					local unitid = getunitid(line[10])
					if (unitid ~= nil) and (unitid ~= 0) then
						local unit = mmf.newObject(unitid)
						
						if (unit.strings[UNITTYPE] == "text") then
							updatecode = 1
						end
					end
					
					if (#undowordunits > 0) then
						for a,b in pairs(undowordunits) do
							if (b == line[10]) then
								updatecode = 1
							end
						end
					end
					
					if (#undowordrelatedunits > 0) then
						for a,b in pairs(undowordrelatedunits) do
							if (b == line[10]) then
								updatecode = 1
							end
						end
					end
				elseif (style == "colour") then
					local unitid = getunitid(line[2])
					MF_setcolour(unitid,line[3],line[4])
					local unit = mmf.newObject(unitid)
					unit.values[A] = line[5]
				elseif (style == "broken") then
					local unitid = getunitid(line[3])
					local unit = mmf.newObject(unitid)
					--MF_alert(unit.strings[UNITNAME])
					unit.broken = 1 - line[2]
				elseif (style == "bonus") then
					local style = 1 - line[2]
					MF_bonus(style)
				elseif (style == "followed") then
					local unitid = getunitid(line[2])
					local unit = mmf.newObject(unitid)
					
					unit.followed = line[3]
				elseif (style == "startvision") then
					local target = line[2]
					
					if (line[2] ~= 0) and (line[2] ~= 0.5) then
						target = getunitid(line[2])
					end
					
					visionmode(0,target,true)
				elseif (style == "stopvision") then
					local target = line[2]
					
					if (line[2] ~= 0) and (line[2] ~= 0.5) then
						target = getunitid(line[2])
					end
					
					visionmode(1,target,true,{line[3],line[4],line[5]})
				elseif (style == "visiontarget") then
					local unitid = getunitid(line[2])
					
					if (spritedata.values[VISION] == 1) and (unitid ~= 0) then
						local unit = mmf.newObject(unitid)
						MF_updatevision(unit.values[DIR])
						MF_updatevisionpos(unit.values[XPOS],unit.values[YPOS])
						spritedata.values[CAMTARGET] = line[2]
					end
				elseif (style == "holder") then
					local unitid = getunitid(line[2])
					local unit = mmf.newObject(unitid)
					
					unit.holder = line[3]
				elseif (style == "updatekey") then
					pickkeys[line[2]] = tonumber(line[3])
					pickkeysi[line[2]] = tonumber(line[4])
				elseif (style == "updateaura") then
					auras[tonumber(line[2])] = tonumber(line[3])
				elseif (style == "updatecolor") then
                    local id = tonumber(line[2])
					doordata[id][1] = line[3]
                    resetdoordisplay(id)
				elseif (style == "updatecolorspend") then
                    local id = tonumber(line[2])
					doordata[id][4] = line[3]
                    resetdoordisplay(id)
                elseif (style == "flipbrownkey") then
                    local id = tonumber(line[2])
                    if (iscursed[id] == false) or (iscursed[id] == nil) then
					    iscursed[id] = true
                    else
                        iscursed[id] = false
                    end
                elseif (style == "updatestar") then
                    local color = line[2]
                    starval[color] = (not starval[color])
                elseif (style == "updatelayer") then
                    local id = tonumber(line[2])
                    layers[id] = tonumber(line[3])
                    layersi[id] = tonumber(line[4])
                elseif (style == "updatecombolayer") then
                    local sync = tonumber(line[2])
                    combodata[sync][3] = tonumber(line[3])
                    combodata[sync][4] = tonumber(line[4])
                elseif (style == "updatecomboaura") then
                    local sync = tonumber(line[2])
                    combodata[sync][2] = tonumber(line[3])
                    resetcombodisplay(sync)
                elseif (style == "updatecombocolor") then
                    local sync = tonumber(line[2])
                    local i2 = tonumber(line[3])
                    comboreq[sync][i2][1] = line[4]
                    resetcombodisplay(sync)
                elseif (style == "updatecombocolorspend") then
                    local sync = tonumber(line[2])
                    combodata[sync][1] = line[3]
                    resetcombodisplay(sync)
                elseif (style == "flipcombobrownkey") then
                    local sync = tonumber(line[2])
                    if (comboiscursed[sync] == false) or (comboiscursed[sync] == nil) then
					    comboiscursed[sync] = true
                    else
                        comboiscursed[sync] = false
                    end
                elseif (style == "updateglitch") then
                    glitchcolor = line[2]
                    resetglitchdisplays()
                elseif (style == "updatesalvage") then
                    salvaging = tonumber(line[2])
                elseif (style == "updateglitchlock") then
                    glitchlocks[tonumber(line[2])][tonumber(line[3])] = line[4]
                end
			end
		end
		
		local nextundo = undobuffer[1]
		nextundo.wordunits = {}
		nextundo.wordrelatedunits = {}
		nextundo.visiontargets = {}
		nextundo.fixedseed = Fixedseed
		
		for i,v in ipairs(currentundo.wordunits) do
			table.insert(nextundo.wordunits, v)
		end
		for i,v in ipairs(currentundo.wordrelatedunits) do
			table.insert(nextundo.wordrelatedunits, v)
		end
		
		if (#currentundo.visiontargets > 0) then
			visiontargets = {}
			for i,v in ipairs(currentundo.visiontargets) do
				table.insert(nextundo.visiontargets, v)
				
				local fix = MF_getfixed(v)
				if (fix ~= nil) then
					table.insert(visiontargets, fix)
				end
			end
		end
		
		table.remove(undobuffer, 2)
	end
	
	--MF_alert("Current fixed seed: " .. tostring(Fixedseed))
	
	do_mod_hook("undoed_after")
	logevents = true
	
	return result
end

function effectblock()
	local levelhide = nil
	
	if (featureindex["level"] ~= nil) then
		levelhide = hasfeature("level","is","hide",1)
		
		local isred = hasfeature("level","is","red",1)
		local isblue = hasfeature("level","is","blue",1)
		local isgreen = hasfeature("level","is","green",1)
		local islime = hasfeature("level","is","lime",1)
		local isyellow = hasfeature("level","is","yellow",1)
		local ispurple = hasfeature("level","is","purple",1)
		local ispink = hasfeature("level","is","pink",1)
		local isrosy = hasfeature("level","is","rosy",1)
		local isblack = hasfeature("level","is","black",1)
		local isgrey = hasfeature("level","is","grey",1)
		local issilver = hasfeature("level","is","silver",1)
		local iswhite = hasfeature("level","is","white",1)
		local isbrown = hasfeature("level","is","brown",1)
		local isorange = hasfeature("level","is","orange",1)
		local iscyan = hasfeature("level","is","cyan",1)
	
		local colours = {isred, isorange, isyellow, islime, isgreen, iscyan, isblue, ispurple, ispink, isrosy, isblack, isgrey, issilver, iswhite, isbrown}
		local ccolours = {{2,2},{2,3},{2,4},{5,3},{5,2},{1,4},{3,2},{3,1},{4,1},{4,2},{0,4},{0,1},{0,2},{0,3},{6,1}}
		
		leveldata.colours = {}
		local c1,c2 = -1,-1
		
		for a=1,#ccolours do
			if (colours[a] ~= nil) then
				local c = ccolours[a]
				
				if (#leveldata.colours == 0) then
					c1 = c[1]
					c2 = c[2]
				end
				
				table.insert(leveldata.colours, {c[1],c[2]})
			end
		end
		
		if (#leveldata.colours == 1) then
			if (c1 > -1) and (c2 > -1) then
				if (c1 == 0) and (c2 == 4) then
					MF_backcolour(c1, c2)
				else
					MF_backcolour_dim(c1, c2)
				end
			end
		elseif (#leveldata.colours == 0) then
			MF_backcolour(0, 4)
		end
	else
		MF_backcolour(0, 4)
	end
	
	local resetcolour = {}
	local updatecolour = {}
	
	for i,unit in ipairs(units) do
		unit.new = false
		
		if (levelhide == nil) then
			unit.visible = true
		else
			unit.visible = false
		end
		
		if (unit.className ~= "level") then		
			local name = unit.strings[UNITNAME]
            local id0 = unit.values[ID]
			
			local isred = hasfeature(name,"is","red",unit.fixed)
			local isblue = hasfeature(name,"is","blue",unit.fixed)
			local isyou = hasfeature(name,"is","you",unit.fixed)
			local islime = hasfeature(name,"is","lime",unit.fixed)
			local isgreen = hasfeature(name,"is","green",unit.fixed)
			local isyellow = hasfeature(name,"is","yellow",unit.fixed)
			local ispurple = hasfeature(name,"is","purple",unit.fixed)
			local ispink = hasfeature(name,"is","pink",unit.fixed)
			local isrosy = hasfeature(name,"is","rosy",unit.fixed)
			local isblack = hasfeature(name,"is","black",unit.fixed)
			local isgrey = hasfeature(name,"is","grey",unit.fixed)
			local issilver = hasfeature(name,"is","silver",unit.fixed)
			local iswhite = hasfeature(name,"is","white",unit.fixed)
			local isbrown = hasfeature(name,"is","brown",unit.fixed)
			local isorange = hasfeature(name,"is","orange",unit.fixed)
			local iscyan = hasfeature(name,"is","cyan",unit.fixed)
			
			unit.colours = {}
            local blueval = (isblue == true) or ((isyou == true) and mastermode)
            if blueval == false then
                blueval = nil
            end
            local yellowval = (isyellow == true) or ((isyou == true) and imode)
            if yellowval == false then
                yellowval = nil
            end
			
			local colours = {isred, isorange, yellowval, islime, isgreen, iscyan, blueval, ispurple, ispink, isrosy, isblack, isgrey, issilver, iswhite, isbrown}
			local ccolours = {{2,2},{2,3},{2,4},{5,3},{5,2},{1,4},{3,2},{3,1},{4,1},{4,2},{0,4},{0,1},{0,2},{0,3},{6,1}}
			
            if (id0 == salvaging) then
                colours = {nil, nil, nil, nil, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, nil}
            end

			local c1,c2,ca = -1,-1,-1
			
			unit.flags[PHANTOM] = false
			local isphantom = hasfeature(name,"is","phantom",unit.fixed)
			if (isphantom ~= nil) then
				unit.flags[PHANTOM] = true
			end
			
			for a=1,#ccolours do
				if (colours[a] ~= nil) then
					local c = ccolours[a]
					
					if (#unit.colours == 0) then
						c1 = c[1]
						c2 = c[2]
						ca = a
					end
					
					table.insert(unit.colours, c)
				end
			end
			
			if (#unit.colours == 1) then
				if (c1 > -1) and (c2 > -1) and (ca > 0) then
					MF_setcolour(unit.fixed,c1,c2)
					unit.colour = {c1,c2}
					unit.values[A] = ca
				end
			elseif (#unit.colours == 0) then
				if (unit.values[A] > 0) and (math.floor(unit.values[A]) == unit.values[A]) then
					if (unit.strings[UNITTYPE] ~= "text") or (unit.active == false) then
						setcolour(unit.fixed)
					else
						setcolour(unit.fixed,"active")
					end
					unit.values[A] = 0
				end
			else
				unit.values[A] = ca
				
				if (unit.strings[UNITTYPE] == "text") then
					local curr = (unit.currcolour % #unit.colours) + 1
					local c = unit.colours[curr]
					
					unit.colour = {c[1],c[2]}
					MF_setcolour(unit.fixed,c[1],c[2])
				end
			end
		end
	end
	
	if (levelhide == nil) then
		local ishide = findallfeature(nil,"is","hide",true)
		
		for i,unitid in ipairs(ishide) do
			local unit = mmf.newObject(unitid)
			
			unit.visible = false
		end
	end
end

function doconvert(data,extrarule_)
	local style = data[2]
	local mats2 = data[3]
	
	local unitid = data[1]
	local unit = {}
	local x,y,dir,name,id,completed,float,ogname = 0,0,0,"",0,0,0,""
	local delthis = false
	local delthis_createall = false
	local delthis_createall_ = false
	
	if (unitid ~= 2) then
		unit = mmf.newObject(unitid)
		x,y,dir,name,id,completed,ogname = unit.values[XPOS],unit.values[YPOS],unit.values[DIR],unit.strings[UNITNAME],unit.values[ID],unit.values[COMPLETED],unit.originalname
	end
	
	local cdata = {}
	cdata[1] = name
	
	if (style == "convert") then
		for a,mats2data in ipairs(mats2) do
			local mat2 = mats2data[1]
			local ingameid = mats2data[2]
			local baseingameid = mats2data[3]
			
			local unitname = ""

            if (keydata[baseingameid] ~= nil) then
                keydata[ingameid] = {keydata[baseingameid][1], keydata[baseingameid][2], keydata[baseingameid][3], keydata[baseingameid][4]}
            end
            if (doordata[baseingameid] ~= nil) then
                doordata[ingameid] = {doordata[baseingameid][1], doordata[baseingameid][2], doordata[baseingameid][3], doordata[baseingameid][4], doordata[baseingameid][5]}
            end
            if (datanames[baseingameid] ~= nil) then
                datanames[ingameid] = datanames[baseingameid]
            end
            if (auras[baseingameid] ~= nil) then
                auras[ingameid] = auras[baseingameid]
            end
            if (layers[baseingameid] ~= nil) then
                layers[ingameid] = layers[baseingameid]
            end
            if (cursed[baseingameid] ~= nil) then
                cursed[ingameid] = cursed[baseingameid]
            end
            if (combosync[baseingameid] ~= nil) then
                combosync[ingameid] = combosync[baseingameid]
            end
            if (origspecial[baseingameid] ~= nil) then
                origspecial[ingameid] = origspecial[baseingameid]
            end
            if (salvageid[baseingameid] ~= nil) then
                salvageid[ingameid] = salvageid[baseingameid]
            end
            if (glitchlocks[baseingameid] ~= nil) then
                glitchlocks[ingameid] = {}
				for i0, j0 in pairs(glitchlocks[baseingameid]) do
					glitchlocks[ingameid][i0] = j0
				end
            end
			
			if (mat2 == "revert") and (unitid ~= 2) and (ogname ~= nil) then
				local originalname = ogname
				
				if (string.len(originalname) > 0) then
					unitname = unitreference[originalname]
					mat2 = originalname
				else
					unitname = nil
				end
				
				if (source == "emptyconvert") then
					unitname = ""
					mat2 = "empty"
				end
				
				if (unitname == unit.className) then
					MF_alert("Trying to revert object to the same thing: " .. tostring(originalname))
					return
				end
			elseif (mat2 == "revert") and (unitid == 2) then
				MF_alert("Trying to revert empty")
				return
			end
			
			if (mat2 ~= "empty") and (mat2 ~= "error") and (mat2 ~= "revert") and (mat2 ~= "createall") then
				if (mats2data[1] ~= "revert") then
					unitname = unitreference[mat2]
				end
				
				if (mat2 == "level") then
					unitname = "level"
				end
				
				if (unitname == nil) then
					MF_alert("no className found for " .. mat2 .. "!")
					return
				end
				
				local newunitid = MF_emptycreate(unitname,x,y)
				local newunit = mmf.newObject(newunitid)
				
				newunit.values[ONLINE] = 1
				newunit.values[XPOS] = x
				newunit.values[YPOS] = y
				newunit.values[DIR] = dir
				newunit.values[POSITIONING] = 20
				
				newunit.values[VISUALLEVEL] = unit.values[VISUALLEVEL]
				newunit.values[VISUALSTYLE] = unit.values[VISUALSTYLE]
				newunit.values[COMPLETED] = completed
				
				newunit.strings[COLOUR] = unit.strings[COLOUR]
				newunit.strings[CLEARCOLOUR] = unit.strings[CLEARCOLOUR]
				
				if (unitname == "level") then
					newunit.values[COMPLETED] = math.max(completed, 1)
					newunit.flags[LEVEL_JUSTCONVERTED] = true
					
					if (string.len(unit.strings[LEVELFILE]) > 0) then
						newunit.values[COMPLETED] = math.max(completed, 2)
					end
					
					if (string.len(unit.strings[COLOUR]) == 0) or (string.len(unit.strings[CLEARCOLOUR]) == 0) then
						newunit.strings[COLOUR] = "1,2"
						newunit.strings[CLEARCOLOUR] = "1,3"
						MF_setcolour(newunitid,1,2)
					else
						local c = MF_parsestring(unit.strings[COLOUR])
						MF_setcolour(newunitid,c[1],c[2])
					end
					
					newunit.visible = true
				end
				
				newunit.values[ID] = ingameid
				
				newunit.strings[U_LEVELFILE] = unit.strings[U_LEVELFILE]
				newunit.strings[U_LEVELNAME] = unit.strings[U_LEVELNAME]
				newunit.flags[MAPLEVEL] = unit.flags[MAPLEVEL]
				
				newunit.values[EFFECT] = 1
				newunit.flags[9] = true
				newunit.flags[CONVERTED] = true
				
				cdata[2] = mat2
				
				addundo({"convert",cdata[1],cdata[2],ingameid,baseingameid,x,y,dir})
				addundo({"create",mat2,ingameid,baseingameid,"convert",x,y,dir})
				
				addunit(newunitid)
				addunitmap(newunitid,x,y,newunit.strings[UNITNAME])
				poscorrect(newunitid,generaldata2.values[ROOMROTATION],generaldata2.values[ZOOM],0)
				
				if (spritedata.values[VISION] == 0) or ((newunit.values[TILING] == 1) and (newunit.values[ZLAYER] <= 10) and (newunit.values[ZLAYER] >= 0)) then
					dynamic(newunitid)
				end
				
				newunit.new = false
				newunit.originalname = unit.originalname
				
				if (newunit.strings[UNITTYPE] == "text") then
					updatecode = 1
				else
					local newname = newunit.strings[UNITNAME]
					local notnewname = "not " .. newunit.strings[UNITNAME]
					
					if (featureindex["word"] ~= nil) then
						for i,v in ipairs(featureindex["word"]) do
							local rule = v[1]
							local conds = v[2]
							
							if (rule[2] == "is") and (rule[3] == "word") then
								if (rule[1] == newname) then
									updatecode = 1
									break
								elseif (unitid ~= 2) then
									if (rule[1] == unitname) then
										updatecode = 1
										break
									end
								end
								
								if (#conds > 0) then
									for a,b in ipairs(conds) do
										if (b[2] ~= nil) and (#b[2] > 0) then
											for c,d in ipairs(b[2]) do
												if (d == newname) or ((string.sub(d, 1, 4) == "not ") and (string.sub(d, 5) ~= newname)) then
													updatecode = 1
													break
												elseif (unitid ~= 2) then
													if (d == unitname) or ((string.sub(d, 1, 4) == "not ") and (string.sub(d, 5) ~= unitname)) then
														updatecode = 1
														break
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
				
				delthis = true
			elseif (mat2 == "error") then
				if (unitid ~= 2) then
					local unit = mmf.newObject(unitid)
					local x,y = unit.values[XPOS],unit.values[YPOS]
					local pmult,sound = checkeffecthistory("paradox")
					local c1,c2 = getcolour(unitid)
					MF_particles("unlock",x,y,20 * pmult,c1,c2,1,1)
					--paradox[id] = 1
				end
				
				delthis = true
			elseif (mat2 == "empty") then
				addundo({"convert",cdata[1],"empty",ingameid,baseingameid,x,y,dir})
				updateunitmap(unitid,x,y,x,y,unit.strings[UNITNAME])
				delthis = true
				
				local tileid = x + y * roomsizex
				if (emptydata[tileid] == nil) then
					emptydata[tileid] = {}
				end
				
				emptydata[tileid]["conv"] = true
			elseif (mat2 == "createall") then
				delthis_createall = createall_single(unitid)
				delthis = delthis_createall
				delthis_createall_ = true
			end
		end
		
		if delthis_createall_ and (delthis_createall == false) and delthis then
			delthis = false
		end
		
		if delthis and (unit.flags[DEAD] == false) then
			addundo({"remove",unit.strings[UNITNAME],unit.values[XPOS],unit.values[YPOS],unit.values[DIR],unit.values[ID],unit.values[ID],unit.strings[U_LEVELFILE],unit.strings[U_LEVELNAME],unit.values[VISUALLEVEL],unit.values[COMPLETED],unit.values[VISUALSTYLE],unit.flags[MAPLEVEL],unit.strings[COLOUR],unit.strings[CLEARCOLOUR],unit.followed,unit.back_init,unit.originalname,unit.strings[UNITSIGNTEXT]})
			
			if (unit.strings[UNITTYPE] == "text") then
				updatecode = 1
			end
			
			delunit(unitid)
			dynamic(unitid)
			MF_specialremove(unitid,2)
		end
	elseif (style == "emptyconvert") then
		for a,mats2data in ipairs(mats2) do
			local mat2 = mats2data[1]
			local i = mats2data[2]
			local j = mats2data[3]
			
			if (mat2 ~= "createall") and (mat2 ~= "error") then
				local unitname = unitreference[mat2]
				local newunitid = MF_emptycreate(unitname,i,j)
				local newunit = mmf.newObject(newunitid)
				
				cdata[1] = "empty"
				
				local id = newid()
				local dir = emptydir(i,j)
				
				if (dir == 4) then
					dir = fixedrandom(0,3)
				end
				
				newunit.values[ONLINE] = 1
				newunit.values[XPOS] = i
				newunit.values[YPOS] = j
				newunit.values[DIR] = dir
				newunit.values[ID] = id
				newunit.values[EFFECT] = 1
				newunit.flags[9] = true
				newunit.flags[CONVERTED] = true
				
				cdata[2] = mat2
				addundo({"convert",cdata[1],cdata[2],id,id,i,j,dir})
				addundo({"create",mat2,id,-1,"emptyconvert",i,j,dir})
				
				addunit(newunitid)
				addunitmap(newunitid,i,j,newunit.strings[UNITNAME])
				dynamic(newunitid)
				
				newunit.originalname = "empty"
				
				local tileid = i + j * roomsizex
				if (emptydata[tileid] == nil) then
					emptydata[tileid] = {}
				end
				
				emptydata[tileid]["conv"] = true
				
				if (newunit.strings[UNITTYPE] == "text") then
					updatecode = 1
				else
					if (featureindex["word"] ~= nil) then
						for i,v in ipairs(featureindex["word"]) do
							local rule = v[1]
							if (rule[1] == newunit.strings[UNITNAME]) then
								updatecode = 1
							elseif (unitid ~= 2) then
								if (rule[1] == unit.strings[UNITNAME]) then
									updatecode = 1
								end
							end
						end
					end
				end
			elseif (mat2 == "createall") then
				createall_single(2,nil,i,j)
			end
		end
	end
end

function effects(timer)
	doeffect(timer,nil,"win","unlock",1,2,20,{2,4})
	doeffect(timer,nil,"best","unlock",6,30,2,{2,4})
	doeffect(timer,nil,"tele","glow",1,5,20,{1,4})
	doeffect(timer,nil,"hot","hot",1,80,10,{0,1})
	doeffect(timer,nil,"bonus","bonus",1,2,20,{4,1})
	doeffect(timer,nil,"wonder","wonder",1,10,5,{0,3})
	doeffect(timer,nil,"sad","tear",1,2,20,{3,2})
	doeffect(timer,nil,"sleep","sleep",1,2,60,{3,2})
	doeffect(timer,nil,"broken","error",3,10,8,{2,2})
	doeffect(timer,nil,"pet","pet",1,0,50,{3,1},"nojitter")
    if (pickkeys["red"] ~= nil) and (pickkeys["red"] >= 1) then
        doeffect(timer,nil,"you","unlock",1,2,20,{2,2})
    end
    if (pickkeys["green"] ~= nil) and (pickkeys["green"] >= 5) then
        doeffect(timer,nil,"you","unlock",1,2,20,{5,2})
    end
    if (pickkeys["blue"] ~= nil) and (pickkeys["blue"] >= 3) then
        doeffect(timer,nil,"you","unlock",1,2,20,{4,4})
    end
	
	doeffect(timer,nil,"power","electricity",2,5,8,{2,4})
	doeffect(timer,nil,"power2","electricity",2,5,8,{5,4})
	doeffect(timer,nil,"power3","electricity",2,5,8,{4,4})
	--doeffect(timer,"play",nil,"music",1,2,30,{0,3})
	
	local rnd = math.random(2,4)
	doeffect(timer,nil,"end","unlock",1,1,10,{1,rnd},"inwards")
	--rnd = math.random(0,2)
	--doeffect(timer,"melt","unlock",1,1,10,{4,rnd},"inwards")
	
	do_mod_hook("effect_always")
end

function movecommand(ox,oy,dir_,playerid_,dir_2,no3d_)
	statusblock(nil,nil,true)
	movelist = {}
	local debug_moves = 0
	
	local take = 1
	local takecount = 8
	local finaltake = false
	local no3d = no3d_ or false
	local playerid = playerid_ or 1
	
	local still_moving = {}
	
	local levelpush = -1
	local levelpull = -1
	local levelmovedir = dir_
	
	local levelmove = {}
	local levelmove2 = {}
	
	if (playerid == 1) then
		levelmove = findfeature("level","is","you")
	elseif (playerid == 2) then
		levelmove = findfeature("level","is","you2")
		
		if (levelmove == nil) then
			levelmove = findfeature("level","is","you")
		end
	elseif (playerid == 3) then
		levelmove = findfeature("level","is","you") or {}
		levelmove2 = findfeature("level","is","you2")
		
		if (#levelmove > 0) and (dir_ ~= nil) then
			levelmovedir = dir_
		elseif (levelmove2 ~= nil) and (dir_ ~= nil) then
			levelmovedir = dir_
		elseif (dir_2 ~= nil) then
			levelmovedir = dir_2
		end
		
		if (levelmove2 ~= nil) then
			for i,v in ipairs(levelmove2) do
				table.insert(levelmove, v)
			end
		end
		
		if (#levelmove == 0) then
			levelmove = nil
		end
	end
	
	if (levelmove ~= nil) then
		local valid = false
		
		for i,v in ipairs(levelmove) do
			if (valid == false) and testcond(v[2],1) then
				valid = true
			end
		end
		
		if (featureindex["reverse"] ~= nil) then
			levelmovedir = reversecheck(1,levelmovedir)
		end
		
		if cantmove("level",1,levelmovedir) then
			valid = false
		end
		
		if valid then
			local ndrs = ndirs[levelmovedir + 1]
			local ox,oy = ndrs[1],ndrs[2]
			
			if (isstill(1,nil,nil,levelmovedir) == false) then
				addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,levelmovedir})
				MF_scrollroom(ox * tilesize,oy * tilesize)
			else
				addundo({"levelupdate",Xoffset,Yoffset,Xoffset,Yoffset,mapdir,levelmovedir})
			end
			
			if (levelmovedir ~= 4) then
				mapdir = levelmovedir
			end
			updateundo = true
		end
	end
	
	while (take <= takecount) or finaltake do
		local moving_units = {}
		local been_seen = {}
		local skiptake = false
		
		if (finaltake == false) then
			if (take == 1) then
				local players = {}
				local players2 = {}
				local players3 = {}
				local empty = {}
				local empty2 = {}
				local empty3 = {}
				
				if (playerid == 1) then
					players,empty = findallfeature(nil,"is","you")
				elseif (playerid == 2) then
					players,empty = findallfeature(nil,"is","you2")
					
					if (#players == 0) then
						players,empty = findallfeature(nil,"is","you")
					end
				elseif (playerid == 3) then
					players,empty = findallfeature(nil,"is","you")
					players2,empty2 = findallfeature(nil,"is","you2")
					
					for i,v in ipairs(players2) do
						table.insert(players, v)
					end
					
					for i,v in ipairs(empty2) do
						table.insert(empty, v)
					end
				end
				
				local fdir = 4
				
				for i,v in ipairs(players) do
					local sleeping = false
					
					fdir = dir_
					
					if (playerid == 3) then
						if (i > #players - #players2) then
							fdir = dir_2
						end
					end
					
					if (v ~= 2) then
						local unit = mmf.newObject(v)
						
						local unitname = getname(unit)
						local sleep = hasfeature(unitname,"is","sleep",v)
						local still = cantmove(unitname,v,fdir)
						
						if (sleep ~= nil) then
							sleeping = true
						elseif still then
							sleeping = true
							
							if (fdir ~= 4) then
								updatedir(v, fdir)
							end
						else
							
							if (fdir ~= 4) then
								updatedir(v, fdir)
							end
						end
					else
						local thisempty = empty[i]
						
						for a,b in pairs(thisempty) do
							local x = a % roomsizex
							local y = math.floor(a / roomsizex)
							
							local sleep = hasfeature("empty","is","sleep",2,x,y)
							local still = cantmove("empty",2,fdir,x,y)
							
							if (sleep ~= nil) or still then
								thisempty[a] = nil
							end
						end
					end
					
					if (sleeping == false) and (fdir ~= 4) then
						if (been_seen[v] == nil) then
							local x,y = -1,-1
							if (v ~= 2) then
								local unit = mmf.newObject(v)
								x,y = unit.values[XPOS],unit.values[YPOS]
								
								table.insert(moving_units, {unitid = v, reason = "you", state = 0, moves = 1, dir = fdir, xpos = x, ypos = y})
								been_seen[v] = #moving_units
							else
								local thisempty = empty[i]
								
								for a,b in pairs(thisempty) do
									x = a % roomsizex
									y = math.floor(a / roomsizex)
								
									table.insert(moving_units, {unitid = 2, reason = "you", state = 0, moves = 1, dir = fdir, xpos = x, ypos = y})
									been_seen[v] = #moving_units
								end
							end
						else
							local id = been_seen[v]
							local this = moving_units[id]
							--this.moves = this.moves + 1
						end
					end
				end
				
				fdir = 4
				
				if (featureindex["3d"] ~= nil) and (spritedata.values[CAMTARGET] ~= 0) and (spritedata.values[CAMTARGET] ~= 0.5) and (no3d == false) then
					local sleeping = false
					local domove = false
					local turndir = 0
					local ox,oy = 0,0
					
					local v = MF_getfixed(spritedata.values[CAMTARGET]) or 0
					
					if (v ~= 2) and (v ~= 0) then
						local unit = mmf.newObject(v)
						
						local udir = unit.values[DIR]
						local ndrs = ndirs[udir + 1]
						ox,oy = ndrs[1],ndrs[2]
						
						if (dir_ == 1) then
							domove = true
						elseif (dir_ == 0) then
							turndir = -1
						elseif (dir_ == 2) then
							turndir = 1
						end
						
						fdir = (udir + turndir + 4) % 4
						
						local unitname = getname(unit)
						local sleep = hasfeature(unitname,"is","sleep",v)
						local still = cantmove(unitname,v,fdir)
						
						if (sleep ~= nil) then
							sleeping = true
						elseif still then
							sleeping = true
							
							if (fdir ~= 4) then
								updatedir(v, fdir)
							end
						else
							if (fdir ~= 4) then
								updatedir(v, fdir)
							end
						end
					
						if (sleeping == false) and (fdir ~= 4) and domove then
							if (been_seen[v] == nil) then
								local x,y = -1,-1
								if (v ~= 2) then
									local unit = mmf.newObject(v)
									x,y = unit.values[XPOS],unit.values[YPOS]
									
									table.insert(moving_units, {unitid = v, reason = "you", state = 0, moves = 1, dir = fdir, xpos = x, ypos = y})
									been_seen[v] = #moving_units
								end
							else
								local id = been_seen[v]
								local this = moving_units[id]
								--this.moves = this.moves + 1
							end
						end
					end
				end
			end
			
			if (take == 2) then
				local movers,mempty = findallfeature(nil,"is","move")
				moving_units,been_seen = add_moving_units("move",movers,moving_units,been_seen,mempty)
				
				local amovers,aempty = findallfeature(nil,"is","auto")
				moving_units,been_seen = add_moving_units("auto",amovers,moving_units,been_seen,aempty)
				
				local chillers,cempty = findallfeature(nil,"is","chill")
				moving_units,been_seen = add_moving_units("chill",chillers,moving_units,been_seen,cempty)
			elseif (take == 3) then
				local nudges1,nempty1 = findallfeature(nil,"is","nudgeright")
				moving_units,been_seen = add_moving_units("nudgeright",nudges1,moving_units,been_seen,nempty1)
				
				if (#moving_units == 0) then
					skiptake = true
				end
			elseif (take == 4) then
				local nudges2,nempty2 = findallfeature(nil,"is","nudgeup")
				moving_units,been_seen = add_moving_units("nudgeup",nudges2,moving_units,been_seen,nempty2)
				
				if (#moving_units == 0) then
					skiptake = true
				end
			elseif (take == 5) then
				local nudges3,nempty3 = findallfeature(nil,"is","nudgeleft")
				moving_units,been_seen = add_moving_units("nudgeleft",nudges3,moving_units,been_seen,nempty3)
				
				if (#moving_units == 0) then
					skiptake = true
				end
			elseif (take == 6) then
				local nudges4,nempty4 = findallfeature(nil,"is","nudgedown")
				moving_units,been_seen = add_moving_units("nudgedown",nudges4,moving_units,been_seen,nempty4)
				
				if (#moving_units == 0) then
					skiptake = true
				end
			elseif (take == 7) then
				local fears = getunitverbtargets("fear")
				
				for i,v in ipairs(fears) do
					local fearname = v[1]
					local fearlist = v[2]
					
					for a,b in ipairs(fearlist) do
						local sleeping = false
						local uid = b[1]
						local feartargets = b[2]
						local valid,feardir = false,4
						local amount = #feartargets
						
						if (fearname ~= "empty") then
							valid,feardir,amount = findfears(uid,feartargets)
						else
							local x = math.floor(uid % roomsizex)
							local y = math.floor(uid / roomsizex)
							valid,feardir = findfears(2,feartargets,x,y)
						end
						
						if valid and (amount > 0) then
							if (fearname ~= "empty") then
								local unit = mmf.newObject(uid)
							
								local unitname = getname(unit)
								local sleep = hasfeature(unitname,"is","sleep",uid)
								local still = cantmove(unitname,uid,feardir)
								
								if (sleep ~= nil) then
									sleeping = true
								elseif still then
									sleeping = true
									updatedir(uid,feardir)
								else
									updatedir(uid,feardir)
								end
							else
								local x = uid % roomsizex
								local y = math.floor(uid / roomsizex)
								
								local sleep = hasfeature("empty","is","sleep",2,x,y)
								local still = cantmove("empty",2,feardir,x,y)
								
								if (sleep ~= nil) or still then
									sleeping = true
								end
							end
							
							local bsid = uid
							if (fearname == "empty") then
								bsid = uid + 200
							end
							
							if (sleeping == false) then
								if (been_seen[bsid] == nil) then
									local x,y = -1,-1
									if (fearname ~= "empty") then
										local unit = mmf.newObject(uid)
										x,y = unit.values[XPOS],unit.values[YPOS]
										
										table.insert(moving_units, {unitid = uid, reason = "fear", state = 0, moves = amount, dir = feardir, xpos = x, ypos = y})
										been_seen[bsid] = #moving_units
									else
										x = uid % roomsizex
										y = math.floor(uid / roomsizex)
									
										table.insert(moving_units, {unitid = 2, reason = "fear", state = 0, moves = amount, dir = feardir, xpos = x, ypos = y})
										been_seen[bsid] = #moving_units
									end
								else
									local id = been_seen[bsid]
									local this = moving_units[id]
									this.moves = this.moves + 1
								end
							end
						end
					end
				end
			elseif (take == 8) then
				local shifts = findallfeature(nil,"is","shift",true)
				
				for i,v in ipairs(shifts) do
					if (v ~= 2) then
						local affected = {}
						local unit = mmf.newObject(v)
						
						local x,y = unit.values[XPOS],unit.values[YPOS]
						local tileid = x + y * roomsizex
						
						if (unitmap[tileid] ~= nil) then
							if (#unitmap[tileid] > 1) then
								for a,b in ipairs(unitmap[tileid]) do
									if (b ~= v) and floating(b,v,x,y) then
									
										--updatedir(b, unit.values[DIR])
										
										if (isstill_or_locked(b,x,y,unit.values[DIR]) == false) then
											if (been_seen[b] == nil) then
												table.insert(moving_units, {unitid = b, reason = "shift", state = 0, moves = 1, dir = unit.values[DIR], xpos = x, ypos = y})
												been_seen[b] = #moving_units
											else
												local id = been_seen[b]
												local this = moving_units[id]
												this.moves = this.moves + 1
											end
										end
									end
								end
							end
						end
					end
				end
				
				local levelshift = findfeature("level","is","shift")
				
				if (levelshift ~= nil) then
					local leveldir = mapdir
					local valid = false
					
					for a,b in ipairs(levelshift) do
						if (valid == false) and testcond(b[2],1) then
							valid = true
						end
					end
					
					if valid then
						for a,unit in ipairs(units) do
							local x,y = unit.values[XPOS],unit.values[YPOS]
							
							if floating_level(unit.fixed) then
								updatedir(unit.fixed, leveldir)
								
								if (isstill_or_locked(unit.fixed,x,y,leveldir) == false) and (issleep(unit.fixed,x,y) == false) then
									table.insert(moving_units, {unitid = unit.fixed, reason = "shift", state = 0, moves = 1, dir = unit.values[DIR], xpos = x, ypos = y})
								end
							end
						end
					end
				end
			end
		else
			for i,data in ipairs(still_moving) do
				if (data.unitid ~= 2) then
					local unit = mmf.newObject(data.unitid)
					
					table.insert(moving_units, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = unit.values[DIR], xpos = unit.values[XPOS], ypos = unit.values[YPOS]})
				else
					-- MF_alert("Still moving: " .. tostring(data.xpos) .. ", " .. tostring(data.ypos) .. ", " .. tostring(data.moves))
					table.insert(moving_units, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = data.dir, xpos = data.xpos, ypos = data.ypos})
				end
			end
			
			still_moving = {}
		end
		
		local unitcount = #moving_units
		local done = false
		local state = 0
		
		if skiptake then
			done = true
		end
		
		while (done == false) and (skiptake == false) and (debug_moves < movelimit) do
			local smallest_state = 99
			local delete_moving_units = {}
			
			for i,data in ipairs(moving_units) do
				local solved = false
				local skipthis = false
				smallest_state = math.min(smallest_state,data.state)
				
				if (data.unitid == 0) then
					solved = true
				end
				
				if (data.state == state) and (data.moves > 0) and (data.unitid ~= 0) then
					local unit = {}
					local dir,name = 4,""
					local x,y = data.xpos,data.ypos
					local holder = 0
					
					if (data.unitid ~= 2) then
						unit = mmf.newObject(data.unitid)
						dir = unit.values[DIR]
						name = getname(unit)
						x,y = unit.values[XPOS],unit.values[YPOS]
						holder = unit.holder or 0
					else
						dir = data.dir
						name = "empty"
					end
					
					debug_moves = debug_moves + 1
					
					--MF_alert(name .. " (" .. tostring(data.unitid) .. ") doing " .. data.reason .. ", take " .. tostring(take) .. ", state " .. tostring(state) .. ", moves " .. tostring(data.moves) .. ", dir " .. tostring(dir))
					
					if (x ~= -1) and (y ~= -1) and (holder == 0) then
						local result = -1
						solved = false
						
						if (state == 0) then
							if (data.unitid == 2) and (((data.reason == "move") and (dir == 4)) or (data.reason == "chill")) then
								data.dir = fixedrandom(0,3)
								dir = data.dir
								
								if cantmove(name,data.unitid,dir,x,y) then
									skipthis = true
								end
							end
						elseif (state == 3) then
							if ((data.reason == "move") or (data.reason == "chill")) then
								local newdir_ = rotate(dir)
								
								if (cantmove(name,data.unitid,newdir_,x,y) == false) then
									dir = newdir_
								end
								
								if (data.unitid ~= 2) and (unit.flags[DEAD] == false) then
									updatedir(data.unitid, newdir_)
									--unit.values[DIR] = dir
									
									if cantmove(name,data.unitid,newdir_,x,y) then
										skipthis = true
									end
								end
							end
						end
						
						if (state == 0) and (data.reason == "shift") and (data.unitid ~= 2) then
							updatedir(data.unitid, data.dir)
							dir = data.dir
						end
						
						if (dir == 4) then
							dir = fixedrandom(0,3)
						end
						
						local olddir = dir
						local returnolddir = false
						
						if (data.reason == "nudgeright") then
							dir = 0
							returnolddir = true
						elseif (data.reason == "nudgeup") then
							dir = 1
							returnolddir = true
						elseif (data.reason == "nudgeleft") then
							dir = 2
							returnolddir = true
						elseif (data.reason == "nudgedown") then
							dir = 3
							returnolddir = true
						end
						
						if (featureindex["reverse"] ~= nil) then
							local revdir = reversecheck(data.unitid,dir,x,y)
							if (revdir ~= dir) then
								dir = revdir
								returnolddir = true
							end
						end
						
						--MF_alert(data.reason)
						
						local newdir = dir
						
						local ndrs = ndirs[dir + 1]
						
						if (ndrs == nil) then
							MF_alert("dir is invalid: " .. tostring(dir) .. ", " .. tostring(name))
						end
						
						local ox,oy = ndrs[1],ndrs[2]
						local pushobslist = {}
						
						local obslist,allobs,specials = check(data.unitid,x,y,dir,false,data.reason)
						local pullobs,pullallobs,pullspecials = check(data.unitid,x,y,dir,true,data.reason)
						
						if returnolddir then
							dir = olddir
						end
						
						local swap = hasfeature(name,"is","swap",data.unitid,x,y)
						local still = cantmove(name,data.unitid,newdir,x,y)
						
						if returnolddir then
							dir = newdir
							
							--MF_alert(tostring(olddir) .. ", " .. tostring(newdir))
						end
						
						for c,obs in pairs(obslist) do
							if (solved == false) then
								if (obs == 0) then
									if (state == 0) then
										result = math.max(result, 0)
									else
										result = math.max(result, 0)
									end
								elseif (obs == -1) then
									result = math.max(result, 2)
									
									local levelpush_ = findfeature("level","is","push")
									
									if (levelpush_ ~= nil) then
										for e,f in ipairs(levelpush_) do
											if testcond(f[2],1) then
												levelpush = dir
											end
										end
									end
								else
									if (swap == nil) or still then
										if (#allobs == 0) then
											obs = 0
										end
										
										if (obs == 1) then
											local thisobs = allobs[c]
											local solid = true
											
											for f,g in pairs(specials) do
												if (g[1] == thisobs) and (g[2] == "weak") then
													solid = false
													obs = 0
													result = math.max(result, 0)
												end
											end
											
											if solid then
												if (state < 2) then
													data.state = math.max(data.state, 2)
													result = math.max(result, 2)
												else
													result = math.max(result, 2)
												end
											end
										else
											if (state < 1) then
												data.state = math.max(data.state, 1)
												result = math.max(result, 1)
											else
												table.insert(pushobslist, obs)
												result = math.max(result, 1)
											end
										end
									else
										result = math.max(result, 0)
									end
								end
							end
						end
						
						if (skipthis == false) then
							local result_check = false
							
							while (result_check == false) and (solved == false) do
								if (result == 0) then
									if (state > 0) then
										for j,jdata in pairs(moving_units) do
											if (jdata.state >= 2) and (jdata.state ~= 10) then
												jdata.state = 0
											end
										end
									end
									
									table.insert(movelist, {data.unitid,ox,oy,olddir,specials,x,y})
									if (data.unitid == 2) and (data.moves > 1) then
										data.xpos = x + ox
										data.ypos = y + oy
										data.dir = dir
									end
									--move(data.unitid,ox,oy,dir,specials)
									
									local swapped = {}
									
									if (swap ~= nil) and (still == false) then
										for a,b in ipairs(allobs) do
											if (b ~= -1) and (b ~= 2) and (b ~= 0) then
												local swapunit = mmf.newObject(b)
												local swapname = getname(swapunit)
												
												local obsstill = hasfeature(swapname,"is","still",b,x+ox,y+oy)
												
												if (obsstill == nil) then
													addaction(b,{"update",x,y,nil})
													swapped[b] = 1
												end
											end
										end
									end
									
									local swaps = findfeatureat(nil,"is","swap",x+ox,y+oy,{"still"})
									if (swaps ~= nil) then
										for a,b in ipairs(swaps) do
											if (swapped[b] == nil) and (b ~= 2) then
												addaction(b,{"update",x,y,nil})
											end
										end
									end
									
									local finalpullobs = {}
									
									for c,pobs in ipairs(pullobs) do
										if (pobs < -1) or (pobs > 1) then
											local paobs = pullallobs[c]
											local hm = 0
											
											if (paobs ~= 2) then
												hm = trypush(paobs,ox,oy,dir,true,x,y,data.reason,data.unitid)
											else
												hm = trypush(paobs,ox,oy,dir,true,x-ox,y-oy,data.reason,data.unitid)
											end
											
											if (hm == 0) then
												table.insert(finalpullobs, paobs)
											end
										elseif (pobs == -1) then
											local levelpull_ = findfeature("level","is","pull")
										
											if (levelpull_ ~= nil) then
												for e,f in ipairs(levelpull_) do
													if testcond(f[2],1) then
														levelpull = dir
													end
												end
											end
										end
									end
									
									for c,pobs in ipairs(finalpullobs) do
										pushedunits = {}
										
										if (pobs ~= 2) then
											dopush(pobs,ox,oy,dir,true,x,y,data.reason,data.unitid)
										else
											dopush(pobs,ox,oy,dir,true,x-ox,y-oy,data.reason,data.unitid)
										end
									end
									
									solved = true
								elseif (result == 1) then
									if (state < 1) then
										data.state = math.max(data.state, 1)
										result_check = true
									else
										local finalpushobs = {}
										
										for c,pushobs in ipairs(pushobslist) do
											local hm = 0
											if (pushobs ~= 2) then
												hm = trypush(pushobs,ox,oy,dir,false,x,y,data.reason)
											else
												hm = trypush(pushobs,ox,oy,dir,false,x+ox,y+oy,data.reason)
											end
											
											if (hm == 0) then
												table.insert(finalpushobs, pushobs)
											elseif (hm == 1) or (hm == -1) then
												result = math.max(result, 2)
											else
												MF_alert("HOO HAH")
												return
											end
										end
										
										if (result == 1) then
                                            for i0, j0 in pairs(specials) do
                                                local b = j0[1]
                                                local reason = j0[2]
                                                local unitid = data.unitid
                                                local bunit = mmf.newObject(b)
                                                local bx,by = bunit.values[XPOS],bunit.values[YPOS]
                                                if (reason == "lock3") then
                                                    mastermode = false
                                                    local valid = true
                                                    local soundshort = ""
                                                    
                                                    if (b ~= 2) then
                                                        
                                                        if bunit.flags[DEAD] then
                                                            valid = false
                                                        end
                                                    end
                                                    
                                                    if (unitid ~= 2) and unit.flags[DEAD] then
                                                        valid = false
                                                    end
                                                    
                                                    if valid then
                                                        local pmult = 1.0
                                
                                                        soundshort = sound
                                                        MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
                                                        generaldata.values[SHAKE] = 8
                                                    end
                                                    setsoundname("turn",7,soundshort)
                                                    local color = j0[3][1]
                                                    local count = j0[3][2]
                                                    local counti = j0[3][4]
                                                    local bid = bunit.values[ID]
                                                    addundo({"updatekey", color, pickkeys[color], pickkeysi[color]})
                                                    if starval[color] ~= true then
                                                        pickkeys[color] = pickkeys[color] - count
                                                        pickkeysi[color] = pickkeysi[color] - counti
                                                    end
                                                    if layers[bid] ~= nil then
                                                        addundo({"updatelayer", bid, layers[bid], layersi[bid]})
                                                        layers[bid] = j0[3][3]
                                                        layersi[bid] = j0[3][5]
                                                    end
                                                    if (combosync[bid] ~= nil) and (combodata[combosync[bid]][3] ~= nil) then
                                                        addundo({"updatecombolayer", combosync[bid], combodata[combosync[bid]][3], combodata[combosync[bid]][4]})
                                                        combodata[combosync[bid]][3] = j0[3][3]
                                                        combodata[combosync[bid]][4] = j0[3][5]
                                                    end
                                                    updateundo = true
                                                end
                                            end
											for c,pushobs in ipairs(finalpushobs) do
												pushedunits = {}
												
												if (pushobs ~= 2) then
													dopush(pushobs,ox,oy,dir,false,x,y,data.reason)
												else
													dopush(pushobs,ox,oy,dir,false,x+ox,y+oy,data.reason)
												end
											end
											result = 0
										end
									end
								elseif (result == 2) then
                                    if (state > 2) then
                                        for i0, j0 in pairs(specials) do
                                            local b = j0[1]
                                            local reason = j0[2]
                                            local unitid = data.unitid
                                            local bunit = mmf.newObject(b)
                                            local bx,by = bunit.values[XPOS],bunit.values[YPOS]
                                            if (reason == "lock3") then
                                                mastermode = false
                                                local valid = true
                                                local soundshort = ""
                                                
                                                if (b ~= 2) then
                                                    
                                                    if bunit.flags[DEAD] then
                                                        valid = false
                                                    end
                                                end
                                                
                                                if (unitid ~= 2) and unit.flags[DEAD] then
                                                    valid = false
                                                end
                                                
                                                if valid then
                                                    local pmult = 1.0
                            
                                                    soundshort = sound
                                                    MF_particles("unlock",bx,by,15 * pmult,2,4,1,1)
                                                    generaldata.values[SHAKE] = 8
                                                end
                                                setsoundname("turn",7,soundshort)
                                                local color = j0[3][1]
                                                local count = j0[3][2]
                                                local counti = j0[3][4]
                                                local bid = bunit.values[ID]
                                                addundo({"updatekey", color, pickkeys[color], pickkeysi[color]})
                                                if starval[color] ~= true then
                                                    pickkeys[color] = pickkeys[color] - count
                                                    pickkeysi[color] = pickkeysi[color] - counti
                                                end
                                                if layers[bid] ~= nil then
                                                    addundo({"updatelayer", bid, layers[bid], layersi[bid]})
                                                    layers[bid] = j0[3][3]
                                                    layersi[bid] = j0[3][5]
                                                end
                                                if (combosync[bid] ~= nil) and (combodata[combosync[bid]][3] ~= nil) then
                                                    addundo({"updatecombolayer", combosync[bid], combodata[combosync[bid]][3], combodata[combosync[bid]][4]})
                                                    combodata[combosync[bid]][3] = j0[3][3]
                                                    combodata[combosync[bid]][4] = j0[3][5]
                                                end
                                                updateundo = true
                                            end
                                        end
                                    end
									if (state < 2) then
										data.state = math.max(data.state, 2)
										result_check = true
									else
										if (state < 3) then
											data.state = math.max(data.state, 3)
											result_check = true
										else
											if ((data.reason == "move") or (data.reason == "chill")) and (state < 4) then
												data.state = math.max(data.state, 4)
												result_check = true
											else
												local weak = hasfeature(name,"is","weak",data.unitid,x,y)
												
												if (weak ~= nil) and (issafe(data.unitid,x,y) == false) then
													delete(data.unitid,x,y)
													generaldata.values[SHAKE] = 3
													
													local pmult,sound = checkeffecthistory("weak")
													MF_particles("destroy",x,y,5 * pmult,0,3,1,1)
													setsoundname("removal",1,sound)
													data.moves = 1
												end
												solved = true
											end
										end
									end
								else
									result_check = true
								end
							end
						else
							solved = true
						end
					else
						solved = true
					end
				end
				
				if solved then
					data.moves = data.moves - 1
					
					if (state > 0) then
						data.state = 10
					end
					
					-- MF_alert("(" .. tostring(data.unitid) .. ") solved, " .. data.reason .. ", t " .. tostring(take) .. ", s " .. tostring(data.state) .. ", m " .. tostring(data.moves) .. ", " .. tostring(data.xpos) .. ", " .. tostring(data.ypos))
					
					if (data.moves == 0) then
						--MF_alert(tunit.strings[UNITNAME] .. " - removed from queue")
						table.insert(delete_moving_units, i)
					else
						table.insert(still_moving, {unitid = data.unitid, reason = data.reason, state = data.state, moves = data.moves, dir = data.dir, xpos = data.xpos, ypos = data.ypos})
						--MF_alert(tunit.strings[UNITNAME] .. " - removed from queue")
						table.insert(delete_moving_units, i)
					end
				end
			end
			
			local deloffset = 0
			for i,v in ipairs(delete_moving_units) do
				local todel = v - deloffset
				table.remove(moving_units, todel)
				deloffset = deloffset + 1
			end
			
			if (#movelist > 0) then
				for i,data in ipairs(movelist) do
					move(data[1],data[2],data[3],data[4],data[5],nil,nil,data[6],data[7])
				end
			end
			
			movelist = {}
			
			if (smallest_state > state) then
				state = state + 1
			else
				state = smallest_state
			end
			
			if (#moving_units == 0) then
				doupdate()
				done = true
			else
				movemap = {}
			end
		end
		
		if (debug_moves >= movelimit) then
			HACK_INFINITY = 200
			destroylevel("toocomplex")
			return
		end

		if (#still_moving > 0) then
			finaltake = true
			moving_units = {}
		else
			finaltake = false
		end
		
		if (finaltake == false) then
			take = take + 1
		end
	end
	
	if (levelpush >= 0) then
		local ndrs = ndirs[levelpush + 1]
		local ox,oy = ndrs[1],ndrs[2]
		
		addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,levelpush})
		
		mapdir = levelpush
		
		MF_scrollroom(ox * tilesize,oy * tilesize)
		updateundo = true
	end
	
	if (levelpull >= 0) then
		local ndrs = ndirs[levelpull + 1]
		local ox,oy = ndrs[1],ndrs[2]
		
		addundo({"levelupdate",Xoffset,Yoffset,Xoffset + ox * tilesize,Yoffset + oy * tilesize,mapdir,levelpull})
		
		mapdir = levelpull
		
		MF_scrollroom(ox * tilesize,oy * tilesize)
		updateundo = true
	end
	
	if (HACK_MOVES >= 10000) then
		HACK_MOVES = 0
		HACK_INFINITY = 200
		destroylevel("infinity")
		return
	end
	
	doupdate()
	code()
	conversion()
	doupdate()
	code()
	moveblock()
	
	if (dir_ ~= nil) then
		mapcursor_move(ox,oy,dir_)
	end
	
	if (#units > 0) and (no3d == false) then
		local vistest,vt2 = findallfeature(nil,"is","3d",true)
		if (#vistest > 0) or (#vt2 > 0) then
			local target = vistest[1] or vt[1]
			visionmode(1)
		elseif (spritedata.values[VISION] == 1) then
			local vistest2 = findfeature(nil,"is","3d")
			if (vistest2 == nil) then
				visionmode(0)
			end
		end
	end
end

function firstlevel()
	local world = generaldata.strings[WORLD]
	local level = generaldata.strings[CURRLEVEL]
	
	generaldata.strings[CURRLEVEL] = ""
	
	if (string.len(level) == 0) then
		local flevel = MF_read("world","general","firstlevel")
		local slevel = MF_read("world","general","start")
		
		local fstatus = tonumber(MF_read("save",world,flevel)) or 0
		local intro = tonumber(MF_read("save",world,"intro")) or 0
		local hassalvage = tonumber(MF_read("save",world,"salv")) or 0
		
		if (string.len(flevel) > 0) then
			if (fstatus ~= 3) or (string.len(slevel) == 0) then
                if (hassalvage == 0) then
                    clearsalvages()
                    MF_store("save",world,"salv","1")
                end
				sublevel(slevel,0,0)
				sublevel(flevel,0,0)
				
				generaldata.strings[CURRLEVEL] = flevel
				generaldata.strings[PARENT] = slevel
				
				if (world == generaldata.strings[BASEWORLD]) and (intro == 0) then
					MF_intro()
				end
			else
				generaldata.strings[CURRLEVEL] = slevel
			end
		elseif (string.len(slevel) > 0) then
			generaldata.strings[CURRLEVEL] = slevel
			sublevel(slevel,0,0)
		end
	end
end
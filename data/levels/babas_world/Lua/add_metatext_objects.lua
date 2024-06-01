meta_objs = {}
for i,v in ipairs(editor_objlist) do
    if string.sub(v.name,1,5) == "text_" then
        local new = 
        {
            name = "text_"..v.name,
            sprite_in_root = false,
            unittype = "text",
            tags = {"text, abstract"},
            tiling = v.tiling,
            type = 0,
            layer = v.layer,
            colour = v.colour,
            colour_active = v.colour_active,
        }
        table.insert(meta_objs, new)
    end
end

for i,v in ipairs(meta_objs) do
    table.insert(editor_objlist_order, v.name)
    editor_objlist[v.name] = v
end

formatobjlist()

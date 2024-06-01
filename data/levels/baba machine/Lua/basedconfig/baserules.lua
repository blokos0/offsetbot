-- These are some extra configurations
local mod_config = {
    -- Displays a lua error message on level start, showing which sentences in baserules.lua were invalid.
    -- You can disable this if you want to avoid all the excess error messages. But invalid sentences will still be ignored.
    report_invalid_sentences = true,

    -- When set to true, this disables the game from automatically inserting "text is push", "level is stop", and "cursor is select" as baserules.
    -- Note that this affects the levelpack as a whole, and cannot be configured per level. If you want some levels to have the above rules,
    -- configure "level_baserules" at the bottom of this file.
    disable_normal_baserules = false,
}

--[[ 
    persist_baserules are always applied in every level in the levelpack. Just put in your list of sentences below.
    Example:
    local persist_baserules = {
        "baba is keke",
        "keke make me",
        "me is blue and pink",
    }

    NOTE: There is a bug where adding group-related rules as persist baserule doesn't work without having at least one text object in the level.
    The fix would require some lua function overriding in rules.lua, which I don't want to do for compatability reasons. There might be other rules that also have this
    problem. So to be on the safe side, make sure you have at least one text object in you level.
 ]]
local persist_baserules = {
    "baba on lever is power",
    "keke on lever is power",
    "me on lever is power",
    "jiji on lever is power",
    "fofo on lever is power",
    "it on lever is power",
    "powered mover is auto",
    "powered fallcell is fall",
    "enemy is sink",
    "mover is push",
    "pusher is push",
    "fallcell is push",
    "level without enemy is win",
    "trash eat all",
    "powered immobile is stop",
    "all nextto rotator_cw is turn",
    "all nextto rotator_ccw is deturn",
    "rotator_cw is push",
    "rotator_ccw is push",
    "slider is push",
    "directional is push",
    "powered slider facing up is lockedleft and lockedright",
    "powered slider facing down is lockedleft and lockedright",
    "powered slider facing left is lockedup and lockeddown",
    "powered slider facing right is lockedup and lockeddown",
    "powered directional facing up is lockedleft and lockedright and lockeddown",
    "powered directional facing down is lockedleft and lockedright and lockedup",
    "powered directional facing left is lockedup and lockeddown and lockedright",
    "powered directional facing right is lockedup and lockeddown and lockedleft",
    "not powered mover on tile is auto",
    "generator is push",
    "powered generator facing generator make love",
    "powered love is generator",
    "powered generator facing mover make mover",
    "powered generator facing repulsor make repulsor",
    "powered generator facing slider make slider",
    "powered generator facing fall make fall",
    "powered generator facing pusher make pusher",
    "powered generator facing directional make directional",
    "powered generator facing cellke make cellke",
    "powered directional on generator is not lockedup and lockeddown and lockedleft and lockedright",
    "powered generator facing rotator_cw make rotator_cw",
    "powered generator facing rotator_ccw make rotator_ccw",
    "powered generator facing bread make bread",
    "powered generator not on skull is shift",
    "powered enemy not nextto repulsor is still",
    "flipper is push",
    "flipper facing up is group",
    "flipper facing down is group",
    "flipper facing left is group2",
    "flipper facing right is group2",
    "all above group is turn and turn",
    "all below group is turn and turn",
    "all besideleft group2 is turn and turn",
    "all besideright group2 is turn and turn",
    "all on generator is reverse",
    "repulsor is push",
    "powered all fear repulsor",
    "immobile fear not repulsor",
    "wall fear not repulsor",
    "algae fear not repulsor",
    "skull fear not repulsor",
    "driller is push",
    "powered driller is auto",
    "powered driller facing generator is swap",
    "powered driller facing mover is swap",
    "powered driller facing driller is swap",
    "powered driller facing pusher is swap",
    "powered driller facing slider is swap",
    "powered driller facing directional is swap",
    "powered driller facing flipper is swap",
    "powered driller facing rotator_cw is swap",
    "powered driller facing rotator_ccw is swap",
    "powered driller facing fall is swap",
    "powered driller facing enemy is swap",
    "powered driller facing repulsor is swap",
    "powered driller facing bread is swap",
    "powered driller facing strange is swap",
    "powered driller facing cellke is swap",
    "bread is push",
    "powered bread is stop",
    "powered bread is not push",
    "powered bread nextto mover and mover is sink",
    "powered bread on mover is sink",
    "powered bread nextto mover and mover is not stop",
    "powered bread nextto mover and pusher is sink",
    "powered bread on mover and pusher is sink",
    "powered bread nextto mover and pusher is not stop",
    "powered bread nextto pusher and pusher is sink",
    "powered bread on pusher and pusher is sink",
    "powered bread nextto pusher and pusher is not stop",
    "powered bread nextto enemy is not bread",
    "strange is push",
    "seldom and powered strange is nudgeup",
    "seldom and powered strange is nudgeleft",
    "seldom and powered strange is nudgeright",
    "seldom and powered strange is nudgedown",
    "strange feeling nudgeup is not nudgeright",
    "strange feeling nudgeright is not nudgedown",
    "strange feeling nudgedown is not nudgeleft",
    "strange feeling nudgeleft is not nudgeup",
    "seldom and powered all nextto strange is turn",
    "seldom and powered all nextto strange is deturn",
    "often and powered strange on tile is still",
    "cellke is push",
    "powered cellke is move"
}



--[[
    levelpack_baserules are just like persist_baserules where every sentence is applied to every level in the levelpack.
    However, each "set" of sentences is applied only when the game detects the rule "level is X", where X can be any string you want.

    The format for each entry in levelpack_baserules is:
        <text block name> = {
            <sentence 1>,
            <sentence 2>,
            <sentence 3>,
            ...
        }
    Where <text block name> does not have "text_" prepended ("push", "shift", "ice" etc).

    Note: Only full rules are allowed. So no "baba is keke is push", where it would've been parsed as two sentences in game.

    The below example will apply "baba is sleep and pet" and "level is pink" when "level is lovebaba" is formed. A similar thing happens when you form "level is poem"

        local levelpack_baserules = {
            lovebaba = {
                "baba is sleep and pet",
                "all near baba is love",
                "level is pink",
            },
            poem = {
                "rose is red",
                "violet is blue",
                "flag is win",
                "baba is you",
            },
        }
 ]]
local levelpack_baserules = {
}




--[[ 
    level baserules are baserules that only apply to specific levels in your levelpack.
    The format for each entry is:
        [<level name>] = {
            <text block name> = {
                <sentence 1>,
                <sentence 2>,
                <sentence 3>,
                ...
            }
        }
    Where <level name> is CASE-SENSITIVE and can be EITHER: 
        - the name of the level ingame (Ex: "the return of scenic pond", "skull house", "prison")
        - the name of the .ld file (excluding ".ld")
    The rest of the format is exactly the same as global baserules.
    
    Note: level baserules will be used instead of global baserules when playing a level that you specified in the variable below.

    The below example applies "baba is green" when "level is baserule1" is formed when playing a level named "woah". 
    It also applies "keke is purple" when "level is baserule1" is formed when playing a level whose .ld file is "23level.ld". 

        local level_baserules = {
            ["woah"] = {
                baserule1 = {
                    "baba is green"
                }
            },
            ["23level"] = {
                baserule1 = {
                    "keke is purple"
                }
            }
        }
 ]]
local level_baserules = {
}

-- Ignore this last part. It's needed to load all the baserules into the mod
return mod_config, levelpack_baserules, level_baserules, persist_baserules
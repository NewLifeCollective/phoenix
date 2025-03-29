return {
    DebugPoly = false,
    Freedom = vec4(1838.38, 2585.93, 46.01, 264.67), -- Freedom spawn coords
    RemoveJob = false,          -- Remove player jobs when send to jail

    -- Create Target Zone to Check Time (if XTPrisonJobs is false) --
    CheckOut = {
        coords = vec3(1836.5, 2592.05, 46.35),
        size = vec3(0.9, 7.8, 1.45),
        rotation = 0.5,
    },

    -- Alert When Entering Prison --
    EnterPrisonAlert  = {
        enable = true,
        header = 'Welcome to Prison, Criminal Scum!',
        content = 'Wait out your time in your cell, or head out into the yard. The infirmary is just across the way if you need to see the doc. Make sure you check out up front, or you\'ll set off the alarms.',
    },

    -- Enter Prison Spawn Location & Emotes --
    Spawns = {
        { coords = vec4(1770.7249755859, 2479.9802246094, 45.74076461792, 31.66007232666),   emote = 'pushup' },
        { coords = vec4(1761.0710449219, 2474.9235839844, 49.693054199219, 33.123195648193), emote = 'pushup' },
        { coords = vec4(1745.0281982422, 2479.2116699219, 45.740684509277, 323.06579589844), emote = 'weights' },
        { coords = vec4(1768.1342773438, 2481.6772460938, 45.740734100342, 33.281074523926), emote = 'lean' },
    },

    -- Canteen Ped --
    CanteenPed = {
        model = 's_m_m_linecook',
        coords = vector4(1778.31, 2560.56, 45.62, 181.13),
        scenario = 'PROP_HUMAN_BBQ',
        mealLength = 2
    },

    -- Prison Doctor --
    PrisonDoctor = {
        model = 's_m_m_doctor_01',
        coords = vec4(1764.87, 2599.15, 45.73, 168.98),
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        healLength = 5
    },

    -- Roster Location --
    RosterLocation = {
        coords = vec3(1790.34, 2553.61, 46.00),
        radius = 0.5,
    },

    -- Set Prison Outfits --
    EnablePrisonOutfits = true,
    PrisonOufits = {
        male = {
            accessories = {
                item = 0,
                texture = 0
            },
            mask = {
                item = 0,
                texture = 0
            },
            pants = {
                item = 5,
                texture = 7
            },
            jacket = {
                item = 0,
                texture = 0
            },
            shirt = {
                item = 15,
                texture = 0
            },
            arms = {
                item = 0,
                texture = 0
            },
            shoes = {
                item = 42,
                texture = 2
            },
            bodyArmor = {
                item = 0,
                texture = 0
            },
        },
        female = {
            accessories = {
                item = 0,
                texture = 0
            },
            mask = {
                item = 0,
                texture = 0
            },
            pants = {
                item = 0,
                texture = 0
            },
            jacket = {
                item = 0,
                texture = 0
            },
            shirt = {
                item = 0,
                texture = 0
            },
            arms = {
                item = 0,
                texture = 0
            },
            shoes = {
                item = 0,
                texture = 0
            },
            bodyArmor = {
                item = 0,
                texture = 0
            },
        }
    },

    -- Reloads Player's Last Skin When Freed --
    ResetClothing = function()
        TriggerEvent('illenium-appearance:client:reloadSkin', true)
    end,

    -- Triggered on Player Heal --
    PlayerHealed = function()
        TriggerEvent('hospital:client:Revive')
        -- TriggerEvent('osp_ambulance:partialRevive')
    end,

    -- Trigger Emote --
    Emote = function(emote)
        -- exports.scully_emotemenu:playEmoteByCommand(emote)
        -- exports["rpemotes"]:EmoteCommandStart(emote)
    end,

    -- Trigger Prison Break Dispatch --
    Dispatch = function(coords)
        -- exports['ps-dispatch']:PrisonBreak()
        -- TriggerEvent('police:client:policeAlert', coords, 'Prison Break')
        
       -- ND Core
        -- exports["ND_MDT"]:createDispatch({
        --             caller = "Boilingbroke Penitentiary",
        --             location = "Sandy Shores",
        --             callDescription = "Prison Break",
        --             coords = vec3(1845.8302, 2585.9011, 45.6726)
        --         })
    end,
}
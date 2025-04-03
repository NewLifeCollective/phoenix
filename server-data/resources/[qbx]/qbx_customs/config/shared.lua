return {
    -- If you experience issues with your zones not working, please ensure the Z value of your vec3 points match. Using different heights may cause problems.
    ---@type ZoneOptions[]
    zones = {
        ---  Benny's Example Zone
        ---     {
        ---         freeRepair = { 'police' }, -- Provides free repairs to specified job
        ---         freeMods = { 'police' }, -- provides free modifications to specified job
        ---         job = { 'police' }, -- Restricts customs access to a specific job (useful for restricting to mechanics, police, ambulance, etc)
        ---         hideBlip = false, -- When true, the blip for this location is hidden
        ---         blip = {
        ---             sprite = 72, -- https://docs.fivem.net/docs/game-references/blips/#blips
        ---             color = 3,   -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        ---             scale = 0.8,
        ---             label = "EXAMPLE ZONE",
        ---         },
        ---         points = {
        ---             vec3(-344.36, -121.92, 38.60),
        ---             vec3(-319.43, -130.65, 38.60),
        ---             vec3(-324.77, -147.93, 38.60),
        ---             vec3(-348.59, -139.1, 38.60),
        ---         }
        ---     },
        --- Default GTA 5 Customs and Benny's Locations
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs - Vinewood',
            },
            points = {
                vec3(-344.36, -121.92, 38.60),
                vec3(-319.43, -130.65, 38.60),
                vec3(-324.77, -147.93, 38.60),
                vec3(-348.59, -139.1, 38.60),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs -- PDM',
            },
            points = {
                vec3(-26.22, -1096.44, 27.32),
                vec3(-24.3, -1091.12, 27.32),
                vec3(-20.88, -1092.39, 27.32),
                vec3(-22.97, -1097.69, 27.33),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs - Airport',
            },
            points = {
                vec3(-1147.7, -1990.31, 13.15),
                vec3(-1171.05, -2013.96, 13.15),
                vec3(-1158.38, -2026.03, 13.15),
                vec3(-1139.17, -2007.18, 13.15),
                vec3(-1144.73, -1992.89, 13.15),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs - East',
            },
            points = {
                vec3(724.93, -1092.04, 22.15),
                vec3(738.52, -1094.83, 22.15),
                vec3(737.36, -1064.56, 22.15),
                vec3(724.14, -1063.71, 22.15),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs - Sandy Shores',
            },
            points = {
                vec3(1172.12, 2644.76, 38.55),
                vec3(1171.39, 2635.66, 38.55),
                vec3(1189.77, 2636.08, 38.55),
                vec3(1189.74, 2644.07, 38.55),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = 'Los Santos Customs - Paleto',
            },
            points = {
                vec3(115.55, 6625.32, 31.75),
                vec3(109.19, 6631.69, 31.75),
                vec3(97.39, 6620.02, 31.75),
                vec3(102.72, 6613.48, 31.75),
            }
        },
        {
            hideBlip = false,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = "Benny's Motorworks",
            },
            blipColor = 5,
            points = {
                vec3(-203.55, -1311.26, 30.85),
                vec3(-228.06, -1319.24, 30.85),
                vec3(-228.25, -1334.25, 30.85),
                vec3(-214.18, -1341.38, 30.85),
                vec3(-195.42, -1321.19, 30.85),
                vec3(-195.26, -1314.11, 30.85),
            }
        },
        { 
            freeRepair = { 'police' }, -- Provides free repairs to specified job
            freeMods = { 'police' }, -- provides free modifications to specified job
            job = { 'police' }, -- Restricts customs access to a specific job (useful for restricting to mechanics, police, ambulance, etc)
            hideBlip = true,
            blip = {
                sprite = 72,
                color = 3,
                scale = 0.8,
                label = "MRPD Garage",
            },
            blipColor = 5,
            points = {
                vec3(455.07, -973.6, 25.7),
                vec3(430.26, -973.66, 25.7),
                vec3(430.73, -978.04, 25.7),
                vec3(454.83, -977.93, 25.7),
            }
        }
    },

    prices = {
        ['cosmetic'] = 50,
        ['colors'] = 100,
        [11] = { 0, 100, 200, 300, 400 },     -- Engine
        [12] = { 0, 250, 500, 750 },               -- Brakes
        [13] = { 0, 500, 1000, 1500, 2000 },      -- Transmission
        [15] = { 0, 300, 600, 900, 1200, 1500 }, -- Suspension
        [18] = 1000                                  -- Turbo
    }
} 
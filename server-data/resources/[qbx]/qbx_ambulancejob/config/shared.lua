return {
    checkInCost = 20, -- Price for using the hospital check-in system
    minForCheckIn = 2, -- Minimum number of people with the ambulance job to prevent the check-in system from being used

    locations = { -- Various interaction points
        duty = {
            vec3(349.51, -585.54, 28.8),
            vec3(-249.17, 6330.74, 32.43),
        },
        vehicle = {
            vec4(327.64, -579.98, 28.8, 335.83),
            vec4(-234.28, 6329.16, 32.15, 222.5),
        },
        helicopter = {
            vec4(351.55, -587.98, 74.16, 258.27),
            vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = {
            {
                shopType = 'AmbulanceArmory',
                name = 'Armory',
                groups = { ambulance = 0 },
                inventory = {
                    { name = 'radio', price = 0 },
                    { name = 'bandage', price = 0 },
                    { name = 'painkillers', price = 0 },
                    { name = 'firstaid', price = 0 },
                    { name = 'weapon_flashlight', price = 0 },
                    { name = 'weapon_fireextinguisher', price = 0 },
                },
                locations = {
                    vec3(341.53, -586.86, 28.8)
                }
            }
        },
        roof = {
            vec3(332.33, -595.62, 43.28),
        },
        main = {
            vec3(343.54, -582.02, 28.8),
        },
        stash = {
            {
                name = 'ambulanceStash',
                label = 'Personal stash',
                weight = 100000,
                slots = 30,
                groups = { ambulance = 0 },
                owner = true, -- Set to false for group stash
                location = vec3(349.57, -580.63, 28.7)
            }
        },

        ---@class Bed
        ---@field coords vector4
        ---@field model number

        ---@type table<string, {coords: vector3, checkIn?: vector3|vector3[], beds: Bed[]}>
        hospitals = {
            pillbox = {
                coords = vec3(362.08, -590.74, 28.67),
                checkIn = vec3(350.77, -588.43, 28.8),
                beds = {
                    {coords = vec4(359.33, -585.95, 43.1, 336.32), model = 1631638868},
                    {coords = vec4(361.21, -580.95, 43.1, 336.32), model = 1631638868},
                    {coords = vec4(354.48, -593.23, 43.1, 73.69), model = 2117668672},
                    {coords = vec4(354.48, -593.23, 43.1, 73.69), model = 2117668672},
                    {coords = vec4(340.62, -596.73, 43.1, 325.79), model = 2117668672},
                },
            },
            paleto = {
                coords = vec3(-250, 6315, 32),
                checkIn = vec3(-254.54, 6331.78, 32.43),
                beds = {
                    {coords = vec4(-252.43, 6312.25, 32.34, 313.48), model = 2117668672},
                    {coords = vec4(-247.04, 6317.95, 32.34, 134.64), model = 2117668672},
                    {coords = vec4(-255.98, 6315.67, 32.34, 313.91), model = 2117668672},
                },
            },
            jail = {
                coords = vec3(1761, 2600, 46),
                beds = {
                    {coords = vec4(1761.96, 2597.74, 45.66, 270.14), model = 2117668672},
                    {coords = vec4(1761.96, 2591.51, 45.66, 269.8), model = 2117668672},
                    {coords = vec4(1771.8, 2598.02, 45.66, 89.05), model = 2117668672},
                    {coords = vec4(1771.85, 2591.85, 45.66, 91.51), model = 2117668672},
                },
            },
        },

        stations = {
            {label = 'Pillbox Hospital', coords = vec4(304.27, -600.33, 43.28, 272.249)},
        }
    },
}
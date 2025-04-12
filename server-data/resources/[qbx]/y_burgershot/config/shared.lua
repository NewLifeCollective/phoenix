return {
    coords = {
        duty = {
            coords = vec3(-1177.79, -897.18, 13.8),
            size = vector3(1.5, 0.5, 2),
            rotation = 33.5,
        },
        cook = {
            coords = vec3(-1186.58, -900.1, 13.8),
            size = vector3(1.0, 1.8, 0.8),
            rotation = 34,
        },
        cook_2 = {
            coords = vec3(-1187.27, -900.65, 13.8),
            size = vector3(1.0, 1.8, 0.8),
            rotation = 34,
        },
        fry = {
            coords = vec3(-1187.49, -899.84, 13.8),
            size = vector3(1.5, 2.5, 0.8),
            rotation = 34,
        },
        burgers = {
            coords = vec3(-1185.42, -901.96, 13.8),
            size = vector3(0.7, 1.8, 0.8),
            rotation = 304,
        },
        drinks = {
            coords = vec3(-1191.26, -897.52, 14.0),
            size = vector3(0.6, 2.2, 1),
            rotation = 34,
        },
        tray = {
            coords = vec3(-1188.91, -897.77, 13.8),
            size = vector3(1, 1.05, 0.5),
            rotation = 35,
        },
        hotstorage = {
            coords = vec3(-1187.48, -896.93, 13.8),
            size = vector3(1.2, 4.6, 1.8),
            rotation = 35,
        },
        storage = {
            coords = vec3(-1184.0, -900.56, 13.8),
            size = vector3(1, 3, 1.8),
            rotation = 35,
        },
    },
    recipes = {
        prep = {
            steak = {
                label = "Steak",
                ingredients = {
                    { item = "rawmeat", amount = 1 },
                }
            },
            fries = {
                label = "Fries",
                ingredients = {
                    { item = "potato", amount = 1 },
                }
            },
            burger = {
                label = "Hamburger",
                ingredients = {
                    { item = "rawmeat", amount = 1 },
                    { item = "lettuce", amount = 1 },
                    { item = "bun", amount = 2 },
                }
            },
        },
        drinks = {
            milkshake = {
                min = 40,
                max = 75,
                label = 'Milkshake',
                ingredients = {
                    { name = 'mshakeformula' , amount = 1 },
                },
                prop = {
                    model = `prop_cs_bs_cup`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0)
                },
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                }
            },
            meatshake = {
                min = 35,
                max = 60,
                prop = {
                    model = `prop_cs_bs_cup`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0)
                },
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                }
            },
        },
        burgers = {
            burger = {
                min = 35,
                max = 60,
                label = 'Hamburger',
                ingredients = {
                    { item = "rawmeat", amount = 1 },
                    { item = "lettuce", amount = 1 },
                    { item = "bun", amount = 2 },
                },
                prop = {
                    model = `prop_cs_bs_cup`,
                    bone = 28422,
                    pos = vec3(0.0, 0.0, 0.0),
                    rot = vec3(0.0, 0.0, 0.0)
                },
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c'
                }
            },

        },
    }
}
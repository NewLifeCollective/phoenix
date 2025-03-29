return {
    coords = {
        duty = {
            coords = vector3(-1190.3, -895.15, 14.0),
            size = vector3(1.5, 0.5, 2),
            rotation = 33.5,
        },
        cook = {
            coords = vector3(-1186.93, -900.41, 14.0),
            size = vector3(1.0, 1.8, 0.8),
            rotation = 34,
        },
        cook_2 = {
            coords = vector3(-1185.43, -901.45, 14.0),
            size = vector3(1.0, 1.8, 0.8),
            rotation = 34,
        },
        fry = {
            coords = vector3(-1187.4, -899.71, 14.0),
            size = vector3(1.5, 2.5, 0.8),
            rotation = 34,
        },
        burgers = {
            coords = vector3(-1190.28, -902.29, 14.0),
            size = vector3(0.7, 1.8, 0.8),
            rotation = 304,
        },
        drinks = {
            coords = vector3(-1190.96, -897.3, 14.0),
            size = vector3(0.6, 2.2, 1),
            rotation = 34,
        },
        tray = {
            coords = vector3(-1188.78, -898.15, 14.0),
            size = vector3(1, 1.05, 0.5),
            rotation = 35,
        },
        hotstorage = {
            coords = vector3(-1188.04, -897.48, 14.0),
            size = vector3(1.2, 4.6, 1.8),
            rotation = 35,
        },
        storage = {
            coords = vector3(-1183.84, -900.37, 14.0),
            size = vector3(1, 3, 1.8),
            rotation = 35,
        },
    },
    recipes = {
        prep = {
            steak = {
                label = "Steak",
                ingredients = {
                    {
                        item = "rawmeat",
                        amount = 1,
                    },
                }
            },
            fries = {
                label = "Fries",
                ingredients = {
                    {
                        item = "potato",
                        amount = 1,
                    },
                }
            },
            burger = {
                label = "Hamburger",
                ingredients= {
                    {
                        item = "rawmeat",
                        amount = 1,
                    },
                    {
                        item = "lettuce",
                        amount = 1,
                    }
                }
            },
        },
        drinks = {
            milkshake = {
                min = 40,
                max = 75,
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
    }
}
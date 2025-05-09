return {
    cityhalls = {
        {
            coords = vec3(-542.67, -208.51, 37.65),
            showBlip = true,
            blip = {
                label = 'City Hall',
                shortRange = true,
                sprite = 182,
                display = 4,
                scale = 0.65,
                colour = 0,
            },
            licenses = {
                ['id'] = {
                    item = 'id_card',
                    label = 'ID Card',
                    cost = 5,
                },
                ['driver'] = {
                    item = 'driver_license',
                    label = 'Driver License',
                    cost = 5,
                },
                ['weapon'] = {
                    item = 'weaponlicense',
                    label = 'Weapon License',
                    cost = 50,
                },
            },
        },
        {
            coords = vec3(-444.91, 6011.71, 32.29),
            showBlip = true,
            blip = {
                label = 'City Hall',
                shortRange = true,
                sprite = 182,
                display = 4,
                scale = 0.65,
                colour = 0,
            },
            licenses = {
                ['id'] = {
                    item = 'id_card',
                    label = 'ID Card',
                    cost = 5,
                },
                ['driver'] = {
                    item = 'driver_license',
                    label = 'Driver License',
                    cost = 5,
                },
                ['weapon'] = {
                    item = 'weaponlicense',
                    label = 'Weapon License',
                    cost = 50,
                },
            },
        },
    },

    employment = {
        enabled = true, -- Set to false to disable the employment menu
        jobs = {
            unemployed = 'Unemployed',
            delivery = 'Delivery Driver',
            taxi = 'Taxi',
            tow = 'Tow Truck',
            reporter = 'News Reporter',
            garbage = 'Garbage Collector',
            bus = 'Bus Driver',
            trucker = 'Truck Driver',
        },
    },
}

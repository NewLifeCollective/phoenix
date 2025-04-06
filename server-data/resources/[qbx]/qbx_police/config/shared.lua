return {
    timeout = 10000,
    maxSpikes = 5,
    policePlatePrefix = 'LSPD',
    objects = {
        cone = {model = `prop_roadcone02a`, freeze = false},
        barrier = {model = `prop_barrier_work05`, freeze = true},
        roadsign = {model = `prop_snow_sign_road_06g`, freeze = true},
        tent = {model = `prop_gazebo_03`, freeze = true},
        light = {model = `prop_worklight_03b`, freeze = true},
        chair = {model = `prop_chair_08`, freeze = true},
        chairs = {model = `prop_chair_pile_01`, freeze = true},
        tabe = {model = `prop_table_03`, freeze = true},
        monitor = {model = `des_tvsmash_root`, freeze = true},
    },

    locations = {
        duty = {
            vec3(443.05, -980.64, 30.69), --MRPD
            vec3(-447.4, 6015.03, 32.29), --Sandy PD
        },
        vehicle = {
            vec4(436.5759, -986.0907, 25.7000, 91.1573),
            vec4(436.7179, -988.9277, 25.7000, 91.4663),
            vec4(436.6748, -991.6530, 25.7000, 95.9289),
            vec4(436.5877, -994.3933, 25.7000, 89.9255),
            vec4(446.6411, -994.2593, 25.7000, 262.3265),
            vec4(446.2852, -991.5200, 25.7000, 268.4483),
            vec4(446.5644, -988.8582, 25.7000, 274.6802),
            vec4(446.7239, -986.0948, 25.7000, 271.5557),
            vec4(426.7206, -981.4843, 25.7000, 275.0804),
            vec4(426.3364, -978.8571, 25.7000, 276.5352),
            vec4(426.4217, -976.2504, 25.7000, 271.3848),
            vec4(1824.83, 3686.24, 33.97, 29.54),
            vec4(1827.64, 3687.86, 33.97, 41.54),
            vec4(1831.05, 3690.04, 33.97, 28.38),
            vec4(1834.3, 3692.08, 33.97, 32.28)


            -- -- old below
            -- vec4(448.89999389648, -984.40002441406, 26.0, 0),
            -- vec4(434.29998779296, -984.54998779296, 26.0, 0),
            -- vec4(434.14999389648, -996.20001220704, 26.0, 0),
            -- vec4(449.0, -996.04998779296, 26.0, 0),
        },
        stash = { -- Not currently used, use ox_inventory stashes
            -- vec3(453.075, -980.124, 30.889),
        },
        impound = {
            vec3(382.13, -1633.75, 29.29),
            vec3(-436.14, 5982.63, 31.34)
        },
        helicopter = {
            vec4(449.168, -981.325, 43.691, 87.234),
            vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = { -- Not currently used, use ox_inventory shops
            -- vec3(462.23, -981.12, 30.68),
        },
        trash = {
            vec3(439.0907, -976.746, 30.776),
        },
        fingerprint = {
            vec3(460.9667, -989.180, 24.92),
        },
        evidence = { -- Not currently used, use ox_inventory evidence system
        },
        stations = {
            {label = 'Mission Row Police Station', coords = vec3(434.0, -983.0, 30.7)},
            {label = 'Sandy Shores Police Station', coords = vec3(1853.4, 3684.5, 34.3)},
            -- {label = 'Vinewood Police Station', coords = vec3(637.1, 1.6, 81.8)},
            -- {label = 'Vespucci Police Station', coords = vec3(-1092.6, -808.1, 19.3)},
            -- {label = 'Davis Police Station', coords = vec3(368.0, -1618.8, 29.3)},
            -- {label = 'Paleto Bay Police Station', coords = vec3(-448.4, 6011.8, 31.7)},
        },
    },

    radars = {
        -- /!\ The maxspeed(s) need to be in an increasing order /!\
        -- If you don't want to fine people just do that: 'config.speedFines = false'
        -- fine if you're maxspeed or less over the speedlimit
        -- (i.e if you're at 41 mph and the radar's limit is 35 you're 6mph over so a 25$ fine)
        speedFines = {
            {fine = 25, maxSpeed = 10 },
            {fine = 50, maxSpeed = 30},
            {fine = 250, maxSpeed = 80},
            {fine = 500, maxSpeed = 180},
        }
    }
}

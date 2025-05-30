return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    ['bank_card'] = {
        label = 'Bank Card',
        weight = 100,
        stack = false,
        consume = 0,
        description = 'A card used for banking transactions',
        image = 'bank_card.png',
    },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
        image = 'bandage.png',
    },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },


    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        image = 'sprunk.png',
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Panties',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
    },

    ["phone"] = {
        label = "Phone",
        weight = 190,
        stack = false,
        consume = 0,
        client = {
            export = "lb-phone.UsePhoneItem",
            remove = function()
                TriggerEvent("lb-phone:itemRemoved")
            end,
            add = function()
                TriggerEvent("lb-phone:itemAdded")
            end
        }
    },

    ['mustard'] = {
        label = 'Mustard',
        weight = 500,
        client = {
            status = { hunger = 25000, thirst = 25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
            usetime = 2500,
            notification = 'You... drank mustard'
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
        prop = { model = 'p_ld_id_card_002' },
        image = 'license.png',
    },

    ['driver_license'] = {
        label = 'Drivers License',
        prop = { model = 'p_ld_id_card_002' },
        image = 'license.png',
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
        prop = { model = 'p_ld_id_card_002' },
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
        prop = { model = 'p_ld_id_card_002' },
        image = 'license.png',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        stack = false,
        allowArmed = true
    },
    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 500,
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
    },

    ["cleaningkit"] = {
        label = "Cleaning Kit",
        weight = 250,
        stack = true,
        close = true,
        description = "A microfiber cloth with some soap will let your car sparkle again!",
        client = {
            image = "cleaningkit.png",
        },
        server = {
            export = 'vehiclehandler.cleaningkit'
        }
    },

    ["tirekit"] = {
        label = "Tire Kit",
        weight = 250,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your tire",
        client = {
            image = "tirekit.png",
        },
        server = {
            export = 'vehiclehandler.tirekit'
        }
    },

    ["repairkit"] = {
        label = "Repairkit",
        weight = 2500,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your vehicle",
        client = {
            image = "repairkit.png",
        },
        server = {
            export = 'vehiclehandler.repairkit',
        }
    },

    ["advancedrepairkit"] = {
        label = "Advanced Repairkit",
        weight = 5000,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your vehicle",
        client = {
            image = "advancedrepairkit.png",
        },
        server = {
            export = 'vehiclehandler.advancedrepairkit',
        }
    },

    ['diamond_ring'] = {
        label = 'Diamond',
        weight = 1500,
    },

    ['rolex'] = {
        label = 'Golden Watch',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
    },

    ['crack_baggy'] = {
        label = 'Crack Baggy',
        weight = 100,
        image = 'cocaine.png'
    },

    ['cokebaggy'] = {
        label = 'Bag of Coke',
        weight = 100,
        image = 'cocaine.png'
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        weight = 2000,
    },

    ['coke_small_brick'] = {
        label = 'Coke Package',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        label = 'Bag of Ecstasy',
        weight = 100,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
    },

    ['oxy'] = {
        label = 'Oxycodone',
        weight = 100,
        image = 'oxycodone.png',
    },

    ['weed_ak47'] = {
        label = 'AK47 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_ak47_seed'] = {
        label = 'AK47 Seed',
        weight = 1,
    },

    ['weed_skunk'] = {
        label = 'Skunk 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_skunk_seed'] = {
        label = 'Skunk Seed',
        weight = 1,
    },

    ['weed_amnesia'] = {
        label = 'Amnesia 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_amnesia_seed'] = {
        label = 'Amnesia Seed',
        weight = 1,
    },

    ['weed_og-kush'] = {
        label = 'OGKush 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_og-kush_seed'] = {
        label = 'OGKush Seed',
        weight = 1,
    },

    ['weed_white-widow'] = {
        label = 'OGKush 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_white-widow_seed'] = {
        label = 'White Widow Seed',
        weight = 1,
    },

    ['weed_purple-haze'] = {
        label = 'Purple Haze 2g',
        weight = 200,
        image = 'weed.png',
    },

    ['weed_purple-haze_seed'] = {
        label = 'Purple Haze Seed',
        weight = 1,
    },

    ['weed_brick'] = {
        label = 'Weed Brick',
        weight = 2000,
    },

    ['weed_nutrition'] = {
        label = 'Plant Fertilizer',
        weight = 2000,
    },

    ['joint'] = {
        label = 'Joint',
        weight = 200,
        image = 'weed_joint.png'
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        label = 'Empty Weed Bag',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 2500,
        image = 'firstaid.png',
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 2500,
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 400,
        image = 'painkillers.png',
    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },

    ['steel'] = {
        label = 'Steel',
        weight = 100,
    },

    ['rubber'] = {
        label = 'Rubber',
        weight = 100,
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 100,
        image = 'scrapmetal.png'
    },

    ['iron'] = {
        label = 'Iron',
        weight = 100,
    },

    ['copper'] = {
        label = 'Copper',
        weight = 100,
    },

    ['aluminium'] = {
        label = 'Aluminium',
        weight = 100,
    },

    ['plastic'] = {
        label = 'Plastic',
        weight = 100,
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
    },

    ['gatecrack'] = {
        label = 'Gatecrack',
        weight = 1000,
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
        image = 'usb_black.png'
    },

    ['trojan_usb'] = {
        label = 'Trojan USB',
        weight = 100,
        image = 'usb_black.png'
    },

    ['toaster'] = {
        label = 'Toaster',
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        weight = 100,
    },

    ['security_card_01'] = {
        label = 'Security Card A',
        weight = 100,
    },

    ['security_card_02'] = {
        label = 'Security Card B',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['antipatharia_coral'] = {
        label = 'Antipatharia',
        weight = 1000,
    },

    ['dendrogyra_coral'] = {
        label = 'Dendrogyra',
        weight = 1000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        weight = 1000,
    },

    ['wine'] = {
        label = 'Wine',
        weight = 500,
    },

    ['grape'] = {
        label = 'Grape',
        weight = 10,
    },

    ['grapejuice'] = {
        label = 'Grape Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
    },

    ['beer'] = {
        label = 'beer',
        weight = 200,
    },

    ['sandwich'] = {
        label = 'sandwich',
        weight = 200,
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['stickynote'] = {
        label = 'Sticky Note',
        weight = 0,
    },

    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 200,
        image = 'evidence_bag.png',
    },

    ['filled_evidence_bag'] = {
        label = 'Filled Evidence Bag',
        weight = 200,
        image = 'evidence_bag.png',
    },

    ['harness'] = {
        label = 'Harness',
        weight = 200,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 5,
        image = 'handcuffs.png',
    },
    ['toy2'] = {
		label = 'Pink Teddy',
		weight = 50,
		stack = false,
		close = false,
		description = 'A Fluffy Pink Teddy from the Atic'
	},

	['toy1'] = {
		label = 'Action Figure',
		weight = 50,
		stack = false,
		close = false,
		description = 'An Action Figure From the late 90\'s'
	},

	['burger'] = {
		label = 'Burger',
		weight = 100,
		stack = true,
		close = true,
		description = 'A regular burger for boring people.'
	},

	['murdermeal'] = {
		label = 'Murder Meal',
		weight = 50,
		stack = true,
		close = true,
		description = 'An Amazing Murder Meal with a chance of a toy.'
	},

	['heartstopper'] = {
		label = 'Burger Heartstopper',
		weight = 500,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['torpedo'] = {
		label = 'Burger Torpedo',
		weight = 310,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['milkshake'] = {
		label = 'Milkshake',
		weight = 125,
		stack = true,
		close = true,
		description = 'Hand-scooped for you!'
	},

	['moneyshot'] = {
		label = 'Burger Moneyshot',
		weight = 300,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['bleeder'] = {
		label = 'Burger Bleeder',
		weight = 250,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['meatshake'] = {
		label = 'Meat Shake',
		weight = 125,
		stack = true,
		close = true,
		description = 'Nice\'N\'Chunky MeatShake remulsified just for you'
	},

	['meatfree'] = {
		label = 'Meat-free burger',
		weight = 125,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['fries'] = {
		label = 'Fries',
		weight = 125,
		stack = true,
		close = true,
		description = 'Sates Hunger.'
	},

	['rawmeat'] = {
		label = 'Raw Meat',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['lettuce'] = {
		label = 'Lettuce',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['bun'] = {
		label = 'Bun',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['steak'] = {
		label = 'Steak',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['tomato'] = {
		label = 'Tomato',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['mshakeformula'] = {
		label = 'Milkshake Formula',
		weight = 125,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},

	['potato'] = {
		label = 'Potato',
		weight = 1500,
		stack = true,
		close = true,
		description = 'An Ingredient'
	},
    ["engine_oil"] = {
        label = "Engine Oil",
        weight = 1000,
      },
      ["tyre_replacement"] = {
        label = "Tyre Replacement",
        weight = 1000,
      },
      ["clutch_replacement"] = {
        label = "Clutch Replacement",
        weight = 1000,
      },
      ["air_filter"] = {
        label = "Air Filter",
        weight = 100,
      },
      ["spark_plug"] = {
        label = "Spark Plug",
        weight = 1000,
      },
      ["brakepad_replacement"] = {
        label = "Brakepad Replacement",
        weight = 1000,
      },
      ["suspension_parts"] = {
        label = "Suspension Parts",
        weight = 1000,
      },
      -- Engine Items
      ["i4_engine"] = {
        label = "I4 Engine",
        weight = 1000,
      },
      ["v6_engine"] = {
        label = "V6 Engine",
        weight = 1000,
      },
      ["v8_engine"] = {
        label = "V8 Engine",
        weight = 1000,
      },
      ["v12_engine"] = {
        label = "V12 Engine",
        weight = 1000,
      },
      ["turbocharger"] = {
        label = "Turbocharger",
        weight = 1000,
      },
      -- Electric Engines
      ["ev_motor"] = {
        label = "EV Motor",
        weight = 1000,
      },
      ["ev_battery"] = {
        label = "EV Battery",
        weight = 1000,
      },
      ["ev_coolant"] = {
        label = "EV Coolant",
        weight = 1000,
      },
      -- Drivetrain Items
      ["awd_drivetrain"] = {
        label = "AWD Drivetrain",
        weight = 1000,
      },
      ["rwd_drivetrain"] = {
        label = "RWD Drivetrain",
        weight = 1000,
      },
      ["fwd_drivetrain"] = {
        label = "FWD Drivetrain",
        weight = 1000,
      },
      -- Tuning Items
      ["slick_tyres"] = {
        label = "Slick Tyres",
        weight = 1000,
      },
      ["semi_slick_tyres"] = {
        label = "Semi Slick Tyres",
        weight = 1000,
      },
      ["offroad_tyres"] = {
        label = "Offroad Tyres",
        weight = 1000,
      },
      ["drift_tuning_kit"] = {
        label = "Drift Tuning Kit",
        weight = 1000,
      },
      ["ceramic_brakes"] = {
        label = "Ceramic Brakes",
        weight = 1000,
      },
      -- Cosmetic Items
      ["lighting_controller"] = {
        label = "Lighting Controller",
        weight = 100,
        client = {
          event = "jg-mechanic:client:show-lighting-controller",
        }
      },
      ["stancing_kit"] = {
        label = "Stancer Kit",
        weight = 100,
        client = {
          event = "jg-mechanic:client:show-stancer-kit",
        }
      },
      ["cosmetic_part"] = {
        label = "Cosmetic Parts",
        weight = 100,
      },
      ["respray_kit"] = {
        label = "Respray Kit",
        weight = 1000,
      },
      ["vehicle_wheels"] = {
        label = "Vehicle Wheels Set",
        weight = 1000,
      },
      ["tyre_smoke_kit"] = {
        label = "Tyre Smoke Kit",
        weight = 1000,
      },
      ["bulletproof_tyres"] = {
        label = "Bulletproof Tyres",
        weight = 1000,
      },
      ["extras_kit"] = {
        label = "Extras Kit",
        weight = 1000,
      },
      -- Nitrous & Cleaning Items
      ["nitrous_bottle"] = {
        label = "Nitrous Bottle",
        weight = 1000,
        client = {
          event = "jg-mechanic:client:use-nitrous-bottle",
        }
      },
      ["empty_nitrous_bottle"] = {
        label = "Empty Nitrous Bottle",
        weight = 1000,
      },
      ["nitrous_install_kit"] = {
        label = "Nitrous Install Kit",
        weight = 1000,
      },
      ["cleaning_kit"] = {
        label = "Cleaning Kit",
        weight = 1000,
        client = {
          event = "jg-mechanic:client:clean-vehicle",
        }
      },
      ["repair_kit"] = {
        label = "Repair Kit",
        weight = 1000,
        client = {
          event = "jg-mechanic:client:repair-vehicle",
        }
      },
      ["duct_tape"] = {
        label = "Duct Tape",
        weight = 1000,
        client = {
          event = "jg-mechanic:client:use-duct-tape",
        }
      },
      -- Performance Item
      ["performance_part"] = {
        label = "Performance Parts",
        weight = 1000,
      },
      -- Mechanic Tablet Item
      ["mechanic_tablet"] = {
        label = "Mechanic Tablet",
        weight = 1000,
        client = {
          event = "jg-mechanic:client:use-tablet",
        }
      },
      -- Gearbox
      ["manual_gearbox"] = {
        label = "Manual Gearbox",
        weight = 1000,
      },
}
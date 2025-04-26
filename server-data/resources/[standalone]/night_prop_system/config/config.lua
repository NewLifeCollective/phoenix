Config = {

    ConfigVersion = "3.3.0",

    Debug = false,
    EventPrefix = "night_prop_system",  -- Leave this be.

    --====================== BULLETIN UI ======================--

    Enable_custom_messages = false,      -- true = bulletin ui: https://github.com/Mobius1/bulletin | false = native installed notify and chatMessage function (c_functions.lua & s_functions.lua), feel free to edit it.
   
    --====================== PERMISSIONS ======================--
    
    EveryoneHasPermission = true,

    Enable_Night_DiscordApi_Permissions = false,    -- server/s_functions.lua
    Enable_Ace_Permissions = false,                 -- server/s_functions.lua
    Enable_ESX_Permissions = false,                 -- client/c_functions.lua & server/s_functions.lua
    Enable_QBCore_Permissions = {                   
        Check_By_Job = false,                       -- client/c_functions.lua & server/s_functions.lua
        Check_By_Permissions = false,               -- server/s_functions.lua
    },

    PermissionRoles = {     -- Fill in: Discord API Role Names / ESX Jobs / Ace group names / QB Jobs and/or Groups
        -- Discord API Examples
        "Manager",
        "Development_Team",
        "Senior_Admin",
        "Admin",
        "Essex_Police_Force",
        "British_Transport_Police",
        "Ambulance_Service",
        "Fire_Service",
        -- ESX or QB Job examples
        "police",
        "ambulance",
        "fire",
        -- Ace Permissions examples
        "Administrator",
        "Supporter",
        "Tester",
    },

        --====================== Commands, Hotkeys and buttons ======================--

        Commands = {
            RoadNodeTool = "roadnodes",                 -- Opens the road node tool.
            PlaceObjectsTool = "placeobjects",          -- Enables the placing/removing object mode.
            SpeedzoneTool = "speedzones",               -- Opens a menu to place speedzones.
            DeleteNearbyObjects = "deleteobjects",      -- Deletes (desynchronized) objects in range of player.
        },   
        
        Animations = {
            PickupAnimationDict = "random@domestic",
            PickupAnimation = "pickup_low",
            PlacedownAnimationDict = "random@domestic",
            PlacedownAnimation = "pickup_low",
        },
    
        HotKeys = { -- MATCH THESE TO THE BUTTONS (https://docs.fivem.net/docs/game-references/controls/)
            RoadNodeTool = "F5",        -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/ (Set to 999 to disable)
            PlaceObjectsTool = "F6",    -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/ (Set to 999 to disable)
            SpeedzoneTool = "F7",       -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/ (Set to 999 to disable)
    
            BrowseLeft = 307,           -- Arrow Right
            BrowseRight = 308,          -- Arrow Left
            PlaceObject = 38,           -- E
            ToggleRoadNode = 38,        -- E
            DeleteObject = 19,          -- LEFT ALT
            DeleteObjectsInRange = 73,  -- X
            StopBrowsing = 177,         -- BACKSPACE / ESC / RIGHT MOUSE BUTTON
        },
    
        Buttons = { -- MATCH THESE TO THE HOTKEYS (https://docs.fivem.net/docs/game-references/controls/)
            BrowseLeft = "~INPUT_REPLAY_BACK~",
            BrowseRight = "~INPUT_REPLAY_ADVANCE~",
            PlaceObject = "~INPUT_PICKUP~",
            ToggleRoadNode = "~INPUT_PICKUP~",
            DeleteObject = "~INPUT_CHARACTER_WHEEL~",
            StopBrowsing = "~INPUT_CELLPHONE_CANCEL~",
            DeleteObjectsInRange = "~INPUT_VEH_DUCK~",  
    
            -- Menu button text
            CreateSpeedzoneButton = '» Create a speedzone',
            BuildTheSpeedzoneButton = '~g~»»»»» ~s~Create speedzone ~g~«««««',
            DeleteSpeedzoneButton = '» Delete a speedzone',
            NoPermissionButton = '» No permission to access this menu.',
            RemoveTheSpeedzoneButton = "Delete speedzone at",
            SelectASpeedButton = '» Select a speed:',
            SelectASizeButton = '» Select a size:',
            YesButton = '» Yes',
            NoButton = '» No',
            BackButton = '~r~««« ~s~BACK',
            ExitMenuButton = '««« ~r~EXIT',
        },

    --====================== Objects (Props) ======================--

    FreezeObjectsOnSpawn = false,
    DeleteObjectsRadius = 15.0,         -- Set radius in meters to delete objects on pressing the multiple object deletion button.
    ObjectAndPropList = {
        -- Default Props
        { Name = "Small Road Cone", Prop = "prop_roadcone02c"},
        { Name = "Large Road Cone", Prop = "prop_roadcone01a"},
        { Name = "Scene Light", Prop = "prop_worklight_04d"},
        { Name = "Striped Barrier", Prop = "prop_mp_barrier_02b"},
        { Name = "Striped Large Cone", Prop = "prop_mp_cone_01"},
        { Name = "Striped Small Cone", Prop = "prop_mp_cone_02"},
        { Name = "No Stripe Small Cone", Prop = "prop_mp_cone_03"},
        { Name = "Stand-up Striped Pole", Prop = "prop_mp_cone_04"},
        { Name = "Gazebo", Prop = "prop_gazebo_02"},
        
        -- ERS Props [Included with the Emergency Response Simulator Ultimate: https://store.nights-software.com/category/ersgamemode]
        -- { Name = "Cone", Prop = "neko_night_cone_00" },
        -- { Name = "Barrier", Prop = "neko_night_water_barrier_00" },
        -- { Name = "Warning triangle", Prop = "neko_night_warning_tri_00" },
        -- { Name = "Rubber barrier", Prop = "neko_night_rubber_barrier_00" },
        -- { Name = "Barrier", Prop = "neko_night_barrier_00" },
        -- { Name = "Barrier 1", Prop = "neko_night_barrier_01" },
        -- { Name = "Barrier 2", Prop = "neko_night_barrier_02" },
        -- { Name = "Arrow board cross", Prop = "neko_night_arrow_board_00" },
        -- { Name = "Arrow board left", Prop = "neko_night_arrow_board_00_l" },
        -- { Name = "Arrow board right", Prop = "neko_night_arrow_board_00_r" }, 

        --Custom Props (Add yours here.)
        -- { Name = "Blue Beacon", Prop = "blue_beacon"},
        -- { Name = "Cone", Prop = "pro_cone"},
        -- { Name = "Amber Cone", Prop = "pro_cone_amber"},
        -- { Name = "Blue Cone", Prop = "pro_cone_blue"},
        -- { Name = "Barrier 'Road Closed'", Prop = "prop_barrier_work05"},
        -- { Name = "Barrier 'Accident'", Prop = "prop_barrier_accident"},
        -- { Name = "Barrier 'Highway Left'", Prop = "prop_barrier_highwaysleft"},
        -- { Name = "Barrier 'Highway Right'", Prop = "prop_barrier_highwaysright"},
        -- { Name = "Barrier 'Drone'", Prop = "prop_barrier_policedrone"},
        -- { Name = "Barrier 'Left'", Prop = "prop_barrier_policeleft"},
        -- { Name = "Barrier 'Right'", Prop = "prop_barrier_policeright"},
        -- { Name = "Barrier 'Slow'", Prop = "prop_barrier_Slow"},
    },

    --====================== Road Closures ======================--

    RoadClosureAnimationDictionary = "taxi_hail",
    RoadClosureAnimation = "hail_taxi",

    --====================== Speedzones ======================--

    MenuStructure = {
        speedzonemenu = {
            name = "speedzonemenu",
            title = "Speedzones",
            subtitle = "Speedzones",
            bgcolor = {2, 219, 154, 150},
            fgcolor = {232, 215, 187, 255},
            submenus = {
                activespeedzones = {
                    name = "activespeedzones",
                    title = "Active Speedzones",
                    subtitle = "DELETE AN ACTIVE ZONE",
                    bgcolor = {2, 219, 154, 150},
                    fgcolor = {232, 215, 187, 255},
                    submenus = {
                    }
                },
                createspeedzones = {
                    name = "createspeedzones",
                    title = "Create a Speedzone",
                    subtitle = "CREATE A SPEEDZONE",
                    bgcolor = {2, 219, 154, 150},
                    fgcolor = {232, 215, 187, 255},
                    submenus = {
                    }
                },
                closemenu = {
                    name = "closemenu",
                    title = "Exit Menu",
                    subtitle = "EXIT MENU?",
                    bgcolor = {2, 219, 154, 150},
                    fgcolor = {232, 215, 187, 255},
                    submenus = {
                    }
                }
            }
        }
    },

    SpeedZoneSpeeds = { 
        {DisplayName = "0 MPH", Speed = 0.0},
        {DisplayName = "5 MPH", Speed = 5.0},
        {DisplayName = "10 MPH", Speed = 10.0},
        {DisplayName = "15 MPH", Speed = 15.0},
        {DisplayName = "20 MPH", Speed = 20.0},
        {DisplayName = "25 MPH", Speed = 25.0},
        {DisplayName = "30 MPH", Speed = 30.0},
        {DisplayName = "35 MPH", Speed = 35.0},
        {DisplayName = "40 MPH", Speed = 40.0},
        {DisplayName = "45 MPH", Speed = 45.0},
        {DisplayName = "50 MPH", Speed = 50.0},
        {DisplayName = "55 MPH", Speed = 55.0},
        {DisplayName = "60 MPH", Speed = 60.0},
        {DisplayName = "65 MPH", Speed = 65.0},
        {DisplayName = "70 MPH", Speed = 70.0},
    },

    SpeedZoneSizes = { 
        {DisplayName = "10 Radius", Radius = 10.0},
        {DisplayName = "20 Radius", Radius = 20.0},
        {DisplayName = "30 Radius", Radius = 30.0},
        {DisplayName = "40 Radius", Radius = 40.0},
        {DisplayName = "50 Radius", Radius = 50.0},
        {DisplayName = "60 Radius", Radius = 60.0},
        {DisplayName = "70 Radius", Radius = 70.0},
        {DisplayName = "80 Radius", Radius = 80.0},
        {DisplayName = "90 Radius", Radius = 90.0},
        {DisplayName = "100 Radius", Radius = 100.0},
    },

    SpeedZoneBlipData = {       -- https://docs.fivem.net/docs/game-references/blips/
        blipName = "Speedzone",
        blipSprite = 9,
        blipColour = 40,    
        blipDisplay = 4,
        blipAlpha = 100,
    },

    --====================== Messages ======================--

    Messages = {
        -- Error Fetching
        InvalidObjectModel = "Invalid object model: ",
        NoPermission = "You do not have the permission to do this.",
        InVehicle = "You must outside of a vehicle.",
        InObjectPlacingMode = "You are already in object placing mode.",
        InObjectPlacingModeWhilstSpeedzone = "You are in object placing mode. Close it first before opening the speed zone menu.",
        InRoadNodeToolWhilstSpeedzone = "You are in the road node tool. Close it first before opening the speedzone menu.",
        InRoadNodeToolWhilstObjectPlacingMode = "You are in the road node tool. Close it first before opening the object placing mode.",
        InObjectPlacingModeWhilstRoadNodeTool = "You are in object placing mode. Close it first before opening the road node tool.",
        InSpeedzoneMenuWhilstRoadNodeTool = "You are in the road node tool. Close it first before opening the speedzone menu.",
        FailedToSpawnObjectLimitReached = "Failed to add an object, likely due to a limit of spawned objects in this area...",

        -- HotKey Help
        HotKeySyntax = "Use ",
        HotKeySyntax2 = "use ",
        HotKeyAndSyntax = " and ",
        HotKeyOrSyntax = "~w~ or ",
        HotKeyEndSyntax = " Browse objects.",
        HotKeyPlaceObjSyntax = " to place the object.",
        HotKeyPlaceObjSyntax2 = " Place ~y~",
        DeleteObject = " Delete closest object.",
        StopBrowsing = " ~r~Exit~w~.",

        -- Regular
        ProcessingSpeedzoneRemoval = "Removing speedzone...",
        LoadingObjectModel = "Loading object model",
        PlacedObject = "You've place an object: ~y~",
        DeletedObject = "Deleted object: ~y~",
        HowToExitPlaceObjectMode = "Use BACKSPACE / ESC / RIGHT MOUSE BUTTON to exit placing objects mode.",
        DeleteMultipleObjects = " to delete multiple objects in range.",
        DeleteNearbyObjects = " Delete objects in range.",
        NoObjectFoundNearby = "Could not find any nearby objects.",

        -- Speedzone Menu
        YouSelectedSyntax = "You selected",
        YouCreatedASpeedzone = "You've created a speedzone.",
        Street = "~w~Street: ~y~",
        Size = "~w~Size: ~y~",
        Speed = "~w~Speed: ~y~",
        Nearby = "~w~nearby",

        -- Road Nodes
        OpenOrCloseNearestRoad = "Open or close the nearest road.",
        OpenedOrClosedTheRoad = "You have opened or closed the road.",
        StillInRoadNodeTool = "You are still in the road node tool.",

        -- Chat Suggestions
        PlaceObjectsToolChatSuggestion = "Command used to place objects.",
        SpeedzoneToolChatSuggestion = "Command used to open the speedzone menu.",
        RoadNodeToolChatSuggestion = "Command used to toggle the road node tool.",
        DeleteNearbyObjectsCommandSuggestion = "Command used to delete objects close to a player.",
    },
}




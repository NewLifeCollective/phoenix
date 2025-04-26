fx_version 'cerulean'
games { 'gta5' }

author 'Night'
description 'Prop & Speedzone management system'
version '3.3.1'
lua54 'yes'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config/*.lua',
    -- '@es_extended/imports.lua' -- ESX
}

-- Usage example exports client side

-- exports['night_prop_system']:TogglePlaceObjectsTool()
-- exports['night_prop_system']:ToggleSpeedzoneTool()
-- exports['night_prop_system']:ToggleRoadNodeTool()

-- Usage Example exports server side (we kept the old naming server side for easy compatibility for previous users)

-- exports['night_prop_system']:OpenPropMenu(src)
-- exports['night_prop_system']:OpenSpeedZoneMenu(src)
-- exports['night_prop_system']:ToggleRoadNodeTool(src)

escrow_ignore {
    'config/*.lua',
    'client/c_functions.lua',
    'client/warmenu.lua',
    'server/s_functions.lua'
}
dependency '/assetpacks'
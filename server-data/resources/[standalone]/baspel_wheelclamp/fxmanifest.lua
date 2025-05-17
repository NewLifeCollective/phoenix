fx_version 'cerulean'
game { 'gta5' }
lua54 'yes' 
author 'Baspel'
description 'Script for wheelclamp with custom props :D'
version '3.3.5'

shared_scripts { 
    'configs/sh_config.lua',
    'shared/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/sv_config.lua',
    'server/load.lua',
    'server/lib/*.lua',
    'server/sql/*.lua',
    'server/framework/*.lua', 
    'server/server.lua'
}

client_scripts { 
    'client/lib/*.lua',
    'client/framework/*.lua',
    'client/target/*.lua',
    'client/client.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/baspel_wheelclamp_pack.ytyp'

escrow_ignore {
    'configs/*.lua',
    'shared/*.lua',
    'server/load.lua',
    'server/framework/*.lua',
    'client/framework/*.lua',
    'client/target/ox-target.lua',
    'client/target/qb-target.lua',
    'README.md'
}
dependency '/assetpacks'
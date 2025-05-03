-- See LICENSE
-- Copyright (C) 2025 TheClassyR3dneck

fx_version 'cerulean'
game 'gta5'

author 'TheClassyR3dneck'
description 'Utility resource to delete entities'
version '3.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'qbx_core',
    'ox_lib'
}
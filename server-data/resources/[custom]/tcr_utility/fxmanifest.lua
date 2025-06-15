-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'TheClassyR3dneck'
description 'TCR Utility - AOP, Peacetime, Announcements'
version '1.0.0'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

exports {
    'GetAOP',
    'GetPeaceTimeStatus'
}

fx_version 'cerulean'
games {"gta5"}
author "Sonoran Software"
version "1.0.0"
config_version "1.0"
real_name "SonoranRadio In Car Radio"
lua54 "yes"

client_scripts {'client/*.lua'}

server_scripts {"server/*.lua", "server/util/unzip.js"}

shared_script {'config/config.lua', 'shared/*.lua'}

files {'stream/*.ytyp', 'html/**/*'}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'
escrow_ignore {"config/config.CHANGEME.lua", "config/radios.CHANGEME.json"}
dependency '/assetpacks'
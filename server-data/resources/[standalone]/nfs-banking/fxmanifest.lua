fx_version "cerulean"
use_experimental_fxv2_oal 'yes'
author "Need 4 Script: Visit our Tebex for more!"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
  "rdr3"
}

ui_page 'web/build/index.html'

server_scripts {
  '@bl_bridge/imports/server.lua',
  '@oxmysql/lib/MySQL.lua',
  'server/**/*'
}

client_scripts {
  '@bl_bridge/imports/client.lua',
  "client/**/*"
}

shared_script {
  '@ox_lib/init.lua',
}

dependency 'bl_bridge'

files {
  'data/*',
	'web/build/index.html',
	'web/build/**/*',
  'web/public/**/*',
}

escrow_ignore {
  "data/*.lua",
}

dependency '/assetpacks'
dependency '/assetpacks-redm'
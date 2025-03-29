fx_version "cerulean"
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
version '1.5.6'

dependencies {
  '/onesync',
}

shared_scripts {
  'require.lua',
  'init.lua',
}

files {
  'utils.lua',
  'client/**/*.lua',
  'imports/client.lua',
}
server_script {
  'imports/server.lua'
}

server_exports {
  'core' -- Ensure this function is actually defined in your server script
}

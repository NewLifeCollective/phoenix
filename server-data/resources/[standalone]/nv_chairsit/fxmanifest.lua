fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Nevera Development'
description '[FREE] Sit on every chair'
version '1.0.0'

shared_scripts {
	'config.lua'
}

client_scripts { 'client/client.lua'}

escrow_ignore {
	'**',
	'**/**'
}
dependency '/assetpacks'
fx_version 'cerulean'
game 'gta5'

description 'NC Music Players'
version '1.0.5'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.extensions.lua',
	'config/players/config.*.lua',
}

server_scripts {
	'config/config.api.lua',
	'config/functions/config.functions.server.lua',
	'server/main.lua'
}

client_scripts {
	'config/config.locale.lua',
	'config/functions/config.functions.client.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

file 'html/**'
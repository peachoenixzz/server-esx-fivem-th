fx_version 'cerulean'
game 'gta5'

description 'NC Booth'
version '1.0.7'
author 'NC'

lua54 'yes'


shared_scripts {

	'config/config.general.lua',
	'config/config.booth.lua',
	'config/config.functions.lua',
	'config/config.extensions.lua',
	'@es_extended/imports.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/config.database.lua',
	'config/functions/config.functions.server.lua',
	'server/main.lua'
}

client_scripts {
	'config/functions/config.functions.client.lua',
	'config/config.locale.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

file 'html/**'
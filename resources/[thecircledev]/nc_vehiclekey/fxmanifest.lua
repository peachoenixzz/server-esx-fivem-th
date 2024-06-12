fx_version 'cerulean'
game 'gta5'

description 'NC Vehicle Key'
version '1.0.0'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.extensions.lua'
}

server_scripts {
	-- MySQL
	'@oxmysql/lib/MySQL.lua',
	'config/config.database.lua',

	'server/main.lua'
}

client_scripts {
	'config/config.functions.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/js/*.js',
	'html/sounds/*.ogg'
}
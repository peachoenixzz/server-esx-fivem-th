fx_version 'cerulean'
game 'gta5'

description 'NC Thief'
version '1.0.6'
author 'NC'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
}

shared_scripts {
	'config/config.general.lua',
	'config/config.functions.lua',
	'config/config.extensions.lua'
}

server_script 'server/main.lua'

client_scripts {
	'config/config.locale.lua',
	'config/config.animations.lua',
	'client/main.lua'
}
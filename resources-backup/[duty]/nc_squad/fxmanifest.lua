fx_version 'cerulean'
game 'gta5'

description 'NC Squad'
version '1.0.2'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.functions.lua',
	'config/config.extensions.lua'
}

server_script 'server/main.lua'

client_script 'client/main.lua'
fx_version 'cerulean'
game 'gta5'

description 'NC Steal Jobs'
version '1.2.3'
author 'NC'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
}

shared_scripts {
	'config/config.general.lua',
	'config/config.objects.lua',
	'config/config.steal.lua',
	'config/config.functions.lua',
	'config/config.extensions.lua'
}

server_script 'server/main.lua'

client_scripts {
	'config/config.locale.lua',
	'client/main.lua'
}
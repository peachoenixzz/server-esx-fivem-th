fx_version 'adamant'

game 'gta5'

description 'Dv_Hunter_tackle for cops'

version '1.1.0'

shared_scripts {
	'@es_extended/imports.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}

fx_version 'adamant'

game 'gta5'

description 'The Circle Dev'

version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client.lua',
	'config.lua',
}

server_script {
	--'@async/async.lua',
	--'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server.lua',
	'config.lua',
}



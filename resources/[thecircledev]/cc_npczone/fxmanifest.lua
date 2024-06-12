fx_version 'adamant'

game 'gta5'

description 'The Circle Dev'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.client.lua',
	'client.lua',
}

server_script {
	--'@async/async.lua',
	--'@oxmysql/lib/MySQL.lua',
	--'@es_extended/locale.lua',
	'server.lua',
	--'config.lua',
}

exports {
	'checkZoneTradeCar',
	'checkZoneReSkin',
}



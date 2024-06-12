fx_version 'adamant'

game 'gta5'

description 'What CITY'

version '1.0.0'

server_scripts {
	'config.lua',
	'server/server.lua',
}

client_scripts {
	'config.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'clients/client.lua',
}

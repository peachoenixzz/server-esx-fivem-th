fx_version 'adamant'
games { 'gta5' }

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'jaymenu.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

file 'AllTattoos.json'
fx_version 'adamant'

game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
}

client_script {
    '@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config.client.lua',
	'client.lua',
}

server_script {
    '@es_extended/locale.lua',
    'config.server.lua',
    'server.lua',
}

exports{
    'checkInDynamic',
}


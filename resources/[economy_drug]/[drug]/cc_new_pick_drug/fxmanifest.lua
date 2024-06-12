fx_version 'cerulean'
game 'gta5'


shared_scripts {
    '@es_extended/imports.lua',
}

client_script {
    '@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'config.lua',
	'client.lua',
}

server_script {
    '@es_extended/locale.lua',
    'config.lua',
    'config.server.lua',
    'server.lua',
}



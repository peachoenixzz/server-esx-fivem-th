fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'The Circle Dev'

version '1.0.0'


shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua',
	'config.lua',
}

server_script {
    '@es_extended/locale.lua',
    'config.lua',
    'server.lua',
}





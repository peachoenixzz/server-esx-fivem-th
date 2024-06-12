fx_version 'adamant'

game 'gta5'

description 'ESX Service'

version '1.0.0'


shared_scripts {
    '@es_extended/imports.lua',
}

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependency 'es_extended'

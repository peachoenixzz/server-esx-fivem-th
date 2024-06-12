fx_version 'adamant'

game 'gta5'

description 'vehrob peachoenixz'

version '1.0'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
    '@es_extended/locale.lua',
	'client.lua'
}


server_scripts {
	'server.lua',
    '@es_extended/locale.lua',
}
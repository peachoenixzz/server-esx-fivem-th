fx_version 'cerulean'
game 'gta5'
author 'Peachoenixz'
description 'Peachoenixz-circlejob'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'config.lua'
}

exports {

}


fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-Duty'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@async/async.lua',
    '@es_extended/locale.lua',
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

exports {
    'checkOnDutyPlayer'
}


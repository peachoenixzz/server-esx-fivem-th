fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-UnJail'


client_scripts {
    '@async/async.lua',
    '@es_extended/locale.lua',
    'client/c.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server/server.lua'
}

exports {
    'unJailMenu',
}

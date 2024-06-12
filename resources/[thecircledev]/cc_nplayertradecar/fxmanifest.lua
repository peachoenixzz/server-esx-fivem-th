fx_version 'cerulean'
game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'client/main.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}



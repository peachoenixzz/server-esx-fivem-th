fx_version 'cerulean'
game 'gta5'

author 'Azael Dev <contact@azael.dev> (https://www.azael.dev/)'
description 'DB - Health and Armor'
version '1.2.6'

lua54 'yes'

shared_scripts {
    'config/shared.config.lua',
    'source/shared/framework.shared.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/auth.config.lua',
    'config/server.config.lua',
    'public/database/server.database.lua',
    'source/server/auth.server.lua',
    'source/server/main.server.lua'
}

client_scripts {
    'config/client.config.lua',
    'source/client/auth.client.lua',
    'source/client/main.client.lua'
}

files {
    'public/framework/**/client.framework.lua'
}

dependencies {
    '/server:4664',
    '/onesync',
    'oxmysql'
}

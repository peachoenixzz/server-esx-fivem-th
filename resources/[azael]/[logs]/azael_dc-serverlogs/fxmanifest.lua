fx_version 'cerulean'
game 'gta5'

author 'Azael Dev <contact@azael.dev> (https://www.azael.dev/)'
description 'DC - Server Logs (Webhook)'
version '1.7.1'

lua54 'yes'

shared_scripts {
    'config/shared.config.lua',
    'source/shared/main.shared.lua'
}

server_scripts {
    'config/auth.config.lua',
    'config/server.config.lua',
    'source/server/auth.server.lua',
    'source/server/main.server.lua'
}

client_scripts {
    'config/client.config.lua',
    'source/client/auth.client.lua',
    'source/client/main.client.lua'
}

dependencies {
    '/server:4664',
    '/onesync'
}

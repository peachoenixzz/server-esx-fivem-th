fx_version 'cerulean'

game 'gta5'

game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-pedenemy'

shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
}


client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@es_extended/locale.lua',
    'config-zone.lua',
    'client/c.lua',
    'client/client-zone.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'server/server.lua',
}
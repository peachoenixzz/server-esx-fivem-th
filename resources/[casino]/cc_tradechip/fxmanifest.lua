fx_version 'adamant'

game 'gta5'

author 'Dev x BTNGaming'
description 'ESX Body Bag System'
version '1.0'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
    'config.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server/main.lua',
    'config.lua'
}

exports {
    'cancelBodyBag',
    'checkStatusBodyBag'
}

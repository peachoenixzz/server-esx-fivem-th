fx_version 'cerulean'
game 'gta5'
author 'Peachoenixz'
description 'Peachoenixz-identify'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'server.lua'
}

exports {
    "getIdentifyPlayer"
}


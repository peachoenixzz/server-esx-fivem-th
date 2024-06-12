fx_version 'cerulean'
games { 'gta5' }
author 'Peachoenixz'
description 'Peachoenixz-tablet'

ui_page 'html/ui.html'

shared_script '@es_extended/imports.lua'

files {
    'html/**/',
    'html/**'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/c.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    "server/server.lua"
}

exports {
    "alertTabletPanel"
}

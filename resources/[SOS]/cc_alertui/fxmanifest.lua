fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-alert'

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

}

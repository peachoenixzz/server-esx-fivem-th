fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-Helpnotify'

ui_page 'html/ui.html'

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
}

exports {
    'hidePolicePanel',
    'showPolicePanel'
}

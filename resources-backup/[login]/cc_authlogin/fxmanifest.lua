fx_version 'cerulean'
game 'gta5'
author 'Peachoenixz'
description 'Peachoenixz-Login'
lua54 'yes'
ui_page 'html/ui.html'
shared_script '@es_extended/imports.lua'

shared_scripts {
    '@es_extended/imports.lua',
}

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
    'server/server.lua'
}

exports {
    'showLoginPanel',
    'hideLoginPanel',
    'tokenCollect'
}

loadscreen 'html/ui.html'

loadscreen_manual_shutdown "yes"

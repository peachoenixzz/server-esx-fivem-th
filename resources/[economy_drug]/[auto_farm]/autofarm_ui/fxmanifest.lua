fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Peachoenixz'
description 'Peachoenixz-progressbar'

ui_page 'html/ui.html'

files {
    'html/**/',
    'html/**'
}

client_scripts { 
    'client/c.lua',
}

exports {
    'hideProcessDetail',
    'showProcessDetail',
    'processItem',
    'cancelProcessItem',
    'updateProcessDetail'
}

fx_version 'adamant'
game 'gta5'

name "sm_skin"
description "Skin System & Clothe Shop @SM"
author "SM Developer"
version "1.0.7"

ui_page "html/index.html"

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/fonts/*.ttf',
    'html/sound/*.ogg',
}

client_scripts {
    'configs/*.lua',
    'client/function.lua',
    'client/client.lua',
    'client/blockskin.lua',
    'client/baber.lua',
    'client/clotheshop.lua',
    'client/skin.lua',
    'client/maskshop.lua',
    'client/shop.lua',
    'client/locker.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'configs/*.lua',
    'sm_auth.lua',
    'server/server.lua',
    'server/skin.lua',
}

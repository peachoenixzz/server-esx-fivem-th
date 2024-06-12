fx_version   'cerulean'
lua54        'yes'
games        { 'gta5' }

name         'sf-texasholdem'
author       'Mateq, Explooosion'
version      '1.0.6'
description  "Casino Texas Hold'em Poker script for FiveM"

dependencies {
	'/server:5848',
    '/onesync',
    '/gameBuild:1868'
}

ui_page 'html/index.html'

files {
    "locales/*",
    "html/**/*",
}

client_scripts {
    "config.lua",
    "modules/client_*.lua",
    "client/*.lua"
}

server_scripts {
    "config.lua",
    "modules/server_*.lua",
    "server/*.lua",
    "server/handEval/api.js",
    "server/handEval/library.js",
}

shared_scripts {
    "modules/shared_*.lua",
    "locales/*.lua"
}

escrow_ignore {
    "config.lua",
    "config.gta.lua",
    "**/editable_*.lua",
    "server/*.lua",
    "**/server_*.lua",
    "**/shared_*.lua",
    "locales/*.lua",
}
dependency '/assetpacks'
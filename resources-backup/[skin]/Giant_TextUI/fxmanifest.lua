-- NC PROTECT+
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

fx_version 'adamant' 

game 'gta5'
author 'GIANT'
description 'GIANT TEXTUI'
version '1.0'
lua54 'yes'


client_scripts {
    "client.lua",
    "config.lua"
}

shared_scripts { '@ox_lib/init.lua', '@es_extended/imports.lua'}

ui_page {
    "html/index.html"
}

files {
    "html/index.html",
    "html/script.js",
    "html/style.css",
    "html/notif.wav"
}


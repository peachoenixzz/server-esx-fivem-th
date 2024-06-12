fx_version 'adamant'

game 'gta5'

description 'ESX Hifi'

version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/fr.lua',
    'server/main.lua',
    'config.lua'
}

client_script {
    '@es_extended/locale.lua',
    'client/main.lua',
    'locales/fr.lua',
    'config.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/app.js'
}

dependencies {
    'es_extended'
}
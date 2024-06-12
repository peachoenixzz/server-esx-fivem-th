fx_version 'cerulean'
game 'gta5'

description 'Logic Store Robbery'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua'
}

server_scripts {
	'config.lua',
    'server/main.lua'
    
}

files {
    'html/**',
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}

exports{
    "miniGameLockPick"
}

shared_script '@es_extended/imports.lua'
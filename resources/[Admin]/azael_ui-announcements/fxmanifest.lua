fx_version 'adamant'

game 'gta5'

description 'UI - Server Announcements By. Azael Dev'

version '1.1.5'

ui_page 'html/index.html'

shared_scripts {
    '@es_extended/imports.lua',
}

files {
	'html/index.html',
	'html/app.js',
	'html/style.css'
}

server_script {
	'config.server.js',
	'server/main.js'
}

client_scripts {
	'client/main.js'
}

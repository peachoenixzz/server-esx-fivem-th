fx_version 'cerulean'

game 'gta5'
lua54 'yes'

ui_page 'html/ui.html'

files {
	'html/**/',
	'html/**'
}

shared_scripts {
	'@es_extended/imports.lua',
}

server_scripts {

}

client_scripts {
	'client/main.lua'
}
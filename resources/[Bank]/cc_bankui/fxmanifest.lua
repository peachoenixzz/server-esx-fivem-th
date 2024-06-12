fx_version 'cerulean'

game 'gta5'


ui_page 'html/ui.html'

files {
	'html/**/',
	'html/**'
}

server_scripts {
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua'
}

export 'openUI'

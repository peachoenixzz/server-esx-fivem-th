
fx_version 'cerulean'

game 'gta5'


ui_page 'html/ui.html'

shared_scripts {
	'@es_extended/imports.lua',
}


files {
	'html/**/'
}

-- Add a client script 
client_script {
	'client/main.lua',
}


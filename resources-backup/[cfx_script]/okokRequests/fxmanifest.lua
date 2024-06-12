fx_version 'cerulean'

game 'gta5'

author 'okok#3488'
description 'okokRequests'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua'
}

export 'requestMenu'

lua54 'yes'

escrow_ignore {
	'server.lua',
	'client.lua'
}
dependency '/assetpacks'
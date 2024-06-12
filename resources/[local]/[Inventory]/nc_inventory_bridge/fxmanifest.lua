fx_version 'cerulean'
game 'gta5'

description 'NC Inventory Bridge'
version '1.1.2'
author 'NC'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	'config.lua',
	'client/main.lua',
	---------------------------------------------
	'client/vault.lua',
	'@xzero_trunk/export/trunk.lua',
}

ui_page 'html/ui.html'

file 'html/**'
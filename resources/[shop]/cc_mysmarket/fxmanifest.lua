fx_version 'cerulean'

description 'Mystery Man Circle'
version '1.0.0'

lua54 'yes'
games {
	"gta5",
}

shared_script '@es_extended/imports.lua'

shared_scripts {
	'@es_extended/imports.lua',
}

ui_page 'web/build/index.html'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/**/*',
}

files {
	'web/build/index.html',
	'web/build/**/*'
}
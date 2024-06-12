

fx_version 'adamant'

game 'gta5'

description 'ESX Billing'
lua54 'yes'
version '1.0.0'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/**/',
	'html/**'
}

exports {
  'openInvoices'
}

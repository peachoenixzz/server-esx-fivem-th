resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Legacy Fuel'

version '1.3' 

ui_page "html/index.html"

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/img/*.png',
}


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'source/fuel_server.lua'
}

client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

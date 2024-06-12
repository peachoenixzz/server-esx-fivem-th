--	esx-qalle-jail
--		2018
--		Carl "Qalle"
--		2018
--	esx-qalle-jail

fx_version 'adamant'

game 'gta5'

description "Jail Script With Working Job"

shared_scripts {
    '@es_extended/imports.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"config.lua",
	"server/server.lua"
}

client_scripts {
	'@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	"config.lua",
	"client/client.lua"
}
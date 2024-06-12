fx_version 'cerulean'

game 'gta5'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	"config.lua",
    "client/client.lua"
}

server_scripts {
    "config.lua",
    "server/server.lua"
}

fx_version 'cerulean'
games { 'gta5' }
author 'General'


ui_page "client/html/ui.html"

files {
  "client/html/**",
}

client_scripts {
  "config.lua",
  "client/main.lua"
}

server_script {
  "config.lua",
  "server/server.lua",
  '@oxmysql/lib/MySQL.lua'
}



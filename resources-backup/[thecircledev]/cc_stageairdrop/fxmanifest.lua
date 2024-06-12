fx_version 'cerulean'
games { 'gta5' }
author 'General'
lua54 'yes'

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
  "config.server.lua",
  "server/server.lua",
  "server/server.fucntion.lua",
  '@oxmysql/lib/MySQL.lua'
}



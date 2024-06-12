--[[

  ESX RP Chat

--]]

fx_version 'adamant'

game 'gta5'

description 'ESX RP Chat'

version '1.0.0'

client_script 'client/main.lua'

server_scripts {

  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'

}

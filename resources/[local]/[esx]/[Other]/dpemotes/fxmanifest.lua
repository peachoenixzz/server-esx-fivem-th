fx_version 'adamant'

game 'gta5'

client_scripts {
	'NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'@oxmysql/lib/MySQL.lua',
	'Server/*.lua'
}

exports {
	"OnEmotePlay",
	"EmoteCancel",
	"SendToRabbitEmotes",
	"WalkMenuStart",
	"checkEmoteWalk",
	"setStateEmoteWalk"
}
this_is_a_map 'yes'
dependency '/assetpacks'

data_file 'DLC_ITYP_REQUEST' 'stream/watertank.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/flower_neck.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/find.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/red_card.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/yellow_card.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/whistle.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/logo_label.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/penguin_flag2.ytyp'
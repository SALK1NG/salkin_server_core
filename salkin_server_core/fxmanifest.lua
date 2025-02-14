fx_version 'bodacious'
game 'gta5'

author 'SALKIN.G'
description 'server_core'

client_scripts {
	"config.lua",
	"functions.lua",
	"client.lua"
}

server_scripts {
	"config.lua",
	"functions.lua",
	"server.lua"
}


shared_script {
	'@es_extended/imports.lua',
	'@mysql-async/lib/MySQL.lua'
}
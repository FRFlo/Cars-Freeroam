fx_version 'adamant'
game 'gta5'

author 'FRFlo'
description 'Cars Freeroam Main'
version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"server/**/*.lua",
	"server/*.lua"
}

client_scripts {
	"client/**/*.lua",
	"client/*.lua"
}

files {
	"html/*.*"
}

ui_page 'html/index.html'
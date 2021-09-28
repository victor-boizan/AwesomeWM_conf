local beautiful = require('beautiful')
local gears = require('gears')
local dir = gears.filesystem.get_configuration_dir() .. "./theme/ressources/icons/"
local g_vars = require('config.var')

return {
	-- user icons
	user = gears.filesystem.get_configuration_dir() .. './config/UserIcon',
	-- number icons
	one         = gears.color.recolor_image(dir .. './numbers/1.svg',                beautiful.fg),
	two         = gears.color.recolor_image(dir .. './numbers/2.svg',                beautiful.fg),
	tree        = gears.color.recolor_image(dir .. './numbers/3.svg',                beautiful.fg),
	-- apps icons
	browser     = gears.color.recolor_image(dir .. './softwares/qutebrowser.svg',      beautiful.fg),
	editor      = gears.color.recolor_image(dir .. './softwares/emacs.svg'      ,      beautiful.fg),
	terminal    = gears.color.recolor_image(dir .. './softwares/term-icon.svg'  ,      beautiful.fg),
	filemanager = gears.color.recolor_image(dir .. './softwares/FileManager.svg',      beautiful.fg),
	-- power icons
	lock        = gears.color.recolor_image(dir .. './powers/lock.svg'       ,      beautiful.fg),
	power       = gears.color.recolor_image(dir .. './powers/power.svg'      ,      beautiful.fg),
	restart     = gears.color.recolor_image(dir .. './powers/restart.svg'    ,      beautiful.fg),
	logout      = gears.color.recolor_image(dir .. './powers/logout.svg'     ,      beautiful.fg),
	sleep       = gears.color.recolor_image(dir .. './powers/power-sleep.svg',      beautiful.fg),
--	battery_empty = gears.color.recolor_image(dir .. '/battery-empty-solid.svg',      beautiful.fg),
	-- tags icons
	todo        = gears.color.recolor_image(dir .. './softwares/Org-mode-unicorn.svg', beautiful.fg),
	chill       = gears.color.recolor_image(dir .. '/coffee.svg',           beautiful.fg),
	social      = gears.color.recolor_image(dir .. '/message.svg',          beautiful.fg),
	distro      = gears.color.recolor_image(dir .. './distros/' .. g_vars.os .. '.svg',beautiful.fg),
	--status icons
	battery     =  gears.color.recolor_image(dir .. './hardwares/car-battery.svg',     beautiful.fg),
	ram         =  gears.color.recolor_image(dir .. './hardwares/memory.svg',          beautiful.fg),
	cpu         =  gears.color.recolor_image(dir .. './hardwares/microchip.svg',       beautiful.fg),
	ssd         =  gears.color.recolor_image(dir .. './hardwares/hdd.svg',             beautiful.fg),
	hdd         =  gears.color.recolor_image(dir .. './hardwares/hdd.svg',             beautiful.fg),
	clock			=  gears.color.recolor_image(dir .. '/Font_Awesome_5_regular_clock.svg', beautiful.fg),
	calendar		=  gears.color.recolor_image(dir .. '/iconmonstr-calendar-4.svg',		 beautiful.fg),
}

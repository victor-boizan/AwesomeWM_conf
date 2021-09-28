local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local icons = require('theme.ressources.icons')

local buildButton = require('widget.button')
local panel_style = gears.shape.rounded_rect

--update the widget
local pkgupdate = wibox.widget {
	font = "hack 17",
	text = "???",
	widget = wibox.widget.textbox
}

local nbpkg_script = gears.filesystem.get_configuration_dir() .. "./scripts/nb-pkg-update.sh"
function pkg_number()
	awful.spawn.easy_async_with_shell(nbpkg_script,
		function(out)
			if tonumber(out)>99
			then pkgnb="99+"
			else pkgnb=out
		end
		pkgupdate.markup = "<i>" .. pkgnb .. "</i>"
		end
	)
end
gears.timer {
	autostart = true,
	--add a 1hours delay
	timeout = 3600,
	single_shot = false,
	call_now = true,
	callback = pkg_number
}
--genreate the wideget

local distro_icon = buildButton(icons.distro, 5, 64)

local widget = wibox.widget {
	{
		{distro_icon, pkgupdate, layout = wibox.layout.flex.horizontal},
		margins = 5,
		widget = wibox.container.margin
	},
	bg = beautiful.widget_bg,
	fg = beautiful.widget_fg,
	shape = panel_style,
	widget = wibox.container.background
}

--return the widget
return widget

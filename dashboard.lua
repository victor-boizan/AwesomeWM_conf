--{{{1 awesome libs
local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local dpi = beautiful.xresources.apply_dpi
--}}}1

local icons = require('theme.ressources.icons')
local apps = require('config.apps')

--{{{1 Get screen geometry
local screen_geometry = awful.screen.focused().geometry
local icon_size = beautiful.dashboard_icon_size or dpi(140)
local panel_style = gears.shape.rounded_rect
--}}}1
--{{{1 widget building functions
local buildButton = require('widget.button')
--}}}1
--{{{1 dashboard
local dash = wibox.widget {
	homogeneous     = true,
	expand          = true,
	spacing         = 10,
	forced_num_cols = 9,
	forced_num_rows = 7,
	min_cols_size   = 64,
	min_rows_size   = 64,
	layout          = wibox.layout.grid,
}

dash_height = ((dash.min_rows_size+dash.spacing)*dash.forced_num_rows)-dash.spacing
dash_width = ((dash.min_cols_size+dash.spacing)*dash.forced_num_cols)-dash.spacing

local board=wibox.widget{
	{
		{dash, layout = wibox.layout.flex.horizontal},
		left=(screen_geometry.width-dash_width)/2,
		right=(screen_geometry.width-dash_width)/2,
		top=(screen_geometry.height-dash_height)/2,
		bottom=(screen_geometry.height-dash_height)/2,
		widget = wibox.container.margin
	},
	bg = beautiful.transparent,
	fg = beautiful.widget_fg,
	shape = panel_style,
	widget = wibox.container.background
}
dashboard = wibox({
	x = screen_geometry.x,
	y = screen_geometry.y,
	visible = false,
	ontop = true,
	type = 'splash',
	widget = board,
	bg = beautiful.dashboard_bg,
	height = screen_geometry.height,
	width = screen_geometry.width
})
dashboard:buttons(gears.table.join( -- Middle click - Hide dashboard
awful.button({}, 2, function() dashboard_hide() end),
awful.button({}, 3, function() dashboard_hide() end)))
function dashboard_hide()
	awful.keygrabber.stop(dashboard_grabber)
	dashboard.visible = false
end
function dashboard_show()
	dashboard_grabber = awful.keygrabber.run(
		function(_, key, event)
			if event == 'release' then return end
			if key == 'Escape' or key == 'q' or key == 'x' or key == 'm' then
				dashboard_hide()
			end
		end
	)
	dashboard.visible = true
end
--}}}1
--{{{widgets
--{{{clock
local clock=wibox.widget{
	format = " %H : %M : %S ",
	font = "hack 12",
	refresh = 1,
  align = "center",
	widget = wibox.widget.textclock
}
local clock_widget = wibox.widget{
	{
		{align = "center",clock, layout = wibox.layout.flex.horizontal},
		top = 5,
		bottom = 5,
		widget = wibox.container.margin
	},
	bg = beautiful.widget_bg,
	fg = beautiful.widget_fg,
	shape = panel_style,
	widget = wibox.container.background
}
dash:add_widget_at(clock_widget , 1, 1, 1, 9)
--}}}
--{{{user
local user = buildButton(icons.user,0, 64)
user:connect_signal('button::release', function() files_command(".config") end)

dash:add_widget_at(user , 2, 1, 1, 1)
--}}}
--{{{power
--{{{ power_widgets
--{{{ poweroff
function poweroff_command()
	awful.spawn.with_shell('poweroff')
	awful.keygrabber.stop(_G.dashboard_grabber)
end
local poweroff = buildButton(icons.power, 5, 64)
poweroff:connect_signal('button::release', function() poweroff_command() end)
--}}}
--{{{ reboot
function reboot_command()
	awful.spawn.with_shell('reboot')
	awful.keygrabber.stop(_G.dashboard_grabber)
end
local reboot = buildButton(icons.restart,5, 64)
reboot:connect_signal('button::release', function() reboot_command() end)
--}}}
--{{{ suspend
function suspend_command()
	dashboard_hide()
	awful.spawn.with_shell(apps.default.lock .. ' & systemctl suspend')
end
local suspend = buildButton(icons.sleep,5, 64)
suspend:connect_signal('button::release', function() suspend_command() end)
--}}}
--{{{ exit
function exit_command() _G.awesome.quit() end
local exit = buildButton(icons.logout, 5, 64)
exit:connect_signal('button::release', function() exit_command() end)
--}}}
--{{{ lock
function lock_command()
	dashboard_hide()
	awful.spawn.with_shell('sleep 1 && ' .. apps.default.lock)
end
local lock = buildButton(icons.lock, 5, 64)
lock:connect_signal('button::release', function() lock_command() end)
--}}}
--}}}
--{{{ power bar
local power_options = wibox.widget {
	{
		poweroff,
		reboot,
		suspend,
		exit,
		lock,
		layout = wibox.layout.flex.vertical,
		spacing = 10
	},
	visible = true,
	bg = beautiful.widget_bg,
	shape = panel_style,
	widget = wibox.container.background
}
--}}}
dash:add_widget_at(power_options , 3, 1, 5, 1)
--}}}
--{{{pkg
local pkg = require('widget.package')
dash:add_widget_at(pkg , 2, 2, 1, 2)
--}}}
--{{{settings
setting_widget =  require('widget.arch_status')
--{{{volume
volume_widget = setting_widget("pulsemixer --get-volume | grep -o -e '^..'") 
dash:add_widget_at(volume_widget , 2, 4, 1, 1)
--}}}
--{{{ brightness
brightness_widget = setting_widget("xbacklight")
dash:add_widget_at(brightness_widget , 2, 5, 1, 1)
--}}}
--}}}
--{{{status
local status_widget = require('widget.status')

--{{{battery
local battery_button = buildButton(icons.battery, 5, 64)
local battery_cmd = "cat /sys/class/power_supply/BAT0/capacity"
local battery_widget = status_widget(battery_cmd,battery_button,1)
dash:add_widget_at(battery_widget , 3, 2, 1, 4)
--}}}
--{{{ram
local ram_button = buildButton(icons.ram, 5, 64)
local ram_cmd = "free | grep Mem | awk '{printf($3/$2*100)}'"
local ram_widget = status_widget(ram_cmd,ram_button,1)
dash:add_widget_at(ram_widget , 4, 2, 1, 4)
--}}}
--{{{cpu
local cpu_button = buildButton(icons.cpu, 5, 64)
local cpu_cmd ="iostat -c | grep -E \"^ .*\" | awk '{printf(100-$6)}'"
local cpu_widget = status_widget(cpu_cmd,cpu_button,1)
dash:add_widget_at(cpu_widget , 5, 2, 1, 4)
--}}}
--{{{disks
local disks_timeout = 3600

local ssd_button = buildButton(icons.ssd, 5, 64)
local ssd_cmd = "df | grep -E '/$' | grep -o ..% | tr '%' ' '"
local ssd_widget = status_widget(ssd_cmd,ssd_button,disks_timeout)
dash:add_widget_at(ssd_widget , 6, 2, 1, 4)
--}}}
--{{{hdd
local hdd_button = buildButton(icons.hdd, 5, 64)
local hdd_cmd = "df | grep -E '/home$' | grep -o ..% | tr '%' ' '"
local hdd_widget = status_widget(hdd_cmd,hdd_button,disks_timeout)
dash:add_widget_at(hdd_widget , 7, 2, 1, 4)
--}}}
--}}}
--{{{calandar
local cal = require('widget.calendar')
dash:add_widget_at(cal , 2, 6, 4, 4)
--}}}
--{{{fortune
local fortune = require('widget.fortune')

local fortune_widget = fortune(140,"",600)
dash:add_widget_at(fortune_widget , 6, 6, 2, 4)
--}}}
--}}}

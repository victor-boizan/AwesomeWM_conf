local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require('gears')
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

--local config_path = os.getenv("XDG_CONFIG_HOME").."/awesome"
-- color are based on the nord color theme
local theme = {}

nord = {}
--polar night
nord[0]  = "#2e3440"
nord[1]  = "#3b4252"
nord[2]  = "#434c5e"
nord[3]  = "#4c566a"

--Snow Storm
nord[4]  = "#d8dee9"
nord[5]  = "#e5e9f0"
nord[6]  = "#eceff4"

--Frost
nord[7]  = "#8fbcbb"
nord[8]  = "#88c0d0"
nord[9]  = "#81a1c1"
nord[10] = "#5e81ac"

--Aurora
nord[11] = "#bf616a"
nord[12] = "#d08770"
nord[13] = "#ebcb8b"
nord[14] = "#a3be8c"
nord[15] = "#b48ead"

theme.transparent   = "#00000000"

theme.bg            = nord[1]
theme.bg_alt        = nord[2] 
theme.fg            = nord[6] 
theme.fg_alt        = nord[5] 

theme.occupied      = nord[10]
theme.urgent        = nord[11] 
theme.accent        = nord[8] 
------------------------------------
theme.font          = "hack 6"

theme.wallpaper     = gfs.get_configuration_dir() .. "./config/wallpaper"
------------------------------------
theme.widget_bg     = theme.bg_alt
theme.widget_fg     = theme.fg

theme.dashboard_bg  = theme.bg .. "44"
--homebar
----the homebar itself
theme.wibar_bg          = theme.bg
theme.wibar_border_color= theme.bg
----taglists
theme.taglist_bg_occupied = theme.occupied
theme.taglist_bg_focus = theme.accent
theme.taglist_fg_focus = theme.fg
----tasklists
theme.tasklist_bg_focus = theme.accent
theme.tasklist_bg_normal = theme.bg
theme.tasklist_font = "hack 11"
----textclock
----systray
----progress bar

theme.progressbar_bg = theme.bg
theme.progressbar_fg = theme.fg


theme.calendar_bg       = theme.widget_bg
theme.calendar_days         = theme.bg
theme.calendar_current_day  = theme.accent
theme.calendar_month_name   = theme.fg
theme.calendar_week_day  = theme.fg_alt

theme.button_bg     = theme.transparent
theme.button_fg     = theme.fg

theme.bg_normal     = theme.bg
theme.bg_focus      = theme.accent
theme.bg_urgent     = theme.urgent
theme.bg_minimize   = theme.bg_alt
theme.bg_systray    = theme.bg

theme.fg_normal     = theme.fg
theme.fg_focus      = theme.fg
theme.fg_urgent     = theme.fg
theme.fg_minimize   = nord[9]

theme.useless_gap   = 8
theme.border_width  = 2
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = nord[15]

theme.layoutlist_shape = gears.shape.circle

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.notification_max_width = 640
theme.notification_max_height = 170
theme.notification_icon_size = 150

theme.icon_theme = nil

return theme

local awful = require('awful')

local icon = require('theme.ressources.icons')
local app = require('config.apps')

local tags = {
	{
		name = 'Generic 1',
		icon = icon.one,
		layout = awful.layout.suit.tile,
		tagapp = app.applauncher,
		isgeneral = true,
	},
	{
		name = 'Generic 2',
		icon = icon.two,
		layout = awful.layout.suit.tile,
		tagapp = app.applauncher,
		isgeneral = true,
	},
	{
		name = 'Generic 3',
		icon = icon.tree,
		layout = awful.layout.suit.tile,
		tagapp = app.applauncher,
		isgeneral = true,
	},
	{
		name = 'editor',
		icon = icon.editor,
		layout =  awful.layout.suit.tile,
		tagapp = app.editor,
	},
	{
		name = 'terminal',
		icon = icon.terminal,
		layout =  awful.layout.suit.tile,
		tagapp = app.terminal,
	},
	{
		name = 'File manager',
		icon = icon.filemanager,
		layout =  awful.layout.suit.tile,
		tagapp = app.filemanager,
	},
	{
		name = 'web',
		icon = icon.browser,
		layout = awful.layout.suit.tile,
		tagapp = app.browser,
	},
	{
		name = 'todo',
		icon = icon.todo,
		layout =  awful.layout.suit.tile,
		tagapp = app.editor,
	},
	{
		name = 'chill',
		icon = icon.chill,
		layout =  awful.layout.suit.max,
		tagapp = app.music,
	},
	{
		name = 'social',
		icon = icon.social,
		layout =  awful.layout.suit.tile,
		tagapp = app.social,
	}
}

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.max,
	awful.layout.suit.fair,
	awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(function(s)
	for i, tag in pairs(tags) do
		awful.tag.add(i, {
			name = tag.name,
			icon = tag.icon,
			icon_only = true,
			layout = tag.layout,
			gap_single_client = true,
			gap = 4,
			screen = s,
			isgeneral = tag.isgeneral,
			tagapp = tag.tagapp,
			selected = i == 1
		})
	end
end)

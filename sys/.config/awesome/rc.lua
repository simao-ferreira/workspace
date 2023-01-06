--                                                   _     _            _
--   __ ___      _____  ___  ___  _ __ ___   ___    | |__ | | __ _  ___| | __
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \___| '_ \| |/ _` |/ __| |/ /
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/___| |_) | | (_| | (__|   <
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|   |_.__/|_|\__,_|\___|_|\_\
--
-- Arch: https://wiki.archlinux.org/title/Awesome
-- Awesome: https://awesomewm.org/apidoc/index.html

pcall(require, "luarocks.loader")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local wibox = require("wibox")

require("error_handler")
require("settings")
require("theme")
require("layout")
require("rules")
require("bindings")
require("tags")
require("menu")
require("bars")


require("signals")

-- -- {{{ Menu
-- -- Create a launcher widget and a main menu
-- myawesomemenu = {
-- 	{
-- 		"hotkeys",
-- 		function()
-- 			hotkeys_popup.show_help(nil, awful.screen.focused())
-- 		end,
-- 	},
-- 	{ "manual", terminal .. " -e man awesome" },
-- 	{ "edit config", editor_cmd .. " " .. awesome.conffile },
-- 	{ "restart", awesome.restart },
-- 	{
-- 		"quit",
-- 		function()
-- 			awesome.quit()
-- 		end,
-- 	},
-- }
--
-- mymainmenu = awful.menu({
-- 	items = {
-- 		{ "awesome", myawesomemenu, beautiful.awesome_icon },
-- 		{ "open terminal", terminal },
-- 	},
-- })
--
-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
--
-- -- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- -- }}}
--
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- -- {{{ Wibar
-- -- Create a textclock widget
-- mytextclock = wibox.widget.textclock()
--
-- -- Create a wibox for each screen and add it
-- local taglist_buttons = gears.table.join(
-- 	awful.button({}, 1, function(t)
-- 		t:view_only()
-- 	end),
-- 	awful.button({ modkey }, 1, function(t)
-- 		if client.focus then
-- 			client.focus:move_to_tag(t)
-- 		end
-- 	end),
-- 	awful.button({}, 3, awful.tag.viewtoggle),
-- 	awful.button({ modkey }, 3, function(t)
-- 		if client.focus then
-- 			client.focus:toggle_tag(t)
-- 		end
-- 	end),
-- 	awful.button({}, 4, function(t)
-- 		awful.tag.viewnext(t.screen)
-- 	end),
-- 	awful.button({}, 5, function(t)
-- 		awful.tag.viewprev(t.screen)
-- 	end)
-- )
--
-- local tasklist_buttons = gears.table.join(
-- 	awful.button({}, 1, function(c)
-- 		if c == client.focus then
-- 			c.minimized = true
-- 		else
-- 			c:emit_signal("request::activate", "tasklist", { raise = true })
-- 		end
-- 	end),
-- 	awful.button({}, 3, function()
-- 		awful.menu.client_list({ theme = { width = 250 } })
-- 	end),
-- 	awful.button({}, 4, function()
-- 		awful.client.focus.byidx(1)
-- 	end),
-- 	awful.button({}, 5, function()
-- 		awful.client.focus.byidx(-1)
-- 	end)
-- )
--
local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
-- 	s.mytaglist = awful.widget.taglist({
-- 		screen = s,
-- 		filter = awful.widget.taglist.filter.all,
-- 		buttons = taglist_buttons,
-- 	})
--
-- 	-- Create a tasklist widget
-- 	s.mytasklist = awful.widget.tasklist({
-- 		screen = s,
-- 		filter = awful.widget.tasklist.filter.currenttags,
-- 		buttons = tasklist_buttons,
-- 	})
--
-- 	-- Create the wibox
-- 	s.mywibox = awful.wibar({ position = "top", screen = s })
--
-- 	-- Add widgets to the wibox
-- 	s.mywibox:setup({
-- 		layout = wibox.layout.align.horizontal,
-- 		{ -- Left widgets
-- 			layout = wibox.layout.fixed.horizontal,
-- 			mylauncher,
-- 			s.mytaglist,
-- 			s.mypromptbox,
-- 		},
-- 		s.mytasklist, -- Middle widget
-- 		{ -- Right widgets
-- 			layout = wibox.layout.fixed.horizontal,
-- 			mykeyboardlayout,
-- 			wibox.widget.systray(),
-- 			mytextclock,
-- 			s.mylayoutbox,
-- 		},
-- 	})
end)

-- Autorun at startup
awful.spawn.with_shell("bash ~/.config/awesome/main/autorun.sh")

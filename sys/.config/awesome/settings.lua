local xrdb = require("beautiful.xresources").get_current_theme()

color = {
	bg = xrdb.background,
	fg = xrdb.foreground,
	black = xrdb.color0,
	red = xrdb.color1,
	green = xrdb.color2,
	yellow = xrdb.color3,
	blue = xrdb.color4,
	magenta = xrdb.color5,
	cyan = xrdb.color6,
	white = xrdb.color7,
	gray = xrdb.color8,
}

-- TODO: Use gears.filesystem.file_readable (filename) to check is wallpaper exists
-- if not, default, or send an error
wallpaper = os.getenv("HOME") .. "/workspace/wallpapers/wallhaven-o3ew8p.png"


terminal = "alacritty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

apps = {
	terminal = "alacritty",
	editor = "nvim",
	launcher = "rofi -show drun",
	browser = "firefox",
	picture = "feh",
	fileManager = "nautilus",
	email = "thunderbird",
}
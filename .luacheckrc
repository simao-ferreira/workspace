-- This file itself
files[".luacheckrc"].ignore = { "111", "112", "131" }

-- Global objects defined by the C code
read_globals = {
    "awesome",
    "button",
    "dbus",
    "drawable",
    "drawin",
    "key",
    "keygrabber",
    "mousegrabber",
    "selection",
    "tag",
    "window",
    "table.unpack",
    "math.atan2",
}

globals = {
    "screen",
    "mouse",
    "root",
    "client",
}

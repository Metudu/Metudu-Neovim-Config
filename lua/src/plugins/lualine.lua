local status, lualine = pcall(require,"lualine")
if not status then
    return
end

local lualine_nightfly = require("lualine.themes.nightfly")
local new_colors = {
    green  = "#28EF00",
    blue   = "#65D1FF",
    violet = "#FF62EF",
    black  = "#000000",
    yellow = "#FFDA7B",
}

lualine_nightfly.normal.a.bg = new_colors.green
lualine_nightfly.insert.a.bg = new_colors.blue
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
    a = {
        gui = "bold",
        bg  = new_colors.yellow,
        fg  = new_colors.black,
    },
}


lualine.setup({
    options = {theme = lualine_nightfly}
})

-- Imports
require("color")

-- Main functions
function love.load()
    -- Global colors
    Color_background = Color:random()
end

function love.draw()
    love.graphics.clear(Color_background:rgba())
end

function love.update()
    Color_background:randomize_rgb()
end

-- Imports
require("color")
require("utils")

-- Main functions
function love.load()
    -- Global colors
    Color_background = Color:new(0.5, 0.5, 0.5)
end

function love.draw()
    love.graphics.clear(Color_background:rgba())
end

function love.update()

end

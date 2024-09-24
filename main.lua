-- Imports
require("color")
require("utils")

-- Main functions
function love.load()
    -- Global colors
    Color_background = Color:random()
end

function love.draw()
    love.graphics.clear(Color_background:rgba())
    print(Color_background)
end

function love.update()

end

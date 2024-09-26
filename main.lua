-- Imports
require("color")
require("timer")
require("timerManager")

-- Main functions
function love.load()
    -- Global variables
    Color_background = Color:random()
    Timer_manager = TimerManager:initiate()

    -- Timers
    Timer_1sec = Timer_manager:create_timer({
        duration = 1,
        autostart = true,
        repeating = true,
        callback = function ()
            Color_background:randomize_rgb()
        end
    })
end

function love.draw()
    love.graphics.clear(Color_background:rgb())
end

function love.update(delta)
    Timer_manager:update(delta)
    --print(Timer_manager)
end


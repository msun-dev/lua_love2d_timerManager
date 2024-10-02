-- Imports
require("timer")
require("timerManager")

-- Main functions
function love.load()
    -- Global variables
    Timer_manager = TimerManager:new()

    -- Timers
    Timer_1sec = Timer_manager:create_timer({
        callback = function ()
            print("1 second")
        end
    })

    Timer_5sec = Timer_manager:create_timer({
        duration = 5,
        autostart = true,
        repeating = true,
        callback = function ()
            print("5 seconds")
        end
    })
end

function love.draw()
    love.graphics.clear()
end

function love.update(delta)
    Timer_manager:update(delta)
    --print(Timer_manager)
end


-- Imports
require("timer")
require("timerManager") -- Optionally you can only import timerManager

-- Initialising timer managers
Timer_manager_default = TimerManager.new({name="TimerManager-Default"})
Timer_manager_chain = TimerManager.new({name="TimerManager-Chain"})

function love.load()
    -- Love2D settings
    love.window.setMode(900, 250)
    Font = love.graphics.newFont("Verdana.ttf", 12)

    -- Timers insitialisation
    -- Simple timers
    Timer_1sec = Timer_manager_default:create_timer({
        duration = 1,
        autostart = true,
        repeating = true,
        callback = function () end
    })

    Timer_3sec = Timer_manager_default:create_timer({
        duration = 3,
        autostart = true,
        repeating = true,
        callback = function () end
    })

    Timer_5sec = Timer_manager_default:create_timer({
        duration = 5,
        autostart = true,
        repeating = true,
        callback = function () end
    })

    -- Chained timers
    Timer_chain1 = Timer_manager_chain:create_timer({
        duration = 5,
        autostart = true,
        repeating = false,
        autoremove = false,
        callback = function ()
            local t = Timer_manager_chain:get_timer(Timer_chain2)
            t:start()
        end
    })

    Timer_chain2 = Timer_manager_chain:create_timer({
        duration = 5,
        autostart = false,
        repeating = false,
        autoremove = false,
        callback = function ()
            local t = Timer_manager_chain:get_timer(Timer_chain1)
            t:start()
        end
    })
end

function love.update(delta)
    -- Updating every timer manager 
    Timer_manager_default:update(delta)
    Timer_manager_chain:update(delta)
end

function love.draw()
    -- Debug info
    love.graphics.setFont(Font)
    love.graphics.print(Timer_manager_default:__tostring(), 0, 0)
    love.graphics.print(Timer_manager_chain:__tostring(), 0, 75)
end


-- Imports
require("timerManager.timerManager")
require("timerManager.timer") -- Optionally you can only import timerManager
require("misc.preview") -- Preview logic

-- Initialising timer managers
Timer_manager_default = TimerManager.new({name="TimerManager-Default"})
Timer_manager_chain = TimerManager.new({name="TimerManager-Chain"})

function love.load()
    -- Love2D settings
    love.window.setMode(900, 350)
    love.window.setTitle("Title Manager preview")
    Font = love.graphics.newFont("misc/Verdana.ttf", 12)

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
    love.graphics.setColor({255,255,255})
    love.graphics.setFont(Font)
    -- Default timer manager
    draw_debug(Timer_manager_default, {x=10, y=10}, Font)
    draw_debug(Timer_manager_chain, {x=10, y=160}, Font)
end
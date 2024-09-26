require("timer")

TimerManager = {
    uuid = "",
    timers = {}
}
TimerManager.__index =  TimerManager
TimerManager.__type = "TimerManager"

function TimerManager:initiate()
    local object = {}
    setmetatable(object, TimerManager)
    return object
end

function TimerManager:create_timer(settings)
    local timer = Timer:new(settings)
    self.timers[timer.uuid] = timer
    return timer.uuid
end

function TimerManager:remove_timer(name)
    -- self.timers.remove(timer) ?
end

function TimerManager:get_timer(timer_name)
    return self.timers[timer_name]
end

function TimerManager:update(delta)
    -- TODO
    for i, timer in pairs(self.timers) do
        timer:update(delta)
        if timer:get_timeleft() < 0 then print("remove table") end
    end
    -- for every timer in self.timers
        -- timer:update(delta) 
        -- if timer.ended and timer.repeating() then self:remove_timer(timer) end
        -- else timers.remove(timer)
end

function TimerManager:__tostring()
    for timer in self.timers do
        print("\tCurrent timers:\n"..string.format(timer:__tostring().."\n"))
    end
end
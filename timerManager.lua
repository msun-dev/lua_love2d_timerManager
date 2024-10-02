require("timer")

TimerManager = {
    timers = {}
}
TimerManager.__index =  TimerManager
TimerManager.__type = "TimerManager"

function TimerManager:new()
    local object = {}
    setmetatable(object, TimerManager)
    return object
end

function TimerManager:create_timer(settings)
    local timer = Timer.new(settings)
    self.timers[timer.uuid] = timer
    return timer.uuid
end

function TimerManager:remove_timer(timer_name)
    self.timers[timer_name] = nil
end

function TimerManager:get_timer(timer_name)
    return self.timers[timer_name]
end

function TimerManager:update(delta) 
    for i, timer in pairs(self.timers) do
        timer:update(delta)
        if timer:get_timeleft() < 0 and timer.repeating ~= true then self:remove_timer(timer.uuid) end
    end
end

function TimerManager:__tostring()
    local out = "Current timers:\n"
    for i, timer in pairs(self.timers) do
        out = string.format(out.."\t"..timer:__tostring().."\n")
    end
    return out
end
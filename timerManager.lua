require("timer")

local template = ("Timer-xxxxxxxx")

TimerManager = {
    name = "TimerManager",
    timers = {}
}

function TimerManager:new(settings)
    local object = setmetatable({}, {__index = TimerManager})
    object.name = (settings.name or "TimerManager")
    object.timers = {}
    return object
end

-- Getters/Setters
function TimerManager:get_timer(timer_name)
    return self.timers[timer_name]
end

-- User methods
function TimerManager:update(delta)
    for i, timer in pairs(self.timers) do
        timer:update(delta)
        if timer:get_timeleft() < 0
            and not timer.repeating
            and timer.autoremove
                then self:remove_timer(timer.uuid) end
    end
end

function TimerManager:create_timer(settings)
    local timer = Timer.new(settings)
    timer.uuid = self:gen_uuid()
    self.timers[timer.uuid] = timer
    return timer.uuid
end

function TimerManager:remove_timer(timer_name)
    self.timers[timer_name] = nil
end

-- TimerManager methods
function TimerManager:gen_uuid()
	local uuid = string.gsub(template, "[x]", function(c)
		local s = love.math.random(0, 0xf)
		return string.format("%x", s)
	end)
	return string.format(uuid)
end

-- Metamethods
function TimerManager:__tostring()
    local out = string.format(self.name.." - Current timers:\n")
    for i, timer in pairs(self.timers) do
        out = string.format(out.."\t"..timer:__tostring().."\n")
    end
    return out
end

Timer = {
    uuid = "",
    duration = 1,
    autostart = true,
    repeating = false,
    autoremove = false,
    callback = nil,
    time_left = 0,
    stopped = true
}
Timer.__index = Timer

-- General methods
function Timer.new(settings)
    local object = {}
    setmetatable(object, Timer)
    assert(settings.callback, string.format("%s: Missing callback for timer.", object.uuid))
    settings.duration = (settings.duration or object.duration)
    settings.autostart =  (object.autostart or settings.autostart)
    settings.repeating =  (object.repeating or settings.repeating)
    object.callback = settings.callback
    if object.autostart then object:start() end
    return object
end

-- Getters/setters
function Timer:get_timeleft()
    return self.time_left
end

function Timer:is_stopped()
    return self.stopped
end

-- User methods
function Timer:start()
    self.time_left = self.duration
    self.stopped = false
end

function Timer:stop()
    self.stopped = false
end

function Timer:execute()
    self.callback()
    if  self.repeating then
        self:start()
    else
        self.stopped = true
    end
end

function Timer:update(delta)
    if self.stopped then return end
    if self.time_left < 0.0 then self:execute() end
    self.time_left = self.time_left - delta
end

-- Metamethods
function Timer:__tostring()
     return string.format(self.uuid..
                        " | Duration: "..self.duration..
                        " | Autostart: "..tostring(self.autostart)..
                        " | Repeating: "..tostring(self.repeating)..
                        " | Stopped: "..tostring(self.stopped)..
                        " | Autoremove:"..tostring(self.autoremove)..
                        " | Time left: "..self.time_left)
end

function Timer:__add(time)
    self.time_left = self.time_left + time
end

function Timer:__sub(time)
    self.time_left = self.time_left - time
end

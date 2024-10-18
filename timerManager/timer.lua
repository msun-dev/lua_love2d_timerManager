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

-- General methods
function Timer.new(settings)
    local object = setmetatable({}, {__index = Timer})
    assert(settings.callback, string.format("%s: Missing callback for timer.", object.uuid))
    if settings.duration ~= nil then object.duration = settings.duration end
    if settings.autostart ~= nil then object.autostart = settings.autostart end
    if settings.repeating ~= nil then object.repeating = settings.repeating end
    if settings.autoremove ~= nil then object.autoremove = settings.autoremove end
    object.callback = settings.callback
    if object.autostart then object:start() end
    return object
end

-- Getters/setters
function Timer:get_timeleft()
    return self.time_left
end

function Timer:get_duration()
    return self.duration
end

function Timer:set_duration(value)
    self.duration = value
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

function Timer:__add(value)
    self.time_left = self.time_left + value
end

function Timer:__sub(value)
    self.time_left = self.time_left - value
end

local Utils = require("utils")

Timer = {
    uuid = "",           -- Assigned randomly
    duration = 1,        -- Timer duration
    autostart = true,    -- Starts automatically after creating
    repeating = false,   -- Repeats automatically after ending
    callback = nil,      -- Called upon ending

    time_left = 0,       -- How much time left
    process = false,     -- Is timer running?
    stopped = false      -- Becomes true when ended
}
Timer.__index = Timer
Timer.__type = "Timer"

-- General methods
function Timer:new(settings)
    self.uuid = Utils.gen_uuid(self.__type)
    assert(settings ~= nil, string.format("%s%s: Missing settings", self.__type, self.uuid))
    assert(settings.callback ~= nil, string.format("%s%s: Missing callback for timer.", self.__type, self.uuid))
    local object = {}
    setmetatable(object, Timer)
    self.duration = settings.duration or self.duration
    self.autostart = settings.autostart or self.autostart
    self.repeating = settings.repeating or self.repeating
    self.callback = settings.callback
    return object
end

function Timer:get_type()
    return self.__type
end

function Timer:get_timeleft()
    return self.time_left
end

function Timer:is_stopped()
    return self.stopped
end

-- Timer methods
function Timer:start()
    self.time_left = self.duration
    self.process = true
end

function Timer:stop()
    -- FIXME: Will not work with autostart timer
    self.process = false
end

function Timer:execute()
    self.callback()
    self.stopped = true
end

function Timer:update(delta)
    if self.autostart and self.process == false then self:start() end
    if self.process == false then return end
    self.time_left = self.time_left - delta
    if self.time_left < 0.0 then
        self:execute()
    end
end

-- Metamethods
function Timer:__tostring()
     return string.format(self.uuid..
                        "|Duration: "..self.duration..
                        "|Autostart: "..tostring(self.autostart)..
                        "|Repeating: "..tostring(self.repeating)..
                        -- TODO: Add callback body?
                        "|Time left: "..self.time_left..
                        "|Stopped: "..tostring(self.stopped))
end

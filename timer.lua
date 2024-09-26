local Utils = require("utils")

Timer = {
    uuid = "",           -- Assigned randomly
    duration = 1,        -- Timer duration
    autostart = true,    -- Starts automatically after creating
    repeating = false,   -- Repeats automatically after ending
    callback = nil,      -- Called upon ending

    time_left = 0,       -- How much time left
    stopped = true       -- Is timer running?
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
    if settings.duration ~= nil then self.duration = settings.duration end
    if settings.autostart ~= nil then self.autostart = settings.autostart end
    if settings.repeating ~= nil then self.repeating = settings.repeating end
    self.callback = settings.callback
    if self.autostart then self:start() end
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
    self.stopped = false
end

function Timer:stop()
    -- FIXME: Will not work with autostart timer
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
    -- if self.autostart and self.stopped then
    --     self:start()
    --     print("from autostart")
    -- end
    if self.repeating and self.stopped then 
        self:start() 
        print("from repeating")
    end
    if self.stopped == true then return end
    self.time_left = self.time_left - delta
    if self.time_left < 0.0 then self:execute() end
end

-- Metamethods
function Timer:__tostring()
     return string.format(self.uuid..
                        "| Duration: "..self.duration..
                        "| Autostart: "..tostring(self.autostart)..
                        "| Repeating: "..tostring(self.repeating)..
                        -- TODO: Add callback body?
                        "| Time left: "..self.time_left..
                        "| Stopped: "..tostring(self.stopped))
end

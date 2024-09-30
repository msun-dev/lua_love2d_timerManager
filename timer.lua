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
Timer.__type = "Timer"
Timer.__index = Timer

-- General methods
function Timer.new(settings)
    local object = {}
    setmetatable(object, Timer)
    object.uuid = Utils.gen_uuid(object.__type)
    
    assert(settings, string.format("%s: Missing settings", object.uuid))
    assert(settings.callback, string.format("%s: Missing callback for timer.", object.uuid))
    
    if settings.duration ~= nil then object.duration = settings.duration end
    if settings.autostart ~= nil then object.autostart = settings.autostart end
    if settings.repeating ~= nil then object.repeating = settings.repeating end
    object.callback = settings.callback
    if object.autostart then object:start() end
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

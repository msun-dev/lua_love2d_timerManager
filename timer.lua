local Utils = require("utils")

Timer = {
    uuid = "",           -- Assigned randomly
    duration = 1,      -- Timer duration
    autostart = true,    -- Starts automatically after creating
    repeating = false,   -- Repeats automatically after ending
    callback = nil,      -- Called upon ending

    time_left = 0,     -- How much time left
    process = false,     -- Is timer running?
    ended = false        -- Becomes true when ended
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
    self.callback = settings.callback
    self.autostart = settings.autostart or self.autostart
    self.repeating = settings.repeating or self.repeating
    return object
end

function Timer:get_type()
    return self.__type
end

-- Timer methods
function Timer:start()
    self.time_left = self.duration
    self.process = true
end

function Timer:stop()
    self.process = false
end

function Timer:execute()
    self.callback()
    self.ended = true
    self.process = false -- Remove when timerManager implemented
end

function Timer:update(delta)
    if self.autostart and self.process == false then
        print("autostart!")
        self:start()
    end
    -- Updates time left to a timer
    --print("upd")
    if self.process == false then return end
    --print(string.format("Update after "..tostring(self.process)))


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
                        -- Add callback body?
                        "|Time left: "..self.time_left..
                        "|Ended: "..tostring(self.ended))
end

local utils = require("utils")

Color = {
	r=0,
	g=0,
	b=0,
	a=0
}
Color.__index = Color

-- function Color:__tostring()
-- 	local string = "Color: \n"
-- 	string = string .. "R: " .. self.r .. ". G: " .. self.g .. ". B: " .. self.b .. "."
-- 	return string
-- end

-- Methods
function Color:new(r, g, b, a)
	local object = {}
	setmetatable(object, Color)
	if r then object.r = r else object.r = 0.0 end
	if g then object.g = g else object.g = 0.0 end
	if b then object.b = b else object.b = 0.0 end
	if a then object.a = a else object.a = 1.0 end
	return object
end

function Color:random()
	local object = {}
	setmetatable(object, Color)
	math.randomseed(os.time())
	object.r = utils.strip(math.random(), 2)
	object.g = utils.strip(math.random(), 2)
	object.b = utils.strip(math.random(), 2)
	object.a = 1.0
	print(object.r, object.g, object.b)
	return object
end

function Color:rgba()
	return self.r, self.g, self.b, self.a
end

function Color:rgb()
	return self.r, self.g, self.b
end

-- Metamethods
function Color:__tostring()
	if self.a < 1 then
		return string.format(
			"#%02x%02x%02x%02x",
			utils.round(self.r * 0xff),
			utils.round(self.g * 0xff),
			utils.round(self.b * 0xff),
			utils.round(self.a * 0xff)
		)
	else
		return string.format(
			"#%02x%02x%02x",
			utils.round(self.r * 0xff),
			utils.round(self.g * 0xff),
			utils.round(self.b * 0xff)
		)
	end
end

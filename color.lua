local Utils = require("utils")

local Color_precision = 2

Color = {
	r=0,
	g=0,
	b=0,
	a=0
}
Color.__index = Color
Color.__type = "Color"

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

function Color:invert()
	self.r = math.abs(self.r - 1)
	self.g = math.abs(self.g - 1)
	self.b = math.abs(self.b - 1)
end

function Color:random()
	local object = {}
	setmetatable(object, Color)
	math.randomseed(os.time())
	object.r = Utils.strip(math.random(), Color_precision)
	object.g = Utils.strip(math.random(), Color_precision)
	object.b = Utils.strip(math.random(), Color_precision)
	object.a = 1.0
	return object
end

function Color:randomize_rgb()
	self.r = Utils.strip(math.random(), Color_precision)
	self.g = Utils.strip(math.random(), Color_precision)
	self.b = Utils.strip(math.random(), Color_precision)
end

function Color:randomize_rgba()
	self:randomize_rgb()
	self.a = Utils.strip(math.random(), Color_precision)
end

function Color:rgba()
	return self.r, self.g, self.b, self.a
end

function Color:rgb()
	return self.r, self.g, self.b
end

function Color:get_type()
	return self.__type
end

-- Metamethods
function Color:__tostring()
	if self.a < 1 then
		return string.format(
			"#%02x%02x%02x%02x",
			Utils.round(self.r * 0xff),
			Utils.round(self.g * 0xff),
			Utils.round(self.b * 0xff),
			Utils.round(self.a * 0xff)
		)
	else
		return string.format(
			"#%02x%02x%02x",
			Utils.round(self.r * 0xff),
			Utils.round(self.g * 0xff),
			Utils.round(self.b * 0xff)
		)
	end
end

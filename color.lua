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
function Color.new(parameters)
	local object = {}
	setmetatable(object, Color)
	object.r = 0.0 or parameters.r
	object.g = 0.0 or parameters.g
	object.b = 0.0 or parameters.b
	object.a = 1.0 or parameters.a
	return object
end

function Color:invert()
	self.r = math.abs(self.r - 1)
	self.g = math.abs(self.g - 1)
	self.b = math.abs(self.b - 1)
end

function Color.new_random()
	local object = {}
	setmetatable(object, Color)
	object.r = Color.generate_color()
	object.g = Color.generate_color()
	object.b = Color.generate_color()
	object.a = 1.0
	return object
end

function Color:randomize_rgb()
	self.r = Color.generate_color()
	self.g = Color.generate_color()
	self.b = Color.generate_color()
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

function Color.generate_color()
	return Utils.strip(love.math.random(), Color_precision)
end
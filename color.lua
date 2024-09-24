--local utils = require(utils.lua)

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
	local color = {}
	setmetatable(color, Color)
	if r then color.r = r else color.r = 0 end
	if g then color.g = g else color.g = 0 end
	if b then color.b = b else color.b = 0 end
	if a then color.a = a else color.a = 1 end
	return color
end

-- Metamethods
function Color:__tostring()
	if self.a < 1 then
		return string.format(
			"#%02x%02x%02x%02x",
			self.r,
			self.g,
			self.b,
			self.a
		)
	else
		return string.format(
			"#%02x%02x%02x",
			self.r,
			self.g,
			self.b
		)
	end
end
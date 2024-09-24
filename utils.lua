local Utils = {}
Utils.__index = Utils

function Utils.round(x)
	return x + 0.5 - (x + 0.5) % 1
end

function Utils.clamp(x, min, max)
	return x < min and min or x > max and max or x
end

function Utils.strip(num, decimals)

end
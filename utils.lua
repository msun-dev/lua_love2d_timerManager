local utils = {}

function utils.round(x)
	return x + 0.5 - (x + 0.5) % 1
end

function utils.clamp(x, min, max)
	return x < min and min or x > max and max or x
end

function utils.strip(num, decimals)
	return string.sub(num * 10 ^ decimals, 0, decimals) / 10 ^ decimals
end

return utils
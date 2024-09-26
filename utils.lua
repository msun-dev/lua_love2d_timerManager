local utils = {}
local seed = os.time()

function utils.round(x)
	return x + 0.5 - (x + 0.5) % 1
end

function utils.clamp(x, min, max)
	return x < min and min or x > max and max or x
end

function utils.strip(num, decimals)
	return string.sub(num * 10 ^ decimals, 0, decimals) / 10 ^ decimals
end

function utils.gen_uuid(prefix)
	math.randomseed(seed)
	local template = ("-xxxxxxxx-xxxx-xxxx-xxxxxxxx")
	local uuid = string.gsub(template, "[x]", function(c)
		local s = math.random(0, 0xf)
		return string.format("%x", s)
	end)
	return string.format(prefix .. uuid)
end

return utils

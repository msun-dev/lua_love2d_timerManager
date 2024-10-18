-- Only for the sake of preview.
-- You can safely remove this file.

local foreground_padding = 2 -- Add support
local background_color = {255, 255, 255} -- Change to outline

function DrawProgressBar(fraction, position, size, color)
    -- percent filled: number - 95; 12.5; etc.
    -- position: {x, y}
    -- size: {w, h}
    -- color: {r, g, b}
    draw_background(position, size)
    draw_progress(fraction, position, size, color)
end

function draw_background(position, size)
    -- Drawmode.line
    love.graphics.setColor(background_color)
    love.graphics.rectangle("line", position.x, position.y, size.w, size.h)
end

function draw_progress(fraction, position, size, color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill",
                position.x + foreground_padding, position.y + foreground_padding,
                clamp(size.w * fraction - foreground_padding * 2), size.h - foreground_padding * 2)
end

function clamp(value)
    if value < 0 then return 0 else return value end
end

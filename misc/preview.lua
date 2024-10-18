-- Only for the sake of preview.
-- You can safely remove this file.

local font_color = {255,255,255}
local timer_debug_upper_margin = 25

local timer_debug_lines = 3
local timer_debug_left_margin = 25

local progressbar_left_margin = 75
local progressbar_size = {w = 100,h = 25}
local progressbar_inner_color = {255,255,255}
local progressbar_outer_color = {255,255,255}
local progressbar_outer_margin = 3


function draw_debug(manager, position, font)
    draw_manager_debug(manager, position, font)
    local timer_debug_pos = {}
    local lines = manager:get_timer_count()
    timer_debug_pos.y = timer_debug_upper_margin + lines * font:getHeight()
    local index = 0
    for key, timer in pairs(manager:get_timers()) do
        timer_debug_pos.x = timer_debug_left_margin + position.x
                            + index * (progressbar_size.w +  progressbar_left_margin)
        draw_timer_debug(timer, timer_debug_pos, font)
        index = index + 1
    end
end

function draw_manager_debug(manager, position, font)
    love.graphics.setColor(font_color)
    love.graphics.setFont(font)
    love.graphics.print(manager:__tostring(), position.x, position.y)
end

function draw_timer_debug(timer, position, font)
    draw_timer_data(timer, position, font)
    local progress = timer:get_timeleft() / timer:get_duration()
    local timer_debug_pos = {}
    timer_debug_pos.x = position.x
    timer_debug_pos.y = position.y + font:getHeight() * timer_debug_lines
    draw_timer_progress(progress, timer_debug_pos)
end

function draw_timer_data(timer, position, font)
    love.graphics.setColor(font_color)
    love.graphics.setFont(font)
    love.graphics.print(timer:get_uuid(), position.x, position.y)
    love.graphics.print(string.format("Duration: ".. timer:get_duration()), position.x, position.y + font:getHeight())
    love.graphics.print(string.format("Time left: " .. timer:get_timeleft()), position.x, position.y + 2 * font:getHeight())
end

function draw_timer_progress(progress, position)
    draw_background(position)
    draw_progress(progress, position)
end

function draw_background(position)
    love.graphics.setColor(progressbar_outer_color)
    love.graphics.rectangle("line", position.x, position.y,
                            progressbar_size.w, progressbar_size.h)
end

function draw_progress(progress, position)
    love.graphics.setColor(progressbar_inner_color)
    love.graphics.rectangle("fill",
                position.x + progressbar_outer_margin, position.y + progressbar_outer_margin,
                clamp(progressbar_size.w * progress - progressbar_outer_margin * 2), -- TO-DO: remove multiplication
                progressbar_size.h - progressbar_outer_margin * 2)
end

function clamp(value)
    if value < 0 then return 0 else return value end
end

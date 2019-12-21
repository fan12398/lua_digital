-- ***************************************************************************
-- Digital tube Version 0.0.1
--
-- Written by Fantl
--
-- MIT license, http://opensource.org/licenses/MIT
-- ***************************************************************************
--==========================Module Part======================
local M = {}
--=========================Local Args=======================
local led_num = 8
--local table = {0,1,2,3,5,9,16,27,48,84,147,255}
local table = {0,1,1,2,3,4,6,8,11,16,23,32,45,64,90,128,180,255}
local bn = 1
local pos = 1
local tm = 0
local buffer
local timer
--================================

local function update()
    tm = tm + 1
    buffer:set(pos, table[bn], table[bn], 0)
    ws2812.write(buffer)

    bn = bn + 1
    if bn > #table then
        bn = 1
        if pos < led_num then
            pos = pos + 1
            --timer:stop()
        end
    end
end

function M.init(num)
    gpio.mode(1, gpio.OUTPUT)
    gpio.write(1, gpio.HIGH)
    ws2812.init()
    if num~=nil then
        led_num = num
    end
    buffer = ws2812.newBuffer(led_num, 3)
    timer = tmr.create()
    timer:register(30, tmr.ALARM_AUTO, update)
end

function M.reset()
    tm = 0
    timer:stop()
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
    bn = 1
    pos = 1
end

function M.start()
    timer:start()
end

function M.stop()
    timer:stop()
end

function M.get_time()
    return(tm)
end

return M

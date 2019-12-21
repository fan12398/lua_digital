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
local table = {0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0xff}
local num_d = {10,10,10,10}
local disp = 0
local timer
--================================

function M.set(num)
    num_d[4] = math.floor(num/1000%10)
    if num_d[4]==0 then
        num_d[4] = 10
    end
    num_d[3] = math.floor(num/100%10)
    if num_d[4]==10 and num_d[3]==0 then
        num_d[3] = 10
    end
    num_d[2] = math.floor(num/10%10)
    if num_d[4]==10 and num_d[3]==10 and num_d[2]==0 then
        num_d[2] = 10
    end
    num_d[1] = num%10
end

function M.set_blank()
    num_d[4] = 10
    num_d[3] = 10
    num_d[2] = 10
    num_d[1] = 10
end

local function display()
    tosend = bit.bor(bit.lshift(table[num_d[disp+1]+1], 8), bit.lshift(1, disp))
    spi.send(1, tosend)
    disp = (disp + 1)%4
end

function M.init()
    spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 16, 4)
    timer = tmr.create()
    timer:register(3, tmr.ALARM_AUTO, display)
    timer:start()
end

return M

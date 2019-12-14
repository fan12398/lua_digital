spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 16, 4)

__table = {0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0xff}
__num_d = {10,10,10,10}
__dl_i = 0
function digital_led()
    tosend = bit.bor(bit.lshift(__table[__num_d[__dl_i+1]+1], 8), bit.lshift(1, __dl_i))
    spi.send(1, tosend)
    __dl_i = (__dl_i + 1)%4
end

function set_num(num)
    __num_d[4] = math.floor(num/1000%10)
    __num_d[3] = math.floor(num/100%10)
    __num_d[2] = math.floor(num/10%10)
    __num_d[1] = num%10
end

local mytimer = tmr.create()
mytimer:register(3, tmr.ALARM_AUTO, digital_led)
mytimer:start()

set_num(1992)
local addtimer = tmr.create()
time = 234
addtimer:register(1000, tmr.ALARM_AUTO, function() time=time+1 set_num(time) end)
addtimer:start()




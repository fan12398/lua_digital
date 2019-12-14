led_num = 8

gpio.mode(1, gpio.OUTPUT)
gpio.write(1, gpio.HIGH)

ws2812.init()
buffer = ws2812.newBuffer(led_num, 3)
bl = 0
pos = 1
tmr.create():alarm(50, 1, function()
        bl = (bl + 2)%200
        if bl==0 then
            if pos<led_num then
                pos = pos + 1
            end
        end
        buffer:set(pos, bl, bl, bl)
        ws2812.write(buffer)
    end)

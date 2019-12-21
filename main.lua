dt = require("digit")
dt.init()
dt.set(2019)

color = require("color")
color.init()
color.reset()

key = 2
gpio.mode(key, gpio.INT)

function key_event(level, when, eventcount)
    if gpio.read(key) == gpio.HIGH then
        color.stop()
        dt.set(color.get_time())
    elseif gpio.read(key) == gpio.LOW then
        color.reset()
        color.start()
        dt.set_blank()
    end
end

gpio.trig(key, "both", key_event)



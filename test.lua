dt = require("digit")
dt.init()
dt.set(2019)

led = require("color")
led.init(30)

key = 2
gpio.mode(key, gpio.INT)
gpio.trig(key, "both", key_event)

function key_event()
# Home Assistant with socat for remote zwave

Based on [homeassistant-home-assistant](https://hub.docker.com/r/homeassistant/home-assistant/) image, [published on docker hub](https://hub.docker.com/r/vladbabii/homeassistant-socat/).

Please [report issues on github](https://github.com/vladbabii/homeassistant-socat/issues).

Instead of using a locally-connected zwave device (usb stick/etc), we can use a serial device mapped over the network with ser2net and then map it to a local zwave serial device with socat.

This docker container ensures that

 - a zwave device is mapped in the local docker with socat

 - home assistant is running

If there are any failures, both socat and home assistant will be restarted.


# Environment options:

All  [homeassistant-home-assistant](https://hub.docker.com/r/homeassistant/home-assistant/) image options are available and on top of that a few others have been added:

**DEBUG_VERBOSE**=0

Set to 1 to see more information

Default: 0

**PAUSE_BETWEEN_CHECKS**=2

In seconds, how much time to wait between checking running processes.

Default: 2

**LOG_TARGET**=/log.log

Path to log file. Ommit to write logs to stdout.

Default: stdout

**SOCAT_ZWAVE_TYPE**="tcp"

**SOCAT_ZWAVE_HOST**="192.168.5.5"

**SOCAT_ZWAVE_PORT**="7676"

Where socat should connect to - will be used as tcp://192.168.5.5:7676

**SOCAT_ZWAVE_LINK**="/dev/zwave"

What the zwave device should be mapped to. Use this in your home assistant configuration file.

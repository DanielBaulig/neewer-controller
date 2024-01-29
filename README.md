# Neewer RGB660 WIFI module

This custom ESPHome firmware was designed to run my Neewer RGB660 WIFI module. It's a 
small ESP32 based gizmo that can be mounted directly to the back of your Neewer RGB660 lights 
to create a stable Bluetooth connection and make the light available over WIFI. It gets
powered directly from the light. Once installed it just lives with the light, whereever it
goes.

![Neewer RGB660 WIFI Controller mounted to the back of a Neewer RGB660 light](https://www.rarelyunplugged.com/posts/neewer-660-rgb-wifi-controller/images/neewer-controller-mounted-closeup.jpeg)

## Getting a Neewer RGB660 WIFI module
If you are interested in building one for yourself, I've provided the [instructions on my
blog Rarely Unplugged](https://www.rarelyunplugged.com/posts/neewer-660-rgb-wifi-controller/). I also put together an [instructional video](https://www.youtube.com/watch?v=wAbPy0ae5Eg) on YouTbe.
If you would rather buy one than build one yourself, I'm going to be selling these devices for a fair price. Make sure to [get notified](https://www.rarelyunplugged.com/buy-neewer-rgb660-wifi-module/) when the first batch is ready.

## Flashing
You can flash the firmware on your ESP32 to turn it into a Neewer 660RGB
controller by either building the firmware from source or by uploading a
pre-built binary firmware.
To flash the firmware from source you will need a running ESPHome instance. 
If you do not have ESPHome or do not want to use it, you can instead follow the
instructions to flash the firmware from a prebuilt binary.

### Flash from binary (ESPHome optional)
1. Download the [most recent build](https://github.com/DanielBaulig/neewer-controller/releases/latest/download/neewer-controller-factory.bin)
   of the firmware (Wemos D1 Mini only). 
2. Visit the [ESPHome Web Tools website](https://web.esphome.io/). 
3. Plug your ESP32 device into your computer.
4. Click on "Connect", select the serial port your device is connected to and 
   click "Connect" again. 
5. Now click "Install" (NOT "Prepare for first use"!) and select the firmware 
   binary you just downloaded.
6. After the firmware was flashed, click the three dot menu and then select
   "Configure Wifi" and then "Connect to Wifi".
7. Fill in your Wifi credentials and click "Connect"

Once you get the "Provisioned!" message you can either go to your ESPHome
instance and adopt the newly flashed device into your ESPHome dashboard. 

If you do not have ESPHome or don't want to use it, you can instead click "Visit
device". You will be able to pair and control your device directly from this web
interface. *Note: currently color control is not available from this interface.*
The web server also exposes a simple [REST API](https://esphome.io/web-api/#api-rest) 
that allows you to integrate the paired light into other systems or apps, e.g. 
[Bitfocus Companion](https://bitfocus.io/companion).

### Flash from source (using ESPHome)
Prepare your ESP32 device for first use and adopt it into ESPHome. Then add the 
following to the start of your devices yaml configuration:

```
packages:
  DanielBaulig.neewer-controller: github://DanielBaulig/neewer-controller/neewer-controller.yaml
```

And make sure to add the following to the esphome section:

```
esphome:
    # [...]
    name_add_mac_suffix: false
```

This will prevent readding the devices MAC address to the device name upon
rebuilding.

Reflash your device. You should now be able to add it to Home Assistant. To pair
a Neewer 660RGB light to your ESP32, follow the instructions under "Pairing".

## Pairing
To pair the controller to a Neewer RGB660 light, simply put the controller board
close to the powered on light (or make sure there is no other unpaired light 
close by) and hit the "Pair with closest device" button. 
You can find this button both in Home Assistant or on the controller web 
interface. It can also be triggered via REST API.
The controller will pair with the light and proceed to connect to it. Connecting
can take a few seconds, so give it some time. Once the light is connected you
will be able to control it through Home Assistant, the controller web interface
or REST API (e.g. using Bitfocus Companion).

## Thanks

This ESP32 firmware is based on [Aria Barrel's](https://github.com/litui) work
on adapting [Xu Lian's](https://github.com/keefo) reverse engineered Neewer BLE
protocol for ESPHome.

It expands on the previous work by providing a more user-friendly discovery and
pairing process that is independent from an actual ESPHome instance and
reflashing the device and can be completed with just the binary firmware and a 
web browser, if need be.

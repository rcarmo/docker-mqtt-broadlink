#!/usr/bin/python
import os, broadlink
import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print "connected"
    client.subscribe("broadlink/send",2)

def on_message(client, userdata, msg):
    print devices, msg.payload
    try:
        if devices and len(devices):
            devices[0].send_data(msg.payload.decode('hex'))
        else:
           raise RuntimeError("no Broadlink devices available.")
    except Exception as e:
        print e, "restarting container"
        exit(-1)

def run():
    c = mqtt.Client("mqtt_broadlink")
    c.on_connect = on_connect
    c.on_message = on_message
    c.connect(os.environ("MQTT_HOST","localhost"), int(os.environ("MQTT_PORT",1883)))
    c.loop_forever()

if __name__ == '__main__':
    while True:
       devices = broadlink.discover(timeout=5)
       if devices and len(devices):
          devices[0].auth()
          print devices
          break
       else:
          print "no Broadlink devices, restarting container"
          exit(-1) 
    run()

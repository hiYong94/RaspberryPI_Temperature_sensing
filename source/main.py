#!/usr/bin/python
#Copyright ChoiYongKwon

# temperature lib
import sys
import Adafruit_DHT

# LED lib
import RPi.GPIO as GPIO
import time

# Piezo lib
from gpiozero import Buzzer

# pymysql lib
import pymysql

# Parse command line parameters.
# input use DHT- Version
sensor_args = { '11': Adafruit_DHT.DHT11,
                '22': Adafruit_DHT.DHT22,
                '2302': Adafruit_DHT.AM2302 }

if len(sys.argv) == 3 and sys.argv[1] in sensor_args:
    sensor = sensor_args[sys.argv[1]]
    pin = sys.argv[2]
else:
    print('Usage: sudo ./Adafruit_DHT.py [11|22|2302] <GPIO pin number>')
    print('Example: sudo ./Adafruit_DHT.py 2302 4 - Read from an AM2302 connected to GPIO pin #4')
    sys.exit(1)

# LED line
def led_output(temp):
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(4, GPIO.OUT)
	GPIO.setup(14, GPIO.OUT)
	if(temp > 25):
		GPIO.output(4, GPIO.HIGH)
		time.sleep(4)
		GPIO.output(4, GPIO.LOW)
	elif(temp < 26 and temp > 24):
		GPIO.output(14, GPIO.HIGH)
		time.sleep(1)
		GPIO.output(14, GPIO.LOW)

# Piezo Buzzer line
def piezo_output(temp):
	buzzer = Buzzer(3)
	if(temp > 25):
		buzzer.on()
		time.sleep(4)
		buzzer.off()
		time.sleep(1)
	elif(temp < 26 and temp > 24):
		buzzer.on()
		time.sleep(1)
		buzzer.off()
		time.sleep(1)


# Total function
def total_output(temp):
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(4, GPIO.OUT)
	GPIO.setup(14, GPIO.OUT)
	buzzer = Buzzer(3)
	if(temp >= 26):
		GPIO.output(4, GPIO.HIGH)
		buzzer.on()
		time.sleep(4)
		GPIO.output(4, GPIO.LOW)
		buzzer.off()
		time.sleep(4)
	elif(temp < 26 and temp > 22):
		GPIO.output(14, GPIO.HIGH)
		buzzer.on()
		time.sleep(1)
		GPIO.output(14, GPIO.LOW)
		buzzer.off()
		time.sleep(1)

# pymysql connect
conn = pymysql.connect(host='localhost', port=3306, user='1123', passwd='1123', db='cyk94')
curs = conn.cursor()

# Run Source code
# input sensor numberm, pin number
while True:
	humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
   	print('Temp={0:0.1f}*  Humidity={1:0.1f}%'.format(temperature, humidity))
	total_output(temperature)
	sql = """insert into DATA_INFO(ttemp, thum) values(%s, %s)"""
	curs.execute(sql,(str(temperature), str(humidity)))
	conn.commit()

curs.close()
conn.close()

#led_output(temperature)
#piezo_output(temperature)

# DHT-11 line
# print result <Temp and Humidity values>

#    print('Temp={0:0.1f}*  Humidity={1:0.1f}%'.format(temperature, humidity))
#else:
#    print('Failed to get reading. Try again!')
#    sys.exit(1)


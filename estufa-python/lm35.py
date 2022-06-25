import time
import serial

porta = 'COM3'
baud_rate = 9600

ser = serial.Serial(porta, baud_rate)

i = 50

while i:
    s = ser.readline()
    s = s.rstrip()
    s = s.decode("utf-8")
    print('Dados: ', s)
    time.sleep(1.0)
    i -= 1
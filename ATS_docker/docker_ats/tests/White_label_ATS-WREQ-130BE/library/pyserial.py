import serial
from time import sleep
import datetime


class pyserial(object):
    
    def __init__(self):
        self.ser = None

    def open_serial_connection(self, port, boud):
        self.ser = serial.Serial(port, boud, timeout=30)
        if self.ser.isOpen():
            print(self.ser.name + ' is open...')
     
    def command_enter(self, cmd):
        if cmd == 'exit':
            self.ser.close()
        else:
            self.ser.write(cmd.encode('utf-8')+b'\r\n')
            #out = ser.readline()
            #out= ser.read_until("Examples:".encode('utf-8'))
            #print('Receiving...'+out.decode('utf-8'))

    def read_until_print_result(self, prompt):
        out= self.ser.read_until(prompt.encode('utf-8'))
        message=out.decode('utf-8', errors='replace')
        #print(message)
        return message

    def read_all_data(self):
        out= self.ser.read_all()
    
        return out

    def close_Serial_Port(self):
        self.ser.close()

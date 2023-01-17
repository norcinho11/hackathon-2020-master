import os

prefix = []


def read_uid():
    with open('/home/pi/uid.txt') as input_file:
        global prefix
        for line in input_file:
            prefix.append((int(line, 16)))


read_uid()
# os.system("echo %x > /home/pi/uid.txt" % prefix[0])

os.system("sleep 10")
os.system("sudo hciconfig hci0 up")
os.system("sudo hciconfig hci0 leadv 3")
os.system("sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 06 1A FF 4C 00 02 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0%x 00 00 00 00 C8 00" % prefix[0])

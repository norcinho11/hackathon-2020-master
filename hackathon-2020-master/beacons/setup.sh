#!/bin/sh
sudo mv -f rc.local /etc
sudo chmod +x /etc/rc.local
sudo systemctl enable rc-local
mv setupBeacon.sh /home/pi
mv setup.py /home/pi
echo "Action succesfull"
rm setup.txt

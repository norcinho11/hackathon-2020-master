#!/bin/sh
echo "Enter UID of beacon in range of <0,15>:"
read beaconID

if [[ $beaconID -gt 15 ]]
then
  echo "The UID is greater then 15, choose lower value!"
else
  hex=$(printf "%X" "$beaconID")
  sudo hciconfig hci0 up
  sudo hciconfig hci0 leadv 3
  sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 06 1A FF 4C 00 02 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0$hex 00 00 00 00 C8 00
  hex=$(printf "%X" "$beaconID")
  echo $hex > uid.txt
fi

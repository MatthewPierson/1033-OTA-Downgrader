#!/bin/bash

clear

echo "**************** Matty's iPhone 5s 10.3.3 OTA Downgrader ****************"
echo ""
echo "Plug device into computer in DFU Mode"
echo ""
echo "THIS WILL FAIL UP TO 40 TIMES, THIS IS NORMAL JUST RE-RUN THIS SCRIPT"
echo ""
echo "There is no current way around this, it's just the nature of the exploit on the 5s"
echo ""
echo "Thanks to Merc (@Vyce_Merculous) for helping me fix stuff with this script!"

if [ ! -f read-pwn-message ]; then
  echo ""
  echo "... Waiting 10 seconds for you to actually read this before continuing ..."
  
  sleep 10
  
  touch read-pwn-message
fi

echo "[Log] Removing old files"
echo ""
rm -rf shsh/*

echo "[Log] Entering PWNDFU Mode"

cd ipwndfu_public

killall iTunes
killall iTunesHelper

sleep 1

./ipwndfu -p

string=$(../bin/lsusb | grep -c "checkm8")
echo $string
if [ $string == 1 ];
then

python rmsigchks.py

cd ..

echo "[Log] Device is in PWNDFU Mode with Sigchcks removed"
echo ""
echo "[Log] Putting device into PWNDREC mode"

cd tmp/

../bin/irecovery -f ibss.final
../bin/irecovery -f ibec.final

echo "[Log] Device is now in PWNDREC mode"
echo ""
echo "**************** PWNing Completed. Please run restore.sh ****************"

else
clear
echo "[ERROR] EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN  ./pwn.sh  AGAIN"
echo "[ERROR] EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN  ./pwn.sh  AGAIN"
echo "[ERROR] EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN  ./pwn.sh  AGAIN"
echo "[ERROR] EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN  ./pwn.sh  AGAIN"
fi

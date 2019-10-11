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
echo ""
echo "... Waiting 10 seconds for you to actually read this before continuing ..."

sleep 10

echo "Removing old files"

rm -rf ipwndfu_public
rm -rf shsh/*

echo "Entering PWNDFU Mode"

git clone https://github.com/LinusHenze/ipwndfu_public.git

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

echo "Device is in PWNDFU Mode with Sigchcks removed"

echo "Putting device into PWNDREC mode"

cd tmp/

../bin/irecovery -f ibss.final
../bin/irecovery -f ibec.final

echo "Device is now in PWNDREC mode"
echo ""
echo "**************** PWNing Completed. Please run restore.sh ****************"

else
clear
echo "**************** EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN pwn.sh AGAIN ****************"
echo "**************** EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN pwn.sh AGAIN ****************"
echo "**************** EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN pwn.sh AGAIN ****************"
echo "**************** EXPLOIT FAILED PLEASE ENTER DFU MODE AGAIN AND RUN pwn.sh AGAIN ****************"
fi

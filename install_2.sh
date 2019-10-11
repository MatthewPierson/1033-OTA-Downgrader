#!/bin/bash
clear
echo "Installing proper dylibs for Futurerestore. Thanks to /user/zxcgenius on reddit for these."

echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo "************* YOU WILL BE REBOOTED AFTER RUNNING THIS SCRIPT"
echo ""
echo "Please enter your password to give the script permissions to move files"

sudo cp depend/libcompression.dylib /usr/lib/libcompression.dylib

sudo cp depend/libimobiledevice.6.dylib /usr/local/lib/libimobiledevice.6.dylib

sudo cp depend/libssl.1.0.0.dylib /usr/local/opt/openssl/lib/libssl.1.0.0.dylib

sudo cp depend/libcrypto.1.0.0.dylib /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib

sudo cp depend/libusbmuxd.4.dylib /usr/local/opt/usbmuxd/lib/libusbmuxd.4.dylib

sudo cp depend/libplist.3.dylib /usr/local/lib/libplist.3.dylib

sudo cp depend/libirecovery.2.dylib /usr/local/lib/libirecovery.2.dylib

sudo cp depend/libfragmentzip.0.dylib /usr/local/lib/libfragmentzip.0.dylib

sudo cp depend/libz.1.dylib /usr/lib/libz.1.dylib

sudo cp depend/libzip.5.dylib /usr/local/opt/libzip/lib/libzip.5.dylib



echo "Done"

echo "MACHINE WILL NOW BE REBOOTED"
sleep 1
echo "Rebooting in 3..."
sleep 1
echo "Rebooting in 2..."
sleep 1
echo "Rebooting in 1..."
sleep 1
echo "Rebooting..."

sudo shutdown -r now

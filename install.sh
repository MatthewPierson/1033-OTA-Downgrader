#!/bin/bash

clear

echo "*** Installing dependencies for Futurerestore ***"

echo "*** You need to have Brew and git installed ***"

echo "*** If a popup about developer tools needing to be installed pops up then install that as well ***"

echo "*** Waiting 10 seconds to make sure you actually read this ***"

sleep 10

echo "[Log] Installing/updating Brew"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "[Log] Installed/Updated Brew"

echo "[Log] Installing wget"

brew install wget

echo "[Log] Installing dependencies"

brew uninstall --ignore-dependencies usbmuxd

brew uninstall --ignore-dependencies libimobiledevice

brew install --HEAD usbmuxd

brew install --HEAD libimobiledevice

brew install libzip

brew install openssl

echo "[Log] Creating folders for dylibs"

sudo mkdir /rsu
echo "[Log] Created /rsu"
sudo mkdir /rsu/lib
echo "[Log] Created /rsu/lib"
sudo mkdir /rsu/local
echo "[Log] Created /rsu/local"
sudo mkdir /rsu/local/lib
echo "[Log] Created /rsu/local/lib"
sudo mkdir /rsu/local/opt
echo "[Log] Created /rsu/local/opt"
sudo mkdir /rsu/local/opt/openssl
echo "[Log] Created /rsu/local/opt/openssl"
sudo mkdir /rsu/local/opt/openssl/lib
echo "[Log] Created /rsu/local/opt/openssl/lib"
sudo mkdir /rsu/local/opt/usbmuxd
echo "[Log] Created /rsu/local/opt/usbmuxd"
sudo mkdir /rsu/local/opt/usbmuxd/lib
echo "[Log] Created /rsu/local/opt/usbmuxd/lib"
sudo mkdir /rsu/local/opt/libzip
echo "[Log] Created /rsu/local/opt/libzip"
sudo mkdir /rsu/local/opt/libzip/lib
echo "[Log] Created /rsu/local/opt/libzip/lib"

echo "[Log] Created folders"

echo "[Log] Moving dylibs into place"

sudo cp -a rsu/lib/. /rsu/lib/
echo "[Log] Copying libcompression and libz"
sudo cp -a rsu/local/lib/. /rsu/local/lib/
echo "[Log] Copying libfragmentzip, libimobiledevice, libirecovery and libplist"
sudo cp -a rsu/local/opt/openssl/lib/. /rsu/local/opt/openssl/lib/
echo "[Log] Copying openssl"
sudo cp -a rsu/local/opt/usbmuxd/lib/. /rsu/local/opt/usbmuxd/lib/
echo "[Log] Copying usbmuxd"
sudo cp -a rsu/local/opt/libzip/lib/. /rsu/local/opt/libzip/lib/
echo "[Log] Copying libzip"

echo "[Log] Cloning and building other dependencies"

echo "[Log] Cloning ipwndfu_public"

git clone https://github.com/MatthewPierson/ipwndfu_public.git

echo "[Log] Cloned ipwndfu_public"

sleep 3

cd ~

echo "[Log] Doing libirecovery"

git clone https://github.com/libimobiledevice/libirecovery.git

cd libirecovery/

./autogen.sh && make && sudo make install

cd ~

echo "[Log] Doing libfragmentzip"

git clone https://github.com/tihmstar/libfragmentzip.git

cd libfragmentzip

./autogen.sh && make && sudo make install

clear

echo "[Log] Installed and built dependencies"


echo "[Log] Installed everything"


echo "[Log] Done, exiting..."

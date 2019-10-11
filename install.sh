#!/bin/bash
echo "... Installing dependencies for Futurerestore ..."

echo "You need to have Brew and git installed."

echo "If a popup about developer tools needing to be installed pops up then install that as well"

echo "... Waiting 10 seconds to make sure you actually read this ..."

sleep 10

echo "... Installing/updating Brew ..."

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "... Installed ..."

echo "... Waiting ..."

sleep 3


brew install wget

echo "... Creating folders for dylibs ..."

sudo mkdir /rsu
sudo mkdir /rsu/lib
sudo mkdir /rsu/local/lib
sudo mkdir /rsu/local/opt
sudo mkdir /rsu/local/opt/openssl
sudo mkdir /rsu/local/opt/openssl/lib
sudo mkdir /rsu/local/opt/usbmuxd
sudo mkdir /rsu/local/opt/usbmuxd/lib
sudo mkdir /rsu/local/opt/libzip
sudo mkdir /rsu/local/opt/libzip/lib

echo "... Moving dylibs into place ..."

sudo cp rsu/lib/* /rsu/lib/
sudo cp rsu/local/lib/* /rsu/local/lib/
sudo cp rsu/local/opt/openssl/lib/* /rsu/local/opt/openssl/lib/
sudo cp rsu/local/opt/usbmuxd/lib/* /rsu/local/opt/usbmuxd/lib/
sudo cp rsu/local/opt/libzip/lib/* /rsu/local/opt/libzip/lib/

echo "... Installed everything ..."


echo "... Done ..."

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

brew uninstall --ignore-dependencies usbmuxd

brew uninstall --ignore-dependencies libimobiledevice

brew install --HEAD usbmuxd

brew install --HEAD libimobiledevice

brew install libzip

brew install openssl

brew install wget

cd ~

git clone https://github.com/libimobiledevice/libirecovery.git

cd libirecovery/

./autogen.sh && make && sudo make install

cd ~

git clone https://github.com/tihmstar/libfragmentzip.git

cd libfragmentzip

./autogen.sh && make && sudo make install

echo "... Installed and built dependencies ..."


echo "... Done ..."

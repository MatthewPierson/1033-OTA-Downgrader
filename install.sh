#!/bin/bash

# This will install all of the need files and programs

#TODO: I may add this later but I'd rather get the important stuff done first.
# Simple check to only update the git repos, if one had already run the script.

echo "[+] Installing dependencies"
brew install libtool automake
if [ -e "ipwndfu_public" ]; then
	cd ipwndfu_public && git pull origin master
	cd ..
else
git clone https://github.com/MatthewPierson/ipwndfu_public
fi
if [ -e "build" ]; then
	echo "[+] Build folder exists! Updating only!"
	cd build
	for d in *
		do
			(cd $d && git pull origin master)
	done
	cd ..
else
echo "[+] Build folder does not exist! Grabbing dependencies and installing!"
mkdir -p build && cd build
git clone --recursive https://github.com/s0uthwest/tsschecker
git clone --recursive https://github.com/merculous/futurerestore
git clone --recursive https://github.com/xerub/img4lib
git clone --recursive https://github.com/tihmstar/liboffsetfinder64
git clone https://github.com/tihmstar/img4tool
git clone https://github.com/libimobiledevice/libirecovery
cd tsschecker
./autogen.sh
echo "[+] Sleeping for 5 seconds. Ensure you have no missing dependencies. If so, please install anything missing."
sleep 5s
make && make install
cd ../futurerestore
./autogen.sh
echo "[+] Sleeping for 5 seconds. Ensure you have no missing dependencies. If so, please install anything missing."
sleep 5s
make && make install
cd ../liboffsetfinder64
./autogen.sh
echo "[+] Sleeping for 5 seconds. Ensure you have no missing dependencies. If so, please install anything missing."
sleep 5s
make && make install
cd ../img4tool
./autogen.sh
echo "[+] Sleeping for 5 seconds. Ensure you have no missing dependencies. If so, please install anything missing."
sleep 5s
make && make install
cd ../img4lib
make && make install
cd ../libirecovery
make && make install
echo "[+] Dependencies should now be installed and compiled. Put your device into pwned DFU mode and execute prep.sh script."
fi
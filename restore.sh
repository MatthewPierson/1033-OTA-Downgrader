#!/bin/bash

# $0 <exec> $1 <device> $2 <ecid> $3 <ipsw>

if [ ! "/usr/local/bin/brew" ]; then
	echo "OOOOF, brew is not installed? Installing..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ "$#" == 3 ]; then
	echo "[+] Installing dependencies"
	brew install libtool automake lsusb
	if [ -e "ipwndfu_public" ]; then
		cd ipwndfu_public && git pull origin master
		cd ..
	else
		git clone https://github.com/MatthewPierson/ipwndfu_public
	fi

	string=$(lsusb | grep -c "checkm8")
	echo "We seem to be in pwned DFU mode!"

	if [ $string == 1 ]; then

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
			echo "[+] Dependencies should now be installed and compiled."
		fi

		rm -rfv ipsw dummy_file *.decrypted *.im4p *.prepatched *.raw *.img4 shsh downgrade* *.restore
		echo "Killing iTunes as this will be quite annoying with what we are going to do."
		killall iTunes && killall iTunesHelper
		mkdir -p ipsw
		mkdir -p shsh
		unzip -d ipsw $3
		cp -rv ipsw/Firmware/Mav7Mav8-7.60.00.Release.bbfw .

		if [ $1 == iPhone6,1 ] || [ $1 == iPhone6,2 ]; then # If iPhone 5S
			mv -v ipsw/Firmware/dfu/*.iphone6*.im4p .

			if [ $1 == iPhone6,1 ]; then 
				cp -rv ipsw/Firmware/all_flash/sep-firmware.n51.RELEASE.im4p .
			else
				cp -rv ipsw/Firmware/all_flash/sep-firmware.n53.RELEASE.im4p .
			fi

			img4 -i iBSS.iphone6.RELEASE.im4p -o iBSS.decrypted -k f2aa35f6e27c409fd57e9b711f416cfe599d9b18bc51d93f2385fa4e83539a2eec955fce5f4ae960b252583fcbebfe75 -D
			img4 -i iBEC.iphone6.RELEASE.im4p -o iBEC.decrypted -k 75a06e85e2d9835827334738bb84ce7315c61c585d30ab07497f68aee0a64c433e4b1183abde4cfd91c185b9a70ab91a -D
			img4tool -e -o iBSS.raw iBSS.decrypted
			img4tool -e -o iBEC.raw iBEC.decrypted
			./iBoot64Patcher iBSS.raw iBSS.prepatched
			./iBoot64Patcher iBEC.raw iBEC.prepatched
			img4tool -p iBSS.im4p --tag ibss --info checkm8 iBSS.prepatched
			img4tool -p iBEC.im4p --tag ibec --info checkm8 iBEC.prepatched 
			tsschecker -d $1 -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 -s --save-path shsh
			mv -v shsh/*.shsh* shsh/stitch.shsh2
			img4tool -p iBSS.im4p -c iBSS.img4 -s shsh/stitch.shsh2
			img4tool -p iBEC.im4p -c iBEC.img4 -s shsh/stitch.shsh2
			cp -v iBSS.img4 ipsw/Firmware/dfu/iBSS.iphone6.RELEASE.im4p
			cp -v iBEC.img4 ipsw/Firmware/dfu/iBEC.iphone6.RELEASE.im4p
		fi

		if [ $1 == iPad4,1 ] || [ $1 == iPad4,2 ] || [ $1 == iPad4,3 ]; then # If iPad Air
			mv -v ipsw/Firmware/dfu/iBEC.ipad4.RELEASE.im4p .

			if [ $1 == iPad4,1 ]; then
				cp -rv ipsw/Firmware/all_flash/sep-firmware.j71.RELEASE.im4p .
			fi

			if [ $1 == iPad4,2 ]; then
				cp -rv ipsw/Firmware/all_flash/sep-firmware.j72.RELEASE.im4p .
			fi 

			if [ $1 == iPad4,3 ]; then
				cp -rv ipsw/Firmware/all_flash/sep-firmware.j73.RELEASE.im4p .
			fi 

			img4 -i iBEC.ipad4.RELEASE.im4p -o iBEC.decrypted -k a83dfcc277766ccb5da4220811ec2407b4f8d062a97628231a289ae2a50647c309c43030577dca7fc2eee3a13ddb51ea -D 
			img4tool -e -o iBEC.raw iBEC.decrypted
			./iBoot64Patcher iBEC.raw iBEC.prepatched 
			img4tool -p iBEC.im4p --tag ibec --info checkm8 iBEC.prepatched 

				if [ $1 == iPad4,3 ]; then
					tsschecker -d $1 --boardconfig j73AP -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 -s --save-path shsh
				else
					tsschecker -d $1 -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 -s --save-path shsh 
				fi

			mv -v shsh/*.shsh* shsh/stitch.shsh2 
			img4tool -p iBEC.im4p -c iBEC.img4 -s shsh/stitch.shsh2 
			cp -v iBEC.img4 ipsw/Firmware/dfu/iBEC.ipad4.RELEASE.im4p
		fi

		if [ $1 == iPad4,4 ] || [ $1 == iPad4,5 ]; then # If iPad Mini 2
			mv -v ipsw/Firmware/dfu/iBEC.ipad4b.RELEASE.im4p .

			if [ $1 == iPad4,4 ]; then
				cp -rv ipsw/Firmware/all_flash/sep-firmware.j85.RELEASE.im4p .
			else
				cp -rv ipsw/Firmware/all_flash/sep-firmware.j86.RELEASE.im4p .
			fi

			img4 -i iBEC.ipad4b.RELEASE.im4p -o iBEC.decrypted -k 3067a2585100890afd3b266926ac254bdcdf5a9eb3ae0464e984333e15876faa116525ca4b61f361283a808ca09c7480 -D 
			img4tool -e -o iBEC.raw iBEC.decrypted
			./iBoot64Patcher iBEC.raw iBEC.prepatched 
			img4tool -p iBEC.im4p --tag ibec --info checkm8 iBEC.prepatched 
			mv -v shsh/*.shsh* shsh/stitch.shsh2 
			img4tool -p iBEC.im4p -c iBEC.img4 -s shsh/stitch.shsh2 
			cp -v iBEC.img4 ipsw/Firmware/dfu/iBEC.ipad4b.RELEASE.im4p 
		fi

		cd ipsw
		zip ../downgrade.ipsw -r9 *
		cd ..
		echo "checkm8" >> dummy_file
		python ipwndfu_public/rmsigchks.py
		raw=$(irecovery -q | grep NONC)
		apnonce=$(echo $raw | cut -d ':' -f 2)

		if [ $1 == iPad4,1 ] || [ $1 == iPad4,2 ] || [ $1 == iPad4,3 ] || [ $1 == iPad4,4 ] || [ $1 == iPad4,5 ]; then
			irecovery -f dummy_file
			irecovery -f iBEC.img4

			if [ $1 == iPad4,3 ]; then
				tsschecker -d $1 --boardconfig j73AP -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 --apnonce $apnonce -s
			else
				tsschecker -d $1 -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 --apnonce $apnonce -s
			fi
		fi

		if [ $1 == iPhone6,1 ] || [ $1 == iPhone6,2 ]; then
			irecovery -f dummy_file
			irecovery -f iBSS.img4
			irecovery -f iBEC.img4
			tsschecker -d $1 -i 10.3.3 -o -m manifests/BuildManifest_$1_1033_OTA.plist -e $2 --apnonce $apnonce -s
		fi

		mv -v *.shsh* shsh/apnonce.shsh2
		echo "Done prepping files! Time to downgrade!!!"

		echo "****RESTORING!****"

		futurerestore -t shsh/apnonce.shsh2 -s sep-firmware.*.RELEASE.im4p -m manifests/BuildManifest_$1_1033_OTA.plist \
		-b Mav7Mav8-7.60.00.Release.bbfw -p manifests/BuildManifest_$1_1033_OTA.plist downgrade.ipsw

		echo "If you see this, we're done! Shoutout to the devs and Matty for making this possible! - Merculous"
		echo "P.S. You know, this could look even better and be even easier if we port it to Python :D"

	else
		echo "Didn't not find checkm8 within lsusb! We are going go exit! Please run again!"
		exit 1
	fi

else
	echo "Usage: $0 <device> <ecid> PathToIpsw"
	echo "Example: $0 iPhone6,1 <ecid> iPhone_4.0_64bit_10.3.3_14G60_Restore.ipsw"
fi

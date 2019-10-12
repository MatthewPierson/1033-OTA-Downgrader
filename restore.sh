#!/bin/bash
clear

echo "**************** Matty's iPhone 5s 10.3.3 OTA Downgrader ****************"

echo "[Log] Removing old files"

rm -rf shsh/*

echo "Are you futurerestoring an iPhone or an iPad?"

read idevice

if [ $idevice == iPhone ] ||[ $idevice == iphone ];
then

echo "Please enter device ID (iPhone6,1 or iPhone6,2 only)"

read device

else

echo "Please enter device ID (iPad4,1 iPad4,2 iPad4,3 iPad4,4 and iPad4,5)"

read device

fi

if [ $device == iPhone6,1 ] ||[ $device == iPhone6,2 ] || [ $device == iPad4,1 ] ||[ $device == iPad4,2 ] ||[ $device == iPad4,3 ] ||[ $device == iPad4,4 ] ||[ $device == iPad4,5 ];
then
kill=0
else
kill=1
fi

if [ $kill == 1 ];
then
echo "[ERROR] Not a supported/valid device, Exiting..."
sleep 1
exit
else
echo "[Log] Vaild device, continuing"
fi

echo "[Log] Getting current APNonce"

#Credit to @dora2_yururi for ECID/Apnonce getting stuff from Nudaoaddu

ret=$(bin/igetnonce 2>/dev/null | grep ECID)
ecidhex=$(echo $ret | cut -d '=' -f 2 )
ecidhex2=$(echo $ecidhex | tr '[:lower:]' '[:upper:]')
echo $ecidhex2 >/dev/null
ecid=$(echo "obase=10; ibase=16; $ecidhex2" | bc)
echo $ecid

ret=$(bin/igetnonce 2>/dev/null | grep ApNonce)
nonce=$(echo $ret | cut -d '=' -f 2)
echo $nonce #APNONCE

if [ $device == iPad4,1 ] || [ $device == iPad4,2 ] || [ $device == iPad4,4 ] || [ $device == iPad4,5 ] || [ $device == iPhone6,1 ] || [ $device == iPhone6,2 ];
then
bin/tsschecker -e "$ecid" -d "$device" -s -o -i 9.9.10.3.3 --buildid 14G60 -m restore/BuildManifest_"$device"_1033_OTA.plist --save-path shsh/ --apnonce "$nonce"
fi
if [ $device == iPad4,3 ];
then
bin/tsschecker -e "$ecid" -d "$device" --boardconfig j73AP -s -o -i 9.9.10.3.3 --buildid 14G60 -m restore/BuildManifest_"$device"_1033_OTA.plist --save-path shsh/ --apnonce "$nonce"
fi

mv shsh/* shsh/OTA.shsh

echo "Do you want to save a copy of the OTA SHSH to somewhere on your computer? (y/n)"
read save

if [ $save == "y" ];
then

echo "Please drag and drop desired folder into this terminal window. (No trailing /)"
read path
cp shsh/OTA.shsh $path
fi

echo "[Log] SHSH saved"

echo "[Log] Starting restore process"
echo ""

if [ $device == iPad4,2 ] || [ $device == iPad4,3 ] || [ $device == iPad4,5 ];
then

echo "[Log] Copying SEP and Baseband"
cp 10.3.3.custom/Firmware/Mav7Mav8-7.60.00.Release.bbfw restore/Baseband.bbfw
else
echo "[Log] No baseband required"
fi

if [ $device == iPad4,1 ]
then
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.j71.RELEASE.im4p restore/sep-firmware."$device".RELEASE.im4p
fi
if [ $device == iPad4,2 ];
then
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.j72.RELEASE.im4p restore/sep-firmware."$device".RELEASE.im4p
fi
if [ $device == iPad4,3 ];
then
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.j73.RELEASE.im4p restore/sep-firmware."$device".RELEASE.im4p
fi
if [ $device == iPad4,4 ];
then
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.j85.RELEASE.im4p restore/sep-firmware."$device".RELEASE.im4p
fi
if [ $device == iPad4,5 ];
then
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.j86.RELEASE.im4p restore/sep-firmware."$device".RELEASE.im4p
fi
echo "[Log] SEP and Baseband copied"
echo ""

if [ $device == iPhone6,1 ] || [ $device == iPhone6,2 ];
then
echo "[Log] Copying SEP and Baseband"
cp 10.3.3.custom/Firmware/Mav7Mav8-7.60.00.Release.bbfw restore/Baseband.bbfw
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.n53.RELEASE.im4p restore/sep-firmware.iPhone6,2.RELEASE.im4p
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.n51.RELEASE.im4p restore/sep-firmware.iPhone6,1.RELEASE.im4p
echo "[Log] SEP and Baseband copied"
echo ""
echo "[Log] Cleaning up un-needed files"
rm -rf 10.3.3.custom
echo "[Log] Clean up done"
echo "[Log] Starting futurerestore"
bin/futurerestore -t shsh/OTA.shsh -s restore/sep-firmware."$device".RELEASE.im4p -m restore/BuildManifest_"$device"_1033_OTA.plist -b restore/Baseband.bbfw -p restore/BuildManifest_"$device"_1033_OTA.plist 10.3.3.custom.ipsw
fi
if [ $device == iPad4,2 ] || [ $device == iPad4,3 ] || [ $device == iPad4,5 ];

then
echo "[Log] Cleaning up un-needed files"
rm -rf 10.3.3.custom
echo "[Log] Clean up done"
echo "[Log] Starting futurerestore"
bin/futurerestore -t shsh/OTA.shsh -s restore/sep-firmware."$device".RELEASE.im4p -m restore/BuildManifest_"$device"_1033_OTA.plist -b restore/Baseband.bbfw -p restore/BuildManifest_"$device"_1033_OTA.plist 10.3.3.custom.ipsw
fi
if [ $device == iPad4,1 ] || [ $device == iPad4,4 ];
then
echo "[Log] Cleaning up un-needed files"
rm -rf 10.3.3.custom
echo "[Log] Clean up done"
echo "[Log] Starting futurerestore"
bin/futurerestore -t shsh/OTA.shsh -s restore/sep-firmware."$device".RELEASE.im4p -m restore/BuildManifest_"$device"_1033_OTA.plist --no-baseband 10.3.3.custom.ipsw
fi

echo "[Log] Futurerestoring complete"
echo ""
echo "**************** Downgrade complete! Enjoy 10.3.3 =) ****************"
echo "**************** Follow me on twitter @mosk_i for help/updates ******"

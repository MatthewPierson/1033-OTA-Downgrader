#!/bin/bash
clear

echo "**************** Matty's iPhone 5s 10.3.3 OTA Downgrader ****************"

echo "Removing old files"

rm -rf shsh/*


echo "Please enter device ID (iPhone6,1 or iPhone6,2) ONLY THE iPHONE 5s IS SUPPORTED"

read device

echo "Getting current APNonce"

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

bin/tsschecker -e "$ecid" -d "$device" -s -o -i 9.9.10.3.3 --buildid 14G60 -m restore/BuildManifest_"$device"_1033_OTA.plist --save-path shsh/ --apnonce "$nonce"

mv shsh/* shsh/OTA.shsh

echo "Do you want to save a copy of the OTA SHSH to somewhere on your computer? (y/n)"
read save

if [ $save == "y" ];
then

echo "Please drag and drop desired folder into this terminal window. (No trailing /)"
read path
cp shsh/OTA.shsh $path
fi

echo "shsh saved"

echo "Starting restore"

cp 10.3.3.custom/Firmware/Mav7Mav8-7.60.00.Release.bbfw restore/Baseband.bbfw
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.n53.RELEASE.im4p restore/sep-firmware.iPhone6,2.RELEASE.im4p
cp 10.3.3.custom/Firmware/all_flash/sep-firmware.n51.RELEASE.im4p restore/sep-firmware.iPhone6,1.RELEASE.im4p

rm -rf 10.3.3.custom


bin/futurerestore -t shsh/OTA.shsh -s restore/sep-firmware."$device".RELEASE.im4p -m restore/BuildManifest_"$device"_1033_OTA.plist -b restore/Baseband.bbfw -p restore/BuildManifest_"$device"_1033_OTA.plist 10.3.3.custom.ipsw


echo "**************** Downgrade complete! Enjoy 10.3.3 =) ****************"
echo "**************** Follow me on twitter @mosk_i for help/updates ******"

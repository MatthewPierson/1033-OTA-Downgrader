#!/bin/bash

# This is prepping all of the files, and grabbing shsh blobs

#TODO Add support for
# iPhone6,2

# iPad4,1 NOTE: iPad's just need iBEC patched
# iPad4,2
# iPad4,3
# iPad4,4
# iPad4,5

# rd=md0 nand-enable-reformat=1 -progress -restore

# Some how inject this for boot-args availability: -v debug=0x14e serial=3 

if [ $1 ]; then
rm -rfv ipsw dummy_file *.decrypted *.im4p *.prepatched *.raw *.img4 shsh downgrade.ipsw *.restore
echo "Killing iTunes as this will be quite annoying with what we are going to do."
killall iTunes && killall iTunesHelper
mkdir -p ipsw
unzip -d ipsw $1
mv -v ipsw/Firmware/dfu/*.iphone6*.im4p .
cp -rv ipsw/Firmware/Mav7Mav8-7.60.00.Release.bbfw .
cp -rv ipsw/Firmware/all_flash/sep-firmware.n51.RELEASE.im4p .
img4 -i iBSS.iphone6.RELEASE.im4p -o iBSS.decrypted -k f2aa35f6e27c409fd57e9b711f416cfe599d9b18bc51d93f2385fa4e83539a2eec955fce5f4ae960b252583fcbebfe75 -D
img4 -i iBEC.iphone6.RELEASE.im4p -o iBEC.decrypted -k 75a06e85e2d9835827334738bb84ce7315c61c585d30ab07497f68aee0a64c433e4b1183abde4cfd91c185b9a70ab91a -D
img4tool -e -o iBSS.raw iBSS.decrypted
img4tool -e -o iBEC.raw iBEC.decrypted
./iBoot64Patcher iBSS.raw iBSS.prepatched
./iBoot64Patcher iBEC.raw iBEC.prepatched
img4tool -p iBSS.im4p --tag ibss --info checkm8 iBSS.prepatched
img4tool -p iBEC.im4p --tag ibec --info checkm8 iBEC.prepatched
irecovery -q
echo "Please copy your ecid and enter your device type. For example, iPhone6,1."
read device
echo "Please enter your ecid."
read ecid
mkdir -p shsh
tsschecker -d $device -i 10.3.3 -o -m manifests/BuildManifest_iPhone6,1_1033_OTA.plist -e $ecid -s --save-path shsh
mv -v shsh/*.shsh* shsh/stitch.shsh2
img4tool -p iBSS.im4p -c iBSS.img4 -s shsh/stitch.shsh2
img4tool -p iBEC.im4p -c iBEC.img4 -s shsh/stitch.shsh2
cp -v iBSS.img4 ipsw/Firmware/dfu/iBSS.iphone6.RELEASE.im4p
cp -v iBEC.img4 ipsw/Firmware/dfu/iBEC.iphone6.RELEASE.im4p
cd ipsw
zip ../downgrade.ipsw -r9 *
cd ..
echo "checkm8" >> dummy_file
python ipwndfu_public/rmsigchks.py
irecovery -f dummy_file
irecovery -f iBSS.img4
irecovery -f iBEC.img4
irecovery -q
echo "Please copy your apnonce and enter it in here. Use the nonce from the line containing NONC:"
read apnonce
tsschecker -d $device -i 10.3.3 -o -m manifests/BuildManifest_iPhone6,1_1033_OTA.plist -e $ecid --apnonce $apnonce -s
mv -v *.shsh* shsh/apnonce.shsh2
echo "Done! Please execute the ./restore.sh script. Just one more step and you'll be able to downgrade!"
else
echo "Usage: $0 PathToIpsw"
fi

#if [ $device == iPad4,1 ] || [ $device == iPad4,2 ] || [ $device == iPad4,4 ] || [ $device == iPad4,5 ] || [ $device == iPhone6,1 ] || [ $device == iPhone6,2 ];
#then
#bin/tsschecker -e "$ecid" -d "$device" -s -o -i 9.9.10.3.3 --buildid 14G60 -m restore/BuildManifest_"$device"_1033_OTA.plist --save-path shsh/ --apnonce "$nonce"
#fi
#if [ $device == iPad4,3 ];
#then
#bin/tsschecker -e "$ecid" -d "$device" --boardconfig j73AP -s -o -i 9.9.10.3.3 --buildid 14G60 -m restore/BuildManifest_"$device"_1033_OTA.plist --save-path shsh/ --apnonce "$nonce"
#fi
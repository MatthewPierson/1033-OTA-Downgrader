#!/bin/bash
clear

echo "**************** Matty's iPhone 5s 10.3.3 OTA Downgrader ****************"

echo "Removing files from failed runs"

rm -rf tmp/*
rm -rf shsh/*
rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore
rm -rf 10.3.3.custom
rm -rf bin/tss*
rm -rf bin/fu*
rm -rf bin/ig*
rm -rf 10.3.3.custom.ipsw

echo "Downloading programs from S0uthwest's Github releases"
echo "Downloading igetnonce"
wget https://github.com/s0uthwest/igetnonce/releases/download/14/igetnonce_macOS_v14.zip -q --show-progress
unzip igetnonce_macOS_v14.zip igetnonce
mv igetnonce bin/igetnonce
rm -rf igetnonce_macOS_v14.zip

echo "Done"

echo "Downloading tsschecker"

wget https://github.com/s0uthwest/tsschecker/releases/download/355/tsschecker_macOS_v355.zip -q --show-progress
unzip tsschecker_macOS_v355.zip
mv tsschecker bin/tsschecker
rm -rf tsschecker_macOS_v355.zip

echo "Done"

echo "Downloading futurerestore"

wget https://github.com/s0uthwest/futurerestore/releases/download/245/futurerestore_macOS_v245.zip -q --show-progress

unzip futurerestore_macOS_v245.zip futurerestore

mv futurerestore bin/futurerestore

rm -rf futurerestore_macOS_v245.zip

echo "Done"


echo "Unzipping IPSW"

unzip iPhone_4.0_64bit_10.3.3_14G60_Restore.ipsw -d iPhone_4.0_64bit_10.3.3_14G60_Restore/

cp iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p tmp/iBEC.iphone6.RELEASE.im4p
echo "IPSW unzipped"

echo "Copying iBEC"

cp iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p tmp/iBSS.iphone6.RELEASE.im4p

echo "Copying iBSS"

echo "Patching files"

bin/bspatch tmp/iBSS.iphone6.RELEASE.im4p tmp/ibss.final patch/ibss.patch

bin/bspatch tmp/iBEC.iphone6.RELEASE.im4p tmp/ibec.final patch/ibec.patch

bin/bspatch bin/futurerestore tmp/futurerestore_new patch/futurerestore.patch

rm -rf tmp/futurerestore

mv tmp/futurerestore_new bin/futurerestore

chmod +x bin/*
echo "Files patched"

echo "Creating new IPSW"

rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p
rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p

cp tmp/ibss.final iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p

cp tmp/ibec.final iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p


mv iPhone_4.0_64bit_10.3.3_14G60_Restore 10.3.3.custom
cd 10.3.3.custom
zip ../10.3.3.custom.ipsw -r0 *
echo "**************** Modified IPSW created successfully ****************"
echo "**************** Prep Completed. Please run pwn.sh ****************"

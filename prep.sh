#!/bin/bash
clear

echo "**************** Matty's iPhone 5s 10.3.3 OTA Downgrader ****************"

echo "[Log] Removing files from previous runs"

rm -rf tmp/*
rm -rf shsh/*
rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore
rm -rf iPad_64bit_10.3.3_14G60_Restore
rm -rf iPad_64bit_10.3.3_14G60_Restore
rm -rf 10.3.3.custom
rm -rf bin/tss*
rm -rf bin/fu*
rm -rf bin/ig*
rm -rf 10.3.3.custom.ipsw

echo "[Log] Downloading programs from S0uthwest's Github releases"
echo "[Log] Downloading igetnonce"
wget -O igetnonce_macOS_v14.zip https://github.com/s0uthwest/igetnonce/releases/download/14/igetnonce_macOS_v14.zip -q --show-progress
unzip igetnonce_macOS_v14.zip igetnonce
mv igetnonce bin/igetnonce
rm -rf igetnonce_macOS_v14.zip

echo "[Log] Done igetnonce"

echo "[Log] Downloading tsschecker"

wget -O tsschecker_macOS_v355.zip https://github.com/s0uthwest/tsschecker/releases/download/355/tsschecker_macOS_v355.zip -q --show-progress
unzip tsschecker_macOS_v355.zip
mv tsschecker bin/tsschecker
rm -rf tsschecker_macOS_v355.zip

echo "[Log] Done tsschecker"

echo "[Log] Downloading futurerestore"

wget -O futurerestore_macOS_v245.zip https://github.com/s0uthwest/futurerestore/releases/download/245/futurerestore_macOS_v245.zip -q --show-progress

unzip futurerestore_macOS_v245.zip futurerestore

mv futurerestore bin/futurerestore

rm -rf futurerestore_macOS_v245.zip

echo "[Log] Done fututrerestore"

echo "[Log] Are you downgrading an iPhone or an iPad?"

read idevice

if [ $idevice == iPad ] || [ $idevice == ipad ];
then

echo "[Log] What model iPad are you using? E.G iPad4,4 or iPad4,1"

read model
fi

if [ $idevice == iPhone ] || [ $idevice == iphone ];
then
echo "[Log] What model iPhone are you using? E.G iPhone6,1 or iPhone6,2"

read model
fi

if [ $model == iPad4,1 ] || [ $model == iPad4,2 ] || [ $model == iPad4,3 ] || [ $model == iPad4,4 ] || [ $model == iPad4,5 ] || [ $model == iPhone6,1 ] || [ $model == iPhone6,2 ];

then

echo "[Log] Supported model!"

else

echo "[ERROR] Unsupported model or model was entered incorrectly, Exiting..."

exit

fi


if [ $model == iPad4,1 ] || [ $model == iPad4,2 ] || [ $model == iPad4,3 ];
then

ipadmodel="ipad4"
fi

if  [ $model == iPad4,4 ] || [ $model == iPad4,5 ];
then

ipadmodel="ipad4b"

fi


if [ $idevice == iPad ] || [ $idevice == ipad ];
then

echo "[Log] iPad chosen"

echo "[Log] Unzipping IPSW"

unzip iPad_64bit_10.3.3_14G60_Restore.ipsw -d iPad_4.0_64bit_10.3.3_14G60_Restore/

echo "[Log] IPSW unzipped"

cp iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC."$ipadmodel".RELEASE.im4p tmp/iBEC."$ipadmodel".RELEASE.im4p

echo "[Log] Copying iBEC"

cp iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS."$ipadmodel".RELEASE.im4p tmp/iBSS."$ipadmodel".RELEASE.im4p

echo "[Log] Copying iBSS"

echo "[Log] Patching files"

chmod +x bin/*

bin/bspatch tmp/iBSS."$ipadmodel".RELEASE.im4p tmp/ibss.final patch/ibss_"$ipadmodel".patch

bin/bspatch tmp/iBEC."$ipadmodel".RELEASE.im4p tmp/ibec.final patch/ibec_"$ipadmodel".patch


elif [ $idevice == iPhone ] || [ $idevice == iphone ];

then

echo "[Log] Unzipping IPSW"

unzip iPhone_4.0_64bit_10.3.3_14G60_Restore.ipsw -d iPhone_4.0_64bit_10.3.3_14G60_Restore/

echo "[Log] IPSW unzipped"

cp iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p tmp/iBEC.iphone6.RELEASE.im4p

echo "[Log] Copying iBEC"

cp iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p tmp/iBSS.iphone6.RELEASE.im4p

echo "[Log] Copying iBSS"

echo "[Log] Patching files"

chmod +x bin/*

bin/bspatch tmp/iBSS.iphone6.RELEASE.im4p tmp/ibss.final patch/ibss.patch

bin/bspatch tmp/iBEC.iphone6.RELEASE.im4p tmp/ibec.final patch/ibec.patch

else
echo "[ERROR] Unknown idevice, Exiting..."
exit
fi

bin/bspatch bin/futurerestore tmp/futurerestore_new patch/futurerestore.patch

rm -rf tmp/futurerestore

mv tmp/futurerestore_new bin/futurerestore

bin/bspatch bin/futurerestore tmp/futurerestore_final patch/futurerestore_2.patch

mv tmp/futurerestore_final bin/futurerestore

chmod +x bin/*

echo "[Log] Making sure permissions are set for binaries"

echo "[Log] Files patched"

echo "[Log] Creating new IPSW"

if [ $idevice == iPhone ] || [ $idevice == iphone ];
then

rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p
rm -rf iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p

cp tmp/ibss.final iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS.iphone6.RELEASE.im4p

cp tmp/ibec.final iPhone_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC.iphone6.RELEASE.im4p

mv iPhone_4.0_64bit_10.3.3_14G60_Restore 10.3.3.custom
cd 10.3.3.custom
zip ../10.3.3.custom.ipsw -r0 *

elif [ $idevice == iPad ] || [ $idevice == ipad ];
then

rm -rf iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS."$ipadmodel".RELEASE.im4p
rm -rf iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC."$ipadmodel".RELEASE.im4p

cp tmp/ibss.final iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBSS."$ipadmodel".RELEASE.im4p

cp tmp/ibec.final iPad_4.0_64bit_10.3.3_14G60_Restore/Firmware/dfu/iBEC."$ipadmodel".RELEASE.im4p


mv iPad_4.0_64bit_10.3.3_14G60_Restore 10.3.3.custom
cd 10.3.3.custom
zip ../10.3.3.custom.ipsw -r0 *

else
echo "You shouldnt have ever gotten this error lmao try again"
exit

fi
echo "[Log] Preperations complete"
echo "**************** Modified IPSW created successfully ****************"
echo "**************** Prep Completed. Please run pwn.sh ****************"

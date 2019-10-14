#!/bin/bash

# This will restore the custom ipsw

echo "****RESTORING!****"
futurerestore -t shsh/apnonce.shsh2 -s sep-firmware.n51.RELEASE.im4p -m manifests/BuildManifest_iPhone6,1_1033_OTA.plist \
-b Mav7Mav8-7.60.00.Release.bbfw -p manifests/BuildManifest_iPhone6,1_1033_OTA.plist downgrade.ipsw
echo "If you see this, we're done! Shoutout to the devs and Matty for making this possible! -Merc"
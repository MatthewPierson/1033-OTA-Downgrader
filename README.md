# 10.3.3 OTA Downgrade Script
Script to downgrade any device that has iOS 10.3.3 OTA signed.
 
Please read this before doing ANYTHING
-------------------------------------------

Yes, this may not work out of the box for everyone. Please note, if you are experienced with compiling things and using package managers, this will be an easy fix. For everyone else, please post any issues on the issues page and I will try to resolve any issues that are present. Also, please do not change a single thing unless you absolutely know what you're doing. Just let the script do its thing.

Only supports the iPhone 5s (6,1 and 6,2), iPad Air (iPad4,1 iPad4,2 and iPad4,3) and iPad Mini 2 (iPad4,4 and iPad4,5). No iPad4,6 support ever because it doesn't have 10.3.3 OTA signed as it shipped with 7.1 not 7.0.

Has been tested on macOS Mojave and Catalina, on both fresh installs and not fresh. Some MacOS versions have better success than others, we cannot fix this.

If this breaks your phone or macOS install neither Matty or Merc take absolutely no responsibility.
This script has been tested by Matty, Merc, and others and should be fine but in case something goes wrong, that's on you not us. 

No verbose boot, custom logo's, or anything else will be added. This will downgrade your device to 10.3.3 and that's it.
-------------------------------------------

The only things you need for this to work are: 

An iOS 10.3.3 ipsw

A few braincells (VERY IMPORTANT) 

Commonsense (RARE BUT ALSO VERY IMPORTANT)

Patience!!!
-------------------------------------------

How to downgrade:
	1. Download your iOS 10.3.3 ipsw.
	2. Run restore.sh as so, with also changing the arguments (don't add the quotes) with what you have: ./restore.sh "device" "ecid" "pathtoipsw"
	3. Wait
	4. Install your favorite iOS 10.x jailbreak
	5. Give feedback (issues, a thank you, anything that should be added to this)
-------------------------------------------

Thank you to anyone who helped us with testing or anything else! Couldn't have done it without the help of everyone who contributed. 

Credits to: axi0mx, Tihmstar, LinusHenze, alitek12, xerub and s0uthwest

Thanks to: @Vyce_Merculous, @xerusxan, @AyyItzRob123, @BarisUlasCukur, @DaveWijk, @melvin_zill and anyone else I missed!
-------------------------------------------

If you have any questions, either open an issue here, message Matty(@mosk_i) or Merc (@Vyce_Merculous) on Twitter, or comment on the reddit post.

Also just note, just because there's something not used in the project, do not send us thousands of messages asking us to add whatever you want.
Do it yourselves, its not hard, at all. Just look things up, the Internet is a thing.

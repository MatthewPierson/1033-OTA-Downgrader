# 10.3.3 OTA Downgrade Script
 Script to downgrade ANY iPhone 5s to 10.3.3 with OTA blobs
 
Please read this before doing ANYTHING
-------------------------------------------

Only supports the iPhone 5s (6,1 and 6,2).
YOU DO NOT NEED PREVIOUSLY SAVED BLOBS. 
PLEASE DON'T ASK ME IF YOU NEED BLOBS, IT'S ANNOYING
-------------------------------------------

Has been tested on macOS Mojave and Catalina, on both fresh installs and not fresh. 

If you keep failing on restore stage, try creating a new 35gb ish partition and installing a fresh copy of macOS Mojave on it and start from step one. 

If this breaks your phone or macOS install I take absolutely no responibility.
These scripts have been tested by me and others and should be fine but incase something goes wrong thats on you not me. 
-------------------------------------------
-------------------------------------------

The only things you need for this is as follows: 
An iPhone 5s (6,1 or 6,2)
iOS 10.3.3 IPSW from ipsw.me 
Terminal open
A few braincells (VERY IMPORTANT) 
Commonsense (RARE BUT ALSO VERY IMPORTANT)

Thank you to anyone who helped me with testing or anything else! Couldn't have done it myself. 

Credits to: axi0mx, Tihmstar, LinusHenze, alitek12, xerub and s0uthwest

Thanks to: @Vyce_Merculous, @xerusxan, @AyyItzRob123, @BarisUlasCukur, @DaveWijk and anyone else I missed!

-------------------------------------------

First make sure you have the 10.3.3 IPSW in the main directory where "prep.sh" and the other scripts are.

Also make sure you have at least 10 GB free on your SSD/HDD

Then run the scripts in this order:
1. `"chmod +x *.sh"`
2. `"sudo ./install.sh"`
3. `"./prep.sh"`
4. Place device into DFU Mode and connect to computer. 
5. THIS SCRIPT MAY/WILL FAIL UP TO 40 TIMES. JUST KEEP TRYING. 
6. `"./pwn.sh"`
7. `"./restore.sh"`
8. Enjoy 10.3.3! 

-------------------------------------------

Enjoy =) Hope these scripts were useful to you! <3 

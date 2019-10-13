# 10.3.3 OTA Downgrade Script
 Script to downgrade ANY iPhone 5s, iPad Air and (almost any) iPad Mini 2 to 10.3.3 with OTA blobs
 
Please read this before doing ANYTHING
-------------------------------------------

Only supports the iPhone 5s (6,1 and 6,2), iPad Air (iPad4,1 iPad4,2 and iPad4,3) and iPad Mini 2 (iPad4,4 and iPad4,5). No iPad4,6 support ever because it doesn't have 10.3.3 OTA signed as it shipped with 7.1 not 7.0

YOU DO NOT NEED PREVIOUSLY SAVED BLOBS. 
PLEASE DON'T ASK ME IF YOU NEED BLOBS, IT'S ANNOYING TO GET THE SAME QUESTION 1000+ TIMES
-------------------------------------------

Has been tested on macOS Mojave, on both fresh installs and not fresh. Would not reccomend Catalina (at this stage) as most users run into issues. 

So macOS support is only Mojave currently. No Catalina, no High Sierra and no Sierra or lower. If it works for you on an unsupported version then great but offically only Mojave is supported. 

If you keep failing on restore stage, try creating a new 35gb ish partition and installing a fresh copy of macOS Mojave on it and start from step one. 

If this breaks your phone or macOS install I take absolutely no responibility.
These scripts have been tested by me and others and should be fine but incase something goes wrong thats on you not me. 
-------------------------------------------
-------------------------------------------

Currently custom boot-args/bootlogo's/verbose restore or boot are not supported because I don't care or have time to get them implemented.

-------------------------------------------
The only things you need for this are as follows: 

The files from this repo

iOS 10.3.3 IPSW from ipsw.me 

All the above in the same folder

An iPhone 5s (6,1 or 6,2) or iPad Air (iPad4,1 iPad4,2 and iPad4,3) or iPad Mini 2 (iPad4,4 and iPad4,5)

A Terminal window open

A few braincells (VERY IMPORTANT) 

Commonsense (RARE BUT ALSO VERY IMPORTANT)

Patience!!!


-------------------------------------------

Thank you to anyone who helped me with testing or anything else! Couldn't have done it myself. 

Credits to: axi0mx, Tihmstar, LinusHenze, alitek12, xerub and s0uthwest

Thanks to: @Vyce_Merculous, @xerusxan, @AyyItzRob123, @BarisUlasCukur, @DaveWijk, @melvin_zill and anyone else I missed!

-------------------------------------------

First make sure you have the 10.3.3 IPSW in the main directory where "prep.sh" and the other scripts are.

Also make sure you have at least 10 GB free on your SSD/HDD

Then run the scripts in this order:
1. `"chmod +x *.sh"`
2. `"./install.sh"`
3. `"./prep.sh"`
4. Place device into DFU Mode and connect to computer. 
5. THIS SCRIPT MAY/WILL FAIL UP TO 40 TIMES. JUST KEEP TRYING. 
6. `"./pwn.sh"`
7. `"./restore.sh"`
8. Enjoy 10.3.3! 

-------------------------------------------

Any questions either open an issue here, message/@me on twitter or comment on the reddit post.

Enjoy =) Hope these scripts were useful to you! <3 

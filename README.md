# 10.3.3 OTA Script
 Script to downgrade 5s's to 10.3.3 with OTA blobs

Only supports the iPhone 5s (6,1 and 6,2). Has been tested on macOS Mojave. Catalina does not work at this stage.

First make sure you have the 10.3.3 IPSW in the main directory where "prep.sh" and the other scripts are.
Also make sure you have at least 10 GB free on your SSD/HDD
Then run the scripts in this order:
1. "./install.sh"
2. "sudo ./install_2.sh
3. "./prep.sh"
4. Place device into DFU Mode and connect to computer. THIS WILL FAIL UP TO 40 TIMES JUST KEEP TRYING. 
5. "./pwn.sh"
6. "./restore.sh"
7. Enjoy 10.3.3! 
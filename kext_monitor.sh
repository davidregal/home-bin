# Records non-Apple kext to a log every 30 minutes
# Created by: David Regal
# Modified: 4/28/2015
# Depends on: kextstat
while [ 1 ]; do date >> ~/tmp/kext_non_apple.txt; kextstat -kl | awk '!/com\.apple/{printf "%s %s\n", $6, $7}' >> ~/tmp/kext_non_apple.txt; sleep 300; done;

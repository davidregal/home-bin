# Sends a "heartbeat" message to Wake Times Aether text file.
# For calculating personal versus business use.
# Script should be running any time Aether is awake and being used for business.
# Created by: David Regal
# Modified: 4/14/2013
while [ 1 ]; do date >> ~/Documents/business/taxes/timebusinessaether.txt; sleep 300; done;

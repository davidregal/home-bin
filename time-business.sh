# Sends a "heartbeat" message to Wake Times Aether text file.
# For calculating personal versus business use.
# Script should be running any time Aether is awake and being used for business.
# Created by: David Regal
# Modified: 2/12/2015
function set_tab_title {
  printf "\e]1;$1\a"
}

set_tab_title "It's business time."
while [ 1 ];
  do date >> ~/Documents/business/taxes/timebusinessaether.txt;
  sleep 300;
done;

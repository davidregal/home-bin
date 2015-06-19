# Logs currently running applications (Windowed processes) the system log (syslog) every 30 minutes
# Created by: David Regal
# Modified: 6/19/2015
# Depends on: Apple Script osx_list_applications.scpt. Adapted from multiple source.
#  Credits:
#  Script from http://apple.stackexchange.com/questions/4286/is-there-a-mac-os-x-terminal-version-of-the-free-command-in-linux-systems.
while [ 1 ]; do 
	osascript ~dave/bin/osx_list_running_applications.scpt;
	sleep 3; # 30 minutes = 1800 seconds.
done;

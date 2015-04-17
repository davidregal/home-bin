# Reports memory levels to a log every 30 minutes
# Created by: David Regal
# Modified: 4/17/2015
# Depends on: mem_report.py. Script from http://apple.stackexchange.com/questions/4286/is-there-a-mac-os-x-terminal-version-of-the-free-command-in-linux-systems.
while [ 1 ]; do date >> ~/tmp/memory_levels.txt; mem_report.py >> ~/tmp/memory_levels.txt; sleep 300; done;

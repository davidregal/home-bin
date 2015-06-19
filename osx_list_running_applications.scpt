-- Logs currently running applications (Windowed processes) the system log (syslog) every 30 minutes
-- Created by: David Regal
-- Modified: 6/19/2015
-- Credits: http://stackoverflow.com/questions/18372328/applescript-get-list-of-running-apps, http://mac-os-x.10953.n7.nabble.com/log-from-applescript-td17561.html

tell application "System Events"
    set listOfProcesses to (name of every process where background only is false)
end tell
--The variable `selectedProcesses` will contain the list of selected items.
repeat with processName in listOfProcesses
	set logMessage to "randomRestartDebug Application Running: " & processName
	--When running script, a newline is added to the terminal from one of these 2 commands. Not a problem unless running the script in a loop. Adding "> /dev/null 2>&1 &" to the end didn't work.
	do shell script "/usr/bin/logger " & quoted form of logMessage
end repeat

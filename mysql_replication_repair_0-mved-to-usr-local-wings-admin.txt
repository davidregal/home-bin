#!/bin/bash
# File: mysql_replication_repair.sh 
# Purpose: Allows you to quickly and selectively skip past certain transactions in the relay log.
# Reason we would do this is the destination table or WINGS site is non-vital (e.g. demo, development, etc).
# Created: 2013-05-05
# By: David Regal
# Credits: http://www.howtoforge.com/how-to-repair-mysql-replication
done=0;
while [ $done -eq 0 ];
do
	# get status
	done=$( mysql -u root -p -Be 'SHOW SLAVE STATUS;' | tail -1 | cut -f12 | grep Yes | wc -l )
	if [ $done -eq 0 ];
		then
		echo "Advancing position past [$(mysql -u root -p -Be 'SHOW SLAVE STATUS;' | tail -1 | cut -f20)]... ";
		read -p "Are you sure? " -n 1 -r;
		if [[ $REPLY =~ ^[Yy]$ ]];
			then
			echo ;
			mysql -u root -p -Be "SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; START SLAVE;";
			sleep 1;
		else
			done=1;
			echo ;
			echo Exiting;
		fi;
	fi
done 


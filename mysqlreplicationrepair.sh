#!/bin/bash
# File: mysql_replication_repair.sh 
# Purpose: Allows you to quickly and selectively skip past certain transactions in the relay log.
# Reason we would do this is the destination table or WINGS site is non-vital (e.g. demo, development, etc).
# Created: 2013-05-05
# By: David Regal
# Credits: http://www.howtoforge.com/how-to-repair-mysql-replication

read -s -p "MySQL root password: " password_mysql;
echo ;
done=0;
sleep_seconds=5;
sleep_seconds_long=300;
while [ $done -eq 0 ];
do
	# get status
	done=$( mysql -u root -p${password_mysql} -Be 'SHOW SLAVE STATUS;' | tail -1 | cut -f12 | grep Yes | wc -l )
	if [ $done -eq 0 ];
	then
		error="$(mysql -u root -p${password_mysql} -Be 'SHOW SLAVE STATUS;' | tail -1 | cut -f20)";
		echo "$error" | grep -q 'wings_demo';
		no_match=$?;
		if [ ${no_match} -eq 0 ];
		then
			echo "Table wings_demo: Yes";
		else
			echo "Table wings_demo: No";
		fi
		echo "Advancing position past ${error}... ";
		read -p "Are you sure? " -n 2 -r;
		if [[ $REPLY =~ ^[Yy]$ ]];
		then
			mysql -u root -p${password_mysql} -Be "SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; START SLAVE;";
			sleep ${sleep_seconds};
		else
			done=1;
			echo Exiting;
		fi
	else
		seconds_behind_info="$(mysql -u root -p${password_mysql} -Be 'SHOW SLAVE STATUS \G' | grep 'Seconds_Behind_Master')";
		echo "INFO:  Slave is ${seconds_behind_info}";
		echo "No errors found yet but if slave is way behind master, then probably a few more errors will pop-up.";
		#echo "Sleep a little more? ";
		#read -p "Are you sure? " -n 1 -r;
		read -p "Sleep for $((sleep_seconds_long/60)) minutes? " -n 2 -r;
		if [[ $REPLY =~ ^[Yy]$ ]];
		then
			done=0;
			sleep ${sleep_seconds_long};
			sleep_seconds_long=$((sleep_seconds_long*2))
		fi
	fi
done

echo Exiting final;

password_mysql="";


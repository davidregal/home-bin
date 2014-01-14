#!/bin/sh
# $Id: throttle.sh 42 2011-05-06 02:50:22Z dave $
# $URL: file:///var/svn/reposit/trunk/homebin/throttle.sh $

arg0=$(basename $0)

usage () {
	arg0=$(basename $0)
	echo "usage: $arg0 [-t command] [-k KByte] [-d] [-v]"
	echo "       $arg0 [-h]"
	echo "       $arg0 [-V]"
}

help () {
	usage
	echo ""
	echo "You must be in the superusers group to use this script."
	echo ""
	echo "Valid options:"
	echo "  -d             : debug output."
	echo "  -k KByte       : Max KByte/s."
	echo "  -V             : Note the capital V. Version info."
	echo "  -v             : verbose output."
	echo "  -t command     : 'on' = turn bandwidth throttle on. 'off' = turn bandwidth throttle off. Controls the throttle."
	echo ""
}

throttleOn () {
	# On
	if [ "$verbose" == "1" ];
	then
		echo "Throttling to ${KByte} KByte/s."
	fi

	sudo ipfw pipe 1 config bw ${KByte}KByte/s
	sudo ipfw add 1 pipe 1 src-port 80
}

throttleOff () {
	sudo ipfw delete 1
}

KByte=15
verbose=
debug=
command=
while getopts "hvVdk:t:" flag
do
	case "$flag" in
		h) help; exit 0;;
		V) echo "$arg0: version $Id: throttle.sh 42 2011-05-06 02:50:22Z dave $"; exit 0;;
		v) verbose=1;;
		k) KByte="$OPTARG";;
		t) command="$OPTARG";;
		*) usage;;
	esac
done

if [ $command = "on" ]; then
	if [ "$verbose" == "1" ];
	then
		echo "Turning on throttle."
	fi
	throttleOn
else
	if [ "$verbose" == "1" ];
	then
		echo "Turning off throttle."
	fi
	throttleOff
fi


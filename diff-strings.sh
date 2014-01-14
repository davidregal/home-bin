#!/bin/sh
left=$1
right=$2
if [ "${left}" = "${right}" ]
	then echo "eq";
else 
	echo "ne"; 
fi

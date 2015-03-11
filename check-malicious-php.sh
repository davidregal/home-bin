#!/bin/bash
# Created by: David Regal
# Modified by: David Regal

arg0=$(basename $0)
VERSION="0"
usage_printed=false # To prevent printing usage more than once

# Functions
function usage () {
	if ! $usage_printed; then
		arg0=$(basename $0)
		echo "Usage: $arg0 -s source-directory [-d]"
		echo "       $arg0 [-h]"
		echo "       $arg0 [-V]"
		usage_printed=true
	fi
}

function help () {
	usage
	echo " Script '$arg0' does a quick check for malicious PHP code. You must 'Use the Source Luke' and review the results to validate if there is a true threat."
	echo ""
	echo "Valid options:"
	echo "  -d                   : debug output."
	echo '  -s source-directory  : Relative or full path to directory to check.'
	echo "  -V                   : version info."
	echo "  -v                   : verbose output."
	echo ""
	echo "Examples:"
	echo "  $arg0 -s ~/tmp/php-reporting-tool"
	echo ""
}

function pause(){
	read -p "$*"
}

expand_tilde()
{
	case "$1" in
	(\~)        echo "$HOME";;
	(\~/*)      echo "$HOME/${1#\~/}";;
	(\~[^/]*/*) local user=$(eval echo ${1%%/*})
				echo "$user/${1#*/}";;
	(\~[^/]*)   eval echo ${1};;
	(*)         echo "$1";;
	esac
}

verbose=
debug=
while getopts "hvVds:" flag
do
	case "$flag" in
		h) help; exit 0;;
		V) echo "$arg0: version $VERSION"; exit 0;;
		v) verbose=1;;
		d) debug=1;;
		s) src_dir="$(expand_tilde $OPTARG)";;
		*) usage;;
	esac
done

dir_to_check="$src_dir"
grep -Rn "shell_exec *(" "$dir_to_check"
grep -Rn "base64_decode *(" "$dir_to_check"
grep -Rn "base64_encode *(" "$dir_to_check"
grep -Rn "phpinfo *(" "$dir_to_check"
grep -Rn "system *(" "$dir_to_check"
grep -Rn "php_uname *(" "$dir_to_check"
grep -Rn "chmod *(" "$dir_to_check"
grep -Rn "fopen *(" "$dir_to_check"
grep -Rn "fclose *(" "$dir_to_check"
grep -Rn "readfile *(" "$dir_to_check"
grep -Rn "edoced_46esab *(" "$dir_to_check"
grep -Rn "eval *(" "$dir_to_check"
grep -Rn "passthru *(" "$dir_to_check"

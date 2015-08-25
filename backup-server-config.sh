#!/bin/bash
# Created by: David Regal
# Modified by: David Regal

arg0=$(basename $0)
usage_printed=false # To prevent printing usage more than once

# Functions
function usage () {
	if ! $usage_printed; then
		arg0=$(basename $0)
		echo "Usage: $arg0 -r destination-root -s server-name"
		echo "Usage: $arg0 [-h]"
		usage_printed=true
	fi
}

function help () {
	usage
	echo " Script '$arg0' makes a backup of the server configuration for PHP, MySQL and Apache. A good time to run this script is before upgrading Linux modules or Linux version. Do not run as root or sudo because it could copied private files with sensitive info (password)."
	echo ""
	echo "Valid options:"
	echo "  -r destination-root  : Root directory of the destination. Must be a git remote repo. No trailing slashes. E.g. ~/etc"
	echo '  -s server-name       : Name of the server being backed up. You can use probably $hostname. Dir <server-name> will be created in <destination-root>'
	echo '  -h                   : Show help.'
	echo ""
	echo "Examples:"
	echo "  $arg0 -r ~/etc -s apollo-web"
	echo '  $arg0 -r ~/etc -s "$(hostname)"'
	echo '  $arg0 -h'
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

while getopts "hr:s:" flag
do
	case "$flag" in
		h) help; exit 0;;
		r) dst_root="$(expand_tilde $OPTARG)";;
		s) servername="$OPTARG";;
		*) usage;;
	esac
done

if [[ "$dst_root" == "" || "$servername" == "" ]]; then
	echo "ERROR: Options -r and -s are required and require arguments." >&2
	usage
	exit 1
fi

# Setup
#servername="wingsdev"
#dst_root="$HOME/etc" # No trailing slash
dst="${dst_root}/${servername}"
src_root="/etc"

# Create dirs
mkdir -p "${dst}/apache2/sites-available/old"
mkdir -p "${dst}/php5/apache2"
mkdir -p "${dst}/php5/apache2/conf.d"
mkdir -p "${dst}/php5/mods-available"
mkdir -p "${dst}/php5/cli"
mkdir -p "${dst}/mysql"
mkdir -p "${dst}/apt"

# Backup dirs or files with critical custom configurations
# Dirs
cp -rpf "${src_root}/apache2/sites-available" "${dst}/apache2/"
cp -rpf "${src_root}/apache2/" "${dst}/"
cp -rpf "${src_root}/php5/apache2" "${dst}/php5/"
cp -rpf "${src_root}/php5/conf.d" "${dst}/php5/"
cp -rpf "${src_root}/php5/mods-available" "${dst}/php5/"
cp -rpf "${src_root}/php5/cli/" "${dst}/php5/"
# Files
cp -pf "${src_root}/mysql/my.cnf" "${dst}/mysql/"
cp -rpf "${src_root}/apt/sources.list" "${dst}/apt/"

# Add and commit locally
cd "${dst_root}"
echo "git status:"
git status
pause "Check git status. If want to add, commit and push, then press return. Otherwise press [Ctrl]+c"
git pl && git add -A . && git commit -a -m "Backup server config for ${servername}."

# Push to github
git pl && git push origin master


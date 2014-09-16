#!/bin/sh
# $Id:$
# $URL:$

arg0=$(basename $0)

usage () {
	arg0=$(basename $0)
	echo "usage: $arg0 [-b branch] [-u upstream-branch] [-p parent-of-wc] [-v]"
	echo "usage: $arg0  [-d] [-v]"
	echo "       $arg0 [-h]"
	echo "       $arg0 [-V]"
}

help () {
	usage
	echo "Description:"
	echo "  Syncs branch with upstream then reintegrates branch ino upstream."
	echo "  WARNING: This will delete branch after it has successfully been reintegrated."
	echo ""
	echo "Valid options:"
	echo "  -d                 : debug output."
	echo "  -b branchName      : Name of development branch."
	echo "  -u NameUpstreamBranch  : Branch to reintegrate into. (e.g. Upstream. Beta. Master)."
	echo "  -p  /full/path  : /path/to/parent/of/wc Full path without trailing slashes. Location where both branches are checked out (working copies). (e.g. /var/www/branches/)."
	echo "  -V                 : version info."
	echo "  -v                 : verbose output."
	echo ""
}

#file=
verbose=
debug=
#while getopts "hvVdf:o:" flag
while getopts "hvVdb:u:p:" flag
do
	case "$flag" in
		h) help; exit 0;;
		V) echo "$arg0: version $Id:$"; exit 0;;
		v) verbose=1;;
		d) debug=1;;
		b) branch="$OPTARG";;
		u) upstream="$OPTARG";;
		p) path="$OPTARG";;
		*) usage;;
	esac
done

cd "${path}"
svn copy svn+ssh://dregal@sshwingsnw/var/svn/wings/wings/branches/beta svn+ssh://dregal@sshwingsnw/var/svn/wings/wings/branches/david -m "Recreate david from beta@HEAD."
svn up "${branch}" "${upstream}"

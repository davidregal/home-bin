# For searching for a function within a file (usually PHP file)
function=$1
file=$2
after=$3
echo "$0: Function: ${function}, File: ${file}, After: ${after}"
grep -P -e "function\s+${function}\(" -A ${after} "${file}"
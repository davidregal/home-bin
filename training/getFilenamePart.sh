#!/bin/bash
files=$(ls *.tmp)
echo "Files: $files"
regex="[0-9]+_([a-z]+)_[0-9a-z]*"
for f in $files
do
	echo "Checking: $f"
	name=$(echo "$f" | grep -Po '(?i)[0-9]+_\K[a-z]+(?=_[0-9a-z]*)').jpg
	echo "${name}"
	#[[ $f =~ $regex ]]
	#name="${BASH_REMATCH[1]}"
	#echo "${name}.jpg"    # concatenate strings
	#name="${name}.jpg"    # same thing stored in a variable
done

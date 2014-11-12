#!/bin/sh

#
# greplace
#
# Globally replace one string with another in a set of files
#
# Usage: search-replace.sh oldtext newtext file


/usr/bin/perl -p -i -e "s/$1/$2/g" $3
#!/bin/sh
alias svn="$1/svn"; cd "$2"; shift $3
until [ -z "$1" ]; do
  echo "[ $1 ]"
  # List the names of the modified functions
  svn diff --diff-cmd diff -x '-U0 -p --show-function-line=[[:blank:]]*[-+][[:blank:]]*([[:alpha:]_]' "$1" \
    | sed -E -e 's/(^@@ [^@]* @@ )((.*([[:<:]][[:alnum:]_]+) *\()|(([[:blank:]]*[-+][[:blank:]]*\([^\)]+\)[[:blank:]]*))([[:alnum:]_]+)).*/  (\4\7): /' -e "t" -e "d" \
    | uniq
  echo ""; shift
done

svn stat | grep '^M ' | sed 's/^M       //' | sort | xargs svn diff > ~/tmp/diff-2010-07-11.txt

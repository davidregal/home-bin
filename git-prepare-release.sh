#!/bin/sh
# Description: Created to more quickly create a release. A release has a version number in it.
# Originally created and tested on Mac OS X 10.9.3.
# init
function pause(){
   read -p "$*"
}

git archive --format zip -0 --worktree-attributes -o ~/tmp/wp/git-wp-dev.zip HEAD
if [ ! -d ~/tmp/wp/dev-release ];
then
  mkdir -p ~/tmp/wp/dev-release
else
  echo "Make sure dir ~/tmp/wp/dev-release is empty."
  result=$(ls ~/tmp/wp/dev-release)
  echo "Contents of dir: ${result}"
  pause "Press [Enter] key to continue..."
fi
cd ~/tmp/wp/ && \
unzip git-wp-dev.zip -d ~/tmp/wp/dev-release && \
echo "Unzipped to ~/tmp/wp/dev-release."

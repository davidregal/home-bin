#!/bin/bash
# Purpose: Backup server configuration for PHP, MySQL and Apache
# When to use: Run this before upgrading Linux modules or Linux version.
# 
# Created by: David Regal
# Modified by: David Regal

# Functions
function pause(){
   read -p "$*"
}

# Setup
servername="wingsdev"
dst_root="$HOME/etc" # No trailing slash
dst="${dst_root}/${servername}"
src_root="/etc"

# Create dirs
mkdir -p "${dst}/apache2/sites-available/old"
mkdir -p "${dst}/php5/apache2"
mkdir -p "${dst}/php5/mods-available"
mkdir -p "${dst}/php5/cli"
mkdir -p "${dst}/mysql"

# Backup dirs with files with critical custom configurations
cp -rpf "${src_root}/apache2/sites-available" "${dst}/apache2/"
cp -rpf "${src_root}/php5/apache2" "${dst}/php5/"
cp -rpf "${src_root}/php5/mods-available" "${dst}/php5/"
cp -rpf "${src_root}/php5/cli" "${dst}/php5/"
cp -rpf "${src_root}/mysql" "${dst}/"

# Add and commit locally
cd "${dst}"
echo "git status:"
git status
pause "Check git status. If it looks good, then press return to add, commit and push to github..."
git add -A . && git commit -a -m "Backup server config for ${servername}."

# Push to github
git push origin master


#!/bin/bash
# Huge disadvantage is the table will become read-only.
# Beware that packing a table while the database is running can lead to data corruption, and is unsupported by MySQL AB. Sometimes warning comes from the table not being closed.

# Example compression savings.
#
# Before:
# dregal@wingsdev:/wingsdev/david/src$ sudo find /var/lib/mysql/ -size +80M | xargs sudo ls -alSh
# -rw-rw---- 1 mysql mysql 346M Jun 12 16:45 /var/lib/mysql/wings_sky/student_course_session.MYI
# -rw-rw---- 1 mysql mysql 120M Mar  6  2013 /var/lib/mysql/wings_sky/student_course_session.MYD
# -rw-rw---- 1 mysql mysql 118M Jun 12 16:45 /var/lib/mysql/wings_thrihl/student_course_session.MYI
# -rw-rw---- 1 mysql mysql 110M Jun 12 16:45 /var/lib/mysql/wings_sky/student_attendance.MYI
# dregal@wingsdev:/wingsdev/david/src$ sudo du -ks /var/lib/mysql/wings_sky
# 1043460/var/lib/mysql/wings_sky
  
# 
# File and dir sizes after:
# dregal@wingsdev:/wingsdev/david/src$ sudo ls -alh /var/lib/mysql/wings_sky/student_course_session.MY{I,D}
# -rw-rw---- 1 mysql mysql  51M Mar  6  2013 /var/lib/mysql/wings_sky/student_course_session.MYD
# -rw-rw---- 1 mysql mysql 294M Sep 21 17:19 /var/lib/mysql/wings_sky/student_course_session.MYI
# dregal@wingsdev:/wingsdev/david/src$ sudo du -ks /var/lib/mysql/wings_sky
# 919932     /var/lib/mysql/wings_sky

# Compression ratio and disk savings in this case:
# ( 346 + 120 - 51 - 294) / ( 346 + 120 ) = 26%
# Saving about 121 MB for MYD and MYI files.
#
# For this DB, wings_sky, saving 1043 - 919 = 124 MB. Significant for my local dev environment on a laptop with a 256 GB SSD harddrive.

pause(){
    read -p "$*"
}

# Config
# No trailing slash
root_dir_mysql=/var/lib/mysql
# No leading or trailing slash
db_name=wings_sky
db_table=student_course_session
file_table_fullpath="${root_dir_mysql}/${db_name}/${db_table}"
# No trailing slash
dir_backup=/tmp

echo "Filesizes before:"
sudo ls -lh "${file_table_fullpath}.MYD"
sudo ls -lh "${file_table_fullpath}.MYI"

echo "Backing up existing files to ${dir_backup}"
sudo cp -p "${file_table_fullpath}.MYD" "${dir_backup}/"
sudo cp -p "${file_table_fullpath}.MYI" "${dir_backup}/"

sudo myisamchk -cFU "${file_table_fullpath}" # fast check for pre-existing errors. 
sudo myisamchk -dvv "${file_table_fullpath}"

echo "Look at the 'Record format' in the output above to see if a table is already compress."
echo "If it has:"
echo "Record format:       Compressed"
echo ""
echo "Complete the following visual checks:"
echo '  1. If the table is already compressed, then press [Ctrl]+c to stop this program now.'
pause '  2. Do not pack if errors exist. Ignore the warning of table "not closed" because this check will go ahead and closed the DB files. Press Enter to continue.'

# How to pack a table on a 'live' system:
echo "To prevent data corruption on a 'live' system, be sure to run the following commands first:"
echo "mysql> LOCK TABLE ${db_name}.${db_table} WRITE;"
echo "mysql> FLUSH TABLE ${db_name}.${db_table};"
echo ""
pause 'On a live system, be sure to run the above 2 commands. Press Enter to continue.'

#sudo myisampack "${file_table_fullpath}"
# to unpack use:
sudo myisamchk --unpack "${file_table_fullpath}"
sudo myisamchk -dvv "${file_table_fullpath}"

echo "After you run myisampack, you must run myisamchk to re-create any indexes. At this time, you can also sort the index blocks and create statistics needed for the MySQL optimizer to work more efficiently."
echo "Can make the .MYI file huge."
sudo myisamchk -rq --sort-index --analyze "${file_table_fullpath}.MYI" # rebuild the index after pack
echo "Now run these commands in MySQL prompt:"
echo "mysql> UNLOCK TABLES; -- Release the table."
echo "mysql> FLUSH TABLE ${db_name}.${db_table}; -- force reload of info_schema data"
echo ""
echo "To see if a table is, in fact, compressed and that MySQL is using the compressed table, issue the following query:"
echo "mysql> SHOW TABLE STATUS FROM dbname LIKE 'tableName'\G"
echo "Row_format must be 'Compressed'."

echo "Filesizes after:"
sudo ls -lh "${file_table_fullpath}.MYD"
sudo ls -lh "${file_table_fullpath}.MYI"

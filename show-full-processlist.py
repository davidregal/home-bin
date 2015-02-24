#!/usr/bin/python

import MySQLdb as mdb

con = mdb.connect('localhost', 'root', '<need-to-add-argument-here>', 'wadmin');

with con: 
    cur = con.cursor()
    cur.execute("SHOW FULL PROCESSLIST")
    rows = cur.fetchall()
    for row in rows:
        print row


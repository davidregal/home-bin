#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Requires Python 3 or above.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

"""

import os
import sys
import argparse
import datetime
import getpass


__title__ = 'create-wp-instance'
__version__ = '0.0.1'
__author__ = 'David Regal'
__license__ = 'MIT'
__copyright__ = 'Copyright 2014 Techborder'


def get_args_parser():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument("-h", "--host",
        default="localhost",
        nargs='?',
        type=str,
        help="Connect to host.")
    parser.add_argument("-p", "--port",
        default=3306,
        nargs='?',
        type=int,
        help="Port number to use for connection.")
    parser.add_argument("-u", "--user",
        default=None,
        nargs='?',
        type=str,
        help="User for login if not current user.")
    parser.add_argument("-P", "--password",
        default='',
        nargs='?',
        type=str,
        help="Password to use when connecting to server.")
    parser.add_argument("--help",
        default=False,
        action='store_true',
        help="Show this help message and exit.")
    return parser

if __name__ == '__main__':
    parser = get_args_parser()
    options = parser.parse_args()
    if options.help:
        parser.print_help()
        parser.exit()
    
    # Debug
    print("Version:", sys.version)
    
    database_name = input("Database name: ")
    print ("Checking name of database.", database_name)
    
    database_user = input("Database user: ")
    print ("Checking name of database.", database_user)
    
    database_password = input("Database user password: ")
    print ("Checking name of database.", database_password)
    
    command = """CREATE DATABASE {database_name}
    CREATE USER {database_user}@localhost;
    SET PASSWORD FOR {database_user}@localhost=PASSWORD('{database_password}');
    GRANT ALL PRIVILEGES ON {database_name}.* TO {database_user}@localhost;
    FLUSH PRIVILEGES;"""
    
    command = command.format(database_name = database_name, database_user = database_user, database_password = database_password)
    print ("SQL commands:")
    print (command)
    
    #is_host_novelcreator = input("Is this going to be used on novelcreator.com? ")
    # Validate characters
    
    # Validate length
    # If being used on bluehost, then prefix will take some room

    #def __init__(self, options):
    #    self.options = options
    #    if self.options.password is None:
    #        self.options.password = getpass.getpass()
    #    if self.options.user is None:
    #        self.options.user = os.getenv('USERNAME')
    #
    #    try:
    #        db = Database.connect(
    #            host=self.options.host,
    #            user=self.options.user,
    #            port=self.options.port,
    #            passwd=self.options.password)
    #    except Exception, err:
    #        logging.exception(err)
    #        print err
    #        sys.exit()

    #if options.debug:
    #    if not os.path.isdir("logs"):
    #        os.mkdir("logs")
    #    logging.basicConfig(
    #        format='%(asctime)s - (%(threadName)s) - %(message)s in %(funcName)s() at %(filename)s : %(lineno)s',
    #        level=logging.DEBUG,
    #        filename="logs/debug.log",
    #        filemode='w',
    #    )
    #    logging.debug(options)
    #else:
    #    logging.basicConfig(handler=logging.NullHandler)
    #
    #if(options.nonint):
    #    monitor = CliMode(options)
    #else:
    #    monitor = IntractiveMode(options)
    #monitor.run()

# vim: fenc=utf8 et sw=4 ts=4

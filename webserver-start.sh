#!/bin/sh
DateUptime="$(date),$(uptime)"; echo "${DateUptime}, webserver, start" >> ~dave/Documents/techborder/taxes/StartStopTechborder.txt

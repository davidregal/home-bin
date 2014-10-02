#!/bin/sh
DateUptime="$(date),$(uptime)"; echo "${DateUptime}, webserver, stop" >> ~dave/Documents/techborder/taxes/StartStopTechborder.txt

#!/bin/sh
DateUptime="$(date),$(uptime)"; echo "${DateUptime}, techborder, stop" >> ~dave/Documents/techborder/taxes/StartStopTechborder.txt

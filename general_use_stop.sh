#!/bin/sh
DateUptime="$(date),$(uptime)"; echo "${DateUptime}, general use, stop" >> ~dave/Documents/techborder/taxes/StartStopTechborder.txt

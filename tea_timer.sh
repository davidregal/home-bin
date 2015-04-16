#!/bin/bash
# Usage:  ./tea_timer.sh
#         echo 3 | ./tea_timer.sh 
# 
# 
function set_tab_title {
  printf "\e]1;$1\a"
}

function set_window_title {
  printf "\e]2;$1\a"
}

echo -n "How many minutes would you like the timer to run? "
read limit
echo
echo "Timing $limit minutes..."
echo
counter=$limit
# How many times to beep before exiting. Helps to not annoy those around your laptop if you're away.
beeps_before_bailing=60
# Seconds between beeps
s_between_beeps=10
while [  0 != $counter ]; do
   echo "$counter minutes left...";
   set_window_title "$counter minutes left"
   set_tab_title "The focus."
   # Debug
   #sleep 1
   sleep 60
   let "counter = $counter - 1"
done
if [ 0 = $counter ]; then
   echo
   echo "Time's up. $limit minutes have elapsed."
   while [ 0 != $beeps_before_bailing ]; do
      echo '"There is no future in any job. The future lies in the man who holds the job."'
      echo "Press Ctl + c to exit."
      echo -e '\a' >&2
      sleep $s_between_beeps
      let "beeps_before_bailing = $beeps_before_bailing - 1"
   done
   exit 0
fi

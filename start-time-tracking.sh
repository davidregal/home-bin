#!/bin/sh
#. ~dave/.bashrc

set_tab_title () 
{ 
    local title="$1";
    if [[ -z "$title" ]]; then
        title=${USER};
    fi;
    echo "\033]0;$title\007"
}

set_tab_title timer
~dave/bin/time-awake.sh &
~dave/bin/time-business.sh


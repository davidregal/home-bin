#!/bin/sh
############################# SSH ##########################################
# Start the complementary tool to remember passwords 
#eval `ssh-agent -s`

# Add my key to it
#ssh-add ~/.ssh/id_rsa

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
	platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
	platform='osx'
fi

if [[ $platform == 'linux' ]]; then
	echo "Linux detected. Setting up SSH Agent."
	# If no SSH agent is already running, start one now. Re-use sockets so we never
	# have to start more than one session.
	# What the block below does is, it sets the socket filename manually to /home/yourusername/.ssh-socket. It then runs ssh-add, which will attempt to connect to the ssh-agent through the socket. If it fails, it means no ssh-agent is running, so we do some cleanup and start one.
	# Credit: http://www.electricmonk.nl/log/2012/04/24/re-use-existing-ssh-agent-cygwin-et-al/
	export SSH_AUTH_SOCK=~/.ssh/ssh-socket

	ssh-add -l >/dev/null 2>&1
	if [ $? = 2 ]; then
	   # No ssh-agent running
	   rm -rf $SSH_AUTH_SOCK
	   # >| allows output redirection to over-write files if no clobber is set
	   ssh-agent -a $SSH_AUTH_SOCK >| /tmp/.ssh-script
	   source /tmp/.ssh-script
	   echo $SSH_AGENT_PID >| ~/.ssh/ssh-agent-pid
	   rm /tmp/.ssh-script
	fi
fi


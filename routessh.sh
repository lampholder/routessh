#!/bin/bash
# Simple mosh-compatible ssh forwarding script to route inbound ssh(/mosh) traffic
#  to a particular machine based on username.
#
# Sample /etc/ssh/sshd_config
# Match user joe
#     ForceCommand /path/to/forward.sh joet@192.168.3.14

if [[ $# -eq 0 ]]
then
    echo "forward.sh: no destination supplied"
    exit
fi

if [[ $SSH_ORIGINAL_COMMAND == *"mosh-server"* ]]
then
    eval `echo $SSH_ORIGINAL_COMMAND | tr -d "'"` -- ssh -q $1
else
    ssh -q $1 $SSH_ORIGINAL_COMMAND
fi

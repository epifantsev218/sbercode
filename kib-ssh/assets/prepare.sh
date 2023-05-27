#!/bin/bash -x
PS1=1
source /root/.bashrc

eval "$(ssh-agent -s)"
touch /root/2.txt

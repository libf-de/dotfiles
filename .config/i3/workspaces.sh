#!/bin/bash

current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
max_workspaces=4

if [ "$1" = "next" ]; then
    next=$((current + 1))
    if [ $next -gt $max_workspaces ]; then
        next=1
    fi
    i3-msg workspace number $next
elif [ "$1" = "prev" ]; then
    prev=$((current - 1))
    if [ $prev -lt 1 ]; then
        prev=$max_workspaces
    fi
    i3-msg workspace number $prev
fi

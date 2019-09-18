#!/bin/bash

# $DIR=$(dirname $PWD)
# dir can be used for Project folder check 

BASE=$(basename $PWD)

if [ $BASE != "andasis-nms-project" ]; then
     echo "You must clone andasis repository first"
     echo "You are not in a nms application directory"
     exit 
fi

NMS_START=~/nms-start.sh

function start_all() {

    files=(*)
    for item in ${files[*]}; do
        if [ -d "${item}" ]; then
            echo "run $item"  
            x-terminal-emulator -e $NMS_START $item
        fi
    done
}

start_all



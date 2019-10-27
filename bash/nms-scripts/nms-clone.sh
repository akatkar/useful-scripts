#!/bin/bash

# This script clone a parent project with their submodules
# and switch to master branch for each sub-module

# Git commands
SWITCH_BRANCH="git checkout"
UPDATE_BRANCH="git pull"

function process_submodule() {
    cd $1
    "$($SWITCH_BRANCH $2)"
    "$($UPDATE_BRANCH)"
    if [[ $1 == *"nms-ui"* ]]; then
        npm install
    fi
    cd ..
}
   
function process_submodules() {
    files=(*)
    for item in ${files[*]}
    do
        if [ -d "${item}" ]
            then process_submodule $item "master"
        fi
    done
}

function clone_with_submodules() {
    echo "cloning $1";
    git clone --recurse-submodules $1
    cd andasis-nms-project
}

function main() {
    clone_with_submodules "git@bitbucket.org:andasisnms/andasis-nms-project.git"

    echo
    echo "Process submodules"
    process_submodules;
    
    cd andasis-nms-project
}

main




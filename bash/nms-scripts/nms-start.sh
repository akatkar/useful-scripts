#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit
fi

function run_springboot() {
    cd $1
    mvn spring-boot:run
}

function run_angular() {
    cd $1
    ng serve --open
}

function start_microservice() {
    echo $1
    if [[ $1 == *"nms-ui"* ]]; then
        run_angular $1
    else
        run_springboot $1
    fi
}

start_microservice $1



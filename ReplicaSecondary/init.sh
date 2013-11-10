#!/usr/bin/env bash

########################
# Prepare
########################
CONFDIR='./etc'
LOGFILE='./install.log'
SRV_CNT=$1
shift 1

function log() {
    echo "$1" >> install.log
}

. ./install.sh $*

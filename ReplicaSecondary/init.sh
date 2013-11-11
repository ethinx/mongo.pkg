#!/usr/bin/env bash

########################
# Prepare
########################
cd "$(dirname ${BASH_SOURCE[0]})"

CONFDIR='./etc'
LOGFILE='./install.log'
SRV_CNT=$1
shift 1

function log() {
    echo "$1" >> install.log
}

. ./install.sh $*

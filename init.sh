#!/usr/bin/env bash

########################
# Prepare
########################
PKGNAME="mongo.pkg"
TMPPATH="/tmp/$PKGNAME"
BASECONF="$TMPPATH/base"
MASTERCONF=""
SLAVECONF=""

cd /tmp

if [ -f $PKGNAME.tar.gz ]
then
    tar xvf $PKGNAME.tar.gz -C /tmp
elif [ -f $PKGNAME.tar.gz2 ]
then
    tar xvf $PKGNAME.tar.gz -C /tmp
else
    echo 'Error when extracting files...'
    exit 1
fi

cd $TMPPATH

. ./install.sh

#!/usr/bin/env bash

########################
# Prepare
########################
#PKGNAME="mongodb"
#TMPPATH="/tmp/$PKGNAME"

########################
# Installation
########################
if ! rpm -q mongo-10gen > /dev/null && ! rpm -q mongo-10gen-server > /dev/null
then

cat > /etc/yum.repos.d/mongodb.repo << EOF
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF

    yum install -q -y mongo-10gen mongo-10gen-server

    chkconfig mongod on
fi

########################
# Configuration files
########################
cp $BASECONF/etc/hosts /etc/hosts
cp $BASECONF/etc/mongod.conf /etc/mongod.conf

########################
# Setup service
########################
service mongod start
#if [ $? -ne 0 ]
#then
    #exit 1
#fi

#if [[ `hostname` == "slave-cloud-1" ]]
#then

#mongo << EOF
#rs.initiate()
#rs.add('slave-cloud-3')
#EOF

#fi

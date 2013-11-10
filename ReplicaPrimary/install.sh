#!/usr/bin/env bash

########################
# Prepare
########################
#PKGNAME="mongodb"
#TMPPATH="/tmp/$PKGNAME"

########################
# Installation
########################
log 'Creating mongodb.repo...'
cat > /etc/yum.repos.d/mongodb.repo << EOF
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF

log 'Installing mongodb...'
yum install -q -y mongo-10gen mongo-10gen-server

log 'chkconfig mongod on'
chkconfig mongod on

########################
# Configuration files
########################
log 'Copying configuration files'
cp $CONFDIR/mongod.conf /etc/mongod.conf

########################
# Setup service
########################
log 'Starting services'
service mongod start

log 'Initiate replication'
mongo << EOF
rs.initiate()
EOF

log 'Adding nodes'
for i in $*
do
rs.add("$i")
done

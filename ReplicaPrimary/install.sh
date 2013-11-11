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
if ! rpm -q mongo-10gen-server
then
yum install -q -y mongo-10gen mongo-10gen-server
fi

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
echo 'rs.initiate()' | mongo
sleep 1
res=0
while [ $res -eq 0 ]
do
    res=`echo 'rs.status()' | mongo --quiet | egrep ok | awk '{print $3}'`
    res=${res/,/}
    sleep 1
done

if [ $? -ne 0 ]
then
    exit 1
fi

log 'Adding nodes'
for ip in $*
do
    log "Adding node $ip"
    json=`mongo --quiet --eval "printjson(rs.add('$ip'))"`
    res=`echo $json | python -c 'import json,sys; print json.load(sys.stdin)["ok"]'`
    if [ $res -eq 1 ]
    then
        log 'Success'
    else
        log 'Failed'
    fi
done

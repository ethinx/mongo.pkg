#!/bin/bash

rm -rf mongo.pkg.tar.gz

tar zcvf mongo.pkg.tar.gz mongo.pkg

scp init.sh mongo.pkg.tar.gz lab.linuxtty.com:/tmp
rm -rf mongo.pkg.tar.gz
ssh lab.linuxtty.com "/bin/bash -c 'nohup /tmp/init.sh > /dev/null 2>&1 &' "

clean:
	service mongod stop
	yum remove -y mongo-10gen mongo-10gen-server
	rm -rf /etc/mongod.conf*
	rm -rf /var/lib/mongo/*

install:
	sh -x init.sh

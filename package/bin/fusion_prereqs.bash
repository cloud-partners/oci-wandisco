#!/bin/bash -x


sudo groupadd hdfs
sudo useradd -g hdfs -l -s /bin/bash hdfs

sudo yum -y install java
sudo yum -y install s3cmd

exit


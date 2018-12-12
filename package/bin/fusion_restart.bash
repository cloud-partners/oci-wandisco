#!/bin/bash -x

#sudo /etc/init.d/fusion-ui-server stop
#sudo /etc/init.d/fusion-ihc-server-* stop
sudo service fusion-server restart
sudo /etc/init.d/fusion-ihc-server-* restart
sudo service fusion-ui-server restart
sleep 30

[ -e /etc/init.d/s3proxy-server ] && sudo service s3proxy-server restart
[ -e /etc/init.d/multicloud-proxy-server ] && sudo service multicloud-proxy-server restart

#printf "%s\n" "Fix firewall - open specific ports"

sudo setenforce 0
sudo systemctl enable firewalld
sleep 1
for p in 6444 7000 8023 8081 8082 8083 9001 8071
do
    sudo firewall-cmd --zone=public --permanent --add-port=${p}/tcp
done
sudo firewall-cmd --reload
sudo setenforce 1


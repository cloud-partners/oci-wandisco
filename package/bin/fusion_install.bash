#!/bin/bash -x

if [[ ! -e "${FusionSoftware}" ]]
then
    printf "%s\n" "*** Error missing or non-existant Directory"
    exit 1
fi

sudo /opt/wandisco/fusion-ui-server/scripts/unins*
sudo rpm -e $( rpm -aq|grep fusion )
sudo rm -rf /etc/wandisco /opt/wandisco /var/log/fusion /var/log/wandisco

test -f /tmp/configuration.properties && sudo /bin/rm /tmp/configuration.properties

cat ${FusionSoftware}/s3_silent_installer.properties | sed \
    -e"s?ADMINUSER?$adminUsername?" \
    -e"s?ADMINPASSWORD?$adminPassword?" \
    -e"s?FQDN?$fqdn?" \
    -e"s?ZONE?$zone?" \
    -e"s?NODE?$node?" \
    -e"s?BUCKET?$bucket?" \
    -e"s?REGION?$region?" \
    -e"s?ENDPOINTURL?$endpointurl?" \
    -e"s?ACCESSKEY?$accesskey?" \
    -e"s?SECRETKEY?$secretkey?" \
    -e"s?FUSIONSOFTWARE?$FusionSoftware?" \
    > /tmp/configuration.properties

cp /home/opc/Fusion_Software/license.key /tmp/

sudo -E NOCHECK=1 \
     FUSIONUI_USER=hdfs \
     FUSIONUI_GROUP=hdfs \
     FUSIONUI_INTERNALLY_MANAGED_USERNAME=admin \
     FUSIONUI_INTERNALLY_MANAGED_PASSWORD=admin \
     FUSIONUI_FUSION_BACKEND_CHOICE=asf-2.5.0:2.5.0 \
     FUSIONUI_UI_PORT=8083 \
     FUSIONUI_TARGET_PORT=8082 \
     SILENT_PROPERTIES_PATH=/tmp/configuration.properties \
     sh ${FusionSoftware}/fusion*s3*sh

if [[ "$?" != "0" ]];
then
    printf "%s\n" "*** Fusion install failed"
    exit 1
fi

exit
#sudo -E /opt/wandisco/fusion-ui-server/scripts/silent_installer_full_install.sh /tmp/configuration.properties

# fix problem with missing .aws file
sudo -u hdfs test -e /home/hdfs/.aws/credentials
if [[ $? == 1 ]] 
then
    #sudo cp -a /root/.aws /home/hdfs
    sudo mkdir /home/hdfs/.aws
    printf "%s\n%s\n%s\n" "[default]" "aws_access_key_id=${accesskey}" "aws_secret_access_key=${secretkey}"  > credentials
    printf "%s\n%s\n" "[default]" "region=${region}"  > config
    sudo mv config credentials /home/hdfs/.aws
    sudo chown -R hdfs /home/hdfs
fi

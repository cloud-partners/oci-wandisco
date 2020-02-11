
export BaseDir="/home/opc"
printf "%s\n" "Installing Fusion Server..."

# bootstrap scripts and software and run installations

export FusionSoftware="${BaseDir}/Fusion_Software"
export FusionScripts="${BaseDir}/bin"

cd "${BaseDir}"

# make the s3cmd tool configuration file s3cfg
# allows debug of s3 API calls
#s3config=${BaseDir}/.s3cfg
#cat <<EOF > ${s3config}
#[default]
#access_key = $accesskey
#secret_key = $secretkey
#bucket_location = $region
#host_base = $endpointurl
#host_bucket = $endpointurl
#signature_v2 = False
#use_https = True
#EOF


wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/S_sIPT1529buqP0gkBqpLPm4zhItDBTqzIis_4mlPlM/n/id45pwgtjyzz/b/package/o/fusion-ui-server-s3_rpm_installer.2.14.sh
#wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/PVx_oJbjrB5Z6R-IrOsM30I6vjydK3w0vBBu5Sx2Hdg/n/id45pwgtjyzz/b/package/o/fusion-ui-server-s3_rpm_installer.2.15.1.sh
wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/N-eATubFUQY4sbvQWC0QOxMc_AiHDVlkyaqAtdBiT24/n/id45pwgtjyzz/b/package/o/multicloud-installer-2.0.1.1.379.sh
wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/EmC9_9FC75mbdZMF37tJgtu-Si3uO4KQ2aPjvXfAwK8/n/id45pwgtjyzz/b/package/o/setup_scripts.zip

unzip setup_scripts.zip
mv multicloud*.sh fusion*.sh ${FusionSoftware}

echo -n $base64_key | base64 -d > ${FusionSoftware}/license.key

if [[ ! -e ${FusionSoftware} ]]
then
    printf "%s\n" "*** Error - missing Packages in: $FusionSoftware"
    exit 1
fi

chown -R opc "${BaseDir}"
chmod +x ${FusionScripts}/*
chmod +x ${FusionSoftware}/*sh

printf "%s\n" "Handle Fusion pre-requisites"
${FusionScripts}/fusion_prereqs.bash

printf "%s\n" "Install and configure Fusion"
${FusionScripts}/fusion_install.bash

printf "%s\n" "Install Fusion Plugin"
${FusionScripts}/fusion_plugin.bash

printf "%s\n" "Restart Fusion services and Open Firewall Ports"
${FusionScripts}/fusion_restart.bash

printf "%s\n" "Finished - Cloud-init has completed Fusion setup"

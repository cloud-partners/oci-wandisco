#!/bin/bash -x

export BaseDir="/home/opc"
# Capture output to BaseDir file
{
printf "%s\n" "Installing Fusion Server..." 

# bootstrap scripts and software and run installations

export FusionSoftware="${BaseDir}/Fusion_Software"
export FusionScripts="${BaseDir}/bin"

cd "${BaseDir}"

#make the s3cmd tool configuration file s3cfg
s3config=${BaseDir}/s3cfg

cat <<EOF > ${s3config}
[default]
access_key = $accesskey
secret_key = $secretkey
bucket_location = $region
host_base = $endpointurl
host_bucket = $endpointurl
signature_v2 = False
use_https = True
EOF

# PackageLocation is an environment variable
# the software and install scripts are in an Object storage bucket

if [[ -z ${PackageLocation} ]]
then 
    printf "%s\n" "*** Error - missing PackageLocation definition"
    exit 1
fi

# get s3cmd to download package files
yum -y install s3cmd
s3cmd -c ${s3config} get -r --force $PackageLocation

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

} &> ${BaseDir}/cloud-init.txt


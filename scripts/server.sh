
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


wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/sdRtbGYlJ4_wd5qwVQ-AFSNt0dFsks-em5r1yuLDO98/n/partners/b/package/o/setup_scripts.zip
wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/-YzzM8HLCQZq7pu0kEKDhzLeTciXXGdqDkDysVnETZg/n/partners/b/package/o/multicloud-installer-2.0.1.1.379.sh
wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/665tvVEHGHxW7F2IEMNMq5IPq3aZ1C7yOk_W-_faico/n/partners/b/package/o/fusion-ui-server-s3_rpm_installer.2.14.sh
# https://objectstorage.us-ashburn-1.oraclecloud.com/p/T1cGagQ_ajUBukdYizSlf_csYRYxnvyQ0DhvatYt7c8/n/partners/b/package/o/fusion-ui-server-s3_rpm_installer.2.15.1.sh

unzip setup_scripts.zip
mv multicloud*.sh fusion*.sh ${FusionSoftware}

tmp_key="Rxk49P0DE6859kmQVrttpavRcgrUllgZhinnqxO+IpjC7ZPRv6DM7PnG4Qh6Nyg5FCkwoSg/NoTBu1iB8XK9kO8MWWgVDOfjIi4wQC6w6ScIrTUmLrXS+Qlx3yJK98MwHSj5NjxQGD7HJPJylDeTy98oV5dY2aqmp5H1xc0nCFGErXKJWe9YaEsjmibCniMlTDl5amb2AH4tWWyROPHJnZ1Gr/1R7uVZN1KgavcdgWk7nBHv5iCzXl/pJzsYs1xwelU7kF0Hl9LuPfRbKg6M8ErmkbbKaKrYHWcarR8od1NCWy/h1805MuOYAcY8FL/2B5atZpnwjPWriR+mjSUbzB6swRCYSyUAxDWtLn6K8p2zxKvyV98Oh9+H+urAjGLtFWoIS6zMPFPVAaoSp3d8ys8WkX7PThY3aAMfzVOoHqCHOWFkczuQKKSOvxK/3KiBFLIxTiQ2ZzDmrkXrdNMC0NHN1lHMcUTC2KK5Xa5fNfJD2Dju26GRKKHi0ocRGGS6jnbod6GxpArdamoFuSeFV/Pt/R5j2YlDtPzYAs3Kyuf/qG6LjydgsXlPDXX0BsuvKmojNDmw1j3YNClQaf3tlZbr8UwG1xMQ2tQad+lDr3/g7+n4NIy9zkkv3Ob7g7Ca3blJup9I4GR/gIr+UYE+VxwKfCyfYf28z8Q2RlSDmec="
echo -n $tmp_key | base64 -d > ${FusionSoftware}/license.key

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

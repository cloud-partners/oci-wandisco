#!/bin/bash -x

if [[ ! -e "${FusionSoftware}" ]]
then
        printf "%s\n" "*** Error missing or non-existant Directory"
	exit 1
fi

sudo -E \
PROXY_IS_SSL=n \
PROXY_LISTEN_HOST_AND_PORT=${proxy} \
sh ${FusionSoftware}/multi*installer*sh <<EOF
Y


n
n
n
n

EOF


exit


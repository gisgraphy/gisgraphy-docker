#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "usage $0 DOCKERID (use docker ps)"
   exit 1 
fi

#docker ps =>DOCKERID
DOCKERID=$1
docker export $DOCKERID > /root/docker-pro.tar
echo "file is in /root/docker-pro.tar"

echo "now compressing"
cd /root/
bzip2 docker-pro.tar

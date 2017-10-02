#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "usage $0 DOCKERID (use docker ps)"
    exit 1
fi

#docker ps =>DOCKERID
DOCKERID=$1
docker exec -t -i $DOCKERID /bin/bash


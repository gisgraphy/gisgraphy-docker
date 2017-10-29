#!/bin/bash

if [ "$#" -ne 1 ]; then
	DOCKERID=$(docker ps -q)
else 
	#docker ps =>DOCKERID
	DOCKERID=$1
fi

docker stop $DOCKERID 

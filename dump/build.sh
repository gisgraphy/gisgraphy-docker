#!/bin/bash

docker build  -t gisgraphydump --build-arg PGPASSWORD=mdppostgres --build-arg BASE_IMAGE=gisgraphyofficial . --build-arg SOLR_DIR=/usr/local/gisgraphy/solr/

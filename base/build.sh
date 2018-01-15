#!/bin/bash

wget http://download.gisgraphy.com/releases/gisgraphy-latest.zip -P ./assets/gisgraphy/

docker build -t gisgraphyofficial  --build-arg PGPASSWORD=mdppostgres .



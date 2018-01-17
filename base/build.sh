#!/bin/bash

echo "Checking if Gisgraphy package is present"
if [ ! -e ./assets/gisgraphy/gisgraphy-latest.zip ]; then echo "Downloading Gisgraphy"; wget http://download.gisgraphy.com/releases/gisgraphy-latest.zip -P ./assets/gisgraphy/; fi
docker build -t gisgraphyofficial  --build-arg PGPASSWORD=mdppostgres .



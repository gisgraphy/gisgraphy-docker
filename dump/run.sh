#!/bin/bash

docker run -td  -p23:22  -p80:80 --hostname=docker.gisgraphy.com  gisgraphyprodump bash


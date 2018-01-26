#/bin/bash


docker pull gisgraphy/gisgraphyofficial  && docker run -ti -p80:8080 --hostname=myhost.com gisgraphyofficial bash


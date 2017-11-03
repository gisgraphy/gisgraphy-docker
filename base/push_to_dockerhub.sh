#!/bin/bash
docker login
docker tag gisgraphyofficial gisgraphy/gisgraphyofficial
docker push gisgraphy/gisgraphyofficial

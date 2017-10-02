#!/bin/bash

docker build -t gisgraphysql  --build-arg PGPASSWORD=mdppostgres .

